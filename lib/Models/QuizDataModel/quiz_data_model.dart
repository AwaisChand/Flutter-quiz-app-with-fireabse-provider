class QuizDataModel {
  final String image;
  final String text;
  final String? category;

  QuizDataModel({required this.image, required this.text, this.category});

  factory QuizDataModel.fromJson(Map<String, dynamic> json) {
    return QuizDataModel(
      image: json['image'] as String,
      text: json['text'] as String,
      category: json['category'] as String,
    );
  }
}
