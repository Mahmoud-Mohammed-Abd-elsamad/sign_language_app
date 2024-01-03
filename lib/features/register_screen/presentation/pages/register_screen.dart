import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_pw_validator/flutter_pw_validator.dart';
import 'package:google_fonts/google_fonts.dart';

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
      decoration: BoxDecoration(color: AppColors.primaryColor),
      child: Scaffold(
        extendBody: true,
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Colors.black, //change your color here
          ),
          centerTitle: true,
          elevation: 0,
          backgroundColor: AppColors.primaryColor,
          title: Text(
            "Sign Language",
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
                const SnackBar(content: Text('register failure1')),
              );
              return _showAlertDialog(context);
            } else if (state is RegisterSuccess) {
              CacheHelper.saveToken(
                  stringToken: state.model.authorisation!.token!);
              Navigator.pushNamedAndRemoveUntil(
                  context, Routes.homeScreen, (route) => false);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('register success')),
              );
            }
          },
          builder: (context, state) {
            if (state is RegisterLoading) {
              return Center(
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
                        top: 0,
                        child: Container(
                          height: 200.w,
                          width: 400.w,
                          color: AppColors.primaryColor,
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        left: 0,
                        child: Center(
                          child: Container(
                            height: 755.w,
                            width: 400,
                            decoration: BoxDecoration(
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
                                    SizedBox(
                                      height: 8.w,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            height: 16.w,
                                          ),
                                          Text(
                                            "",
                                            style: GoogleFonts.poppins(
                                              fontSize: 21.sp,
                                              fontWeight: FontWeight.bold,
                                              color: AppColors.primaryColor,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Column(
                                      children: [
                                        CustomFormTextField(
                                          validator: (String) {
                                            if (String == null ||
                                                String.isEmpty) {
                                              return "this field is required";
                                            }
                                            return null;
                                          },
                                          hintText: "Full Name",
                                          keyboardType: TextInputType.name,
                                          controller: context
                                              .read<RegisterCubit>()
                                              .nameController,
                                          suffixIcon: Icon(Icons.person),
                                          obscureText: false,
                                          onPressedIcon: () {},
                                        ),
                                        SizedBox(
                                          height: 8.w,
                                        ),
                                        CustomFormTextField(
                                          validator: (String) {
                                            if (String == null ||
                                                String.isEmpty) {
                                              return "this field is required";
                                            }
                                            return null;
                                          },
                                          hintText: "Email",
                                          keyboardType:
                                              TextInputType.emailAddress,
                                          controller: context
                                              .read<RegisterCubit>()
                                              .emailController,
                                          suffixIcon: Icon(Icons.person),
                                          obscureText: false,
                                        ),
                                        SizedBox(
                                          height: 8.w,
                                        ),
                                        CustomFormTextField(
                                          validator: (String) {
                                            if (String == null ||
                                                String.isEmpty) {
                                              return "this field is required";
                                            }
                                            return null;
                                          },
                                          hintText: "Password",
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
                                          validator: (String) {
                                            if (String == null ||
                                                String.isEmpty) {
                                              return "this field is required";
                                            }
                                            return null;
                                          },
                                          onChanged: (value) {
                                            context
                                                .read<RegisterCubit>()
                                                .confirmPasswordFunction(value);
                                          },
                                          hintText: "Confirm Password",
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
                                          obscureText: false,
                                        ),
                                        SizedBox(
                                          height: 4.w,
                                        ),
                                        new FlutterPwValidator(
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
                                            onSuccess: () {},
                                            onFail: () {}),
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
                                              text: "Create Account",
                                              onTap: () {
                                                if (context
                                                    .read<RegisterCubit>()
                                                    .formKey
                                                    .currentState!
                                                    .validate()) {
                                                  context
                                                      .read<RegisterCubit>()
                                                      .register();
                                                  ////>>>>>>>>>>>>>>>>>>>>>>.
                                                  FocusScope.of(context)
                                                      .unfocus(); // for close keyboard
                                                  // Navigator.pushNamedAndRemoveUntil(context,
                                                  //     Routes.homeScreen, (route) => false);
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
                                              Text(
                                                  "Already have an account yet ? ",
                                                  style: GoogleFonts.poppins(
                                                      fontSize: 12.sp,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: Colors.black)),
                                              Text(" Sign In",
                                                  style: GoogleFonts.poppins(
                                                    fontSize: 12.sp,
                                                    fontWeight: FontWeight.w500,
                                                    color:
                                                        AppColors.primaryColor,
                                                  )),
                                            ],
                                          ),
                                        ),
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
                Text('Register Failed'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('ok'),
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
