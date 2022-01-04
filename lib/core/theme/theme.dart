import 'package:flutter/material.dart';

/// Темная тема приложения
ThemeData darkTheme(context) {
  return ThemeData(
    fontFamily: 'GoogleSansRegular',
    primarySwatch: Colors.blue,
    primaryColor: Colors.black,
    errorColor: _errorColor,
    accentColor: Colors.cyan,
    disabledColor: Colors.grey,
    cardColor: Color(0xff1f2124),
    canvasColor: Colors.black,
    brightness: Brightness.dark,
    buttonTheme: Theme.of(context)
        .buttonTheme
        .copyWith(colorScheme: ColorScheme.dark(), buttonColor: Colors.blue, splashColor: Colors.black),
    appBarTheme: const AppBarTheme(
      elevation: 0.0,
    ),
  );
}

/// Светлая тема приложения
ThemeData lightTheme(context) {
  return ThemeData(
      fontFamily: 'Roboto',
      primarySwatch: Colors.blue,
      primaryColor: _mainBlue,
      accentColor: Colors.blue,
      disabledColor: Colors.grey,
      cardColor: Colors.white,
      canvasColor: Colors.white,
      cursorColor: _darkGrey,
      brightness: Brightness.light,
      buttonTheme: Theme.of(context).buttonTheme.copyWith(
          colorScheme: const ColorScheme.light(),
          buttonColor: _mainBlue,
          textTheme: ButtonTextTheme.primary,
          splashColor: Colors.white),
      elevatedButtonTheme: const ElevatedButtonThemeData(style: ButtonStyle(animationDuration: Duration(seconds: 1))),
      appBarTheme: const AppBarTheme(
        elevation: 4.0,
      ),
      textTheme: Theme.of(context).textTheme.copyWith(
          bodyText1: const TextStyle(color: darkText, fontFamily: "Roboto", fontSize: 16),
          headline6: const TextStyle(color: Colors.white, fontFamily: "Roboto", fontSize: 24)));
}

const Color _mainBlue = Color(0xFF1664A7);
const Color _deepBlue = Color(0xFF005987);
const Color _mainBlue60 = Color(0x9626628C);
const Color _white = Color(0xFFFFFFFF);
const Color _backgroundWhite = Color(0xFFE9F4F8);
const Color _backgroundBlue = Color(0xFFDBECF3);
const Color _errorColor = Color(0xFFC75A4C);

const Color _secondaryBackground = Color(0xFF6EA3BD);

const Color darkText = Color(0xFF3D4250);
const Color _darkGrey = Color(0xFF6F7485);
const Color _lightGrey = Color(0xFFBCDAE8);
const Color _lighterGrey = Color(0xFFC5C5C7);

const TextStyle main17blackText = TextStyle(
  color: Colors.black,
  fontSize: 17.0,
);
const TextStyle _timeStyle = TextStyle(
  color: _darkGrey,
  fontSize: 14.0,
);

const TextStyle _mainLetterDescriptionStyle = TextStyle(
  color: darkText,
  fontSize: 14.0,
);
const int _tabletSign = 600;
const double _iconSize = 20.5;
const _animationDuration = Duration(milliseconds: 250);

Color _darken(Color color, [double amount = .1]) {
  assert(amount >= 0 && amount <= 1);

  final hsl = HSLColor.fromColor(color);
  final hslDark = hsl.withLightness((hsl.lightness - amount).clamp(0.0, 1.0));

  return hslDark.toColor();
}

Color _lighten(Color color, [double amount = .1]) {
  assert(amount >= 0 && amount <= 1);

  final hsl = HSLColor.fromColor(color);
  final hslLight = hsl.withLightness((hsl.lightness + amount).clamp(0.0, 1.0));

  return hslLight.toColor();
}

Color _stringColorToHex(String nameOfColor) {
  switch (nameOfColor) {
    case 'blue':
      return Colors.blue;
      break;
    case 'red':
      return Colors.red;
      break;
    case 'purple':
      return Colors.purple;
      break;
    case 'yellow':
      return Colors.yellow;
      break;
    case 'orange':
      return Colors.orange;
      break;
    case 'grey':
      return Colors.grey;
      break;
    default:
      return Colors.black;
  }
}
