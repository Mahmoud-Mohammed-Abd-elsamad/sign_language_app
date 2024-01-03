import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_camera/flutter_camera.dart';
import '../../../../../config/routes/routes.dart';

class CameraPage extends StatefulWidget {
  const CameraPage({Key? key}) : super(key: key);
  static List picture = [];
  static String? videos;

  @override
  _CameraPageState createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  @override
  Widget build(BuildContext context) {
    return FlutterCamera(
      color: Colors.amber,
      onImageCaptured: (value) {
        final path = value.path;

        print("::::::::::::::::::::::::::::::::: $path");
        if (path.contains('.jpg')) {
          CameraPage.picture.add(value.path);
          Navigator.pushNamedAndRemoveUntil(
              context, Routes.signToLanguageScreen, (route) => false);
        }
      },
      onVideoRecorded: (value) {
        final path = value.path;
        CameraPage.videos = value.path;
        Navigator.pushNamedAndRemoveUntil(
            context, Routes.signToLanguageScreen, (route) => false);
        print('::::::::::::::::::::::::;; video pth $path');

        ///Show video preview .mp4
      },
    );
    // return Container();
  }
}

