import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:p_lyric/themes.dart';
import 'package:p_lyric/views/home_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print(Get.isDarkMode);
    return GetMaterialApp(
      theme: ThemeData(
        brightness: Brightness.light,
        colorScheme: lightColorScheme,
        textTheme: textTheme,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        colorScheme: darkColorScheme,
        textTheme: textTheme,
      ),
      home: HomePage(),
    );
  }
}
