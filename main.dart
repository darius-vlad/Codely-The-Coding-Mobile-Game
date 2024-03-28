// ignore_for_file: unused_local_variable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:code_app/firebase_options.dart';
import 'package:code_app/settings_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'new_button.dart';
import 'package:animate_gradient/animate_gradient.dart';
import 'menu_page.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const HomePage());
}

class HomePage extends StatefulWidget {
  //final String username;
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        debugShowCheckedModeBanner: false, home: MainPage());
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage>
    with SingleTickerProviderStateMixin {
  static bool isButtonPressed = false;
  late String _username = 'Guest';
  late AnimationController _controller;
  late Animation<Alignment> _topAlignmentAnimation;
  late Animation<Alignment> _bottomAlignmentAnimation;

  void initState() {
    super.initState();
    // Call the method to get the username when the widget initializes
    _fetchUsername();
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 8));
    _topAlignmentAnimation = TweenSequence<Alignment>([
      TweenSequenceItem(
          tween: Tween<Alignment>(
              begin: Alignment.topLeft, end: Alignment.topRight),
          weight: 1),
      TweenSequenceItem(
          tween: Tween<Alignment>(
              begin: Alignment.topRight, end: Alignment.bottomRight),
          weight: 1),
      TweenSequenceItem(
          tween: Tween<Alignment>(
              begin: Alignment.bottomRight, end: Alignment.bottomLeft),
          weight: 1),
      TweenSequenceItem(
          tween: Tween<Alignment>(
              begin: Alignment.bottomLeft, end: Alignment.topLeft),
          weight: 1),
    ]).animate(_controller);

    _bottomAlignmentAnimation = TweenSequence<Alignment>([
      TweenSequenceItem(
          tween: Tween<Alignment>(
              begin: Alignment.bottomRight, end: Alignment.bottomLeft),
          weight: 1),
      TweenSequenceItem(
          tween: Tween<Alignment>(
              begin: Alignment.bottomLeft, end: Alignment.topLeft),
          weight: 1),
      TweenSequenceItem(
          tween: Tween<Alignment>(
              begin: Alignment.topLeft, end: Alignment.topRight),
          weight: 1),
      TweenSequenceItem(
          tween: Tween<Alignment>(
              begin: Alignment.topRight, end: Alignment.bottomRight),
          weight: 1),
    ]).animate(_controller);

    _controller.repeat();
  }

  Future<void> _fetchUsername() async {
    String? username = await getUsernameOfCurrentUser();
    if (username != null) {
      setState(() {
        _username = username;
      });
    }
  }

  void buttonPressed() {
    setState(() {
      if (isButtonPressed == false) {
        isButtonPressed = true;
        Future.delayed(
          const Duration(milliseconds: 200),
          () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MenuPage(
                  onMenuPageButtonPressed: () {
                    // Callback when the button is pressed in MenuPage
                    setState(() {
                      isButtonPressed = false;
                    });
                  },
                ),
              ),
            );
          },
        );
      } else if (isButtonPressed == true) {
        isButtonPressed = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double scaleX = 0.30;
    double scaleY = 0.30;
    double textHeight = screenSize.height * scaleY;
    double textWidth = screenSize.width * scaleX;
    double midTextX = (screenSize.width - textHeight) / 2;
    double midTextY = (screenSize.height - textWidth) / 3;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: AnimatedBuilder(
          animation: _controller,
          builder: (context, _) {
            return Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [
                    Color.fromARGB(255, 98, 98, 98),
                    Color.fromARGB(255, 69, 69, 69),
                    Color.fromARGB(255, 28, 28, 28),
                  ],
                      begin: _topAlignmentAnimation.value,
                      end: _bottomAlignmentAnimation.value)),
              child: Stack(
                children: [
                  Positioned(
                    top: midTextY + 80,
                    left: midTextX,
                    child: Container(
                      height: textWidth,
                      width: textHeight,
                      child: Center(
                        child: Text('Hello , $_username',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.openSans(
                              textStyle: TextStyle(
                                fontSize:
                                    1.30 * (15 + 0.0039065 * screenSize.width),
                                color: Colors.greenAccent.shade100,
                                fontWeight: FontWeight.w900,
                              ),
                            )),
                      ),
                    ),
                  ),
                  Positioned(
                      bottom: 16,
                      right: 16,
                      child: IconButton(
                        icon: Icon(Icons.settings),
                        color: Colors.greenAccent.shade100,
                        iconSize: 64,
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SettingsPage()));
                        },
                      )),
                  Center(
                    child: NewButton(
                      onTap: buttonPressed,
                      isButtonPressed: isButtonPressed,
                    ),
                  ),
                  Positioned(
                    top: midTextY,
                    left: midTextX,
                    child: Container(
                      height: textWidth,
                      width: textHeight,
                      child: Center(
                        child: Text('Codely',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.openSans(
                              textStyle: TextStyle(
                                fontSize:
                                    3.70 * (15 + 0.00390625 * screenSize.width),
                                color: Colors.greenAccent.shade100,
                                fontWeight: FontWeight.w900,
                                shadows: [
                                  Shadow(
                                    blurRadius: 12,
                                    offset: Offset(3, 2),
                                    color: Colors.black,
                                  )
                                ],
                              ),
                            )),
                      ),
                    ),
                  )
                ],
              ),
            );
          }),
    );
  }

  Future<String?> getUsernameOfCurrentUser() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      String uid = user.uid;
      try {
        DocumentSnapshot userSnapshot =
            await FirebaseFirestore.instance.collection('users').doc(uid).get();
        if (userSnapshot.exists) {
          // User document exists, retrieve username
          return userSnapshot['username'];
        } else {
          // User document does not exist
          print('User document does not exist');
          return null;
        }
      } catch (e) {
        print('Error fetching user document: $e');
        return null;
      }
    } else {
      // No user is currently signed in
      return "Guest";
    }
  }
}
