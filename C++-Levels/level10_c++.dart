import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:code_app/Level_Pages/levels_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Level10CPlus extends StatefulWidget {
  @override
  _Level10CPlusState createState() => _Level10CPlusState();
}

class _Level10CPlusState extends State<Level10CPlus> {
  TextEditingController answerController = TextEditingController();
String codeBefore = '#include <iostream>\n\nclass Car {\nprivate:\nstd::string brand;\n\npublic:\nCar(____) {\nbrand = _brand;\n}\n\nvoid drive() {\nstd::cout << "Driving " << brand << std::endl;\n }\n};\n';
  String requirement = 'Fill in the blank to define a class Car with a constructor that initializes the brand member variable and a member function drive that outputs "Driving [brand]":';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[800],
        title:  Text(
          'Fill in the Code',
          style: GoogleFonts.openSans(
          textStyle: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w800,
          ),
         ) ,
         ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      backgroundColor: Colors.grey[800],
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Display the requirement
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(requirement,
                    style: GoogleFonts.openSans(
                      textStyle: const TextStyle(
                          fontSize: 22.0,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                          shadows: [
                            Shadow(
                              offset: Offset(2.0, 2.0),
                              blurRadius: 3.0,
                              color: Colors.black,
                            )
                          ]),
                    )),
              ),
              SizedBox(height: 64.0),

              // Display the code before the input
              Container(
                padding: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(32),
                  border:
                      Border.all(color: Colors.greenAccent.shade100, width: 4),
                ),
                child: Text(
                  '$codeBefore${answerController.text}',
                  style: GoogleFonts.openSans(
                    textStyle: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 22.0,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 32.0),
              // Smaller and narrower text box for user input

              SizedBox(
                width: 32, // Set the width as needed
                child: TextField(
                  controller: answerController,
                  maxLines: 1, // Set maxLines to 1 for a single line input
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: 'Your answer here...',
                    hintStyle: const TextStyle(color: Colors.white),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey.shade600)),
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.greenAccent.shade100)),
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 12.0), // Adjust padding
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  // Implement logic to check the user's answer
                  checkAnswer();
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.grey[800],
                ),
                child: Text(
                  'Submit',
                  style: GoogleFonts.openSans(
                  textStyle: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w800
                    
                  ),
                ),
              ),
          )],
          ),
        ),
      ),
    );
  }

  Future<void> checkAnswer() async {
    String userAnswer = answerController.text.trim();
    // Implement logic to check the user's answer against the correct solution

    // For example, you can compare the user's answer to the expected solution
     String expectedSolution = 'std::string _brand';
    expectedSolution = expectedSolution.replaceAll(' ', ''); // Remove spaces
    userAnswer = userAnswer.replaceAll(' ', '');
    User? currentUser = FirebaseAuth.instance.currentUser;
    if (userAnswer == expectedSolution) {
      // Correct answer
      showResultDialog('Correct!', Colors.green,true);
       await FirebaseFirestore.instance.collection('users').doc(currentUser?.uid).update({
      'c_plus_plus_levels.level10': true,
    });
    } else {
      // Incorrect answer
      showResultDialog('Incorrect. Try again!', Colors.red,false);
    }
  }

   void showResultDialog(String message, Color color, bool isCorrect) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Result:',
            style: GoogleFonts.openSans(
                textStyle: TextStyle(
              fontWeight: FontWeight.w800,
              color: Colors.black,
            )),
          ),
          content: Text(
            message,
            style: GoogleFonts.openSans(
                textStyle: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 18,
              color: Colors.black,
            )),
          ),
          backgroundColor: color,
          actions: [
            TextButton(
              onPressed: () {
                if (isCorrect == true) {
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => LevelScrollCP()));
                } else {
                  Navigator.of(context).pop();
                }
              },
              child: Text(
                'OK',
                style: GoogleFonts.openSans(
                    textStyle: TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 16,
                )),
              ),
            ),
          ],
        );
      },
    );
  }
}
