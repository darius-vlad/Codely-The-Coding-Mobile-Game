import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:code_app/C++-Levels/level1_c++.dart';
import 'package:code_app/C++-Levels/level2_c++.dart';
import 'package:code_app/C++-Levels/level3_c++.dart';
import 'package:code_app/C++-Levels/level4_c++.dart';
import 'package:code_app/C++-Levels/level5_c++.dart';
import 'package:code_app/C++-Levels/level6_c++.dart';
import 'package:code_app/C++-Levels/level7_c++.dart';
import 'package:code_app/C++-Levels/level8_c++.dart';
import 'package:code_app/C++-Levels/level9_c++.dart';
import 'package:code_app/C++-Levels/level10_c++.dart';
import 'package:code_app/C++-Levels/level11_c++.dart';
import 'package:code_app/C++-Levels/level12_c++.dart';
import 'package:code_app/C++-Levels/level13_c++.dart';
import 'package:code_app/C++-Levels/level14_c++.dart';
import 'package:code_app/C++-Levels/level15_c++.dart';
import 'package:code_app/C++-Levels/level16_c++.dart';
import 'package:code_app/C++-Levels/level17_c++.dart';
import 'package:code_app/C++-Levels/level18_c++.dart';
import 'package:code_app/C++-Levels/level19_c++.dart';
import 'package:code_app/C++-Levels/level20_c++.dart';
import 'package:code_app/C++-Levels/level21_c++.dart';
import 'package:code_app/main.dart';
import 'package:code_app/menu_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LevelScrollCP extends StatefulWidget {
  const LevelScrollCP({super.key});

  @override
  State<LevelScrollCP> createState() => _LevelScrollCPState();
}

class _LevelScrollCPState extends State<LevelScrollCP> {
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
            userSnapshot['c_plus_plus_levels'];

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
         title: Text('C++',
            style:GoogleFonts.openSans(
               textStyle: TextStyle(
                fontWeight: FontWeight.w800,
                color: Colors.white,
                fontSize: 2.25*(15+0.00390625*screenSize.width),
               )
            )
          ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
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
                        String levelClassName = 'Level${index + 1}CPlus';
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
      case 'Level1CPlus':
        return Level1CPlus();
      case 'Level2CPlus':
        return Level2CPlus();
      case 'Level3CPlus':
        return Level3CPlus();
      case 'Level4CPlus':
        return Level4CPlus();
      case 'Level5CPlus':
        return Level5CPlus();
      case 'Level6CPlus':
        return Level6CPlus();
      case 'Level7CPlus':
        return Level7CPlus();
      case 'Level8CPlus':
        return Level8CPlus();
      case 'Level9CPlus':
        return Level9CPlus();
      case 'Level10CPlus':
        return Level10CPlus();
      case 'Level11CPlus':
        return Level11CPlus();
      case 'Level12CPlus':
        return Level12CPlus();
      case 'Level13CPlus':
        return Level13CPlus();
      case 'Level14CPlus':
        return Level14CPlus();
      case 'Level15CPlus':
        return Level15CPlus();
      case 'Level16CPlus':
        return Level16CPlus();
      case 'Level17CPlus':
        return Level17CPlus();
      case 'Level18CPlus':
        return Level18CPlus();
      case 'Level19CPlus':
        return Level19CPlus();
      case 'Level20CPlus':
        return Level20CPlus();
      case 'Level21CPlus':
        return Level21CPlus();
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
      height: 0.120 * screenSize.height,
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
