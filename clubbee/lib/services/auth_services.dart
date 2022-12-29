import 'dart:convert';

import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

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
    var prefs = await SharedPreferences.getInstance();
    String email = "";
    String schoolId = "";
    String fullName = "";
    String amazonid = "";
    try {
      var userAttributes = await Amplify.Auth.fetchUserAttributes();
      for (var element in userAttributes) {
        print(element.userAttributeKey.toString());
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
            print(element.value);
            schoolId = element.value;
            prefs.setString("school_id", schoolId);
            break;
          case "email_verified":
            break;
          default:
        }
      }
      Dio dio = Dio();
      dio.post(
          "http://clubeeserver.eu-central-1.elasticbeanstalk.com/api/register",
          data: {
            "full_name": fullName,
            "email": email,
            "studentnumber": schoolId,
            "amazon_id": amazonid
          },
          options: Options(headers: {
            "auth-key":
                "0d5d254b22d390d9e11a132d53521a229da9fa0ae9ba009a76499f57c1d64e30"
          }));
    } catch (e) {
      print(e);
    }
  }
}
