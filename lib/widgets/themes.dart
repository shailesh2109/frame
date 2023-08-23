import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class MyTheme{
  static ThemeData lightTheme(BuildContext context) =>ThemeData(
      fontFamily: GoogleFonts.handlee().fontFamily,
      
      appBarTheme: AppBarTheme(
        color: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0.5,
        
      )
    );

  static ThemeData darkTheme(BuildContext context)=>ThemeData(
    brightness: Brightness.dark

  );

  static Color darkBlue=Color(0xff403b58);
  static Color cream=Color(0xfff5f5f5);
  static Color black=Color.fromARGB(255, 66, 66, 66);
  static Color green=Color(0xff088178);


    }

