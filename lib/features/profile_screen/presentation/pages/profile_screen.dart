import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../config/routes/routes.dart';
import '../../../../core/utils/app_colors.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Container(
        child: Container(
          height: double.infinity,
          child: Column(
            children: [
              SizedBox(
                height: 150.w,
              ),
              Center(
                child: Container(
                    height: 120.w,
                    width: 160.w,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: Container(
                      child: Icon(
                        CupertinoIcons.profile_circled,
                        size: 120.w,
                      ),
                    )),
              ),
              Center(
                child: Text(
                  "Mahmoud Mohammed ",
                  style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w500,
                      color: AppColors.primaryColor,
                      fontSize: 20.sp),
                ),
              ),
              Column(mainAxisSize: MainAxisSize.max, children: [
                _customItem(
                    text: 'About me',
                    icon: CupertinoIcons.profile_circled,
                    onTap: () {
                      _settingModalBottomSheet(context);
                    },
                    flipX: false),
                _customItem(
                    text: 'History',
                    icon: Icons.history,
                    onTap: () {},
                    flipX: false),
                _customItem(
                    text: 'Sign out',
                    icon: Icons.output_outlined,
                    onTap: () {
                      // delete saved token

                      Navigator.pushNamedAndRemoveUntil(
                          context, Routes.onBoardingScreen, (route) => false);
                    },
                    flipX: true),
              ])
              // Container(
              //   height: 475.3.w,
              //   width: double.infinity,
              //   decoration: BoxDecoration(
              //     color: Colors.white,
              //     borderRadius: BorderRadius.only(topLeft: Radius.circular(50.w),
              //         topRight: Radius.circular(50.w),bottomLeft: Radius.circular(0.w),bottomRight: Radius.circular(0.w))
              //   ),
              //   child: Padding(
              //
              //     padding: const EdgeInsets.all(16.0),
              //     child: Column(
              //       crossAxisAlignment: CrossAxisAlignment.start,
              //       children: [
              //         SizedBox(height: 32.w,),
              //         _customItem(label: 'Full Name', text: 'Mahmoud Mohammad'),
              //         SizedBox(height: 8.w,),
              //         _customItem(label: 'E-mail', text: 'mahmoud.mohamed55@gmail.com'),
              //         SizedBox(height: 8.w,),
              //         Text("History",style:GoogleFonts.poppins(color: Colors.black87,fontSize: 21.sp,fontWeight: FontWeight.bold),),
              //
              //
              //
              //
              //       ],
              //     )
              //   ),
              // )
            ],
          ),
        ),
      ),
    );
  }

  Widget _customItem(
      {required String text,
      required IconData icon,
      required void Function() onTap,
      required bool flipX}) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Row(
          children: [
            Transform.flip(
                flipX: flipX,
                child: Icon(
                  icon,
                  size: 30,
                )),
            SizedBox(
              width: 5.w,
            ),
            Text(
              text,
              style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                  fontSize: 20.sp),
            ),
          ],
        ),
      ),
    );
  }

  void _settingModalBottomSheet(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Container(
            height: 477.w,
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Full Name",
                    style: GoogleFonts.poppins(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: 20.sp),
                  ),
                  SelectableText(
                    "Mahmoud Mohammed",
                    style: GoogleFonts.poppins(
                        color: AppColors.primaryColor,
                        fontWeight: FontWeight.w500,
                        fontSize: 20.sp),
                    cursorColor: Colors.black,
                    autofocus: false,
                  ),
                  Text(
                    "Email",
                    style: GoogleFonts.poppins(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: 20.sp),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(12))),
                    child: SelectableText(
                      "Mahmoud.mohammed55@gmail.com",
                      style: GoogleFonts.poppins(
                          color: AppColors.primaryColor,
                          fontWeight: FontWeight.w500,
                          fontSize: 16.sp),
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }

  Widget _customItemm({
    required String label,
    required String text,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.poppins(
              color: Colors.black87,
              fontSize: 18.sp,
              fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 8.w,
        ),
        Container(
            height: 50.w,
            width: double.infinity,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(15)),
                border: Border.all(color: Colors.grey)),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                text,
                style: GoogleFonts.poppins(
                    color: AppColors.primaryColor,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500),
              ),
            ))
      ],
    );
  }
}
