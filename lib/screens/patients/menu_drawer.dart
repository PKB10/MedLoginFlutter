/*!
 @file menu_drawer.dart

 @brief  MenuDrawer class
 @discussion This file contains the view class for the left menu shown in patients_list screen.

 @author Priyanka Bhatia
 @copyright  2021 Priyanka Bhatia
 @version  1.0.0
 */

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:med_login/models/session.dart';
import 'package:med_login/utils/session_notifier.dart';
import 'package:med_login/constants.dart';

class MenuDrawer extends StatelessWidget {
  const MenuDrawer({
    Key? key,
    this.onLogOut,
    this.onRefresh,
  }) : super(key: key);
  final onLogOut;
  final onRefresh;
  @override
  Widget build(BuildContext context) {
    Session userSession = Provider.of<MLSessionNotifier>(context).userSession;
    return Container(
      width: 200,
      child: Drawer(
        child: Container(
          color: kMLGreenAccentColor,
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              SizedBox(height: 40),
              Center(
                child: Text(
                  'Welcome, ' + (userSession.name ?? ''),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ),
              SizedBox(height: 20),
              ListTile(
                title: Row(
                  children: [
                    Icon(
                      FontAwesomeIcons.retweet,
                      color: Colors.white,
                      size: 20,
                    ),
                    SizedBox(width: 10),
                    Text(
                      'Refresh',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                onTap: onRefresh,
              ),
              ListTile(
                title: Row(
                  children: [
                    Icon(
                      FontAwesomeIcons.signOutAlt,
                      color: Colors.white,
                      size: 20,
                    ),
                    SizedBox(width: 6),
                    Text(
                      'LogOut',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                onTap: onLogOut,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
