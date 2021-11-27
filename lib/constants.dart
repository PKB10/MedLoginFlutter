/*!
 @file constants.dart

 @brief  App Constants
 @discussion This file contains the common constants used in the application.

 @author Priyanka Bhatia
 @copyright  2021 Priyanka Bhatia
 @version  1.0.0
 */

import 'package:flutter/material.dart';

// API Constants:
const String SERVER_BASE_URL =
    "http://medlo-ecsal-agu63xv2dg1b-521010580.us-east-2.elb.amazonaws.com";
const String LOGIN_URL = "$SERVER_BASE_URL/users/login/";
const String ALL_PATIENTS_URL = "$SERVER_BASE_URL/patients";

// Color Constants:
const kMLBlueColor = Color(0xFF2196F3);
const kMLGreenAccentColor = Color(0xFF69F0AE);
const kMLErrorColor = Colors.red;
const kTextColor = Colors.black;
const kMLWhiteColor = Color(0xFFFFFFFF);
const kMLTealBlueColor = Color(0xFF55B2DA);
