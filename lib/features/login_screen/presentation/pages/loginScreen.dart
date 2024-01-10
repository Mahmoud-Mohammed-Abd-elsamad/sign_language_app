import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sign_language_app/core/utils/app_images.dart';
import 'package:sign_language_app/core/utils/app_strings.dart';

import '../../../../config/routes/routes.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/cach_helper.dart';
import '../../../../core/utils/componants/custom_button.dart';
import '../../../../core/utils/componants/custome_form_text_field.dart';
import '../manager/login_cubit.dart';
class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white, //change your color here
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: AppColors.primaryColor,
        title: Text(
        AppStrings.login,
          style: GoogleFonts.poppins(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 20.sp),
        ),
      ),
      body: BlocConsumer<LoginCubit, LoginState>(listener: (context, state) {
        if (state is LoginFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Login Failed")),
          );
          return _showAlertDialog(context);
        } else if (state is LoginSuccess) {
          CacheHelper.saveToken(stringToken: state.model.authorisation!.token!);
          Navigator.pushNamedAndRemoveUntil(
              context, Routes.homeScreen, (route) => false);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Login success')),
          );
        }
      }, builder: (context, state) {
        if (state is LoginLoading) {
          return const Center(
            child: CircularProgressIndicator(
              color: AppColors.primaryColor,
            ),
          );
        } else {
          return Form(
              key: context.read<LoginCubit>().formKey,
              child: Stack(children: [
                Container(height: double.infinity,width: double.infinity,
                color: Colors.white),
                Positioned(
                  top: 0,
                  right: 0,
                  left: 0,
                  child: Container(
                    height: 340,
                    child: Image.asset(AppImages.loginScreenBackGroundImage,fit: BoxFit.fill),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  left: 0,
                  child: Center(
                    child: Container(
                      height: 415.w,
                      width: 400.w,
                      decoration: const BoxDecoration(
                        color: AppColors.darkWight,
                          borderRadius: BorderRadius.only(topLeft: Radius.circular(40),topRight: Radius.circular(40))),

                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,

                          children: [
                            SizedBox(
                              height: 8.w,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text("Welcome Back",style:GoogleFonts.poppins(fontSize: 21.sp,fontWeight: FontWeight.bold,color:AppColors.primaryColor,),
                                      ),Text("Sign to your account",style:GoogleFonts.poppins(fontSize: 16.sp,fontWeight: FontWeight.w600,color: Colors.black.withOpacity(.4),),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 16.w,
                            ),
                            Column(
                              children: [
                                CustomFormTextField(
                                  validator: (String) {
                                    if (String == null || String.isEmpty) {
                                      return "this field is required";
                                    }
                                    return null;
                                  },
                                  hintText: "Email",
                                  keyboardType: TextInputType.emailAddress,
                                  controller:
                                  context.read<LoginCubit>().emailController,
                                  suffixIcon: Icon(Icons.email,color: Colors.black.withOpacity(.6),),
                                  obscureText: false,
                                ),
                                SizedBox(
                                  height: 8.w,
                                ),

                                CustomFormTextField(
                                  validator: (String) {
                                    if (String == null || String.isEmpty) {
                                      return "this field is required";
                                    }
                                    return null;
                                  },
                                  hintText: "Password",
                                  keyboardType: TextInputType.visiblePassword,
                                  controller:
                                  context.read<LoginCubit>().passController,
                                  suffixIcon:
                                  const Icon(CupertinoIcons.eye_slash_fill),
                                  onPressedIcon: () {
                                    context.read<LoginCubit>().obscureTextFunction();
                                  },
                                  obscureText: context.read<LoginCubit>().obscureText,
                                ),
                                SizedBox(height: 8.w,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text("Forget Password?",style:GoogleFonts.poppins(fontSize: 12.sp,fontWeight: FontWeight.w500,color:AppColors.primaryColor,)),
                                    SizedBox(width: 12.w,)
                                  ],
                                ),
                                SizedBox(
                                  height: 16.w,
                                ),
                                Center(
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        bottom:
                                        MediaQuery.of(context).viewInsets.bottom),
                                    child: CustomButton(
                                      text: "Login",
                                      onTap: () {
                                        if (context
                                            .read<LoginCubit>()
                                            .formKey
                                            .currentState!
                                            .validate()) {
                                          context
                                              .read<LoginCubit>().login();
                                          ////>>>>>>>>>>>>>>>>>>>>>>.
                                          FocusScope.of(context).unfocus(); // for close keyboard
                                          // Navigator.pushNamedAndRemoveUntil(context,
                                          //     Routes.homeScreen, (route) => false);
                                        }
                                      },
                                      backgroundColor: AppColors.primaryColor,
                                      borderColor: Colors.white,
                                      width: 280.w,
                                      height: 52.w,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 8.w,),
                                InkWell(
                                  onTap: () {
                                    Navigator.pushNamedAndRemoveUntil(
                                        context,
                                        Routes.registerScreen,
                                            (route) => false);
                                  },
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.center,
                                    children: [
                                      Text(
                                          AppStrings.alreadyHaveAnAccount,
                                          style: GoogleFonts.poppins(
                                              fontSize: 12.sp,
                                              fontWeight:
                                              FontWeight.w500,
                                              color: Colors.black)),
                                      Text(AppStrings.signUp,
                                          style: GoogleFonts.poppins(
                                            fontSize: 12.sp,
                                            fontWeight: FontWeight.w500,
                                            color:
                                            AppColors.primaryColor,
                                          )),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 20.w,)
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],));
        }
      }),
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
                Text(AppStrings.invalidEmailOrPassword),
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
