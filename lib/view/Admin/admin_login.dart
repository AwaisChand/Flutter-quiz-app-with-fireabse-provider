import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app/Common/AppButton/app_button.dart';
import 'package:quiz_app/Common/AppSnackBar/app_snackbar.dart';
import 'package:quiz_app/Common/AppTextField/app_text_field.dart';
import 'package:quiz_app/Common/AppTextStyles/app_text_styles.dart';
import 'package:quiz_app/Common/AppTexts/app_texts.dart';
import 'package:quiz_app/Provider/AddQuizProvider/add_quiz_provider.dart';

class AdminLogin extends StatefulWidget {
  const AdminLogin({Key? key}) : super(key: key);

  @override
  State<AdminLogin> createState() => _AdminLoginState();
}

class _AdminLoginState extends State<AdminLogin> {
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Consumer<AddQuizProvider>(
      builder: (context, adminLoginProvider, _) {
        return Scaffold(
          backgroundColor: Color(0xFFededeb),
          resizeToAvoidBottomInset: false,
          body: Stack(
            children: [
              Container(
                height: height,
                width: width,
                margin: EdgeInsets.only(top: height * 0.56),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.vertical(
                      top: Radius.elliptical(width, 110.0)),
                  gradient: LinearGradient(
                      colors: [Color.fromARGB(255, 53, 51, 51), Colors.black]),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    vertical: height * 0.08, horizontal: 30),
                child: Text(AppTexts.adminPanelTitleText,
                    style: AppTextStyles.adminPanelTitleTextStyle),
              ),
              Positioned(
                right: 20,
                left: 20,
                top: height * 0.15,
                child: Material(
                  borderRadius: BorderRadius.circular(20),
                  elevation: 3,
                  color: Colors.white,
                  child: Container(
                    height: height * 0.5,
                    width: width,
                    padding: EdgeInsets.symmetric(
                        horizontal: 20, vertical: height * 0.07),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      children: [
                        AppTextField(
                            controller: userNameController,
                            hintText: 'UserName',
                            textInputType: TextInputType.emailAddress),
                        SizedBox(
                          height: 30,
                        ),
                        AppTextField(
                          controller: passwordController,
                          hintText: 'Password',
                          textInputType: TextInputType.visiblePassword,
                          obscureText: true,
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        AppButton(
                            isLoading: adminLoginProvider.isLoading,
                            onPress: () {
                              if (userNameController.text.isEmpty) {
                                AppSnackBar.showErrorMessage(
                                    "Please Enter UserName");
                              } else if (passwordController.text.isEmpty) {
                                AppSnackBar.showErrorMessage(
                                    "Please Enter Password");
                                ;
                              } else if (passwordController.text.length < 6) {
                                AppSnackBar.showErrorMessage(
                                    "Password must be 6 character long!");
                              } else {
                                adminLoginProvider.adminLogin(
                                    userName: userNameController.text.trim(),
                                    password: passwordController.text.trim());
                              }
                            },
                            text: AppTexts.loginText)
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
