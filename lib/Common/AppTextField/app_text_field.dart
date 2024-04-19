import 'package:flutter/material.dart';
import 'package:quiz_app/Common/AppTextStyles/app_text_styles.dart';

class AppTextField extends StatelessWidget {
  AppTextField(
      {Key? key,
      required this.controller,
      required this.hintText,
      this.obscureText,
      // this.obscuringCharacter,
      required this.textInputType,
      this.suffixIcon})
      : super(key: key);

  final TextEditingController controller;
  final String hintText;
  final TextInputType textInputType;
  final bool? obscureText;
  // final String? obscuringCharacter;
  final Widget? suffixIcon;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: textInputType,
      obscureText: obscureText ?? false,
      // obscuringCharacter: obscuringCharacter ?? "",
      style: AppTextStyles.hintTextStyle,
      decoration: InputDecoration(
          hintText: hintText,
          hintStyle: AppTextStyles.hintTextStyle,
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(color: Colors.black, width: 1)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(color: Colors.black, width: 1)),
          suffixIcon: suffixIcon),
    );
  }
}
