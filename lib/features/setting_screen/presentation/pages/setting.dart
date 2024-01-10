import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/flutter_tts.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  State<SettingScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<SettingScreen> {
  double sliderValue = .5;
  double sliderValue2 = 1;

  int weightCounter = 40;
  int edgeCounter = 15;

  @override
  Widget build(BuildContext context) {

    double screenHeight = MediaQuery.sizeOf(context).height;
    double screenWidth = MediaQuery.sizeOf(context).width;
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white, //change your color here
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: AppColors.primaryColor,
        title: Text(
          "Settings",
          style: GoogleFonts.poppins(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 20.sp),
        ),
      ),
      body: Column(
        children: [
          SizedBox(height: 350.w,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 30.w,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Center(
                      child: Text(
                        "$sliderValue",
                        style: const TextStyle(
                            fontSize: 32,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      )),

                ],
              ),
              SizedBox(
                height: 30.w,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "   Speech rate",
                      style: GoogleFonts.poppins(fontWeight: FontWeight.w500,fontSize: 16,color: Colors.black),
                    ),
                    Expanded(
                      child: Slider(
                          activeColor: AppColors.primaryColor,
                          inactiveColor: Colors.grey,
                          thumbColor: AppColors.primaryColor,
                          value: sliderValue,
                          max: 1,
                          min: .1,
                          divisions: 36,
                          label: sliderValue.round().toString(),
                          onChanged: (value) {
                            sliderValue = value;
                            FlutterTtsMe.configureTts(setSpeechRate: value, setVolume: sliderValue2);
                            setState(() {

                            });
                          }),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 50.w,),
              Text(
                "   Volume",
                style: GoogleFonts.poppins(fontWeight: FontWeight.w500,fontSize: 16,color: Colors.black),
              ),
              Expanded(
                child: Slider(
                    activeColor: AppColors.primaryColor,
                    inactiveColor: Colors.grey,
                    thumbColor: AppColors.primaryColor,
                    value: sliderValue2,
                    max: 1,
                    min: .1,
                    divisions: 36,
                    label: sliderValue2.round().toString(),
                    onChanged: (value) {
                      sliderValue2 = value;
                      FlutterTtsMe.configureTts(setSpeechRate: sliderValue, setVolume: value);
                      setState(() {

                      });

                    }),
              ),
            ],
          ),
          ),
            ],
          ));

  }

  Widget _customSlider(double screenHeighy) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: screenHeighy * .01,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Center(
                child: Text(
              "$sliderValue",
              style: const TextStyle(
                  fontSize: 32,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            )),

          ],
        ),
        SizedBox(
          height: screenHeighy * .01,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "   Speech rate",
                style: GoogleFonts.poppins(fontWeight: FontWeight.w500,fontSize: 16,color: Colors.black),
              ),
              Expanded(
                child: Slider(
                    activeColor: AppColors.primaryColor,
                    inactiveColor: Colors.grey,
                    thumbColor: AppColors.primaryColor,
                    value: sliderValue,
                    max: 5,
                    min: 1,
                    divisions: 36,
                    label: sliderValue.round().toString(),
                    onChanged: (value) {
                      sliderValue = value;
                      setState(() {});
                    }),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
