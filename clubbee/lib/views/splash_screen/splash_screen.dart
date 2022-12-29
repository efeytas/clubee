import 'dart:async';

import 'package:lottie/lottie.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:clubbee/global_parameters.dart';
import 'package:clubbee/services/auth_services.dart';
import 'package:clubbee/views/main_page/main_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../services/api_sevices.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
    loadDataThenStart();
  }

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  loadDataThenStart() async {
    //AuthService().signOutCurrentUser();
    await AuthService().sendUserAttributesToEc2();
    await Future.delayed(Duration(seconds: 2));
    var prefs = await SharedPreferences.getInstance();
    var schoolID = prefs.getString("school_id");
    currentUser = await ApiServices.getUserData(schoolID ?? "150180086");
    activeChapters =
        await ApiServices.getActiveChapters(schoolID ?? "150180086");
    appliedEvents = await ApiServices.getAppliedEvents(schoolID ?? "150180086");
    print(appliedEvents);

    Get.off(() => const MainPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Center(
            child: SizedBox(
              width: 250.0,
              child: TextLiquidFill(
                loadDuration: Duration(seconds: 3),
                waveDuration: Duration(milliseconds: 750),
                text: 'ClubBee',
                waveColor: Colors.amberAccent,
                boxBackgroundColor: Colors.white,
                textStyle: TextStyle(
                  fontSize: 50.0,
                  fontWeight: FontWeight.bold,
                ),
                boxHeight: 300.0,
              ),
            ),
          ),
          Positioned(
              top: 700,
              left: 170,
              child: SizedBox(
                  height: 100,
                  child: Lottie.asset(
                    'assets/loader.json',
                  ))),
        ],
      ),
    );
  }
}
