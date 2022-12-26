import 'dart:async';

import 'package:clubbee/global_parameters.dart';
import 'package:clubbee/views/main_page/main_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../services/api_sevices.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  double h = 300;
  double w = 300;
  double r = 16;
  Timer? _timer;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
    _timer = Timer.periodic(const Duration(milliseconds: 700), (timer) {
      if (h == 300) {
        setState(() {
          h = 400;
          w = 600;
          r = 32;
        });
      } else {
        setState(() {
          h = 300;
          w = 300;
          r = 16;
        });
      }
    });
    loadDataThenStart();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();

    super.dispose();
  }

  loadDataThenStart() async {
    currentUser = await ApiServices.getUserData(150180086);
    Get.off(() => const MainPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AnimatedContainer(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(r), color: Colors.yellow),
          duration: const Duration(milliseconds: 300),
          height: h,
          width: w,
          child: const FittedBox(
            child: Text(
              "Clubbee",
              style: TextStyle(color: Colors.black87),
            ),
          ),
        ),
      ),
    );
  }
}
