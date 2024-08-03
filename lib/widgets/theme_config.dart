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
          titleTextStyle: TextStyle(color: CustomColors.black, fontSize: 30, fontFamily: 'Roboto'),
        ),
        textTheme: const TextTheme(
          titleSmall: TextStyle(color: CustomColors.black, fontSize: 20),
          bodySmall: TextStyle(color: CustomColors.black, fontSize: 15),
          headlineSmall: TextStyle(color: CustomColors.black, fontSize: 25),

          titleMedium: TextStyle(color: CustomColors.black, fontSize: 30),
          bodyMedium: TextStyle(color: CustomColors.black, fontSize: 20),
          headlineMedium: TextStyle(color: CustomColors.black, fontSize: 35),
          labelMedium: TextStyle(color: CustomColors.black, fontSize: 20),

          titleLarge: TextStyle(color: CustomColors.black, fontSize: 40),
          bodyLarge: TextStyle(color: CustomColors.black, fontSize: 25),
          headlineLarge: TextStyle(color: CustomColors.black, fontSize: 45),
          labelLarge: TextStyle(color: CustomColors.black, fontSize: 25),
        ),
      );