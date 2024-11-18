

import 'dart:async';

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
    super.initState();
    Timer(Duration(seconds: 3),(){
      Navigator.of(context).pushReplacementNamed('homepage');
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        alignment: Alignment.center,
        height: 700,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 100,),
            Text('Media    \n      Player',style: GoogleFonts.rancho(
              fontSize: 90,
              letterSpacing: 3,
              wordSpacing: 5,
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),)
          ],
        ),
      ),
    );
  }
}
