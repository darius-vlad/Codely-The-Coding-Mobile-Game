import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:code_app/SQL-Levels/level10_sql.dart';
import 'package:code_app/SQL-Levels/level11_sql.dart';
import 'package:code_app/SQL-Levels/level12_sql.dart';
import 'package:code_app/SQL-Levels/level13_sql.dart';
import 'package:code_app/SQL-Levels/level14_sql.dart';
import 'package:code_app/SQL-Levels/level15_sql.dart';
import 'package:code_app/SQL-Levels/level16_sql.dart';
import 'package:code_app/SQL-Levels/level17_sql.dart';
import 'package:code_app/SQL-Levels/level18_sql.dart';
import 'package:code_app/SQL-Levels/level19_sql.dart';
import 'package:code_app/SQL-Levels/level1_sql.dart';
import 'package:code_app/SQL-Levels/level20_sql.dart';
import 'package:code_app/SQL-Levels/level21_sql.dart';
import 'package:code_app/SQL-Levels/level2_sql.dart';
import 'package:code_app/SQL-Levels/level3_sql.dart';
import 'package:code_app/SQL-Levels/level4_sql.dart';
import 'package:code_app/SQL-Levels/level5_sql.dart';
import 'package:code_app/SQL-Levels/level6_sql.dart';
import 'package:code_app/SQL-Levels/level7_sql.dart';
import 'package:code_app/SQL-Levels/level8_sql.dart';
import 'package:code_app/SQL-Levels/level9_sql.dart';



import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LevelScrollSQL extends StatefulWidget {
  const LevelScrollSQL({super.key});

  @override
  State<LevelScrollSQL> createState() => _LevelScrollSQLState();
}

class _LevelScrollSQLState extends State<LevelScrollSQL> {
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
            userSnapshot['sql_levels'];

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
        title: Text('SQL',
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
                        String levelClassName = 'Level${index + 1}SQL';
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
      case 'Level1SQL':
        return Level1SQL();
      case 'Level2SQL':
        return Level2SQL();
      case 'Level3SQL':
        return Level3SQL();
      case 'Level4SQL':
        return Level4SQL();
      case 'Level5SQL':
        return Level5SQL();
      case 'Level6SQL':
        return Level6SQL();
      case 'Level7SQL':
        return Level7SQL();
      case 'Level8SQL':
        return Level8SQL();
      case 'Level9SQL':
        return Level9SQL();
      case 'Level10SQL':
        return Level10SQL();
      case 'Level11SQL':
        return Level11SQL();
      case 'Level12SQL':
        return Level12SQL();
      case 'Level13SQL':
        return Level13SQL();
      case 'Level14SQL':
        return Level14SQL();
      case 'Level15SQL':
        return Level15SQL();
       case 'Level16SQL':
        return Level16SQL();
      case 'Level17SQL':
        return Level17SQL();
      case 'Level18SQL':
        return Level18SQL();
      case 'Level19SQL':
        return Level19SQL();
      case 'Level20SQL':
        return Level20SQL();
      case 'Level21SQL':
        return Level21SQL();
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
