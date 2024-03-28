import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NewButton extends StatelessWidget {
  final onTap;
  bool isButtonPressed;
  NewButton({this.onTap, required this.isButtonPressed});

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double scaleX = 0.20;
    double scaleY = 0.30;
    double buttonHeight= screenSize.height*scaleY;
    double buttonWidth = screenSize.width*scaleX;
    double midX = (screenSize.width-buttonHeight)/2;
    double midY = 2*(screenSize.height-buttonWidth)/3;
    return Stack(
      children: [Positioned(
        top: midY,
        left : midX,
        child: GestureDetector(
          onTap: onTap,
          child: AnimatedContainer(
            
            duration: Duration(milliseconds: 200),
            height: buttonWidth,
            width: buttonHeight,
            child: Center(
              child: Text(
                'Play',
                textAlign: TextAlign.center,
                style: GoogleFonts.openSans(
                textStyle : TextStyle(
                  fontSize: 2.10*(15+0.00390625*screenSize.width),
                  color: Colors.black,
                  fontWeight: FontWeight.w800,
                 
                ),),
              ),
            ),
            decoration: BoxDecoration(
              color: Colors.greenAccent.shade100,
              borderRadius: BorderRadius.circular(64),
              border: Border.all(
                color:
                    isButtonPressed ? Colors.grey.shade200  : Colors.grey.shade300,
              ),
              boxShadow: isButtonPressed
                  ? []
                  : [
                      BoxShadow(
                        color: Colors.grey.shade500,
                        offset: const Offset(6, 6),
                        blurRadius: 15,
                        spreadRadius: 1,
                      ),
                       BoxShadow(
                        color: Colors.grey.shade200,
                        offset: Offset(-6, -6),
                        blurRadius: 15,
                        spreadRadius: 1,
                      ),
                    ],
            ),
          ),
        ),
      ),
    ],);
  }
}
