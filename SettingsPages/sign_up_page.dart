import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:code_app/SettingsPages/login_page.dart';
import 'package:code_app/SumWidgets/form_container_widget.dart';
import 'package:code_app/firebase_auth_implementation/firebase_auth_services.dart';
import 'package:code_app/global/common/toast.dart';
import 'package:code_app/main.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final FirebaseAuthServices _auth = FirebaseAuthServices();
  bool isSigningUp = false;
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
           leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
            ),
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                  context, MaterialPageRoute(builder: (context) => HomePage()),(route)=>false);
            },
          ),
          title: Text(
            "Sign Up",
            style: GoogleFonts.openSans(
              textStyle: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          backgroundColor: Colors.grey[800],
        ),
        backgroundColor: Colors.grey[800],
        body: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text("Sign Up",
                  style: GoogleFonts.openSans(
                    textStyle: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                      fontSize: 32,
                    ),
                  )),
              const SizedBox(
                height: 30,
              ),
              FormContainerWidget(
                controller: _usernameController,
                hintText: "Username",
                isPasswordField: false,
              ),
              const SizedBox(
                height: 10,
              ),
              FormContainerWidget(
                controller: _emailController,
                hintText: "Email",
                isPasswordField: false,
              ),
              const SizedBox(
                height: 10,
              ),
              FormContainerWidget(
                controller: _passwordController,
                hintText: "Password",
                isPasswordField: true,
              ),
              const SizedBox(
                height: 30,
              ),
              GestureDetector(
                onTap: () {
                  _signUp();
                },
                child: Container(
                  width: double.infinity,
                  height: 45,
                  decoration: BoxDecoration(
                    color: Colors.greenAccent.shade100,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: isSigningUp
                        ? CircularProgressIndicator(color: Colors.white)
                        : Text(
                            "Sign up",
                            style: GoogleFonts.openSans(
                              textStyle: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already have an account?",
                     style: GoogleFonts.openSans(
              textStyle: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                  ),
            ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => LoginPage()),
                          (route) => false);
                    },
                    child: Text("Login",
                     style: GoogleFonts.openSans(
              textStyle:  TextStyle(
                  color: Colors.greenAccent.shade100,
                  fontWeight: FontWeight.w800,
                  ),
            ),),
                  )
                ],
              )
            ]),
          ),
        ));
  }

  void _signUp() async {
    setState(() {
      isSigningUp = true;
    });

    String username = _usernameController.text;
    String email = _emailController.text;
    String password = _passwordController.text;

    // Sign up the user with email and password
    User? user = await _auth.signUpWithEmailAndPassword(email, password);

    if (user != null) {
      // User registration successful, add user details to Firestore
      await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
        'username': username,
        'email': email,
        'c_plus_plus_levels': _initializeLevelCompletion(),
        'java_levels': _initializeLevelCompletion(),
        'java_script_levels' : _initializeLevelCompletion(),
        'sql_levels': _initializeLevelCompletion(),
        'hmtl_levels': _initializeLevelCompletion(),
        'c#_levels': _initializeLevelCompletion(),
      });

      // Update the UI
      setState(() {
        isSigningUp = false;
      });

      // Navigate to the home page
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => HomePage()));

      // Show success message
      showToast(message: "User successfully created");
    } else {
      // User registration failed
      setState(() {
        isSigningUp = false;
      });
      showToast(message: "Some error occurred");
    }
  }


  Map<String, bool> _initializeLevelCompletion() {
  // Initialize completion status for all levels to false
  return {
    'level1': false,
    'level2': false,
    'level3': false,
    'level4': false,
    'level5': false,
    'level6': false,
    'level7': false,
    'level8': false,
    'level9': false,
    'level10': false,
    'level11': false,
    'level12': false,
    'level13': false,
    'level14': false,
    'level15': false,
    'level16': false,
    'level17': false,
    'level18': false,
    'level19': false,
    'level20': false,
    'level21': false,
    
    // Add more levels as needed
  };
}


}
