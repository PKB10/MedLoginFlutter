/*!
 @file patients_screen.dart

 @brief  PatientsScreen class
 @discussion This file contains class for the patients list screen - the first screen shown to a logged in user.

 @author Priyanka Bhatia
 @copyright  2021 Priyanka Bhatia
 @version  1.0.0
 */

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:med_login/constants.dart';
import 'package:med_login/utils/user_preferences.dart';
import 'package:med_login/models/session.dart';
import 'package:med_login/utils/session_notifier.dart';
import 'package:med_login/screens/patients/menu_drawer.dart';
import 'package:med_login/screens/login/login_screen.dart';
import 'package:med_login/utils/patients_notifier.dart';
import 'package:med_login/screens/patients/patients_list.dart';

class PatientsScreen extends StatelessWidget {
  const PatientsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Session userSession = Provider.of<MLSessionNotifier>(context).userSession;
    print('Currently logged in user: ${userSession.name.toString()}');

    final patientsProvider =
        Provider.of<MLPatientsNotifier>(context, listen: false);

    WidgetsBinding.instance?.addPostFrameCallback((_) {
      try {
        // Ensure there is an internet connection.
        InternetAddress.lookup('google.com').then((result) {
          print('result:' + result.toString());
          if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
            print('connected');
            patientsProvider.resetStreams();
            patientsProvider.fetchData(userSession);
          }
        });
      } on SocketException catch (_) {
        print('not connected');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("No internet connection detected."),
          ),
        );
      }
    });
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kMLGreenAccentColor,
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        title: Text(
          'Patients',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        actions: [
          Center(
            child: InkWell(
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("Coming soon!"),
                  ),
                );
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  FontAwesomeIcons.search,
                  color: Colors.white,
                  size: 16,
                ),
              ),
            ),
          ),
          SizedBox(width: 10),
        ],
      ),
      drawer: MenuDrawer(onLogOut: () {
        Navigator.of(context).pop();
        UserPreferences().deleteUserSession();
        Navigator.of(context).pushReplacement(
            new MaterialPageRoute(builder: (BuildContext context) {
          return LoginScreen();
        }));
      }, onRefresh: () {
        Navigator.of(context).pop();
        try {
          // Ensure there is an internet connection.
          InternetAddress.lookup('google.com').then((result) {
            print('result:' + result.toString());
            if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
              print('connected');
              patientsProvider.resetStreams();
              patientsProvider.fetchData(userSession);
            }
          });
        } on SocketException catch (_) {
          print('not connected');
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("No internet connection detected."),
            ),
          );
        }
      }),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: PatientsList(),
      ),
    );
  }
}
