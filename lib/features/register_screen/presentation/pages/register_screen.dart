import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_pw_validator/flutter_pw_validator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sign_language_app/core/utils/app_strings.dart';

import '../../../../config/routes/routes.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/cach_helper.dart';
import '../../../../core/utils/componants/custom_button.dart';
import '../../../../core/utils/componants/custome_form_text_field.dart';
import '../manager/register_cubit.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.primaryColor,
      child: Scaffold(
        backgroundColor: Colors.white,
        extendBody: true,
        appBar: AppBar(
          iconTheme: const IconThemeData(
            color: Colors.white, //change your color here
          ),
          centerTitle: true,
          elevation: 0,
          backgroundColor: AppColors.primaryColor,
          title: Text(
            AppStrings.signUp,
            style: GoogleFonts.poppins(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20.sp),
          ),
        ),
        resizeToAvoidBottomInset: false,
        body: BlocConsumer<RegisterCubit, RegisterState>(
          listener: (context, state) {
            if (state is RegisterFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text(AppStrings.registerFailure)),
              );
              _showAlertDialog(context);
            } else if (state is RegisterSuccess) {
              CacheHelper.saveToken(
                  stringToken: state.model.authorisation!.token!);
              Navigator.pushNamedAndRemoveUntil(
                  context, Routes.homeScreen, (route) => false);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text(AppStrings.registerSuccess)),
              );
            }
          },
          builder: (context, state) {
            if (state is RegisterLoading) {
              return const Center(
                child: CircularProgressIndicator(
                  color: AppColors.primaryColor,
                ),
              );
            } else {
              return Form(
                  key: context.read<RegisterCubit>().formKey,
                  child: Stack(
                    children: [
                      Container(
                          height: double.infinity,
                          width: double.infinity,
                          color: AppColors.primaryColor),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        left: 0,
                        child: Center(
                          child: Container(
                            height: 650.w,
                            width: 400.w,
                            decoration: const BoxDecoration(
                                color: Color(0xffF4F5F9),
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(40),
                                    topRight: Radius.circular(40))),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [],
                                      ),
                                    ),
                                    Column(
                                      children: [
                                        CustomFormTextField(
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return AppStrings.thisFieldIsRequired;
                                            }
                                            return null;
                                          },
                                          hintText: AppStrings.fullName,
                                          keyboardType: TextInputType.name,
                                          controller: context
                                              .read<RegisterCubit>()
                                              .nameController,
                                          suffixIcon: const Icon(Icons.person),
                                          obscureText: false,
                                          onPressedIcon: () {},
                                        ),
                                        SizedBox(
                                          height: 8.w,
                                        ),
                                        CustomFormTextField(
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return AppStrings.thisFieldIsRequired
                                              ;
                                            }
                                            return null;
                                          },
                                          hintText: AppStrings.emailPattern,
                                          keyboardType:
                                              TextInputType.emailAddress,
                                          controller: context
                                              .read<RegisterCubit>()
                                              .emailController,
                                          suffixIcon: Icon(Icons.email,color: Colors.black.withOpacity(.6)),
                                          obscureText: false,
                                        ),
                                        SizedBox(
                                          height: 8.w,
                                        ),
                                        CustomFormTextField(
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return AppStrings.thisFieldIsRequired;
                                            }
                                            return null;
                                          },
                                          hintText: AppStrings.password,
                                          keyboardType:
                                              TextInputType.visiblePassword,
                                          controller: context
                                              .read<RegisterCubit>()
                                              .passController,
                                          suffixIcon: const Icon(
                                              CupertinoIcons.eye_slash_fill),
                                          onPressedIcon: () {
                                            context
                                                .read<RegisterCubit>()
                                                .obscureTextFunction();
                                          },
                                          obscureText: context
                                              .read<RegisterCubit>()
                                              .obscureText,
                                        ),
                                        SizedBox(
                                          height: 8.w,
                                        ),
                                        CustomFormTextField(
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return AppStrings.thisFieldIsRequired;
                                            }
                                            return null;
                                          },
                                          onChanged: (value) {
                                            context
                                                .read<RegisterCubit>()
                                                .confirmPasswordFunction(value);
                                          },
                                          hintText: AppStrings.confirmPassword,
                                          keyboardType:
                                              TextInputType.visiblePassword,
                                          controller: context
                                              .read<RegisterCubit>()
                                              .confirmPasswordController,
                                          suffixIcon: Icon(
                                            CupertinoIcons.check_mark_circled,
                                            size: 25,
                                            color: context
                                                    .read<RegisterCubit>()
                                                    .confirmPassword
                                                ? AppColors.primaryColor
                                                : null,
                                          ),
                                          obscureText: true,
                                        ),
                                        SizedBox(
                                          height: 4.w,
                                        ),
                                        FlutterPwValidator(
                                            controller: context
                                                .read<RegisterCubit>()
                                                .passController,
                                            successColor:
                                                AppColors.primaryColor,
                                            minLength: 8,
                                            uppercaseCharCount: 2,
                                            lowercaseCharCount: 2,
                                            numericCharCount: 2,
                                            width: 400.w,
                                            height: 220.w,
                                            onSuccess: () {
                                              context
                                                  .read<RegisterCubit>()
                                                  .flutterPwValidator = true;
                                            },
                                            onFail: () {
                                              context
                                                  .read<RegisterCubit>()
                                                  .flutterPwValidator = false;
                                            }),
                                        SizedBox(
                                          height: 16.w,
                                        ),
                                        Center(
                                          child: Padding(
                                            padding: EdgeInsets.only(
                                                bottom: MediaQuery.of(context)
                                                    .viewInsets
                                                    .bottom),
                                            child: CustomButton(
                                              text: AppStrings.signUp,
                                              onTap: () {
                                                if (context
                                                        .read<RegisterCubit>()
                                                        .formKey
                                                        .currentState!
                                                        .validate() &&
                                                    context
                                                            .read<
                                                                RegisterCubit>()
                                                            .flutterPwValidator ==
                                                        true) {
                                                  context
                                                      .read<RegisterCubit>()
                                                      .register();
                                                  FocusScope.of(context)
                                                      .unfocus(); // for close keyboard
                                                }
                                              },
                                              backgroundColor:
                                                  AppColors.primaryColor,
                                              borderColor: Colors.white,
                                              width: 280.w,
                                              height: 52.w,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 8.w,
                                        ),
                                        InkWell(
                                          onTap: () {
                                            Navigator.pushNamedAndRemoveUntil(
                                                context,
                                                Routes.loginScreen,
                                                (route) => false);
                                          },
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(AppStrings.alreadyHaveAnAccount,
                                                  style: GoogleFonts.poppins(
                                                      fontSize: 12.sp,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: Colors.black)),
                                              Text(AppStrings.signIn,
                                                  style: GoogleFonts.poppins(
                                                    fontSize: 12.sp,
                                                    fontWeight: FontWeight.w500,
                                                    color:
                                                        AppColors.primaryColor,
                                                  )),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: 20.w,
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ));
            }
          },
        ),
      ),
    );
  }

  void _showAlertDialog(context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          // <-- SEE HERE
          title: const Text('Error'),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(AppStrings.registerFailedPleaseTryAgain),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text(AppStrings.ok),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
