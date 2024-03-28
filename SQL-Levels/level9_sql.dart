import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:code_app/Level_Pages/levels_page_sql.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Level9SQL extends StatefulWidget {
  @override
  _Level9SQLState createState() => _Level9SQLState();
}

class _Level9SQLState extends State<Level9SQL> {
  TextEditingController answerController = TextEditingController();
 String codeBefore = 'SELECT ____(salary) FROM employees;';
  String requirement =
      'Fill in the blank to retrieve the maximum value of the "salary" column from the "employees" table:';

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[800],
        title: Text(
          'Fill in the Code',
          style: GoogleFonts.openSans(
            textStyle:  TextStyle(
              color: Colors.white,
              fontSize: 1.15*(15+0.00390625*screenSize.width),
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
        leading: IconButton(
          color: Colors.white,
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
                      textStyle:  TextStyle(
                          fontSize: 1.20*(15+0.00390625*screenSize.width),
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
              SizedBox(height: 0.05*screenSize.height),

              // Display the code before the input
              Container(
                padding: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(32),
                  border:
                      Border.all(color: Colors.greenAccent.shade100, width: 4),
                ),
                child: Text(
                  '$codeBefore',
                  style: GoogleFonts.openSans(
                    textStyle:  TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 15+0.00390625*screenSize.width,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 0.025*screenSize.height),
              // Smaller and narrower text box for user input

              SizedBox(
                width: double.infinity, // Set the width as needed
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
              SizedBox(height: 0.015*screenSize.height),
              ElevatedButton(
                onPressed: () {
                  // Implement logic to check the user's answer
                  checkAnswer();
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.grey[700],
                ),
                child: Text(
                  'Submit',
                  style: GoogleFonts.openSans(
                    textStyle: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w800),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> checkAnswer() async {
    String userAnswer = answerController.text.trim();
    // Implement logic to check the user's answer against the correct solution

    // For example, you can compare the user's answer to the expected solution
    String expectedSolution = 'MAX';
    expectedSolution = expectedSolution.replaceAll(' ', ''); // Remove spaces
    userAnswer = userAnswer.replaceAll(' ', '');
    User? currentUser = FirebaseAuth.instance.currentUser;
    if (userAnswer == expectedSolution) {
      // Correct answer
      showResultDialog('Correct!', Colors.greenAccent.shade100, true);
      await FirebaseFirestore.instance
          .collection('users')
          .doc(currentUser?.uid)
          .update({
        'sql_levels.level9': true,
      });
    } else {
      // Incorrect answer
      showResultDialog(
          'Incorrect. Try again!', Colors.redAccent.shade100, false);
    }
  }

  void showResultDialog(String message, Color color, bool isCorrect) {
    Size screenSize = MediaQuery.of(context).size;
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
              fontSize: 15+0.00390625*screenSize.width,
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
                      MaterialPageRoute(builder: (context) => LevelScrollSQL()));
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
