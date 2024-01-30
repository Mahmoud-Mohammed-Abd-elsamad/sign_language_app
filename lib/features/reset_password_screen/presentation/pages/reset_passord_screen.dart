import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sign_language_app/core/utils/app_colors.dart';
import 'package:sign_language_app/core/utils/componants/custome_form_text_field.dart';
import 'package:sign_language_app/features/reset_password_screen/presentation/manager/reset_password_cubit.dart';

import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/componants/custom_button.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(iconTheme:const IconThemeData(color: Colors.white),
        backgroundColor: AppColors.primaryColor,
        title: Center(
          child: Text(
            AppStrings.forgetPassword,
            style: GoogleFonts.poppins(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20.sp),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                AppStrings.forgetPasswordHeadText,
                style: GoogleFonts.poppins(
                    color: const Color(0xff757575),
                    fontWeight: FontWeight.w400,
                    fontSize: 14.sp),
              ),
            ),
            SizedBox(
              height: 8.w,
            ),
           Padding(
             padding:  EdgeInsets.only(left: 20.w),
             child: Column(
               crossAxisAlignment: CrossAxisAlignment.center,
               children: [
               CustomFormTextField(
                   validator: (value) {
                     if (value == null || value.isEmpty) {
                       return AppStrings.thisFieldIsRequired;
                     }
                   },
                   hintText: "name",
                   keyboardType: TextInputType.name,
                   obscureText: false,
                   controller: context.read<ResetPasswordCubit>().nameController),
               SizedBox(
                 height: 8.w,
               ),
               CustomFormTextField(
                   validator: (value) {
                     if (value == null || value.isEmpty) {
                       return AppStrings.thisFieldIsRequired;
                     }
                   },
                   hintText: AppStrings.emailPattern,
                   keyboardType: TextInputType.emailAddress,
                   obscureText: false,
                   controller: context.read<ResetPasswordCubit>().emailController),
                  SizedBox(height: 440.w,),
                 BlocConsumer<ResetPasswordCubit,ResetPasswordState>(
                   builder: (BuildContext context, state) {
                     if(state is ResetPasswordInitial){
                       return CustomButton(width: 257.w, height: 52.w, text: AppStrings.resetPassword, onTap: () {
                         context.read<ResetPasswordCubit>().resetPassword();
                       }, backgroundColor: AppColors.primaryColor,
                       borderColor: AppColors.primaryColor,);
                     }else if (state is ResetPasswordLoading){
                       return Stack(

                         children:[
                           CustomButton(width: 257.w, height: 52.w, text: '', onTap: () {  }, backgroundColor: AppColors.primaryColor,
                           borderColor: AppColors.primaryColor,),
                           Positioned(
                             left: 130.w,
                             top:20,
                             child: SizedBox(
                               height: 20.w,
                               width: 20.w,
                               child: const CircularProgressIndicator(color: Colors.white,)),
                           )]
                       );
                     }else{
                       return CustomButton(width: 257.w, height: 52.w, text: AppStrings.resetPassword, onTap: () {  }, backgroundColor: AppColors.primaryColor,
                         borderColor: AppColors.primaryColor,);
                     }
                   },
                   listener: (BuildContext context, Object? state) {
                     if(state is ResetPasswordSuccess){
                      _showAlertDialog(context, text: AppStrings.checkYourGmail);
                     }
                     else if(state is ResetPasswordFailure){
                       _showAlertDialog(context, text: AppStrings.invalidEmailOrName);
                     }
                   },

                 )

               ],),
           )
          ],
        ),
      ),
    );
  }
  void _showAlertDialog(context, {required String text }) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          // <-- SEE HERE
          title: const Text(''),
          content:  SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(text),
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
