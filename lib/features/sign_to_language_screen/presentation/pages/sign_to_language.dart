import 'dart:io';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:share_plus/share_plus.dart';
import 'package:sign_language_app/core/utils/app_strings.dart';
import 'package:video_player/video_player.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/componants/custom_icon_button.dart';
import '../manager/sign_to_language_cubit.dart';

class SignToLanguageScreen extends StatelessWidget {
  const SignToLanguageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SignToLanguageCubit>();

    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          PopupMenuButton(onSelected: (value) async {
            File file = File(cubit.pickedFileT!.path);
            file.createSync();
            if (file.existsSync() == true) {
              await Share.shareXFiles([XFile(file.path)], text: AppStrings.done);
            }
          }, itemBuilder: (context) {
            return [
              PopupMenuItem(
                  value: MenuItem.item1,
                  child: Text(
                    AppStrings.share,
                    style: GoogleFonts.poppins(
                        fontSize: 16, fontWeight: FontWeight.w500),
                  ))
            ];
          })
        ],
        iconTheme: const IconThemeData(
          color: Colors.white, //change your color here
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: AppColors.primaryColor,
        title: Text(
          AppStrings.signToLanguageApp,
          style: GoogleFonts.poppins(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 20.sp),
        ),
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          BlocConsumer<SignToLanguageCubit, SignToLanguageState>(
            listener: (context, state) {
              if (state is SignToLanguageTranslateSuccess) {
                cubit.controller =
                    VideoPlayerController.file(File(cubit.pickedFileT!.path))
                      ..initialize().then((_) {
                        //    setState(() {}); >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
                      });
                cubit.controller.value.isPlaying
                    ? cubit.controller.pause()
                    : cubit.controller.play();
              }
            },
            builder: (context, state) {
              if (state is SignToLanguageInitial) {
                return Center(
                    child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 20.w,
                      ),
                      Stack(children: [
                        Container(
                            height: 500.w,
                            width: 350.w,
                            decoration: BoxDecoration(
                                color: AppColors.primaryColor,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.w))),
                            child: const Center(
                                child: Text(AppStrings.takeVideoForTranslateIt))),
                        Positioned(
                          top: 400,
                          right: 15,
                          child: Container(
                            height: 80,
                            width: 300,
                            decoration: const BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                                color: Colors.transparent),
                            child: Center(
                                child: Text(
                              "",
                              style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 21.sp),
                            )),
                          ),
                        ),
                      ]),
                    ],
                  ),
                ));
              } else if (state is SignToLanguageTranslateLoading) {
                return Center(
                    child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 20.w,
                      ),
                      Stack(children: [
                        Container(
                            height: 500.w,
                            width: 350.w,
                            decoration: BoxDecoration(
                                color: AppColors.primaryColor,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.w)))),
                        Positioned(
                          top: 220,
                          right: 22,
                          child: Container(
                            height: 100,
                            width: 300,
                            decoration: const BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                                color: Colors.transparent),
                            child: const Center(
                                child: CircularProgressIndicator(
                              color: Colors.white,
                            )),
                          ),
                        ),
                      ]),
                    ],
                  ),
                ));
              } else if (state is SignToLanguageTranslateFailed) {
                return Center(
                    child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 20.w,
                      ),
                      Stack(children: [
                        Container(
                          height: 500.w,
                          width: 350.w,
                          decoration: BoxDecoration(
                              color: AppColors.primaryColor,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.w))),
                        ),
                        Positioned(
                          top: 250,
                          right: 30,
                          child: Container(
                            height: 150,
                            width: 300,
                            decoration: const BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                                color: Colors.transparent),
                            child: Center(
                                child: Text(
                              AppStrings.checkYourNetwork,
                              style: GoogleFonts.poppins(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 21.sp),
                            )),
                          ),
                        ),
                      ]),
                    ],
                  ),
                ));
              } else if (state is SignToLanguageTranslateSuccess) {
                cubit.newWord = state.model.word?.result ?? '';
                return Center(
                    child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 8.w,
                      ),
                      Stack(children: [
                        Container(
                          height: 510.w,
                          width: 325.w,
                          decoration: BoxDecoration(
                              color: AppColors.primaryColor,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.w))),
                        ),
                        Positioned(
                          top: 10,
                          right: 8,
                          child: Column(
                            children: [
                              Container(
                                height: 490,
                                width: 340,
                                decoration: const BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20)),
                                    color: Colors.white),
                                child: Center(
                                  child: cubit.controller.value.isInitialized
                                      ? VideoPlayer(cubit.controller)
                                      : Container(),
                                ),
                              ),
                              AnimatedTextKit(
                                animatedTexts: [
                                  TypewriterAnimatedText(
                                    '${state.model.word!.result}',
                                    textStyle: const TextStyle(
                                      fontSize: 32.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    speed: const Duration(milliseconds: 2200),
                                  ),
                                ],
                                totalRepeatCount: 1,
                                pause: const Duration(milliseconds: 800),
                                displayFullTextOnTap: true,
                                stopPauseOnTap: true,
                              )
                            ],
                          ),
                        ),
                      ]),
                    ],
                  ),
                ));
              }

              return Column(
                children: [
                  SizedBox(
                    height: 350.w,
                  ),
                  const Center(
                    child: Text(AppStrings.invalidState),
                  ),
                  SizedBox(
                    height: 350.w,
                  ),
                ],
              );
            },
          ),
          SizedBox(
            height: 70.w,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              CustomCircleIconButton(
                width: 50.w,
                height: 50.w,
                icon: Icons.image,
                iconSize: 25.w,
                onTap: () async {
                  cubit.pickedFileT = await ImagePicker().pickVideo(
                      source: ImageSource.gallery,
                      maxDuration: const Duration(seconds: 15));

                  if (context.mounted) {
                    context
                        .read<SignToLanguageCubit>()
                        .signToLanguageTranslateVideo(
                            video: cubit.pickedFileT!.path);
                  }
                },
              ),
              CustomCircleIconButton(
                width: 70,
                height: 70,
                icon: Icons.camera_alt_outlined,
                iconSize: 30,
                onTap: () async {
                  cubit.pickedFileT = await ImagePicker().pickVideo(
                      source: ImageSource.camera,
                      maxDuration: const Duration(seconds: 15));

                  if (cubit.pickedFileT != null) {
                    if (context.mounted) {
                      context
                          .read<SignToLanguageCubit>()
                          .signToLanguageTranslateVideo(
                              video: cubit.pickedFileT!.path);
                    }
                  }
                },
              ),
              CustomCircleIconButton(
                width: 50.w,
                height: 50.w,
                icon: CupertinoIcons.speaker_1_fill,
                iconSize: 25.w,
                onTap: () {
                  cubit.flutterTts.speakText(cubit.newWord);
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}

enum MenuItem { item1 }
