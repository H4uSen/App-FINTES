import 'package:flutter/material.dart';

class CustomColors {
  static const Color white = Color.fromRGBO(253, 255, 226, 1);
  static const Color black = Color.fromRGBO(26, 33, 48, 1);
  static const Color lightBlue = Color.fromRGBO(131, 180, 255, 1);
  static const Color darkBlue = Color.fromRGBO(90, 114, 160, 1);
}
ThemeData customThemeData = ThemeData(
        fontFamily:'Roboto',
        primaryColor: CustomColors.lightBlue,
        scaffoldBackgroundColor: CustomColors.white,
        buttonTheme: const ButtonThemeData(
          buttonColor: CustomColors.darkBlue,
          textTheme: ButtonTextTheme.primary,
        ),
        appBarTheme:const AppBarTheme(
          backgroundColor: CustomColors.lightBlue,
          titleTextStyle: TextStyle(color: CustomColors.black, fontSize: 30, fontFamily: 'Roboto', wordSpacing: 2),
        ),
        textTheme: const TextTheme(
          titleSmall: TextStyle(color: CustomColors.black, fontSize: 20, wordSpacing: 2),
          bodySmall: TextStyle(color: CustomColors.black, fontSize: 15, wordSpacing: 2),
          headlineSmall: TextStyle(color: CustomColors.black, fontSize: 25, wordSpacing: 2),

          titleMedium: TextStyle(color: CustomColors.black, fontSize: 30, wordSpacing: 2),
          bodyMedium: TextStyle(color: CustomColors.black, fontSize: 20, wordSpacing: 2),
          headlineMedium: TextStyle(color: CustomColors.black, fontSize: 35, wordSpacing: 2),
          labelMedium: TextStyle(color: CustomColors.black, fontSize: 20, wordSpacing: 2),

          titleLarge: TextStyle(color: CustomColors.black, fontSize: 40, wordSpacing: 2),
          bodyLarge: TextStyle(color: CustomColors.black, fontSize: 25, wordSpacing: 2),
          headlineLarge: TextStyle(color: CustomColors.black, fontSize: 45, wordSpacing: 2),
          labelLarge: TextStyle(color: CustomColors.black, fontSize: 25, wordSpacing: 2),
        ),
      );