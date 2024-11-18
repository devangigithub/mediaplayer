import 'package:flutter/material.dart';
import 'package:mediaplayer/screen/Audio_View.dart';
import 'package:mediaplayer/screen/home_screen.dart';
import 'package:mediaplayer/screen/splash_scrren.dart';


void main(){
  runApp(
      MaterialApp(
        debugShowCheckedModeBanner: false,
    initialRoute: '/',
    routes: {
           'homepage':(context){return HomeScreen();},
      '/':(context){return SplashScreen();},
           'audio':(context){return AudioView();},


    },
  ));
}