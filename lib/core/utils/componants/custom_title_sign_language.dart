import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';


class CustomTitleSignLanguage extends StatelessWidget {
  const CustomTitleSignLanguage({Key? key,required this.fontSize}) : super(key: key);

 final double fontSize ;

  @override
  Widget build(BuildContext context) {
    return Text(
      "Sign Language",
      style: GoogleFonts.poppins(
          color: Colors.white,
          fontSize: fontSize.sp,
          fontWeight: FontWeight.w500),
    );
  }
}
