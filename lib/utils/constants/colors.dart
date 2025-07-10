import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

//! --- App Basic Colors
  static const Color primary = Color(0xFF4b68ff);
  static const Color secondary = Color(0xFFFFE24b);
  static const Color accent = Color(0xFFb0c7ff);

//! --- Text Colors
  static const Color textPrimary = Color(0xFF333333);
  static const Color textSecondary = Color(0xFF6c7570);
  static const Color textWhite = Colors.white;

//! --- Background Colors
  static const Color bgLight = Color(0xFFf6f6f6);
  static const Color bgDark = Color(0xFF272727);
  static const Color bgPrimary = Color(0xFFf3f5ff);

//! --- Containers Background Colors
  static const Color lightContainer = Color(0xFFf6f6f6);
  static Color darkContainer = AppColors.white.withValues(alpha: 0.8);

//! --- Buttons Colors
  static const Color buttonPrimary = Color(0xFF4b68ff);
  static const Color buttonSecondary = Color(0xFF6c7570);
  static const Color buttonDisabled = Color(0xFFc4c4c4);

//! --- Border Colors
  static const Color borderPrimary = Color(0xFFd9d9d9);
  static const Color borderSecondary = Color(0xFFe6e6e6);

//! ---> Error and validation colors
  static const Color error = Color(0xFFd32f2f);
  static const Color success = Color(0xFF388e3c);
  static const Color warning = Color(0xFFf57c00);
  static const Color info = Color(0xFF1976d2);

//! ---> shades
  static const Color black = Color(0xFF232323);
  static const Color darkerGrey = Color(0xFF4f4f4f);
  static const Color darkGrey = Color(0xFF939393);
  static const Color grey = Color(0xFFe0e0e0);
  static const Color softGrey = Color(0xFFF4F4F4);
  static const Color lightGrey = Color(0xFFF9F9F9);
  static const Color white = Color(0xFFFFFFFF);

//! --->order status colors
  static const Color pendingOrderColor = Color(0xFF1976d2);
  static const Color processingOrderColor = Color(0xFFf57c00);
  static const Color shippedOrderColor = Color.fromARGB(255, 188, 27, 197);
  static const Color deliveredOrderColor = Color(0xFF388e3c);
  static const Color cancelledOrderColor = Color(0xFFd32f2f);

//! ---> attribute colors
  static const List<Color> attributeColors = [
    black,
    darkerGrey,
    darkGrey,
    primary,
    error,
  ];
}
