import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:quiz_app/Common/AppSnackBar/app_snackbar.dart';
import 'package:quiz_app/Service/FirestoreDatabase/firestore_database.dart';
import 'package:quiz_app/view/AddQuiz/add_quiz.dart';

class AddQuizProvider extends ChangeNotifier {
  // create an instance of firestore database

  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  // create an instance of firebase storage

  Reference _firebaseStorage = FirebaseStorage.instance.ref();

  // create an instance of image picker

  ImagePicker _imagePicker = ImagePicker();

  File? _selectedImage;
  File? get selectedImage => _selectedImage;
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  set loading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  Future<void> getImage() async {
    final pickedImage =
        await _imagePicker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      _selectedImage = File(pickedImage.path);
      notifyListeners();
    } else {
      debugPrint("Error while picking the image from gallery");
    }
  }

  Future<void> uploadItems(
      {required String id,
      required String category,
      required String option1,
      required String option2,
      required String option3,
      required String option4,
      required String correctAns}) async {
    loading = true;
    if (_selectedImage != null &&
        option1 != "" &&
        option2 != "" &&
        option3 != "" &&
        option4 != "" &&
        correctAns != "") ;
    Reference _storage = _firebaseStorage.child('imagePost').child(id);

    UploadTask uploadTask = _storage.putFile(_selectedImage!);

    final downLoadUrl = await (await uploadTask).ref.getDownloadURL();

    Map<String, dynamic> addQuizData = {
      "image": downLoadUrl,
      "option 1": option1,
      "option 2": option2,
      "option 3": option3,
      "option 4": option4,
      "correctAns": correctAns
    };
    FirestoreDatabase.addQuizCategory(addQuizData, category);
    loading = false;
    notifyListeners();
  }

  Future<void> adminLogin(
      {required String userName, required String password}) async {
    loading = true;
    await _firebaseFirestore.collection("Admin").get().then((snapshot) {
      snapshot.docs.forEach((result) {
        if (result.data()['id'] != userName) {
          AppSnackBar.showErrorMessage("Your id is invalid");
          loading = false;
        } else if (result.data()['password'] != password) {
          AppSnackBar.showErrorMessage("Your password is invalid");
          loading = false;
        } else {
          Get.toNamed(AddQuiz.routeName);
          AppSnackBar.showSuccessMessage("You have successfully login!");
          loading = false;
          notifyListeners();
        }
      });
    });
  }
  // set the selected img is null

  void clearSelectedImage() {
    _selectedImage = null;
    notifyListeners();
  }
}
