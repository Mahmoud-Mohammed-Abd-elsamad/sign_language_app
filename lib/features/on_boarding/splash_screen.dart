import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../config/routes/routes.dart';
import '../../core/utils/app_images.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  var splash = AppImages.splashImage1;
  var stateCount = 0;

  @override
  void initState() {
    Future.delayed(const Duration(seconds: 4), () {
      Navigator.pushNamedAndRemoveUntil(
          context, Routes.onBoardingScreen, (route) => false);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 2), () {
      stateCount++;
      if (stateCount <= 1) {
        splash = AppImages.splashImage2;
        setState(() {});
      }
    });
    return Scaffold(
      body: Container(
          height: double.infinity,
          width: double.infinity,
          child: Image.asset(
            splash,
            fit: BoxFit.fill,
          )),
    );
  }
}