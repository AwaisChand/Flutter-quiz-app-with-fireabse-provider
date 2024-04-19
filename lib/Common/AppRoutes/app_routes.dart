import 'package:get/get.dart';
import 'package:quiz_app/view/AddQuiz/add_quiz.dart';
import 'package:quiz_app/view/Admin/admin_login.dart';
import 'package:quiz_app/view/HomeView/home.dart';

const adminLoginRoute = '/adminLogin';

final AppRoutes = [
  GetPage(
    name: adminLoginRoute,
    page: () => const AdminLogin(),
  ),
  GetPage(
    name: HomeView.routeName,
    page: () => const HomeView(),
    transition: Transition.rightToLeft,
  ),

  // GetPage(
  //   name: QuestionsView.routeName,
  //   page: () => const QuestionsView(category: ,),
  //   transition: Transition.noTransition,
  // ),

  GetPage(
    name: AddQuiz.routeName,
    page: () =>  AddQuiz(),
    transition: Transition.rightToLeft,

  ),
];
