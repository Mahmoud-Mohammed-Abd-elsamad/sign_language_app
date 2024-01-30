import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sign_language_app/core/utils/app_images.dart';
import 'package:sign_language_app/core/utils/app_strings.dart';

import '../../../../config/routes/routes.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_icons.dart';
import '../../../../core/utils/cach_helper.dart';
import '../../../../core/utils/componants/custom_icon_button.dart';
import '../../../../core/utils/componants/custom_title_sign_language.dart';
import '../manager/home_cubit.dart';
import '../widgets/custome_drawer.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);



  @override
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
                    color: Colors.white,
                    size: 30,
                  ),
                ),
              )
            ],
            leading: Builder(
              builder: (BuildContext context) {
                return IconButton(
                  icon: const Icon(Icons.menu,color: Colors.white,),
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
                        child: Image.asset(AppImages.homeScreenImage))),
                Positioned(
                    top: 80.w,
                    left: 290.w,
                    child: const ImageIcon(
                      AssetImage(AppIcons.noListenIcon),
                      size: 50,
                    )),
                Positioned(
                    top: 80.w,
                    left: 25.w,
                    child: const ImageIcon(
                      AssetImage(AppIcons.noSoundIcon),
                      size: 50,
                    )),
                SizedBox(
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
                            AppStrings.camera,
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
                          AppStrings.write,
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
        if (state is HomeStateSuccess) {
          context.read<HomeCubit>().name = state.model.name?? "";
          context.read<HomeCubit>().email = state.model.email?? "";
        }else if (state is NavigateToProfileScreenSuccess) {
          _showProfileScreen(context, name:context.read<HomeCubit>().name, email:context.read<HomeCubit>().email);
        }
      },
    );
  }



  _showProfileScreen(BuildContext context,{required String name,required String email}) {
    var alertDialog = AlertDialog(
      title: Text(
        AppStrings.profile,
        style: GoogleFonts.poppins(
            color: Colors.black, fontSize: 21, fontWeight: FontWeight.w500),
      ),
      content: SizedBox(
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
                    _profileIcon(name:name),
                    size: 50.w,
                    color: Colors.white,
                  )),
            ),
            SizedBox(
              height: 8.w,
            ),
            Center(
              child: Text(
                "$name ",
                style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                    fontSize: 16.sp),
              ),
            ),
            Center(
              child: Text(
                email,
                style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                    fontSize: 12.sp),
              ),
            ),
            Column(mainAxisSize: MainAxisSize.max, children: [
              _customItem(
                  text:AppStrings.history,
                  icon: Icons.history,
                  onTap: () {
                    Navigator.pushNamed(context, Routes.historyScreen);
                  },
                  flipX: false),
              _customItem(
                  text: AppStrings.settings,
                  icon: Icons.settings,
                  onTap: () {
                    Navigator.pushNamed(context, Routes.settingScreen);
                  },
                  flipX: true),
              _customItem(
                  text: AppStrings.signOut,
                  icon: Icons.output_outlined,
                  onTap: () {
                    // delete saved token
                    CacheHelper.deleteToken();
                    Navigator.pushNamedAndRemoveUntil(
                        context, Routes.loginScreen, (route) => false);
                  },
                  flipX: true),
            ])
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
  IconData _profileIcon({required String name}){
    IconData icon = CupertinoIcons.profile_circled;
    List<String> alphabets = [  "A", "a" ,"B" , "b" , "C" , "c" , "D" ,"d" , "E", "e" , "F" , "f" , "G" , "g" , "H" ,
      "h" , "I" , "i" , "J" , "j" , "K" , "k" , "L" , "l" ," M" , "m" , "N" , "n" , "O" , "o" , "P" , "p"  ,"Q" ,"q" ,
      "R" , "r" , "S" , "s" , "T" , "t" , "U" , "u" , "V" , "v" , "W" , "w" , "X" , "x" , "Y" , "y" , "Z", "z" ];

    if(name[0] == alphabets[0] || name[0] == alphabets[1]) {
      icon = FontAwesomeIcons.a;
    }else if(name[0] == alphabets[2] || name[0] == alphabets[3]) {
      icon = FontAwesomeIcons.b;
    }else if(name[0] == alphabets[4] || name[0] == alphabets[5]) {
      icon = FontAwesomeIcons.c;
    }else if(name[0] == alphabets[6] || name[0] == alphabets[7]) {
      icon = FontAwesomeIcons.d;
    }else if(name[0] == alphabets[8] || name[0] == alphabets[9]) {
      icon = FontAwesomeIcons.e;
    }else if(name[0] == alphabets[10] || name[0] == alphabets[11]) {
      icon = FontAwesomeIcons.f;
    }else if(name[0] == alphabets[12] || name[0] == alphabets[13]) {
      icon = FontAwesomeIcons.g;
    }else if(name[0] == alphabets[14] || name[0] == alphabets[15]) {
      icon = FontAwesomeIcons.h;
    }else if(name[0] == alphabets[16] || name[0] == alphabets[17]) {
      icon = FontAwesomeIcons.i;
    }else if(name[0] == alphabets[18] || name[0] == alphabets[19]) {
      icon = FontAwesomeIcons.j;
    }else if(name[0] == alphabets[20] || name[0] == alphabets[21]) {
      icon = FontAwesomeIcons.k;
    }else if(name[0] == alphabets[22] || name[0] == alphabets[23]) {
      icon = FontAwesomeIcons.l;
    }else if(name[0] == alphabets[24] || name[0] == alphabets[25]) {
      icon = FontAwesomeIcons.m;
    }else if(name[0] == alphabets[26] || name[0] == alphabets[27]) {
      icon = FontAwesomeIcons.n;
    }else if(name[0] == alphabets[28] || name[0] == alphabets[29]) {
      icon = FontAwesomeIcons.o;
    }else if(name[0] == alphabets[30] || name[0] == alphabets[31]) {
      icon = FontAwesomeIcons.p;
    }else if(name[0] == alphabets[32] || name[0] == alphabets[33]) {
      icon = FontAwesomeIcons.q;
    }else if(name[0] == alphabets[34] || name[0] == alphabets[35]) {
      icon = FontAwesomeIcons.r;
    }else if(name[0] == alphabets[36] || name[0] == alphabets[37]) {
      icon = FontAwesomeIcons.s;
    }else if(name[0] == alphabets[38] || name[0] == alphabets[39]) {
      icon = FontAwesomeIcons.t;
    }else if(name[0] == alphabets[40] || name[0] == alphabets[41]) {
      icon = FontAwesomeIcons.u;
    }else if(name[0] == alphabets[42] || name[0] == alphabets[43]) {
      icon = FontAwesomeIcons.v;
    }else if(name[0] == alphabets[44] || name[0] == alphabets[45]) {
      icon = FontAwesomeIcons.w;
    }else if(name[0] == alphabets[46] || name[0] == alphabets[47]) {
      icon = FontAwesomeIcons.x;
    }else if(name[0] == alphabets[48] || name[0] == alphabets[49]) {
      icon = FontAwesomeIcons.y;
    }else{
      icon = FontAwesomeIcons.z;
    }

    return icon;
  }
}
