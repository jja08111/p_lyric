import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:p_lyric/themes.dart';
import 'package:p_lyric/views/home_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cardShape = const RoundedRectangleBorder(
      borderRadius: const BorderRadius.all(
        const Radius.circular(12.0),
      ),
    );

    return GetMaterialApp(
      theme: ThemeData(
        brightness: Brightness.light,
        colorScheme: lightColorScheme,
        textTheme: textTheme,
        cardTheme: CardTheme(
          color: const Color(0xe6ffffff),
          shape: cardShape,
        ),
        primaryTextTheme: primaryTextTheme,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        colorScheme: darkColorScheme,
        textTheme: textTheme,
        cardTheme: CardTheme(
          color: const Color(0xe6121212),
          shape: cardShape,
        ),
        primaryTextTheme: primaryTextTheme,
      ),
      home: HomePage(),
    );
  }
}
