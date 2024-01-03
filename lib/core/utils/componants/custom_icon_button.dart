import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../app_colors.dart';

class CustomCircleIconButton extends StatelessWidget {
   CustomCircleIconButton({Key? key,required this.width, required this.height, required this.icon,required this.iconSize,required this.onTap}) : super(key: key);

  double width;
  double height;
  IconData icon;
  double iconSize;
  void Function() onTap;


  @override
  Widget build(BuildContext context) {
    return InkWell(
    onTap:onTap ,
    child: Container(
      height: height.w,
      width: width.w,
      decoration: BoxDecoration(
        color: AppColors.primaryColor,
        shape: BoxShape.circle,
      ),
      child: Icon(icon, size: iconSize,),
    ),
      );
  }
}
