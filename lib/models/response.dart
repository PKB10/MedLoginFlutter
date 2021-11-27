/*!
 @file response.dart

 @brief  Response class
 @discussion This file contains classes that serve as model placeholder classes for API responses and requests used in the application.

 @author Priyanka Bhatia
 @copyright  2021 Priyanka Bhatia
 @version  1.0.0
 */

import 'package:med_login/models/session.dart';
import 'package:med_login/models/patient.dart';

// This class serves as a model placeholder class for 'users/login' endpoint response in the application.
class LoginResponse {
  final String message;
  final String error;
  final Session? userSession;

  LoginResponse({required this.message, required this.error, this.userSession});

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      message: json["message"] != null ? json["message"] : "",
      error: json["error"] != null ? json["error"] : "",
      userSession: json["user"] != null ? Session.fromJson(json["user"]) : null,
    );
  }
}

// This class serves as a model placeholder class for 'users/login' request POST body in the application.
class LoginRequest {
  String? username;
  String? password;

  LoginRequest({
    this.username,
    this.password,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'username': username?.trim(),
      'password': password?.trim(),
    };

    return map;
  }
}

// This class serves as a model placeholder class for '/patients' endpoint response in the application.
class PatientResponse {
  final String message;
  final String error;
  final List<Patient>? patients;

  PatientResponse({required this.message, required this.error, this.patients});

  factory PatientResponse.fromJson(Map<String, dynamic> json) {
    return PatientResponse(
      message: json["message"] != null ? json["message"] : "",
      error: json["error"] != null ? json["error"] : "",
      patients: json["patients"] != null
          ? List<Patient>.from(
              json["patients"].map((model) => Patient.fromJson(model)))
          : null,
    );
  }
}
