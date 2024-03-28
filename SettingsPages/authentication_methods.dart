
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:code_app/SettingsPages/authentication_methods.dart';
import 'package:code_app/SettingsPages/sign_up_page.dart';
import 'package:code_app/firebase_auth_implementation/firebase_auth_services.dart';
import 'package:code_app/global/common/toast.dart';
import 'package:code_app/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';


class AuthMethods extends StatefulWidget {
  @override
  State<AuthMethods> createState() => _AuthMethodsState();
}

class _AuthMethodsState extends State<AuthMethods> {
   final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[800],
        title:  Text('Authentication Methods',
        style: GoogleFonts.openSans(
          textStyle: const TextStyle(
            fontWeight: FontWeight.w800,
            color: Colors.white
          )
        )),
      ),
      body: const SettingsBody(),
      backgroundColor: Colors.grey[800],
    );
  }
}

class SettingsBody extends StatefulWidget {
  const SettingsBody({Key? key});

  @override
  State<SettingsBody> createState() => _SettingsBodyState();
}

class _SettingsBodyState extends State<SettingsBody> {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SettingsButton(
            title: 'Email/Password',
            onPressed: () {
             Navigator.push(context, MaterialPageRoute(builder: (context)=>(SignUpPage()))) ;
            },
          ),
          SettingsButton(
            title: 'Google',
            onPressed: () {
              _signInWithGoogle();
            },
          ),
          SettingsButton(
            title: 'Facebook',
            onPressed: () {
              print('Logout pressed');
            },
          ),
        ],
      ),
    );
  }



  _signInWithGoogle() async {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  try {
    final GoogleSignInAccount? googleSignInAccount = await _googleSignIn.signIn();

    if (googleSignInAccount != null) {
      showToast(message: "Successfully signed in with Google");
      
      final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;
      
      final AuthCredential credential = GoogleAuthProvider.credential(
        idToken: googleSignInAuthentication.idToken,
        accessToken: googleSignInAuthentication.accessToken,
      );

      // Sign in with credential
      UserCredential userCredential = await _firebaseAuth.signInWithCredential(credential);
      
      // Extract user data
      String uid = userCredential.user!.uid;
      String email = userCredential.user!.email ?? '';
      String displayName = userCredential.user!.displayName ?? '';
      
       DocumentSnapshot userSnapshot = await FirebaseFirestore.instance.collection('users').doc(uid).get();
      // Store user data in Firestore
       if (!userSnapshot.exists){
      await FirebaseFirestore.instance.collection('users').doc(uid).set({
        'email': email,
        'username': displayName,
         'c_plus_plus_levels': _initializeLevelCompletion(),
        'java_levels': _initializeLevelCompletion(),
        'java_script_levels' : _initializeLevelCompletion(),
        'sql_levels': _initializeLevelCompletion(),
        'hmtl_levels': _initializeLevelCompletion(),
        'c#_levels': _initializeLevelCompletion(),
        
        // Add any other user details you want to store
      });}

      // Navigate to the home page
      Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
    
    }
  } catch (e) {
    showToast(message: "Some error occurred: $e");
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







class SettingsButton extends StatefulWidget {
  final String title;
  final VoidCallback onPressed;

  const SettingsButton({
    Key? key,
    required this.title,
    required this.onPressed,
  }) : super(key: key);

  @override
  State<SettingsButton> createState() => _SettingsButtonState();
}

class _SettingsButtonState extends State<SettingsButton> {
  @override
  Widget build(BuildContext context) {
     bool isSwitched = false;
    Size screenSize = MediaQuery.of(context).size;
    double screenWidth = screenSize.width;
    double toMakeItRight = screenWidth-220;
    return SizedBox(
      width: double.infinity, // Takes the whole width
      child: Padding(
        padding: const EdgeInsets.symmetric(
            vertical: 0.0), // Adjust vertical padding
        child: TextButton(
          onPressed: widget.onPressed,
          style: ButtonStyle(
            padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
              const EdgeInsets.symmetric(
                  vertical: 12.0, horizontal: 16.0), // Adjust padding
            ),
            backgroundColor:
                MaterialStateProperty.all<Color>(Colors.grey.shade800),
            side: MaterialStateProperty.all<BorderSide>(
               BorderSide(width: 2.0, color: Colors.grey.shade700), // Border settings
            ),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.zero, // Rounded corners
              ),
            ),
          ),
          child: Row(
            children: [
                 if(widget.title == "Email/Password")
                 Icon(Icons.email_rounded,color: Colors.white)
                else if(widget.title == "Google")
                 FaIcon(FontAwesomeIcons.google,color: Colors.white)
                 else 
                 if(widget.title == "Facebook")
                 Icon(Icons.facebook,color: Colors.white),
            
              const SizedBox(
                width: 8.0,
              ),
               Container(
                width: 86,
                child: Text(
                  widget.title,
                  style: GoogleFonts.openSans(
                  textStyle : const TextStyle(fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.w600),
                )
                ),
              ),
              SizedBox(width: toMakeItRight,),
              const Icon(Icons.arrow_forward_ios,color: Colors.white)
              

            ],
          ),
        ),
      ),
    );
  }

  
}
