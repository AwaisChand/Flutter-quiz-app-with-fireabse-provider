import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';

class AppSnackBar {
  static showSuccessMessage(
    String message, {
    ScaffoldMessengerState? messengerState,
  }) {
    final s = messengerState ?? ScaffoldMessenger.of(Get.context!);
    s.showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: GoogleFonts.poppins(
              textStyle: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: Colors.black)),
        ),
        backgroundColor: Colors.white,
      ),
    );
  }

  static showErrorMessage(
    String message, {
    ScaffoldMessengerState? messengerState,
  }) {
    final s = messengerState ?? ScaffoldMessenger.of(Get.context!);
    s.showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: GoogleFonts.poppins(
              textStyle: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: Colors.white)),
        ),
        backgroundColor: Colors.red,
      ),
    );
  }
}
