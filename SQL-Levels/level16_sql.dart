import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:code_app/Level_Pages/levels_page_sql.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Level16SQL extends StatefulWidget {
  @override
  _Level16SQLState createState() => _Level16SQLState();
}

class _Level16SQLState extends State<Level16SQL> {
  String question = 'What does SQL stand for?\n';
  List<String> choices = [
    'A) System Query Language;',
    'B) Structured Query Language;',
    'C) Sequential Query Language;',
    'D) Standardized Query Language;',
  ];
  int correctIndex = 1;
  int selectedIndex = -1;

  @override

  Widget build(BuildContext context) {
  Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[800],
        title: Text(
          'Multiple Choice Question',
          style: GoogleFonts.openSans(
            textStyle:  TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w800,
              fontSize:  1.15*(15+0.00390625*screenSize.width)
            ),
          ),
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
              // Display the question
              Text(question,
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
              SizedBox(height: 16.0),
              // Display the choices
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: choices.map((choice) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      padding: EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(32),
                        border: Border.all(
                            color: Colors.greenAccent.shade100, width: 4),
                      ),
                      child: RadioListTile<int>(
                        fillColor: MaterialStateColor.resolveWith(
                            (states) => Colors.greenAccent.shade100),
                        title: Text(
                          choice,
                          style: GoogleFonts.openSans(
                            textStyle:  TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: (15+0.00390625*screenSize.width),
                              color: Colors.white,
                            ),
                          ),
                        ),
                        value: choices.indexOf(choice),
                        groupValue: selectedIndex,
                        onChanged: (int? value) {
                          setState(() {
                            selectedIndex = value!;
                          });
                        },
                      ),
                    ),
                  );
                }).toList(),
                  ),
              SizedBox(height: 16.0),
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
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> checkAnswer() async {
    User? currentUser = FirebaseAuth.instance.currentUser;
    if (selectedIndex != -1) {
      // Check if user selected an option
      if (selectedIndex == correctIndex) {
        // Correct answer
        
        showResultDialog('Correct!', Colors.green,true);
         await FirebaseFirestore.instance.collection('users').doc(currentUser?.uid).update({
      'sql_levels.level16': true,
    });
      } else {
        // Incorrect answer
        showResultDialog('Incorrect. Try again!', Colors.red,false);
      }
    } else {
      // User didn't select any option
      showResultDialog('Please select an option!', Colors.grey,false);
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
