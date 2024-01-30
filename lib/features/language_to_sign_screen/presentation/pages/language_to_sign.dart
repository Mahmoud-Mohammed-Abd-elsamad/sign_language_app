import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sign_language_app/core/utils/app_strings.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/flutter_tts.dart';
import '../manager/language_to_sign_cubit.dart';

class LanguageToSignScreen extends StatelessWidget {
  LanguageToSignScreen({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white, //change your color here
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: AppColors.primaryColor,
        title: Text(
          AppStrings.languageToSign,
          style: GoogleFonts.poppins(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 20.sp),
        ),
      ),
      body: SizedBox(
        height: 820.w,
        child: SingleChildScrollView(
          child: Column(
            children: [
              BlocConsumer<LanguageToSignCubit, LanguageToSignState>(
                listener: (context, state) {
                  if (state is LanguageToSignSuccess) {
                    context.read<LanguageToSignCubit>().textController.text =
                        "";
                  }
                },
                builder: (context, state) {
                  if (state is LanguageToSignInitial) {
                    return Column(
                      children: [
                        Container(
                          height: 230.w,
                        ),
                        Container(
                          color: AppColors.darkWight,
                          height: 150.w,
                          child: Center(
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 16.w,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      AppStrings.text,
                                      style: GoogleFonts.poppins(
                                          color: Colors.black,
                                          fontSize: 16.w,
                                          fontWeight: FontWeight.w400),
                                    ),
                                    SizedBox(
                                      height: 8.w,
                                    ),
                                    const Spacer(),
                                    IconButton(
                                        onPressed: () {
                                          context.read<LanguageToSignCubit>().flutterTts.speakText("");
                                        },
                                        icon: const Icon(
                                            CupertinoIcons.speaker_1_fill))
                                  ],
                                ),
                                SizedBox(
                                  height: 8.w,
                                ),
                                const Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [],
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
                                      AppStrings.sign,
                                      style: GoogleFonts.poppins(
                                          color: AppColors.primaryColor,
                                          fontSize: 16.w,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    );
                  } else if (state is LanguageToSignLoading) {
                    return Column(
                      children: [
                        SizedBox(
                          height: 300.w,
                        ),
                        const CircularProgressIndicator(
                          color: AppColors.primaryColor,
                        ),
                        SizedBox(
                          height: 35.w,
                        ),
                      ],
                    );
                  } else if (state is LanguageToSignSuccess) {
                    return SingleChildScrollView(
                      child: Column(
                        children: [
                          SizedBox(
                            height: 267.w,
                          ),
                          TranslateItem(
                            flutterTts:  context.read<LanguageToSignCubit>().flutterTts,
                            state: state,
                          ),
                        ],
                      ),
                    );
                  } else if (state is LanguageToSignFailed) {
                    return Column(
                      children: [
                        SizedBox(
                          height: 200.w,
                        ),
                        SizedBox(
                          width:270.w,
                          height: 110,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width:150.w,
                              decoration:const BoxDecoration(
                                color: AppColors.darkWight
                              ),
                              child: Center(
                                  child: Text(
                                AppStrings.checkYourConnection,
                                style: GoogleFonts.poppins(
                                    fontSize: 16.sp, fontWeight: FontWeight.w500),
                              )),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 200.w,
                        ),
          
          
                      ],
                    );
                  } else {
                    return Column(
                      children: [
                        SizedBox(
                          height: 0.w,
                        ),
                        const Center(
                          child: SizedBox(
                              height: 200,
                              width: double.infinity,
                              child: Text(
                                ".......",
                                style: TextStyle(color: Colors.red),
                              )),
                        ),
                      ],
                    );
                  }
                },
              ),
              SizedBox(
                height: 250.w,
              ),
              Container(child: _customTextField(context))
            ],
          ),
        ),
      ),
    );
  }

  Padding _customTextField(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0),
      child: TextField(
        controller: context.read<LanguageToSignCubit>().textController,
        decoration: InputDecoration(
          suffixIcon: InkWell(
              onTap: () {
                context.read<LanguageToSignCubit>().languageToSignTranslate();
                FocusScope.of(context).unfocus();
              },
              child: const Icon(
                Icons.send,
                color: AppColors.primaryColor,
              )),
          filled: true,
          fillColor: Colors.white,
          hintText: AppStrings.typeToTranslate,
          contentPadding: const EdgeInsets.all(20),
          enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                width: 3,
                color: AppColors.primaryColor,
              ),
              borderRadius: BorderRadius.circular(50) //<-- SEE HERE
              ),
          focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(width: 3, color: AppColors.primaryColor),
              borderRadius: BorderRadius.circular(50) //<-- SEE HERE
              ),
          disabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(width: 3, color: AppColors.primaryColor),
              borderRadius: BorderRadius.circular(50) //<-- SEE HERE
              ),
        ),
      ),
    );
  }
}

class TranslateItem extends StatelessWidget {
  const TranslateItem(
      {super.key, required this.flutterTts, required this.state});

  final FlutterTtsMe flutterTts;
  final dynamic state;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 215.w,
      width: double.infinity,
      child: Column(
        children: [
          Row(
            children: [
              Text(
                AppStrings.text,
                style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontSize: 16.w,
                    fontWeight: FontWeight.w400),
              ),
              SizedBox(
                height: 8.w,
              ),
              const Spacer(),
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
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Text(
                  "  ${state.model.word}",
                  style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontSize: 21.w,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 16.w,
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
                AppStrings.sign,
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
                return Stack(children: [
                  const Positioned(
                      top: 25,
                      right: 45,
                      child: SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                          ))),
                  Container(
                    height: 65.w,
                    width: 100.w,
                    decoration: BoxDecoration(
                        color: AppColors.primaryColor,
                        border: Border.all(color: AppColors.primaryColor)),
                    child: Image.network(
                      state.model.images![index],
                      fit: BoxFit.fill,
                    ),
                  ),
                ]);
              },
            ),
          ),

        ],
      ),
    );
  }
}
