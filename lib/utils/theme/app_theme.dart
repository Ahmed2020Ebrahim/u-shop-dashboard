import 'package:flutter/material.dart';
import 'package:ushop_web/utils/constants/colors.dart';
import 'package:ushop_web/utils/theme/custom_theme/check_box_theme.dart';
import 'package:ushop_web/utils/theme/custom_theme/appbar_theme.dart';
import 'package:ushop_web/utils/theme/custom_theme/bottom_sheet_theme.dart';
import 'package:ushop_web/utils/theme/custom_theme/chip_theme.dart';
import 'package:ushop_web/utils/theme/custom_theme/elevated_button_theme.dart';
import 'package:ushop_web/utils/theme/custom_theme/outlined_button_theme.dart';
import 'package:ushop_web/utils/theme/custom_theme/text_theme.dart';
import 'package:ushop_web/utils/theme/custom_theme/textfield_theme.dart';

class AppTheme {
  AppTheme._();

//! ---> Light App Theme
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    fontFamily: "Schyler",
    brightness: Brightness.light,
    primaryColor: AppColors.primary,
    scaffoldBackgroundColor: AppColors.softGrey,
    textTheme: AppTextTheme.lightTextTheme,
    elevatedButtonTheme: AppElevatedButtonTheme.lightElevatedButtonTheme,
    appBarTheme: UAppBarTheme.lightAppbarTheme,
    bottomSheetTheme: AppBottomSheetTheme.lightBottomSheetTheme,
    checkboxTheme: AppCheckBoxTheme.lightCheckBoxTheme,
    chipTheme: AppChipTheme.lightChipTheme,
    outlinedButtonTheme: AppOutLineButtonTheme.lightOutlineButtonTheme,
    inputDecorationTheme: AppTextFieldTheme.lightInputDecorationTheme,
  );

//! ---> Dark App Theme
  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    fontFamily: "Poppins",
    brightness: Brightness.dark,
    primaryColor: Colors.blue,
    scaffoldBackgroundColor: Colors.black,
    textTheme: AppTextTheme.darkTextTheme,
    elevatedButtonTheme: AppElevatedButtonTheme.darkElevatedButtonTheme,
    appBarTheme: UAppBarTheme.darkAppbarTheme,
    bottomSheetTheme: AppBottomSheetTheme.darkBottomSheetTheme,
    checkboxTheme: AppCheckBoxTheme.darkCheckBoxTheme,
    chipTheme: AppChipTheme.darkChipTheme,
    outlinedButtonTheme: AppOutLineButtonTheme.darkOutlineButtonTheme,
    inputDecorationTheme: AppTextFieldTheme.darkInputDecorationTheme,
  );
}
