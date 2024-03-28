import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:code_app/JavaScript-Levels/level10_js.dart';
import 'package:code_app/JavaScript-Levels/level11_js.dart';
import 'package:code_app/JavaScript-Levels/level12_js.dart';
import 'package:code_app/JavaScript-Levels/level13_js.dart';
import 'package:code_app/JavaScript-Levels/level14_js.dart';
import 'package:code_app/JavaScript-Levels/level15_js.dart';
import 'package:code_app/JavaScript-Levels/level16_js.dart';
import 'package:code_app/JavaScript-Levels/level17_js.dart';
import 'package:code_app/JavaScript-Levels/level18_js.dart';
import 'package:code_app/JavaScript-Levels/level19_js.dart';
import 'package:code_app/JavaScript-Levels/level1_js.dart';
import 'package:code_app/JavaScript-Levels/level20_js.dart';
import 'package:code_app/JavaScript-Levels/level21_js.dart';
import 'package:code_app/JavaScript-Levels/level2_js.dart';
import 'package:code_app/JavaScript-Levels/level3_js.dart';
import 'package:code_app/JavaScript-Levels/level4_js.dart';
import 'package:code_app/JavaScript-Levels/level5_js.dart';
import 'package:code_app/JavaScript-Levels/level6_js.dart';
import 'package:code_app/JavaScript-Levels/level7_js.dart';
import 'package:code_app/JavaScript-Levels/level8_js.dart';
import 'package:code_app/JavaScript-Levels/level9_js.dart';


import 'package:code_app/main.dart';
import 'package:code_app/menu_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LevelScrollJS extends StatefulWidget {
  const LevelScrollJS({super.key});

  @override
  State<LevelScrollJS> createState() => _LevelScrollJSState();
}

class _LevelScrollJSState extends State<LevelScrollJS> {
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
            userSnapshot['java_script_levels'];

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
        title: Text('JavaScript',
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
                        String levelClassName = 'Level${index + 1}JS';
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
      case 'Level1JS':
        return Level1JS();
      case 'Level2JS':
        return Level2JS();
      case 'Level3JS':
        return Level3JS();
      case 'Level4JS':
        return Level4JS();
      case 'Level5JS':
        return Level5JS();
      case 'Level6JS':
        return Level6JS();
      case 'Level7JS':
        return Level7JS();
      case 'Level8JS':
        return Level8JS();
      case 'Level9JS':
        return Level9JS();
      case 'Level10JS':
        return Level10JS();
      case 'Level11JS':
        return Level11JS();
      case 'Level12JS':
        return Level12JS();
      case 'Level13JS':
        return Level13JS();
      case 'Level14JS':
        return Level14JS();
      case 'Level15JS':
        return Level15JS();
       case 'Level16JS':
        return Level16JS();
      case 'Level17JS':
        return Level17JS();
      case 'Level18JS':
        return Level18JS();
      case 'Level19JS':
        return Level19JS();
      case 'Level20JS':
        return Level20JS();
      case 'Level21JS':
        return Level21JS();
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
