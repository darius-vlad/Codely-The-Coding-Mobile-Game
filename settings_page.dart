import 'package:code_app/SettingsPages/authentication_methods.dart';
import 'package:code_app/global/common/toast.dart';
import 'package:code_app/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[800],
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title:  Text('Settings',
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

class SettingsBody extends StatelessWidget {
  const SettingsBody({Key? key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SettingsButton(
            title: 'Account',
            onPressed: () {
             Navigator.push(context, MaterialPageRoute(builder: (context)=>AuthMethods())) ;
            },
          ),
          SettingsButton(
            title: 'Vibration',
            onPressed: () {
              print('Vibration settings pressed');
            },
          ),
          SettingsButton(
            title: 'Logout',
            onPressed: () {
              _signOut(context);
              
            },
          ),
        ],
      ),
    );
  }




Future<void> _signOut(BuildContext context) async {
  await FirebaseAuth.instance.signOut();
 await GoogleSignIn().signOut();
  Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(builder: (context) => HomePage()),
    (route) => false,
  );
  showToast(message: "Successfully Signed Out");
}


}

class SettingsButton extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;

  const SettingsButton({
    Key? key,
    required this.title,
    required this.onPressed,
  }) : super(key: key);

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
          onPressed: onPressed,
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
              if (title == "Account")
                 Icon(Icons.account_box,color: Colors.white)
              else if (title == "Vibration")
                 Icon(Icons.vibration,color: Colors.white)
              else if (title == "Logout")
                const Icon(
                  Icons.logout,
                  color: Colors.red,
                ),
              const SizedBox(
                width: 8.0,
              ),
              if(title=="Logout")
              Container(
                width: 86,
                child: Text(
                  title,
                  style: GoogleFonts.openSans(
                  textStyle : const TextStyle(fontSize: 18,
                  color: Colors.red,
                  fontWeight: FontWeight.w600),
                )
                ),
              )
              else
               Container(
                width: 86,
                child: Text(
                  title,
                  style: GoogleFonts.openSans(
                  textStyle : const TextStyle(fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.w600),
                )
                ),
              ),
              SizedBox(width: toMakeItRight,),
              if(title=="Logout")
              const Icon(Icons.arrow_forward_ios,color: Colors.red)
              else
              const Icon(Icons.arrow_forward_ios,color: Colors.white)
              

            ],
          ),
        ),
      ),
    );
  }


 
}
