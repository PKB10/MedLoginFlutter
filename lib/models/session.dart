/*!
 @file session.dart

 @brief  User session class
 @discussion This class serves as a model placeholder class for all user sessions in the application.

 @author Priyanka Bhatia
 @copyright  2021 Priyanka Bhatia
 @version  1.0.0
 */

class Session {
  String? userId;
  String? userName;
  String? name;
  String? sessiontoken;
  String? sessionid;

  Session({
    this.userId,
    this.userName,
    this.name,
    this.sessiontoken,
    this.sessionid,
  });

  factory Session.fromJson(Map<String, dynamic> responseData) {
    return Session(
      userId: responseData['userid'],
      userName: responseData['username'],
      name: responseData['name']['first'] + ' ' + responseData['name']['last'],
      sessiontoken: responseData['sessiontoken'],
      sessionid: responseData['sessionid'],
    );
  }
}
