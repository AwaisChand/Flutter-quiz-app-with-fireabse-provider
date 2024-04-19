import 'package:quiz_app/Common/AppAssetsPath/app_assets_path.dart';
import 'package:quiz_app/Models/QuizDataModel/quiz_data_model.dart';

class AppData {
  static List<QuizDataModel> quizDataList = [
    QuizDataModel(image: AppAssetsPath.placeImage, text: "Place", category: "Place"),
    QuizDataModel(image: AppAssetsPath.animalsImage, text: "Animals", category: "Animals"),
    QuizDataModel(image: AppAssetsPath.fruitsImage, text: "Fruits", category: "Fruits"),
    QuizDataModel(image: AppAssetsPath.objectsImage, text: "Objects", category: "Objects"),
    QuizDataModel(image: AppAssetsPath.sportsImage, text: "Sports", category: "Sports"),
    QuizDataModel(image: AppAssetsPath.randomImage, text: "Random", category: "Random"),
  ];
}
