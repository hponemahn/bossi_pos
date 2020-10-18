import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TitleText extends StatelessWidget{
  Widget build(BuildContext context){
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        text: 'p',
        style: GoogleFonts.portLligatSans(
          // ignore: deprecated_member_use
          textStyle: Theme.of(context).textTheme.display1,
          fontSize: 30,
          fontWeight: FontWeight.w700,
          color: Colors.purple[800],
        ),
        children: [
          TextSpan(
            text: 'o',
            style: TextStyle(color: Colors.black, fontSize: 30),
          ),
          TextSpan(
            text: 's',
            style: TextStyle(color: Colors.purple[800], fontSize: 30),
          )
        ]
      )
      );
  }
}