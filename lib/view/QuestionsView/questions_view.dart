import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quiz_app/Service/FirestoreDatabase/firestore_database.dart';

class QuestionsView extends StatefulWidget {
  const QuestionsView({
    Key? key,
    required this.category,
  }) : super(key: key);

  final String category;
  static const routeName = '/questionsView';

  @override
  State<QuestionsView> createState() => _QuestionsViewState();
}

class _QuestionsViewState extends State<QuestionsView> {
  Stream? quizStream;
  final PageController pageController = PageController();
  Future<void> fetchDataFromFirestore() async {
    quizStream = await FirestoreDatabase.getQuizCategory(widget.category);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    fetchDataFromFirestore();
    debugPrint("category printed: ${widget.category}");
  }

  Widget showQuiz() {
    return StreamBuilder(
      stream: quizStream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting ||
            quizStream == null) {
          return SizedBox(
              height: 25,
              width: 25,
              child: Center(
                  child: CircularProgressIndicator(
                color: Colors.white,
                strokeWidth: 4,
              )));
        } else if (!snapshot.hasData || snapshot.data.docs.isEmpty) {
          return Flexible(
            child: Align(
                alignment: Alignment.center,
                child: Text(
                  'No data available',
                  style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 18)),
                )),
          );
        } else if (snapshot.hasError) {
          return Center(
              child: Text(
            'Error: ${snapshot.error}',
            style: GoogleFonts.poppins(
                textStyle: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 18)),
          ));
        }
        final documents = snapshot.data!.docs;
        return Flexible(
          child: PageView.builder(
            controller: pageController,
            itemCount: documents.length,
            itemBuilder: (context, index) {
              final DocumentSnapshot documentSnapshot = documents[index];
              return buildQuizPage(documentSnapshot);
            },
          ),
        );
      },
    );
  }

  Widget buildQuizPage(DocumentSnapshot documentSnapshot) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        children: [
          Container(
            width: width,
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20)),
              gradient: LinearGradient(colors: [
                Colors.greenAccent,
                Colors.lightGreen,
              ]),
            ),
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image(
                    image: NetworkImage(documentSnapshot['image']),
                    fit: BoxFit.cover,
                    height: height * 0.3,
                  ),
                ),
                quizContainerWidget(
                  "${documentSnapshot["option 1"]}",
                  height * 0.08,
                  selectedAnswer == "${documentSnapshot["option 1"]}",
                ),
                quizContainerWidget(
                  "${documentSnapshot["option 2"]}",
                  height * 0.08,
                  selectedAnswer == "${documentSnapshot["option 2"]}",
                ),
                quizContainerWidget(
                  "${documentSnapshot["option 3"]}",
                  height * 0.08,
                  selectedAnswer == "${documentSnapshot["option 3"]}",
                ),
                quizContainerWidget(
                  "${documentSnapshot["option 4"]}",
                  height * 0.08,
                  selectedAnswer == "${documentSnapshot["option 4"]}",
                ),
                SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () {
                    pageController.nextPage(
                        duration: Duration(milliseconds: 200),
                        curve: Curves.easeIn);
                  },
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 1),
                          shape: BoxShape.circle),
                      child: Icon(Icons.arrow_forward_ios),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  String? selectedAnswer;
  bool isCorrectAnswer = false;
  String correctAnswer = '';

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    // double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.pink,
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: height * 0.06, right: 20, left: 20),
            child: Row(
              children: [
                GestureDetector(
                  onTap: (){
                    Get.back();
                  },
                  child: Icon(
                    Icons.arrow_back_ios_new_outlined,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
                Flexible(
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      "${widget.category}",
                      style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 20,
                              color: Colors.white)),
                    ),
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          showQuiz(),
        ],
      ),
    );
  }

  Widget quizContainerWidget(String text, double height, bool isSelected) {
    return GestureDetector(
        onTap: () {
          bool isCorrect = text == "correctAns";
          setState(() {
            selectedAnswer = text;
            isCorrectAnswer = isCorrect;
          });
        },
        child: Container(
          height: height,
          width: double.infinity,
          margin: EdgeInsets.only(top: 35),
          padding: EdgeInsets.symmetric(vertical: 18, horizontal: 15),
          decoration: BoxDecoration(
              color: isSelected ? Colors.purple : Colors.transparent,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                  color: isSelected ? Colors.white : Colors.black, width: 1)),
          child: Text(
            text,
            style: GoogleFonts.poppins(
                textStyle: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: isSelected ? Colors.white : Colors.black)),
          ),
        ));
  }
}
