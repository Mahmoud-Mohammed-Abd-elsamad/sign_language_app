import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/componants/custom_icon_button.dart';
import '../../../../core/utils/flutter_tts.dart';
import '../manager/language_to_sign_cubit.dart';

class LanguageToSignScreen extends StatelessWidget {
  LanguageToSignScreen({Key? key}) : super(key: key);

  FlutterTtsMe flutterTts = FlutterTtsMe(setSpeechRate: 1.0, setVolume: 1.0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: AppColors.primaryColor,
        title: Text(
          "Language To Sign",
          style: GoogleFonts.poppins(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 20.sp),
        ),
      ),
      body: SingleChildScrollView(
        child: BlocConsumer<LanguageToSignCubit, LanguageToSignState>(
          listener: (context, state) {
            // TODO: implement listener
          },
          builder: (context, state) {
            if (state is LanguageToSignLoading) {
              return Column(
                children: [
                  SizedBox(
                    height: 300.w,
                  ),
                  const SizedBox(
                    height: 100,
                    width: double.infinity,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    height: 200.w,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: TextField(
                      controller:
                          context.read<LanguageToSignCubit>().textController,
                      decoration: InputDecoration(
                        suffixIcon: InkWell(
                            child: Icon(
                          Icons.send,
                          color: AppColors.primaryColor,
                        )),
                        filled: true,
                        fillColor: Colors.white,
                        hintText: "type to translate",
                        contentPadding: EdgeInsets.all(20),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              width: 3,
                              color: AppColors.primaryColor,
                            ),
                            borderRadius:
                                BorderRadius.circular(50) //<-- SEE HERE
                            ),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 3, color: AppColors.primaryColor),
                            borderRadius:
                                BorderRadius.circular(50) //<-- SEE HERE
                            ),
                        disabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 3, color: AppColors.primaryColor),
                            borderRadius:
                                BorderRadius.circular(50) //<-- SEE HERE
                            ),
                      ),
                    ),
                  )
                ],
              );
            } else if (state is LanguageToSignSuccess) {
              context.read<LanguageToSignCubit>().textController.text = "";
              return Column(
                children: [
                  SizedBox(
                    height: 350.w,
                  ),
                  SizedBox(
                    height: 250,
                    width: double.infinity,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              "  Language",
                              style: GoogleFonts.poppins(
                                  color: Colors.black,
                                  fontSize: 16.w,
                                  fontWeight: FontWeight.w400),
                            ),
                            Spacer(),
                            IconButton(
                                onPressed: () {
                                  flutterTts.speakText("${state.model.word}");
                                },
                                icon: const Icon(CupertinoIcons.speaker_1_fill))
                          ],
                        ),
                        SizedBox(
                          height: 8.w,
                        ),
                        Row(
                          children: [
                            Text(
                              "  ${state.model.word}",
                              style: GoogleFonts.poppins(
                                  color: Colors.black,
                                  fontSize: 21.w,
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 8.w,
                        ),
                        Divider(
                          height: 6.w,
                          color: Colors.black,
                          endIndent: 80.0.w,
                          indent: 80.0.w,
                          thickness: 2,
                        ),
                        SizedBox(
                          height: 8.w,
                        ),
                        Row(
                          children: [
                            Text(
                              "  Sign",
                              style: GoogleFonts.poppins(
                                  color: AppColors.primaryColor,
                                  fontSize: 16.w,
                                  fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 8.w,
                        ),
                        Expanded(
                          flex: 2,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: state.model.images!.length,
                            itemBuilder: (context, index) {
                              return Container(
                                height: 50.w,
                                width: 100.w,
                                decoration: BoxDecoration(
                                    color: AppColors.primaryColor,
                                    border: Border.all(
                                        color: AppColors.primaryColor)),
                                child: Image.network(
                                  state.model.images![index],
                                  fit: BoxFit.fill,
                                ),
                              );
                            },
                          ),
                        ),
                        SizedBox(
                          height: 8.w,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 200.w,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: TextField(
                      controller:
                          context.read<LanguageToSignCubit>().textController,
                      decoration: InputDecoration(
                        suffixIcon: InkWell(
                            onTap: () {
                              context
                                  .read<LanguageToSignCubit>()
                                  .languageToSignTranslate();
                            },
                            child: Icon(
                              Icons.send,
                              color: AppColors.primaryColor,
                            )),
                        filled: true,
                        fillColor: Colors.white,
                        hintText: "type to translate",
                        contentPadding: EdgeInsets.all(20),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              width: 3,
                              color: AppColors.primaryColor,
                            ),
                            borderRadius:
                                BorderRadius.circular(50) //<-- SEE HERE
                            ),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 3, color: AppColors.primaryColor),
                            borderRadius:
                                BorderRadius.circular(50) //<-- SEE HERE
                            ),
                        disabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 3, color: AppColors.primaryColor),
                            borderRadius:
                                BorderRadius.circular(50) //<-- SEE HERE
                            ),
                      ),
                    ),
                  )
                ],
              );
            } else if (state is LanguageToSignInitial) {
              return Column(
                children: [
                  SizedBox(
                    height: 300.w,
                  ),
                  SizedBox(
                    height: 100,
                    width: double.infinity,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 10,
                      itemBuilder: (context, index) {
                        return Container(
                          height: 20.w,
                          width: 100.w,
                          decoration: BoxDecoration(
                              color: AppColors.primaryColor,
                              border:
                                  Border.all(color: AppColors.primaryColor)),
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    height: 200.w,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: TextField(
                      controller:
                          context.read<LanguageToSignCubit>().textController,
                      decoration: InputDecoration(
                        suffixIcon: InkWell(
                            onTap: () {
                              context
                                  .read<LanguageToSignCubit>()
                                  .languageToSignTranslate();
                              print("hello hello");
                            },
                            child: Icon(
                              Icons.send,
                              color: AppColors.primaryColor,
                            )),
                        filled: true,
                        fillColor: Colors.white,
                        hintText: "type to translate",
                        contentPadding: EdgeInsets.all(20),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              width: 3,
                              color: AppColors.primaryColor,
                            ),
                            borderRadius:
                                BorderRadius.circular(50) //<-- SEE HERE
                            ),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 3, color: AppColors.primaryColor),
                            borderRadius:
                                BorderRadius.circular(50) //<-- SEE HERE
                            ),
                        disabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 3, color: AppColors.primaryColor),
                            borderRadius:
                                BorderRadius.circular(50) //<-- SEE HERE
                            ),
                      ),
                    ),
                  )
                ],
              );
            } else if (state is LanguageToSignFailed) {
              return Column(
                children: [
                  SizedBox(
                    height: 300.w,
                  ),
                  SizedBox(
                    height: 100,
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                          child: Text(
                        "${state.model.errorMessage} \"please try again\"",
                        style: GoogleFonts.poppins(
                            fontSize: 16.sp, fontWeight: FontWeight.w500),
                      )),
                    ),
                  ),
                  SizedBox(
                    height: 200.w,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: TextField(
                      controller:
                          context.read<LanguageToSignCubit>().textController,
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                          onPressed: () {
                            context
                                .read<LanguageToSignCubit>()
                                .languageToSignTranslate();
                            print("hello hello");
                          },
                          icon: Icon(
                            Icons.send,
                            color: AppColors.primaryColor,
                          ),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        hintText: "type to translate",
                        contentPadding: EdgeInsets.all(20),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              width: 3,
                              color: AppColors.primaryColor,
                            ),
                            borderRadius:
                                BorderRadius.circular(50) //<-- SEE HERE
                            ),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 3, color: AppColors.primaryColor),
                            borderRadius:
                                BorderRadius.circular(50) //<-- SEE HERE
                            ),
                        disabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 3, color: AppColors.primaryColor),
                            borderRadius:
                                BorderRadius.circular(50) //<-- SEE HERE
                            ),
                      ),
                    ),
                  )
                ],
              );
            } else {
              return Column(
                children: [
                  SizedBox(
                    height: 300.w,
                  ),
                  SizedBox(
                    height: 100,
                    width: double.infinity,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 10,
                      itemBuilder: (context, index) {
                        return Container(
                          height: 20.w,
                          width: 100.w,
                          decoration: BoxDecoration(
                              color: Colors.amber,
                              border:
                                  Border.all(color: AppColors.primaryColor)),
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    height: 200.w,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: TextField(
                      controller:
                          context.read<LanguageToSignCubit>().textController,
                      decoration: InputDecoration(
                        suffixIcon: InkWell(
                            onTap: () {
                              context
                                  .read<LanguageToSignCubit>()
                                  .languageToSignTranslate();
                              print("hello hello");
                            },
                            child: Icon(
                              Icons.send,
                              color: Colors.lightGreenAccent,
                            )),
                        filled: true,
                        fillColor: Colors.white,
                        hintText: "type to translate",
                        contentPadding: EdgeInsets.all(20),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              width: 3,
                              color: AppColors.primaryColor,
                            ),
                            borderRadius:
                                BorderRadius.circular(50) //<-- SEE HERE
                            ),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 3, color: AppColors.primaryColor),
                            borderRadius:
                                BorderRadius.circular(50) //<-- SEE HERE
                            ),
                        disabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 3, color: AppColors.primaryColor),
                            borderRadius:
                                BorderRadius.circular(50) //<-- SEE HERE
                            ),
                      ),
                    ),
                  )
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
