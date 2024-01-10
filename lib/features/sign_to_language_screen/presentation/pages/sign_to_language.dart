import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share_plus/share_plus.dart';
import 'package:video_player/video_player.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/componants/custom_icon_button.dart';
import '../../../../core/utils/flutter_tts.dart';
import '../manager/sign_to_language_cubit.dart';
import 'camera_page/camera_page.dart';

class SignToLanguageScreen extends StatefulWidget {
  const SignToLanguageScreen({Key? key}) : super(key: key);

  @override
  State<SignToLanguageScreen> createState() => _SignToLanguageScreenState();
}

class _SignToLanguageScreenState extends State<SignToLanguageScreen> {
  late VideoPlayerController _controller;
  bool hasVideo = false;

  FlutterTtsMe flutterTts = FlutterTtsMe();

  @override
  void initState() {
    super.initState();

    if (CameraPage.videos != null) {
      hasVideo = true;

      _controller = VideoPlayerController.file(File(CameraPage.videos!))
        ..initialize().then((_) {
          // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
          setState(() {});
        });
    } else {
      hasVideo = false;

      _controller = VideoPlayerController.networkUrl(
          Uri(path: "https://youtu.be/mBqQPxQLSfc?si=HttOlGa592Bno8ou"))
        ..initialize().then((_) {
          // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
          setState(() {});
        });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          PopupMenuButton(onSelected: (value) async {
            File file = File("${CameraPage.videos!}");
            file.createSync();
            if (file.existsSync() == true) {
              await Share.shareXFiles([XFile(file.path)], text: "done");
            }

            print("Share method here ");
          }, itemBuilder: (context) {
            return [
              PopupMenuItem(
                  value: MenuItem.item1,
                  child: Text(
                    "Share",
                    style: GoogleFonts.poppins(
                        fontSize: 16, fontWeight: FontWeight.w500),
                  ))
            ];
          })
        ],
        iconTheme: IconThemeData(
          color: Colors.white, //change your color here
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: AppColors.primaryColor,
        title: Text(
          "Sign to language ",
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
              if (state is SignToLanguageTranslateLoading) {
                print(
                    "hello every body loading ===============================================");
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
                            child: Center(
                                child: hasVideo
                                    ? VideoPlayer(_controller)
                                    : Text(
                                        "Take Video For Translate  Translate Translate It"))),
                        Positioned(
                          top: 400,
                          right: 15,
                          child: Container(
                            height: 80,
                            width: 300,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(20)),
                                color: Colors.transparent),
                            child: Center(
                                child: Text(
                              "hello iam mahmoud",
                              style: GoogleFonts.poppins(
                                  color: hasVideo ? Colors.white : Colors.amber,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 21.sp),
                            )),
                          ),
                        ),
                      ]),
                      // SizedBox(
                      //   height: 32.w,
                      // ),
                      // Row(children: [
                      //   CustomCircleIconButton(
                      //     width: 50,
                      //     height: 50,
                      //     icon: CupertinoIcons.speaker_1_fill,
                      //     iconSize: 25,
                      //     onTap: () {
                      //       flutterTts.speakText("hello mahmoud  ");
                      //     },
                      //   ),
                      //   Spacer(),
                      //   CustomCircleIconButton(
                      //     width: 50,
                      //     height: 50,
                      //     icon: Icons.send,
                      //     iconSize: 25,
                      //     onTap: () {
                      //       setState(() {
                      //         _controller.value.isPlaying
                      //             ? _controller.pause()
                      //             : _controller.play();
                      //       });
                      //       if (CameraPage.videos != null) {
                      //         print(
                      //             "call my method =====================================================");
                      //         context
                      //             .read<SignToLanguageCubit>()
                      //             .signToLanguageTranslateVideo(
                      //                 video: CameraPage.videos);
                      //       }
                      //     },
                      //   )
                      // ]),
                      // Row(
                      //   children: [
                      //     CustomCircleIconButton(
                      //       width: 50,
                      //       height: 50,
                      //       icon: Icons.image,
                      //       iconSize: 25,
                      //       onTap: () async {
                      //         final pickedFile = await ImagePicker().pickVideo(
                      //             source: ImageSource.gallery,
                      //             maxDuration: const Duration(seconds: 10));
                      //         //.pickImage(source: ImageSource.gallery);
                      //         print("pickedFile  =====================  111 ");
                      //
                      //         if (pickedFile == null) {
                      //           print(
                      //               "pickedFile == nullpickedFile == null =====================");
                      //         }
                      //         if (pickedFile != null) {
                      //           context
                      //               .read<SignToLanguageCubit>()
                      //               .signToLanguageTranslateVideo(
                      //                   video: pickedFile.path);
                      //         }
                      //         print("pickedFile  =====================  222 ");
                      //       },
                      //     ),
                      //     SizedBox(
                      //       width: 30.w,
                      //     ),
                      //     SizedBox(
                      //       width: 30.w,
                      //     ),
                      //     CustomCircleIconButton(
                      //       width: 70,
                      //       height: 70,
                      //       icon: Icons.camera_alt_outlined,
                      //       iconSize: 30,
                      //       onTap: () async {
                      //         Navigator.push(
                      //             context,
                      //             MaterialPageRoute(
                      //                 builder: (context) => CameraPage()));
                      //         setState(() {});
                      //       },
                      //     ),
                      //   ],
                      // )
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
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(20)),
                                color: Colors.transparent),
                            child: Center(
                                child: CircularProgressIndicator(
                              color: Colors.white,
                            )),
                          ),
                        ),
                      ]),
                      SizedBox(
                        height: 32.w,
                      ),
                      // Row(children: [
                      //   CustomCircleIconButton(
                      //     width: 50,
                      //     height: 50,
                      //     icon: CupertinoIcons.add,
                      //     iconSize: 25,
                      //     onTap: () {
                      //       flutterTts.speakText(" loading");
                      //     },
                      //   ),
                      //   Spacer(),
                      //   CustomCircleIconButton(
                      //     width: 50,
                      //     height: 50,
                      //     icon: Icons.send,
                      //     iconSize: 25,
                      //     onTap: () {
                      //       setState(() {
                      //         _controller.value.isPlaying
                      //             ? _controller.pause()
                      //             : _controller.play();
                      //       });
                      //       if (CameraPage.videos != null) {
                      //         context
                      //             .read<SignToLanguageCubit>()
                      //             .signToLanguageTranslateVideo(
                      //                 video: CameraPage.videos);
                      //       }
                      //     },
                      //   )
                      // ]),
                      // Row(
                      //   children: [
                      //     CustomCircleIconButton(
                      //       width: 50,
                      //       height: 50,
                      //       icon: Icons.image,
                      //       iconSize: 25,
                      //       onTap: () async {
                      //         final pickedFile = await ImagePicker()
                      //             .pickVideo(source: ImageSource.gallery);
                      //         //.pickImage(source: ImageSource.gallery);
                      //         if (pickedFile != null) {
                      //           context
                      //               .read<SignToLanguageCubit>()
                      //               .signToLanguageTranslateVideo(
                      //                   video: pickedFile);
                      //           setState(() {});
                      //         }
                      //       },
                      //     ),
                      //     SizedBox(
                      //       width: 30.w,
                      //     ),
                      //     CustomCircleIconButton(
                      //       width: 50,
                      //       height: 50,
                      //       icon: Icons.share,
                      //       iconSize: 25,
                      //       onTap: () async {
                      //         Share.shareXFiles(
                      //             [context.read<SignToLanguageCubit>().videoPath],
                      //             text: "Check out this video!");
                      //         setState(() {});
                      //       },
                      //     ),
                      //     SizedBox(
                      //       width: 30.w,
                      //     ),
                      //     CustomCircleIconButton(
                      //       width: 70,
                      //       height: 70,
                      //       icon: Icons.camera_alt_outlined,
                      //       iconSize: 30,
                      //       onTap: () async {
                      //         Navigator.push(
                      //             context,
                      //             MaterialPageRoute(
                      //                 builder: (context) => CameraPage()));
                      //         setState(() {});
                      //       },
                      //     ),
                      //   ],
                      // )
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
                            height: 120,
                            width: 300,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(20)),
                                color: Colors.transparent),
                            child: Center(
                                child: Text(
                              "     check your network \nconnection and try again\n ${state.model.errorMessage}",
                              style: GoogleFonts.poppins(
                                  color: hasVideo ? Colors.white : Colors.amber,
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
                          // child: Center(
                          //     child: hasVideo
                          //         ? VideoPlayer(_controller)
                          //         : Text("Take Video For Translate It"))
                        ),
                        Positioned(
                          top: 400,
                          right: 15,
                          child: Container(
                            height: 80,
                            width: 300,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(20)),
                                color: Colors.transparent),
                            child: Center(
                                child: Text(
                              "hello iam mahmoud success",
                              style: GoogleFonts.poppins(
                                  color: hasVideo ? Colors.white : Colors.amber,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 21.sp),
                            )),
                          ),
                        ),
                      ]),
                    ],
                  ),
                ));
              }

              return const Center(
                child: Text("invalid state !!!!!!!!!!!!"),
              );
            },
          ),
          SizedBox(
            height: 20.w,
          ),
          Row(children: [
            SizedBox(width: 8.w,),
            CustomCircleIconButton(
              width: 50.w,
              height: 50.w,
              icon: CupertinoIcons.speaker_1_fill,
              iconSize: 25.w,
              onTap: () {
                flutterTts.speakText("hello mahmoud  ");
              },
            ),
            const Spacer(),
            CustomCircleIconButton(
              width: 50,
              height: 50,
              icon: Icons.send,
              iconSize: 25,
              onTap: () {
                setState(() {
                  _controller.value.isPlaying
                      ? _controller.pause()
                      : _controller.play();
                });
                if (CameraPage.videos != null) {
                  print(
                      "call my method =====================================================");
                  context
                      .read<SignToLanguageCubit>()
                      .signToLanguageTranslateVideo(
                      video: CameraPage.videos);
                }
              },
            ),
            SizedBox(width: 8.w,)
          ]
          ),
          Row(
            children: [
              SizedBox(width: 8.w,),
              CustomCircleIconButton(
                width: 50.w,
                height: 50.w,
                icon: Icons.image,
                iconSize: 25.w,
                onTap: () async {
                  final pickedFile = await ImagePicker().pickVideo(
                      source: ImageSource.gallery,
                      maxDuration: const Duration(seconds: 10));
                  //.pickImage(source: ImageSource.gallery);
                  print("pickedFile  =====================  111 ");

                  if (pickedFile == null) {
                    print(
                        "pickedFile == nullpickedFile == null =====================");
                  }
                  if (pickedFile != null) {
                    context
                        .read<SignToLanguageCubit>()
                        .signToLanguageTranslateVideo(
                        video: pickedFile.path);
                  }
                  print("pickedFile  =====================  222 ");
                },
              ),
              SizedBox(
                width: 60.w,
              ),
              SizedBox(
                width: 30.w,
              ),
              CustomCircleIconButton(
                width: 70,
                height: 70,
                icon: Icons.camera_alt_outlined,
                iconSize: 30,
                onTap: () async {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CameraPage()));
                  setState(() {});
                },
              ),
            ],
          )
        ],
      ),
    );
  }

// void speakText(String text) async {
//   await flutterTts.speak(text);
// }
//
// void stopSpeaking() async {
//   await flutterTts.stop();
// }
}

enum MenuItem { item1 }
