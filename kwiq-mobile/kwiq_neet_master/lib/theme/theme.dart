import 'package:flutter/material.dart';

class Colors {
  const Colors();

  static const Color white = const Color(0xFFFFFFFF);
  static const Color white70 = const Color(0xFFE1E8EF);
  static const Color blue = const Color(0xFF00FFFF);
  static const Color black = const Color(0xFF000000);
  static const Color grey = const Color(0xFFA9A9A9);
  static const Color purple = const Color(0xFF6200EA);
  static const Color yellow = const Color(0xFFFFFF00);

  static const Color appBarTitle = const Color(0xFFFFFFFF);
  static const Color appBarIconColor = const Color(0xFFFFFFFF);
  static const Color appBarDetailBackground = const Color(0x00FFFFFF);
  static const Color appBarGradientStart = const Color(0xFF0675BA);
  static const Color appBarGradientEnd = const Color(0xFF1DB8E6);

  static const Color kwiqWarnGradientStart = const Color(0xFFFA2328);
  static const Color kwiqWarnGradientEnd = const Color(0xFFEAEA32);

  static const Color kwiqCardGradientStart = const Color(0xFFF89C1D);
  static const Color kwiqCardGradientEnd = const Color(0xFFF6E75A);

  //static const Color kwiqCard = const Color(0xFF434273);
  static const Color kwiqCard = const Color(0xFF1DB8E6);
  //static const Color kwiqListBackground = const Color(0xFF3E3963);
  static const Color kwiqPageBackground = const Color(0xFF0675BA);
  static const Color kwiqSubPageBackground = const Color(0xFFEAEA32);

  static const Color kwiqCardTitle = const Color(0xFF00FFC4);
  static const Color kwiqTitle = const Color(0xFF021EAA);
  static const Color kwiqSubTitle = const Color(0xFF141414);
  static const Color kwiqContent = const Color(0xFF083D84);
  //static const Color kwiqContent = const Color(0xFF009152);

}

class Dimens {
  const Dimens();

  static const kwiqLogoWidth = 50.0;
  static const kwiqLogoHeight = 50.0;

  static const kwiqCarWidth = 40.0;
  static const kwiqCardHeight = 40.0;

  static const kwiqWidth = 70.0;
  static const kwiqHeight = 70.0;
}

class TextStyles {
  //const TextStyles();
  TextStyles();

  static const TextStyle appBarTitle = const TextStyle(
      color: Colors.appBarTitle,
      fontFamily: 'Poppins',
      fontWeight: FontWeight.w700,
      fontSize: 21.0);

  static const TextStyle kwiqCardTitle = const TextStyle(
      color: Colors.kwiqCardTitle,
      fontFamily: 'Poppins',
      fontWeight: FontWeight.w600,
      fontSize: 21.0);

  static const TextStyle kwiqItemTitle = const TextStyle(
      color: Colors.kwiqTitle,
      fontFamily: 'Poppins',
      fontWeight: FontWeight.w600,
      fontSize: 21.0);

  static const TextStyle kwiqSubTitle = const TextStyle(
      color: Colors.kwiqSubTitle,
      fontFamily: 'Poppins',
      fontWeight: FontWeight.w300,
      fontSize: 18.0);

  static const TextStyle kwiqContent = const TextStyle(
      color: Colors.kwiqContent,
      fontFamily: 'Poppins',
      fontWeight: FontWeight.w300,
      fontSize: 15.0);

  static const TextStyle kwiqUser = const TextStyle(
      color: Colors.kwiqContent,
      fontFamily: 'Poppins',
      fontWeight: FontWeight.bold,
      fontSize: 16.0);

  static const TextStyle inputText = const TextStyle(
      color: Colors.kwiqContent,
      fontFamily: 'Poppins',
      fontWeight: FontWeight.w300,
      fontSize: 18.0);

  static const TextStyle link = const TextStyle(
      color: Colors.kwiqContent,
      fontFamily: 'Poppins',
      fontWeight: FontWeight.bold,
      fontSize: 18.0);

  static const TextStyle button = const TextStyle(
      color: Colors.white,
      fontFamily: 'Poppins',
      fontWeight: FontWeight.bold,
      fontSize: 18.0);

  static const TextStyle logout = const TextStyle(
      color: Colors.kwiqContent,
      fontFamily: 'Poppins',
      fontWeight: FontWeight.bold,
      fontSize: 18.0);
}

final ThemeData theme = new ThemeData(
    //Colors
    brightness: Brightness.light,
    primaryColor: Colors.kwiqCard,
    //primarySwatch: Colors.white,
    accentColor: Colors.kwiqPageBackground,
    //Font
    fontFamily: 'Montserrat',
    //Text Theme
    textTheme: TextTheme(
      headline: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
      title: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
      body1: TextStyle(fontSize: 15.0),
    ));

// final TextStyle titleStyle = TextStyle(fontSize: 18);

// final TextStyle subTitleStyle = TextStyle(fontSize: 16);

// final TextStyle bodyStyle = TextStyle(fontSize: 15, color: Colors.black);
