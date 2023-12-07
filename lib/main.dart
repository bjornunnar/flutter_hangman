import 'package:flutter/material.dart';
import 'package:hangman/widgets/hangman.dart';

void main() {
  runApp(const MaterialApp(
    themeMode: ThemeMode.dark,
    // theme: lightTheme,
    // darkTheme: darkTheme,
    home: Hangman(),
  ));
}

var kColorScheme =
    ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 37, 62, 175));
var kDarkColorScheme = ColorScheme.fromSeed(
    seedColor: const Color.fromARGB(255, 23, 38, 105),
    brightness: Brightness.dark);

ThemeData lightTheme = ThemeData().copyWith(
  brightness: Brightness.light,
  useMaterial3: true,
  colorScheme: kColorScheme,
  elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
    backgroundColor: kColorScheme.primaryContainer,
  )),
);

ThemeData darkTheme = ThemeData.dark().copyWith(
  brightness: Brightness.dark,
  useMaterial3: true,
  colorScheme: kDarkColorScheme,
  elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
    backgroundColor: kDarkColorScheme.primaryContainer,
    foregroundColor: kDarkColorScheme.onPrimaryContainer,
  )),
);

