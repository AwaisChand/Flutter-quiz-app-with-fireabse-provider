import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quiz_app/Common/AppAssetsPath/app_assets_path.dart';
import 'package:quiz_app/Common/AppData/app_data.dart';
import 'package:quiz_app/view/AddQuiz/add_quiz.dart';
import 'package:quiz_app/view/QuestionsView/questions_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  static const routeName = '/home';

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        width: width,
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
            Colors.greenAccent,
            Colors.lightGreen,
          ]),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  height: 200,
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(
                      vertical: height * 0.08, horizontal: 15),
                  decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [
                        Colors.black,
                        Colors.grey,
                      ]),
                      borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(30),
                          bottomLeft: Radius.circular(30))),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                        child: Image(
                            image: AssetImage(AppAssetsPath.personImage),
                            height: 50,
                            width: 50,
                            fit: BoxFit.cover),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Padding(
                        padding:  EdgeInsets.only(top: 8.0),
                        child: Text(
                          "Muhammad Awais",
                          style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white)),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  margin:
                      EdgeInsets.only(top: height * 0.2, right: 20, left: 20),
                  decoration: BoxDecoration(),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image(
                      image: AssetImage(
                        AppAssetsPath.quizImage,
                      ),
                      height: height * 0.24,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Top Quiz Categories",
                    style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                    )),
                  ),
                  GestureDetector(
                    onTap: (){
                      Get.toNamed(AddQuiz.routeName);
                    },
                    child: Text(
                      "Add Quiz",
                      style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                      )),
                    ),
                  ),
                ],
              ),
            ),
            Flexible(
              child: AlignedGridView.count(
                crossAxisCount: 2,
                mainAxisSpacing: height * 0.02,
                crossAxisSpacing: height * 0.02,
                itemCount: AppData.quizDataList.length,
                physics: BouncingScrollPhysics(),
                shrinkWrap: true,
                padding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                itemBuilder: (context, index) {
                  final quizData = AppData.quizDataList[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => QuestionsView(
                                  category: quizData.category ?? '')));
                    },
                    child: Material(
                      borderRadius: BorderRadius.circular(20),
                      elevation: 3.0,
                      child: Container(
                        height: height * 0.2,
                        // padding: EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                            gradient: LinearGradient(colors: [
                              Colors.black,
                              Colors.grey,
                            ]),
                            borderRadius: BorderRadius.circular(20)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image(
                              image: AssetImage(quizData.image),
                              height: 80,
                              width: 80,
                              fit: BoxFit.cover,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "${quizData.text}",
                              style: GoogleFonts.poppins(
                                  textStyle: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                              )),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
