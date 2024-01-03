import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/componants/custom_icon_button.dart';
import '../../../../core/utils/flutter_tts.dart';
import '../../domain/entities/sign_to_language_body.dart';
import '../manager/sign_to_language_cubit.dart';
import 'camera_page/camera_page.dart';

class SignToLanguageScreen extends StatefulWidget {
  const SignToLanguageScreen({Key? key}) : super(key: key);

  @override
  State<SignToLanguageScreen> createState() => _SignToLanguageScreenState();
}

class _SignToLanguageScreenState extends State<SignToLanguageScreen> {
  String imagePath = "";
  late VideoPlayerController _controller;
  bool hasVideo = false;

  FlutterTtsMe flutterTts = FlutterTtsMe(setSpeechRate: 3.0, setVolume: 5.0);


  @override
  void initState() {
    super.initState();

    if (CameraPage.videos != null) {
      print(
          "======================1  hasVideo $hasVideo ===================================");

      hasVideo = true;
      _controller = VideoPlayerController.file(File(CameraPage.videos!))
        ..initialize().then((_) {
          // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
          setState(() {});
        });
    } else {
      print(
          "====================== 2 hasVideo $hasVideo ===================================");
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
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
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
      body: Center(
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
                      borderRadius: BorderRadius.all(Radius.circular(10.w))),
                  child: Center(
                      child: hasVideo
                          ? VideoPlayer(_controller)
                          : Text("Take Video For Translate It"))),
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
            SizedBox(
              height: 32.w,
            ),
            Row(children: [
              CustomCircleIconButton(
                width: 50,
                height: 50,
                icon: CupertinoIcons.speaker_1_fill,
                iconSize: 25,
                onTap: () {
                  flutterTts.speakText("hello mahmoud  ");
                },
              ),
              Spacer(),
              CustomCircleIconButton(
                width: 50,
                height: 50,
                icon: Icons.send,
                iconSize: 25,
                onTap: () {
                  {
                    setState(() {
                      _controller.value.isPlaying
                          ? _controller.pause()
                          : _controller.play();
                    });
                  }
                  context
                      .read<SignToLanguageCubit>()
                      .signToLanguageTranslateVideo(SignToLanguageBody(
                          name: "name",
                          email: "email",
                          password: "password",
                          rePassword: "rePassword"));
                },
              )
            ]),
            Row(
              children: [
                CustomCircleIconButton(
                  width: 50,
                  height: 50,
                  icon: Icons.image,
                  iconSize: 25,
                  onTap: () async {
                    final pickedFile = await ImagePicker()
                        .pickImage(source: ImageSource.gallery);
                    if (pickedFile == null) return;
                    imagePath = File(pickedFile.path).path;
                    setState(() {});
                  },
                ),
                SizedBox(
                  width: 90.w,
                ),
                CustomCircleIconButton(
                  width: 70,
                  height: 70,
                  icon: Icons.camera_alt_outlined,
                  iconSize: 30,
                  onTap: () async {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => CameraPage()));
                    setState(() {});
                  },
                ),
              ],
            )
          ],
        ),
      )),
    );
  }
  //
  // void speakText(String text) async {
  //   await flutterTts.speak(text);
  // }
  //
  // void stopSpeaking() async {
  //   await flutterTts.stop();
  // }
}
