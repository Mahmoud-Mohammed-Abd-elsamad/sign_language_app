import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../app_colors.dart';

class CustomButton extends StatelessWidget {
   CustomButton(
      {super.key,
      required this.width,
      required this.height,
      required this.text,
      required this.onTap,
      required this.backgroundColor,
      required this.borderColor});

  double width;
  double height;
  String text;
  void Function() onTap;
  Color backgroundColor;
  Color borderColor;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: width.w,
        height: height.w,
        decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.all(
              Radius.circular(15.w),
            ),
            border: Border.all(color: borderColor)),
        child: Center(
            child: Text(
          text,
          style: GoogleFonts.inter(
              color: Colors.white,
                  fontSize: 16.w,
                  fontWeight: FontWeight.w700),
            )),
      ),
    );
  }
}
