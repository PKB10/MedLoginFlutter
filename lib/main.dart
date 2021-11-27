import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:med_login/constants.dart';
import 'package:med_login/utils/user_preferences.dart';
import 'package:med_login/screens/login/login_screen.dart';
import 'package:med_login/utils/login_notifier.dart';
import 'package:med_login/screens/patients/patients_screen.dart';
import 'package:med_login/utils/patients_notifier.dart';
import 'models/session.dart';
import 'package:med_login/utils/session_notifier.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  Future<Session> getUserData() => UserPreferences().getUserSession();
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MLSessionNotifier()),
        ChangeNotifierProvider(create: (_) => MLPatientsNotifier()),
        ChangeNotifierProvider(create: (_) => MLLoginNotifier()),
      ],
      child: MaterialApp(
        title: 'MedLogin',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: kMLWhiteColor,
        ),
        home: FutureBuilder<Session>(
            future: getUserData(),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                case ConnectionState.waiting:
                  return CircularProgressIndicator();
                default:
                  if (snapshot.hasError)
                    return Text('Error: ${snapshot.error}');
                  else if (snapshot.data!.sessiontoken == null)
                    return LoginScreen();
                  else
                    Provider.of<MLSessionNotifier>(context)
                        .setUser(snapshot.data!);

                  return PatientsScreen();
              }
            }),
      ),
    );
  }
}
