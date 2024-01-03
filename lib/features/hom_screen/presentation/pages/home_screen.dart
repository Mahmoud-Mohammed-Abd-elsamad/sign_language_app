import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../config/routes/routes.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_icons.dart';
import '../../../../core/utils/cach_helper.dart';
import '../../../../core/utils/componants/custom_icon_button.dart';
import '../../../../core/utils/componants/custom_title_sign_language.dart';
import '../manager/home_cubit.dart';
import '../widgets/custome_drawer.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);
  static String routeName = "home";

  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      builder: (BuildContext context, state) {
        return Scaffold(
          backgroundColor: Colors.white,
          drawer: const Drawer(
            child: CustomDrawer(),
          ),
          appBar: AppBar(
            elevation: 0.w,
            title: const Center(
                child: CustomTitleSignLanguage(
              fontSize: 21,
            )),
            backgroundColor: AppColors.primaryColor,
            actions: [
              InkWell(
                onTap: () {
                  context.read<HomeCubit>().navigateToProfileScreen();
                },
                child: Padding(
                  padding: EdgeInsets.only(right: 16.0.w),
                  child: const Icon(
                    CupertinoIcons.profile_circled,
                    color: Colors.black87,
                    size: 30,
                  ),
                ),
              )
            ],
            leading: Builder(
              builder: (BuildContext context) {
                return IconButton(
                  icon: Image.asset(AppIcons.drawerIcon),
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                  tooltip:
                      MaterialLocalizations.of(context).openAppDrawerTooltip,
                );
              },
            ),
          ),
          body: Column(
            children: [
              Stack(children: [
                Positioned(
                    top: 60.w,
                    left: 25.w,
                    child: Center(
                        child: Image.asset("assets/images/home_image.png"))),
                Positioned(
                    top: 80.w,
                    left: 290.w,
                    child: ImageIcon(
                      AssetImage(AppIcons.noListenIcon),
                      size: 50,
                    )),
                Positioned(
                    top: 80.w,
                    left: 25.w,
                    child: ImageIcon(
                      AssetImage(AppIcons.noSoundIcon),
                      size: 50,
                    )),
                Container(
                  height: 400.w,
                  width: double.infinity,
                )
              ]),
              SizedBox(
                height: 32.w,
              ),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          CustomCircleIconButton(
                            width: 90,
                            height: 90,
                            icon: Icons.camera_alt_outlined,
                            iconSize: 35,
                            onTap: () {
                              Navigator.pushNamed(
                                  context, Routes.signToLanguageScreen);
                            },
                          ),
                          Text(
                            "Camera",
                            style: GoogleFonts.poppins(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 20.sp),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 20.w,
                    ),
                    Column(
                      children: [
                        CustomCircleIconButton(
                          width: 90,
                          height: 90,
                          icon: Icons.edit_calendar_outlined,
                          iconSize: 35,
                          onTap: () {
                            Navigator.pushNamed(
                                context, Routes.languageToSignScreen);
                          },
                        ),
                        Text(
                          "Write",
                          style: GoogleFonts.poppins(
                              fontWeight: FontWeight.bold, fontSize: 20.sp),
                        )
                      ],
                    ),
                    SizedBox(
                      width: 50.w,
                    ),
                  ],
                ),
              )
            ],
          ),
        );
      },
      listener: (BuildContext context, HomeState state) {
        if (state is ProfileState) {
          showProfileScreen(context);
        }
      },
    );
  }

  showProfileScreen(BuildContext context) {
    var alertDialog = AlertDialog(
      title: Text(
        "Profile",
        style: GoogleFonts.poppins(
            color: Colors.black, fontSize: 21, fontWeight: FontWeight.w500),
      ),
      content: Container(
        height: 350.w,
        child: Column(
          children: [
            SizedBox(
              height: 8.w,
            ),
            Center(
              child: Container(
                  height: 85.w,
                  width: 85.w,
                  decoration: const BoxDecoration(
                    color: Colors.teal,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    FontAwesomeIcons.m,
                    size: 50.w,
                    color: Colors.white,
                  )),
            ),
            SizedBox(
              height: 8.w,
            ),
            Center(
              child: Text(
                "Mahmoud Mohammed ",
                style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                    fontSize: 16.sp),
              ),
            ),
            Center(
              child: Text(
                "M.mohammed55@gmail.com ",
                style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                    fontSize: 12.sp),
              ),
            ),
            Column(mainAxisSize: MainAxisSize.max, children: [
              _customItem(
                  text: 'History',
                  icon: Icons.history,
                  onTap: () {
                    Navigator.pushNamed(context, Routes.historyScreen);
                  },
                  flipX: false),
              _customItem(
                  text: 'Settings',
                  icon: Icons.settings,
                  onTap: () {
                    // delete saved token
                  },
                  flipX: true),
              _customItem(
                  text: 'Sign out',
                  icon: Icons.output_outlined,
                  onTap: () {
                    // delete saved token
                    CacheHelper.deleteToken();
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
    );
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return alertDialog;
        });
  }

  buildBottomNavigationBarItem(IconData image, bool selected) {
    return BottomNavigationBarItem(
        icon: Container(
            height: 40.w,
            width: 40.w,
            decoration: BoxDecoration(
                color: selected ? Colors.white : AppColors.primaryColor,
                shape: BoxShape.circle),
            child: Icon(
              image,
              color: selected ? AppColors.primaryColor : Colors.white,
            )),
        label: "");
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
                  size: 25,
                )),
            SizedBox(
              width: 5.w,
            ),
            Text(
              text,
              style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                  fontSize: 16.sp),
            ),
          ],
        ),
      ),
    );
  }
}
