import 'package:flutter/material.dart';
import 'package:hangman/widgets/hangman.dart';
import 'package:flutter/services.dart';

void main() {

  // locking the app in portrait mode
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then((fn){

    runApp(MaterialApp(
      // themeMode: ThemeMode.dark,
      theme: hangmanLight,
      darkTheme: hangmanDark,
      home: const Hangman(),
    ));

  });
}

var kColorScheme =
    ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 37, 62, 175));
var kDarkColorScheme = ColorScheme.fromSeed(
    seedColor: const Color.fromARGB(255, 23, 38, 105),
    brightness: Brightness.dark);

ThemeData hangmanLight = ThemeData().copyWith(
  brightness: Brightness.light,
  useMaterial3: true,
  colorScheme: kColorScheme,
  elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
    backgroundColor: kColorScheme.primaryContainer,
  )),
);

ThemeData hangmanDark = ThemeData.dark().copyWith(
  brightness: Brightness.dark,
  useMaterial3: true,
  colorScheme: kDarkColorScheme,
  elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
    backgroundColor: kDarkColorScheme.primaryContainer,
    foregroundColor: kDarkColorScheme.onPrimaryContainer,
  )),
);

