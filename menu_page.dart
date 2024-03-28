import 'package:code_app/Level_Pages/level_page_java.dart';
import 'package:code_app/Level_Pages/levels__page_js.dart';
import 'package:code_app/Level_Pages/levels_page.dart';
import 'package:code_app/Level_Pages/levels_page_sql.dart';
import 'package:code_app/main.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MenuPage extends StatefulWidget {
  final VoidCallback? onMenuPageButtonPressed;

  const MenuPage({Key? key, this.onMenuPageButtonPressed}) : super(key: key);

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[800],
      body: Stack(
        children: [
          const ScrollPage(),
          Align(
            alignment: Alignment.bottomCenter,
            child: ElevatedButton(
              onPressed: () {
                widget.onMenuPageButtonPressed?.call();
                Navigator.of(context).pop();
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.grey[800], // Set the background color to grey
              ),
              child: Text('Back to home page',
                  style: GoogleFonts.openSans(
                      textStyle: TextStyle(
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                  ))),
            ),
          ),
        ],
      ),
    );
  }
}

class ScrollPage extends StatefulWidget {
  const ScrollPage({Key? key}) : super(key: key);

  @override
  State<ScrollPage> createState() => _ScrollPageState();
}

class _ScrollPageState extends State<ScrollPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[800],
      body: Scrollbar(
        thumbVisibility: true,
        child: ListView.separated(
          padding: const EdgeInsets.all(48),
          separatorBuilder: (context, index) {
            return const SizedBox(height: 24);
          },
          itemCount: 6,
          itemBuilder: (context, index) {
            return Language(index: index);
          },
        ),
      ),
    );
  }
}

class Language extends StatelessWidget {
  final int index;
  const Language({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    String cardText = 'card';
    switch (index) {
      case 0:
        cardText = 'C++';
        break;
      case 1:
        cardText = 'Java';
        break;
      case 2:
        cardText = 'JavaScript';
        break;
      case 3:
        cardText = 'SQL';
        break;
      case 4:
        cardText = 'HTML';
        break;
      case 5:
        cardText = 'C#';
        break;
    }
    return GestureDetector(
      onTap: () {
        switch (index) {
          case 0:
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    const LevelScrollCP(), // Menu page for C++
              ),
            );
            break;

          case 1:
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    const LevelScrollJava(), // Menu page for C++
              ),
            );
            break;

          case 2:
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    const LevelScrollJS(), // Menu page for C++
              ),
            );
            break;

          case 3:
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    const LevelScrollSQL(), // Menu page for C++
              ),
            );
            break;
          // Add cases for other languages here
        }
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(64),
          color: Colors.greenAccent.shade100,
        ),
        width: double.infinity,
        height: 0.172 * screenSize.height,
        child: Center(
          child: Text(
            cardText,
            style: GoogleFonts.openSans(
              textStyle: TextStyle(
                fontSize: 1.90 * (15 + 0.00390625 * screenSize.width),
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
