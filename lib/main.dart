import 'package:e_learn/pages/main/navigation_page.dart';
import 'package:e_learn/pages/signin_sigin_up/signin_page.dart';
import 'package:e_learn/services/helper/controller/helper_controller.dart';
import 'package:e_learn/utils/app_theme.dart';
import 'package:e_learn/utils/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

HelperController helperController = Get.put(HelperController());
RxBool isLoggedIn = false.obs;
void main() async {
  isLoggedIn.value = await helperController.initialSetup();
  runApp(const MyApp());
}

// ignore: must_be_immutable
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
      home: Obx(() {
        return isLoggedIn.value ? NavigationPage() : SignInPage();
      }),
    );
  }
}
