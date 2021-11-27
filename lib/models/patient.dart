/*!
 @file patient.dart

 @brief  Patient class
 @discussion This class serves as a model placeholder class for all patients in the application.

 @author Priyanka Bhatia
 @copyright  2021 Priyanka Bhatia
 @version  1.0.0
 */

class Patient {
  String? id;
  String? name;
  String? email;
  String? birthdate;
  String? gender;
  dynamic diseases;
  dynamic allergies;

  Patient({
    this.id,
    this.name,
    this.email,
    this.birthdate,
    this.gender,
    this.diseases,
    this.allergies,
  });

  factory Patient.fromJson(Map<String, dynamic> responseData) {
    return Patient(
      id: responseData['_id'],
      name: responseData['name']['first'] + ' ' + responseData['name']['last'],
      email: responseData['email'],
      birthdate: responseData['birthdate'],
      gender: responseData['gender'],
      diseases: responseData['diseases'],
      allergies: responseData['allergies'],
    );
  }
}
