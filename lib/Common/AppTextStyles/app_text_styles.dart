import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextStyles {
  static TextStyle adminPanelTitleTextStyle = GoogleFonts.poppins(
      textStyle: TextStyle(fontWeight: FontWeight.w700, fontSize: 18));

  static TextStyle loginTextStyle = GoogleFonts.poppins(
      textStyle: TextStyle(
          fontSize: 18, fontWeight: FontWeight.w500, color: Colors.white));

  // add quiz screen text styles

  static TextStyle titleTextStyle = GoogleFonts.poppins(
      textStyle: TextStyle(fontWeight: FontWeight.w700, fontSize: 20));

  static TextStyle labelTextStyle = GoogleFonts.poppins(
      textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.w500));

  static TextStyle hintTextStyle = GoogleFonts.poppins(
      textStyle: TextStyle(fontWeight: FontWeight.w400, fontSize: 15));
}
