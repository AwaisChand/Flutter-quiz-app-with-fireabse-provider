import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app/Common/AppButton/app_button.dart';
import 'package:quiz_app/Common/AppSnackBar/app_snackbar.dart';
import 'package:quiz_app/Common/AppTextField/app_text_field.dart';
import 'package:quiz_app/Common/AppTextStyles/app_text_styles.dart';
import 'package:quiz_app/Common/AppTexts/app_texts.dart';
import 'package:quiz_app/Provider/AddQuizProvider/add_quiz_provider.dart';
import 'package:quiz_app/view/HomeView/home.dart';
import 'package:random_string/random_string.dart';

class AddQuiz extends StatefulWidget {
  const AddQuiz({Key? key}) : super(key: key);

  static const routeName = '/addQuizView';

  @override
  State<AddQuiz> createState() => _AddQuizState();
}

class _AddQuizState extends State<AddQuiz> {
  final TextEditingController option1Controller = TextEditingController();
  final TextEditingController option2Controller = TextEditingController();
  final TextEditingController option3Controller = TextEditingController();
  final TextEditingController option4Controller = TextEditingController();
  final TextEditingController correctAnsController = TextEditingController();

  String? _selectedItem;
  List<String> _quizCategoryList = [
    'Place',
    'Animals',
    'Fruits',
    'Objects',
    'Sports',
    'Random'
  ];

  final id = randomAlphaNumeric(10);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Consumer<AddQuizProvider>(
      builder: (context, quizProvider, _) {
        return Scaffold(
          appBar: AppBar(
            title:
                Text(AppTexts.titleText, style: AppTextStyles.titleTextStyle),
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(AppTexts.labelText1,
                      style: AppTextStyles.labelTextStyle),
                  quizProvider.selectedImage == null
                      ? GestureDetector(
                          onTap: () {
                            quizProvider.getImage();
                          },
                          child: Center(
                            child: Material(
                              borderRadius: BorderRadius.circular(10),
                              elevation: 3.0,
                              child: Container(
                                height: height * 0.18,
                                width: width * 0.37,
                                margin: EdgeInsets.only(top: height * 0.02),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border:
                                      Border.all(color: Colors.black, width: 2),
                                ),
                                child: Icon(Icons.camera_alt_outlined),
                              ),
                            ),
                          ),
                        )
                      : GestureDetector(
                          onTap: () {
                            quizProvider.getImage();
                          },
                          child: Center(
                            child: Material(
                              borderRadius: BorderRadius.circular(10),
                              elevation: 3.0,
                              child: Container(
                                  height: height * 0.18,
                                  width: width * 0.37,
                                  margin: EdgeInsets.only(top: height * 0.02),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                        color: Colors.black, width: 2),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image(
                                      image: FileImage(
                                          quizProvider.selectedImage!),
                                      fit: BoxFit.cover,
                                    ),
                                  )),
                            ),
                          ),
                        ),
                  SizedBox(
                    height: height * 0.05,
                  ),
                  labelText("Option 1"),
                  SizedBox(
                    height: 15,
                  ),
                  AppTextField(
                      controller: option1Controller,
                      hintText: "Enter Option 1",
                      textInputType: TextInputType.text),
                  SizedBox(
                    height: 15.0,
                  ),
                  labelText("Option 2"),
                  SizedBox(
                    height: 15,
                  ),
                  AppTextField(
                      controller: option2Controller,
                      hintText: "Enter Option 2",
                      textInputType: TextInputType.text),
                  SizedBox(
                    height: 15.0,
                  ),
                  labelText("Option 3"),
                  SizedBox(
                    height: 15,
                  ),
                  AppTextField(
                      controller: option3Controller,
                      hintText: "Enter Option 3",
                      textInputType: TextInputType.text),
                  SizedBox(
                    height: 15.0,
                  ),
                  labelText("Option 4"),
                  SizedBox(
                    height: 15,
                  ),
                  AppTextField(
                      controller: option4Controller,
                      hintText: "Enter Option 4",
                      textInputType: TextInputType.text),
                  SizedBox(
                    height: 15.0,
                  ),
                  labelText("Correct Answer"),
                  SizedBox(
                    height: 15,
                  ),
                  AppTextField(
                    controller: correctAnsController,
                    hintText: "Enter Correct Answer",
                    textInputType: TextInputType.text,
                  ),
                  Container(
                    height: height * 0.08,
                    width: width,
                    margin: EdgeInsets.only(top: 20),
                    padding: EdgeInsets.only(top: 5, right: 20, left: 20),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                      dropdownColor: Colors.white,
                      iconSize: 36,
                      hint: Text(
                        "Select Category",
                        style: AppTextStyles.hintTextStyle,
                      ),
                      icon: Icon(
                        Icons.arrow_drop_down,
                        color: Colors.black,
                      ),
                      value: _selectedItem,
                      onChanged: (String? value) {
                        setState(() {
                          _selectedItem = value;
                        });
                      },
                      items: _quizCategoryList.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value,
                            style: AppTextStyles.hintTextStyle,
                          ),
                        );
                      }).toList(),
                    )),
                  ),
                  SizedBox(
                    height: height * 0.05,
                  ),
                  AppButton(
                    isLoading: quizProvider.isLoading,
                    onPress: () {
                      if(quizProvider.selectedImage == null){
                        AppSnackBar.showErrorMessage("Please pick image from your gallery");
                      }else if(option1Controller.text.isEmpty){
                        AppSnackBar.showErrorMessage("Enter Option 1");
                      }else if(option2Controller.text.isEmpty){
                        AppSnackBar.showErrorMessage("Enter Option 2");
                      }else if(option3Controller.text.isEmpty){
                        AppSnackBar.showErrorMessage("Enter Option 3");
                      }else if(option4Controller.text.isEmpty){
                        AppSnackBar.showErrorMessage("Enter Option 4");
                      }else if(correctAnsController.text.isEmpty){
                        AppSnackBar.showErrorMessage("Enter Correct Answer");
                      }else if(_selectedItem == null){
                        AppSnackBar.showErrorMessage("Please pick your category");
                      }else{
                        quizProvider
                            .uploadItems(
                          option1: option1Controller.text,
                          option2: option2Controller.text,
                          option3: option3Controller.text,
                          option4: option4Controller.text,
                          correctAns: correctAnsController.text,
                          id: id,
                          category: _selectedItem ?? '',
                        )
                            .then((value) {
                          AppSnackBar.showSuccessMessage(
                              "Quiz has been added successfully");
                          option1Controller.clear();
                          option2Controller.clear();
                          option3Controller.clear();
                          option4Controller.clear();
                          correctAnsController.clear();
                          _selectedItem = null;
                          quizProvider.clearSelectedImage();
                          Get.toNamed(HomeView.routeName);
                        }).onError((error, stackTrace) {
                          AppSnackBar.showErrorMessage("${error.toString()}");
                        });
                      }
                    },
                    text: AppTexts.titleText,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget labelText(String label) {
    return Text(label, style: AppTextStyles.labelTextStyle);
  }
}
