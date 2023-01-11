import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_authenticator/amplify_authenticator.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:clubbee/views/main_page/main_page.dart';
import 'package:clubbee/views/splash_screen/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'amplifyconfiguration.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    _configureAmplify();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Authenticator(
      signUpForm: SignUpForm.custom(fields: [
        SignUpFormField.email(required: true),
        SignUpFormField.password(),
        SignUpFormField.passwordConfirmation(),
        SignUpFormField.birthdate(required: true),
        SignUpFormField.name(required: true),
        SignUpFormField.custom(
            title: "School Id",
            required: true,
            attributeKey: CognitoUserAttributeKey.parse("custom:school_id")),
      ]),
      child: GetMaterialApp(
        builder: Authenticator.builder(),
        debugShowCheckedModeBanner: false,
        theme: Theme.of(context).copyWith(primaryColor: Colors.yellow),
        home: const SplashScreen(),
      ),
    );
  }

  void _configureAmplify() async {
    try {
      await Amplify.addPlugin(AmplifyAuthCognito());
      await Amplify.configure(amplifyconfig);
      print('Successfully configured');
    } on Exception catch (e) {
      print('Error configuring Amplify: $e');
    }
  }
}
