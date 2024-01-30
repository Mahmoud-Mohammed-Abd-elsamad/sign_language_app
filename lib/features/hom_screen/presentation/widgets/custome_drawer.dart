import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_images.dart';
import '../pages/colors_screen.dart';
import '../pages/litters_screen.dart';
import '../pages/numders_screen.dart';


class CustomDrawer extends StatefulWidget {
  const CustomDrawer({Key? key,})
      : super(key: key);

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height:250.w ,
          width: 280.w,
          color: AppColors.primaryColor,
          child: Center(child: Text(
            "Sign Language",
            style: GoogleFonts.poppins(
                color: Colors.white,
                fontSize: 21.sp,
                fontWeight: FontWeight.w500),
          )),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              InkWell(
                  onTap: () {
                    //Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const NumbersScreen()),
                    );
                    setState(() {});
                  },
                  child: Image.asset(AppImages.numbersIcon,width: 100.w,height: 150.w,)
              ),
              InkWell(
                onTap: () {
                //  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const ColorsScreen()),
                  );
                  setState(() {});
                },
                child:  Image.asset(AppImages.colorsIcon,width: 100.w,height: 150.w,),
              ),
              InkWell(
                onTap: () {
                  //Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const AlphabetScreen()),
                  );
                  setState(() {});
                },
                child: SingleChildScrollView(
                    child: Image.asset(
                      AppImages.alphabetIcon,
                      width: 100.w,
                      height: 150.w,
                    )),
              )
            ],
          ),
        ),
      ],
    );
  }
}
