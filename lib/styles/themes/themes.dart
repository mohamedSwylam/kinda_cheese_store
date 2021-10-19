import 'package:flutter/material.dart';

ThemeData darkTheme = ThemeData(
  fontFamily: 'Almarai',
  primarySwatch: Colors.teal,
  appBarTheme: AppBarTheme(
    elevation: 0.0,
  ),
  primaryColor:  Colors.black ,
  accentColor: Colors.teal,
  backgroundColor:  Colors.grey.shade700 ,
  scaffoldBackgroundColor: Colors.black,
  indicatorColor:  Color(0xff0E1D36) ,
  buttonColor: Color(0xff3B3B3B) ,
  hintColor: Colors.grey.shade300 ,
  highlightColor: Color(0xff372901) ,
  hoverColor: Color(0xff3A3A3B) ,
  focusColor:  Color(0xff0B2512),
  disabledColor: Colors.grey,
  textSelectionColor:  Colors.white ,
  cardColor:  Color(0xFF151515) ,
  canvasColor:  Colors.black ,
  brightness: Brightness.dark ,
  textTheme: TextTheme(
    subtitle1: TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.bold,
        color: Colors.white),
    bodyText2: TextStyle(
      color: Colors.grey,
      fontSize: 24,
      fontWeight: FontWeight.w600,
    ),
    subtitle2: TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 10,
      color: Colors.white,
    ),
    bodyText1: TextStyle(
      height: 1.5,
      color: Colors.white,
      fontWeight: FontWeight.bold,
      fontSize: 23,
      /*shadows: [
                      Shadow(
                        offset: Offset(0.0,15),
                        color:Colors.black,
                        blurRadius: 40,
                      ),
                    ],*/
    ),
    headline6: TextStyle(
      height: 1.5,
      color: Colors.white,
      fontWeight: FontWeight.bold,
      fontSize: 15,
    ),
  ),
);
ThemeData lightTheme = ThemeData(
  fontFamily: 'Almarai',
  scaffoldBackgroundColor: Colors.grey.shade300,
  primarySwatch: Colors.teal,
  primaryColor: Colors.grey.shade300,
  accentColor: Colors.teal,
  backgroundColor: Colors.white,
  indicatorColor:  Color(0xffCBDCF8),
  buttonColor:  Color(0xffF1F5FB),
  hintColor: Colors.grey.shade800,
  highlightColor:  Color(0xffFCE192),
  hoverColor:  Color(0xff4285F4),
  focusColor: Color(0xffA8DAB5),
  disabledColor: Colors.grey,
  textSelectionColor:  Colors.black,
  cardColor: Colors.white,
  canvasColor: Colors.grey[50],
  brightness:  Brightness.light,
  appBarTheme: AppBarTheme(
    elevation: 0.0,
  ),
  textTheme: TextTheme(
    subtitle1: TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.bold,
        color: Colors.black),
    bodyText2: TextStyle(
        color: Colors.grey,
        fontSize: 24,
        fontWeight: FontWeight.w600,
    ),
    subtitle2: TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 10,
      color: Colors.black,
    ),
    bodyText1: TextStyle(
      height: 1.5,
      color: Colors.black,
      fontWeight: FontWeight.bold,
      fontSize: 23,
      /*shadows: [
                      Shadow(
                        offset: Offset(0.0,15),
                        color:Colors.black,
                        blurRadius: 40,
                      ),
                    ],*/
    ),
    headline6: TextStyle(
      height: 1.5,
      color: Colors.black,
      fontWeight: FontWeight.bold,
      fontSize: 15,
    ),
  ),

);


/*class Styles {
  static ThemeData themeData(bool isDarkTheme, BuildContext context) {
    return ThemeData(
      scaffoldBackgroundColor: isDarkTheme ? Colors.black :Colors.grey.shade300,
      primarySwatch: Colors.purple,
      primaryColor: isDarkTheme ? Colors.black : Colors.grey.shade300,
      accentColor: Colors.deepPurple,
      backgroundColor: isDarkTheme ? Colors.grey.shade700 : Colors.white,
      indicatorColor: isDarkTheme ? Color(0xff0E1D36) : Color(0xffCBDCF8),
      buttonColor: isDarkTheme ? Color(0xff3B3B3B) : Color(0xffF1F5FB),
      hintColor: isDarkTheme ? Colors.grey.shade300 : Colors.grey.shade800,
      highlightColor: isDarkTheme ? Color(0xff372901) : Color(0xffFCE192),
      hoverColor: isDarkTheme ? Color(0xff3A3A3B) : Color(0xff4285F4),
      focusColor: isDarkTheme ? Color(0xff0B2512) : Color(0xffA8DAB5),
      disabledColor: Colors.grey,
      textSelectionColor: isDarkTheme ? Colors.white : Colors.black,
      cardColor: isDarkTheme ? Color(0xFF151515) : Colors.white,
      canvasColor: isDarkTheme ? Colors.black : Colors.grey[50],
      brightness: isDarkTheme ? Brightness.dark : Brightness.light,
      buttonTheme: Theme.of(context).buttonTheme.copyWith(
          colorScheme: isDarkTheme ? ColorScheme.dark() : ColorScheme.light()),
      appBarTheme: AppBarTheme(
        elevation: 0.0,
      ),
    );
  }
}*/
