import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:quiz_app/Provider/AddQuizProvider/add_quiz_provider.dart';

List<SingleChildWidget> providerClasses = [...independentProviders];
List<SingleChildWidget> independentProviders = [
  ChangeNotifierProvider(create: (_) => AddQuizProvider()),
];
