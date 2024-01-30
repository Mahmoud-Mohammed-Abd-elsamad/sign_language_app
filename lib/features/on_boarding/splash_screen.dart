import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sign_language_app/core/utils/app_icons.dart';
import 'package:sign_language_app/core/utils/app_strings.dart';

import '../../config/routes/routes.dart';
import '../../core/utils/app_colors.dart';
import '../../core/utils/app_images.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  var stateCount = 0;
  bool isAnimationCompleted = false;

  @override
  void initState() {
    Future.delayed(const Duration(seconds: 1), () {
      stateCount++;
      if(stateCount <= 1){
        setState(() {
          isAnimationCompleted = true;
        });
      }

    });
    Future.delayed(const Duration(seconds: 5), () {
      Navigator.pushNamedAndRemoveUntil(
          context, Routes.onBoardingScreen, (route) => false);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: Stack(
          children: [
             SizedBox(height: 650.w,width: 400.w,),AnimatedPositioned(
              left: 133.w,
              duration: const Duration(seconds: 2),
              top: isAnimationCompleted ? MediaQuery.of(context).size.height - 465.w : 100.w,
              child: Image.asset(AppIcons.logo),
            ),
            AnimatedPositioned(
              left: 68.w,
              duration: const Duration(seconds: 2),
              top:  430.w,
              child: Text(
                AppStrings.signLanguage,
                style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w600,
                    fontSize: 32.sp,
                    color: AppColors.primaryColor),
              )
            ),
            ]
      ),
    ));
  }
}
