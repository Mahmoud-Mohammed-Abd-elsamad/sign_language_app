import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../app_colors.dart';

class CustomCircleIconButton extends StatelessWidget {
   const CustomCircleIconButton({Key? key,required this.width, required this.height, required this.icon,required this.iconSize,required this.onTap}) : super(key: key);

 final double width;
 final double height;
   final IconData icon;
   final double iconSize;
 final void Function() onTap;


  @override
  Widget build(BuildContext context) {
    return InkWell(
    onTap:onTap ,
    child: Container(
      height: height.w,
      width: width.w,
      decoration: const BoxDecoration(
        color: AppColors.primaryColor,
        shape: BoxShape.circle,
      ),
      child: Icon(icon, size: iconSize,color: Colors.white,),
    ),
      );
  }
}
