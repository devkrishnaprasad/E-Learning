import 'package:e_learn/utils/theme/colors.dart';
import 'package:flutter/material.dart';

InputDecorationTheme textFiledDecoration = InputDecorationTheme(
  filled: true,
  fillColor: Colors.white,
  border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(15.0),
    borderSide: BorderSide.none,
  ),
);

ElevatedButtonThemeData lightElevatedButtonTheme = ElevatedButtonThemeData(
  style: ElevatedButton.styleFrom(
    elevation: 100.0,
    foregroundColor: Colors.white,
    backgroundColor: primaryColor,
    disabledBackgroundColor: Colors.grey,
    disabledForegroundColor: Colors.grey,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(50.0),
    ),
  ),
);

CheckboxThemeData checkboxThemeData = CheckboxThemeData(
  checkColor: WidgetStateProperty.resolveWith<Color>((Set<WidgetState> states) {
    if (states.contains(WidgetState.disabled)) {
      return Colors.grey;
    }
    return overlayColor;
  }),
  fillColor: WidgetStateProperty.resolveWith<Color>((Set<WidgetState> states) {
    if (states.contains(WidgetState.disabled)) {
      return checkboxBackgroundColor;
    }
    if (states.contains(WidgetState.selected)) {
      return componentsColor;
    }
    return Colors.white;
  }),
  side: const BorderSide(
    color: secondaryColor, // Border color
    width: 2.0, // Border width
  ),
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(5.0),
  ),
);
