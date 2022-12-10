import 'package:amplify_flutter/amplify_flutter.dart';

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
}
