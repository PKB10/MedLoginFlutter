/*!
 @file login_screen.dart

 @brief  LoginScreen class
 @discussion This file contains class for the login form screen.

 @author Priyanka Bhatia
 @copyright  2021 Priyanka Bhatia
 @version  1.0.0
 */

import 'dart:io';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:med_login/constants.dart';
import 'package:med_login/models/response.dart';
import 'package:med_login/utils/login_notifier.dart';
import 'package:med_login/utils/session_notifier.dart';
import 'package:med_login/screens/patients/patients_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool setPasswordToSecureText = true;
  bool setLoginInProgress = false;
  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();
  LoginRequest loginRequest = LoginRequest();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final focus = FocusNode();

  @override
  void initState() {
    super.initState();
    // loginRequest = new LoginRequest();
  }

  @override
  Widget build(BuildContext context) {
    MLLoginNotifier loginProvider = Provider.of<MLLoginNotifier>(context);

    Future<bool> isInternet() async {
      var connectivityResult = await (Connectivity().checkConnectivity());
      if (connectivityResult == ConnectivityResult.mobile) {
        // Ensure there is an internet connection.
        dynamic result = await InternetAddress.lookup('google.com');
        if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
          // Mobile data detected & internet connection confirmed.
          return true;
        } else {
          // Mobile data detected but no internet connection found.
          return false;
        }
      } else if (connectivityResult == ConnectivityResult.wifi) {
        //Ensure there is an internet connection.
        dynamic result = await InternetAddress.lookup('google.com');
        if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
          // Wifi detected & internet connection confirmed.
          return true;
        } else {
          // Wifi detected but no internet connection found.
          return false;
        }
      } else {
        // Neither mobile data or WIFI detected, not internet connection found.
        return false;
      }
    }

    onSubmit([String? text]) async {
      if (validateAndSave()) {
        FocusScope.of(context).unfocus();
        print(loginRequest.toJson());

        if (mounted) {
          setState(() {
            setLoginInProgress = true;
          });
        }

        bool b = await isInternet();
        if (b) {
          print('connected');

          final Future<dynamic> response = loginProvider.login(loginRequest);
          response.then((userSession) {
            if (mounted) {
              setState(() {
                setLoginInProgress = false;
              });
            }
            if (userSession != null) {
              Provider.of<MLSessionNotifier>(context, listen: false)
                  .setUser(userSession);

              Navigator.of(context).pushReplacement(
                  new MaterialPageRoute(builder: (BuildContext context) {
                return PatientsScreen();
              }));

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("Logged in successfully."),
                ),
              );
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("Sorry, username/password is invalid."),
                ),
              );
            }
          });
        } else {
          print('not connected');
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("No internet connection detected."),
            ),
          );
        }
      }
    }

    return Scaffold(
      key: scaffoldKey,
      backgroundColor: kMLWhiteColor,
      appBar: AppBar(
        backgroundColor: kMLGreenAccentColor,
        title: Text('MedLogin'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12),
          child: Column(
            children: <Widget>[
              setLoginInProgress
                  ? Padding(
                      padding: const EdgeInsets.all(40.0),
                      child: Center(child: new CircularProgressIndicator()),
                    )
                  : Form(
                      key: globalFormKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(height: 25),
                          Text(
                            "Welcome to MedLogin",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: kMLBlueColor,
                              fontSize: 30,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(height: 14),
                          Text(
                            "Sign in to continue",
                            style: TextStyle(
                              color: kTextColor,
                              fontSize: 18,
                            ),
                          ),
                          SizedBox(height: 20),
                          new TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            textInputAction: TextInputAction.next,
                            onFieldSubmitted: (v) {
                              FocusScope.of(context).requestFocus(focus);
                            },
                            onSaved: (input) => loginRequest.username = input,
                            validator: (input) => input!.length < 3
                                ? "Username should be valid"
                                : null,
                            decoration: new InputDecoration(
                              hintText: "Username",
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.black.withOpacity(0.2),
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: kMLGreenAccentColor,
                                ),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: kMLErrorColor,
                                ),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 2.0, color: kMLErrorColor),
                              ),
                              prefixIcon: Icon(
                                Icons.person,
                                color: kMLGreenAccentColor,
                              ),
                            ),
                          ),
                          SizedBox(height: 20),
                          new TextFormField(
                            focusNode: focus,
                            onFieldSubmitted: onSubmit,
                            style: TextStyle(color: kTextColor),
                            keyboardType: TextInputType.text,
                            onSaved: (input) => loginRequest.password = input,
                            validator: (input) => input!.length < 3
                                ? "Password should be more than 3 characters"
                                : null,
                            obscureText: setPasswordToSecureText,
                            decoration: new InputDecoration(
                              hintText: "Password",
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.black.withOpacity(0.2),
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: kMLGreenAccentColor,
                                ),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: kMLErrorColor,
                                ),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 2.0, color: kMLErrorColor),
                              ),
                              prefixIcon: Icon(
                                Icons.lock,
                                color: kMLGreenAccentColor,
                              ),
                              suffixIcon: IconButton(
                                onPressed: () {
                                  if (mounted) {
                                    setState(() {
                                      setPasswordToSecureText =
                                          !setPasswordToSecureText;
                                    });
                                  }
                                },
                                color: kMLGreenAccentColor.withOpacity(0.4),
                                icon: Icon(setPasswordToSecureText
                                    ? Icons.visibility_off
                                    : Icons.visibility),
                              ),
                            ),
                          ),
                          SizedBox(height: 20),
                          InkWell(
                            onTap: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text("Coming soon!"),
                                ),
                              );
                            },
                            child: Text(
                              'Forgot Password?',
                              style: TextStyle(color: kMLBlueColor),
                            ),
                          ),
                          SizedBox(height: 14),
                          Container(
                            width: double.infinity,
                            child: TextButton(
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        kMLGreenAccentColor),
                                fixedSize: MaterialStateProperty.all(
                                  Size(double.infinity, double.infinity),
                                ),
                              ),
                              onPressed: onSubmit,
                              child: Text(
                                "Submit",
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 14),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Don\'t have an account?',
                                style: TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text("Coming soon!"),
                                    ),
                                  );
                                },
                                child: Text(
                                  'Contact Admin',
                                  style: TextStyle(
                                    color: kMLBlueColor,
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 15),
                        ],
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }

  bool validateAndSave() {
    final form = globalFormKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    }
    return false;
  }
}
