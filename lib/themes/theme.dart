import 'package:flutter/material.dart';

const Color yellowColor = Color.fromARGB(255, 255, 217, 0); 
const Color blackColor = Colors.black; 
const Color whiteColor = Colors.white;
const Color Roxo = Color.fromRGBO(100,65,165, 1);
const Color RoxoBlack = Color.fromRGBO(161,124,184,1);
const Color prestoPastel = Color.fromRGBO(24, 24, 24, 1);

final ThemeData customTheme = ThemeData(
  primaryColor: RoxoBlack,
  scaffoldBackgroundColor: Color.fromRGBO(26, 26, 26, 0.922),

  textTheme: Typography.whiteRedmond,
    
  appBarTheme: AppBarTheme(
    backgroundColor: prestoPastel,
    foregroundColor: whiteColor,
  ),

  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: prestoPastel,
    selectedItemColor: RoxoBlack,
    unselectedItemColor: Color.fromARGB(255, 255, 255, 255),
    selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
  ),
  
  cardTheme: CardTheme(
    color: Color.fromARGB(255, 38, 38, 38),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.all<Color>(Roxo),
      foregroundColor: MaterialStateProperty.all<Color>(whiteColor),
    ),
  ),

  iconTheme: IconThemeData(color: blackColor),
);