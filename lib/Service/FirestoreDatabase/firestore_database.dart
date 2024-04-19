import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreDatabase {
  static Future addQuizCategory(
      Map<String, dynamic> quizCategory, String category) async {
    return await FirebaseFirestore.instance
        .collection(category)
        .add(quizCategory);
  }


  static Future<Stream<QuerySnapshot>> getQuizCategory(String category) async {
    if (category.isEmpty) {
      throw ArgumentError('Category cannot be empty');
    }

    return FirebaseFirestore.instance.collection(category).snapshots();
  }

}
