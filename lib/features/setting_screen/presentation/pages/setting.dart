import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sign_language_app/core/utils/app_strings.dart';
import 'package:sign_language_app/core/utils/cach_helper.dart';
import 'package:sign_language_app/features/setting_screen/presentation/manager/setting_screen_cubit.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/flutter_tts.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<SettingScreenCubit>();
    return Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(
            color: Colors.white, //change your color here
          ),
          centerTitle: true,
          elevation: 0,
          backgroundColor: AppColors.primaryColor,
          title: Text(
            AppStrings.settings,
            style: GoogleFonts.poppins(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20.sp),
          ),
        ),
        body: BlocBuilder<SettingScreenCubit,SettingScreenState>(
          builder: (BuildContext context, state) {
            return Column(
              children: [
                SizedBox(
                  height: 350.w,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 60.w,
                      ),
                      Container(
                        height: 100.w,
                        margin: EdgeInsets.all(8.w),
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                          color: AppColors.primaryColor,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                AppStrings.speechRate,
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                    color: Colors.white),
                              ),
                              Expanded(
                                child: SliderTheme(
                                  data: SliderTheme.of(context).copyWith(
                                    valueIndicatorTextStyle: const TextStyle(
                                      color: AppColors
                                          .primaryColor, // Set the text color here
                                    ),
                                  ),
                                  child: Slider(
                                      activeColor: Colors.white,
                                      inactiveColor: Colors.grey,
                                      thumbColor: Colors.white,
                                      value: cubit.setSpeechRateSliderValue,
                                      max: 2,
                                      min: 0.1,
                                      divisions: 36,
                                      label: cubit.setSpeechRateSliderValue
                                          .round()
                                          .toString(),
                                      onChanged: (value) {
                                        cubit.setSpeechRateSliderValue = value;
                                        FlutterTtsMe.configureTts(
                                            setSpeechRate: value,
                                            setVolume: cubit.setVolumeSliderValue);
                                        CacheHelper.saveSettings(
                                            speechRate: value,
                                            volume: cubit.setVolumeSliderValue);
                                        cubit.setStateSettingScreen();
                                      }),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30.w,
                      ),
                      Container(
                        margin: EdgeInsets.all(8.w),
                        height: 100.w,
                        decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                            color: AppColors.primaryColor),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              AppStrings.volume,
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
                                  color: Colors.white),
                            ),
                            Expanded(
                              child: SliderTheme(
                                data: SliderTheme.of(context).copyWith(
                                  valueIndicatorTextStyle: const TextStyle(
                                    color: AppColors
                                        .primaryColor, // Set the text color here
                                  ),
                                ),
                                child: Slider(
                                    activeColor: Colors.white,
                                    inactiveColor: Colors.grey,
                                    thumbColor: Colors.white,
                                    value: cubit.setVolumeSliderValue,
                                    max: 1,
                                    min: .1,
                                    divisions: 36,
                                    label: cubit.setVolumeSliderValue
                                        .round()
                                        .toString(),
                                    onChanged: (value) {
                                      cubit.setVolumeSliderValue = value;
                                      FlutterTtsMe.configureTts(
                                          setSpeechRate:
                                          cubit.setSpeechRateSliderValue,
                                          setVolume: value);
                                      CacheHelper.saveSettings(
                                          speechRate:
                                          cubit.setSpeechRateSliderValue,
                                          volume: value);

                                      cubit.setStateSettingScreen();
                                    }),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            );
          },
        ));
  }
}
