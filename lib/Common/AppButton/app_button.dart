import 'package:flutter/material.dart';
import 'package:quiz_app/Common/AppTextStyles/app_text_styles.dart';

class AppButton extends StatelessWidget {
  const AppButton(
      {Key? key,
      required this.onPress,
      required this.text,
      this.isLoading = false})
      : super(key: key);

  final VoidCallback onPress;
  final String text;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return SizedBox(
      width: double.infinity,
      child: MaterialButton(
        color: Colors.black,
        height: height * 0.07,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        onPressed: onPress,
        child: isLoading
            ? SizedBox(
                height: 25,
                width: 25,
                child: Center(
                  child: CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 4,
                  ),
                ),
              )
            : Text(text, style: AppTextStyles.loginTextStyle),
      ),
    );
  }
}
