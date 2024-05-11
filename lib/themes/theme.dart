import 'package:flutter/material.dart';

// Definição de cores personalizadas
const Color yellowColor = Color(0xFFFFD700); // Amarelo
const Color blackColor = Colors.black; // Preto
const Color whiteColor = Colors.white; // Branco

// Definição do ThemeData personalizado
final ThemeData customTheme = ThemeData(
  // Cor do esquema
  primaryColor: yellowColor,
  scaffoldBackgroundColor: whiteColor,

  // Texto
  textTheme: TextTheme(
    headline1: TextStyle(color: blackColor),
    bodyText1: TextStyle(color: blackColor),
  ),

  // AppBar
  appBarTheme: AppBarTheme(
    backgroundColor: yellowColor,
    foregroundColor: blackColor,
  ),

  // Botões
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.all<Color>(yellowColor),
      foregroundColor: MaterialStateProperty.all<Color>(blackColor),
    ),
  ),

  // Ícones
  iconTheme: IconThemeData(color: blackColor),
);
