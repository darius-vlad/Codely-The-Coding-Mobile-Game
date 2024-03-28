import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:code_app/C++-Levels/level12_c++.dart';
import 'package:code_app/Java-Levels/level10_java.dart';
import 'package:code_app/Java-Levels/level11_java.dart';
import 'package:code_app/Java-Levels/level12_java.dart';
import 'package:code_app/Java-Levels/level13_java.dart';
import 'package:code_app/Java-Levels/level14_java.dart';
import 'package:code_app/Java-Levels/level15_java.dart';
import 'package:code_app/Java-Levels/level16_java.dart';
import 'package:code_app/Java-Levels/level17_java.dart';
import 'package:code_app/Java-Levels/level18_java.dart';
import 'package:code_app/Java-Levels/level19_java.dart';
import 'package:code_app/Java-Levels/level1_java.dart';
import 'package:code_app/Java-Levels/level20_java.dart';
import 'package:code_app/Java-Levels/level21_java.dart';
import 'package:code_app/Java-Levels/level2_java.dart';
import 'package:code_app/Java-Levels/level3_java.dart';
import 'package:code_app/Java-Levels/level4_java.dart';
import 'package:code_app/Java-Levels/level5_java.dart';
import 'package:code_app/Java-Levels/level6_java.dart';
import 'package:code_app/Java-Levels/level7_java.dart';
import 'package:code_app/Java-Levels/level8_java.dart';
import 'package:code_app/Java-Levels/level9_java.dart';
import 'package:code_app/main.dart';
import 'package:code_app/menu_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LevelScrollJava extends StatefulWidget {
  const LevelScrollJava({super.key});

  @override
  State<LevelScrollJava> createState() => _LevelScrollJavaState();
}

class _LevelScrollJavaState extends State<LevelScrollJava> {
  late List<bool> levelCompletionStatus;
  bool isLoading = true; // Flag to indicate whether data fetching is in progress

  @override
  void initState() {
    super.initState();
    // Initialize all levels as incomplete initially
    levelCompletionStatus = List.generate(21, (index) => false);
    // Fetch completion statuses
    _fetchCompletionStatuses();
  }

  Future<void> _fetchCompletionStatuses() async {
    String? userId = FirebaseAuth.instance.currentUser?.uid;

    if (userId != null) {
      DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .get();

      if (userSnapshot.exists) {
        Map<String, dynamic> completionStatus =
            userSnapshot['java_levels'];

        for (int i = 0; i < levelCompletionStatus.length; i++) {
          String levelKey = 'level${i + 1}';
          if (completionStatus.containsKey(levelKey)) {
            setState(() {
              levelCompletionStatus[i] = completionStatus[levelKey];
            });
          }
        }
      }
    }
 await Future.delayed(Duration(milliseconds: 350));
    // Data fetching is complete
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text('Java',
            style:GoogleFonts.openSans(
               textStyle: TextStyle(
                fontWeight: FontWeight.w800,
                color: Colors.white,
                fontSize: 2.25*(15+0.00390625*screenSize.width),
               )
            )
          ),
        backgroundColor: Colors.grey[800],
      ),
      backgroundColor: Colors.grey[800],
      body: isLoading
          ? Center(child: CircularProgressIndicator(
            color: Colors.greenAccent.shade100,
          )) // Show loading indicator while fetching data
          : Scrollbar(
              child: GridView.builder(
                itemCount: 21,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3),
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () {
                        String levelClassName = 'Level${index + 1}Java';
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    _getClassFromString(levelClassName)));
                      },
                      child: Level(
                        index: index,
                        isCompleted: levelCompletionStatus[index],
                      ),
                    ),
                  );
                },
              ),
            ),
    );
  }
}


  Widget _getClassFromString(String className) {
    switch (className) {
      case 'Level1Java':
        return Level1Java();
      case 'Level2Java':
        return Level2Java();
      case 'Level3Java':
        return Level3Java();
      case 'Level4Java':
        return Level4Java();
      case 'Level5Java':
        return Level5Java();
      case 'Level6Java':
        return Level6Java();
      case 'Level7Java':
        return Level7Java();
      case 'Level8Java':
        return Level8Java();
      case 'Level9Java':
        return Level9Java();
      case 'Level10Java':
        return Level10Java();
      case 'Level11Java':
        return Level11Java();
      case 'Level12Java':
        return Level12Java();
      case 'Level13Java':
        return Level13Java();
      case 'Level14Java':
        return Level14Java();
      case 'Level15Java':
        return Level15Java();
      case 'Level16Java':
        return Level16Java();
      case 'Level17Java':
        return Level17Java();
      case 'Level18Java':
        return Level18Java();
      case 'Level19Java':
        return Level19Java();
      case 'Level20Java':
        return Level20Java();
      case 'Level21Java':
        return Level21Java();
      // Add more cases for other levels as needed
      default:
        return Container(); // Default to a generic level if the class is not found
    }
  }


class Level extends StatefulWidget {
  final int index;
  final bool isCompleted;

  Level({Key? key, required this.index, required this.isCompleted}) : super(key: key);

  @override
  _LevelState createState() => _LevelState();
}

class _LevelState extends State<Level> {
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    String cardText = (widget.index + 1).toString();
    Color levelColor = widget.isCompleted ? Colors.greenAccent.shade100 : Colors.grey;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: levelColor,
      ),
      width: double.infinity,
      height: 250,
      child: Center(
        child: Text(cardText,
            textAlign: TextAlign.center,
            style: GoogleFonts.openSans(
              textStyle:  TextStyle(
                fontSize: 1.95*(15+0.00390625*screenSize.width),
                fontWeight: FontWeight.w800,
              ),
            )),
      ),
    );
  }
}
