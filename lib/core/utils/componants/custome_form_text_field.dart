import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomFormTextField extends StatefulWidget {
  const CustomFormTextField(
      {super.key,
      required this.validator,
      required this.hintText,
      required this.keyboardType,
      required this.obscureText,
      required this.controller,
      this.suffixIcon,
      this.onPressedIcon,
      this.onChanged});

  final String? Function(String?)? validator;
  final String? hintText;
  final TextInputType keyboardType;
  final bool obscureText;
  final TextEditingController controller;
  final Widget? suffixIcon;
  final void Function()? onPressedIcon;
  final  void Function(String)? onChanged;

  @override
  State<CustomFormTextField> createState() => _CustomFormTextFieldState();
}

class _CustomFormTextFieldState extends State<CustomFormTextField> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 326.w,
     // height: 50.w,
      child: TextFormField(

        onChanged: widget.onChanged,
        validator: widget.validator,
        keyboardType: widget.keyboardType,
        obscureText: widget.obscureText,
        controller: widget.controller,
        decoration: InputDecoration(
          suffixIcon: IconButton(
            onPressed: widget.onPressedIcon,
            icon: widget.suffixIcon ??
                Container(
                  height: 0,
                  width: 0,
                ),
          ),
          filled: true,
          fillColor: Colors.white,
          hintText: widget.hintText,
          border:  const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.teal,width: 3)),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(
              width: 1,
              color: Colors.grey,
            ),

            //borderSide: BorderSide(color: Colors.white, width: 2)
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(
              width: 1,
              color: Colors.grey,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(
              width: 1,
              color: Colors.grey,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(width: 0, color: Colors.white),
          ),
          focusedErrorBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            borderSide: BorderSide(
              width: 1,
              color: Colors.red,
            ),
          ),
        ),
      ),
    );
  }
}
