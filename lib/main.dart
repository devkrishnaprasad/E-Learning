import 'package:e_learn/pages/main/navigation_page.dart';
import 'package:e_learn/utils/app_theme.dart';
import 'package:e_learn/utils/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        checkboxTheme: checkboxThemeData,
        elevatedButtonTheme: lightElevatedButtonTheme,
        scaffoldBackgroundColor: backgroundColor,
        inputDecorationTheme: textFiledDecoration,
        colorScheme: ColorScheme.fromSeed(seedColor: primaryColor),
        useMaterial3: true,
      ),
      home: NavigationPage(),
    );
  }
}
