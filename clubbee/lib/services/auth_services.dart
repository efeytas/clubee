import 'dart:convert';

import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:http/http.dart' as http;

class AuthService {
  Future<void> signOutCurrentUser() async {
    try {
      await Amplify.Auth.signOut();
    } on AuthException catch (e) {
      print(e.message);
    }
  }

  Future<void> signOutCurrentUserFromAllDevices() async {
    try {
      await Amplify.Auth.signOut(
          options: const SignOutOptions(globalSignOut: true));
    } on AuthException catch (e) {
      print(e.message);
    }
  }

  sendUserAttributesToEc2() async {
    String email = "";
    String schoolId = "";
    String fullName = "";
    String amazonid = "";
    try {
      var userAttributes = await Amplify.Auth.fetchUserAttributes();
      for (var element in userAttributes) {
        switch (element.userAttributeKey.toString()) {
          case "name":
            fullName = element.value;
            break;
          case "birthdate":
            break;
          case "email":
            email = element.value;
            break;
          case "sub":
            amazonid = element.value;
            break;
          case "custom:school_id":
            schoolId = element.value;
            break;
          case "email_verified":
            break;
          default:
        }
      }
      http.post(Uri.parse("example.com"),
          body: jsonEncode({
            "full_name": fullName,
            "email": email,
            "studentnumber": schoolId,
            "amazon_id": amazonid
          }));
    } catch (e) {
      print(e);
    }
  }
}
