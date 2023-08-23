import 'dart:async';

import 'package:celebrare_assignment/screens/home_page.dart';
import 'package:celebrare_assignment/widgets/themes.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(const Duration(seconds: 1), () async {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => HomePage()));
    });
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyTheme.cream,
      body: Center(
          child: Text(
        "Celebrare",
        style: TextStyle(
            fontFamily: GoogleFonts.dancingScript().fontFamily, fontSize: 40),
      )),
    );
  }
}
