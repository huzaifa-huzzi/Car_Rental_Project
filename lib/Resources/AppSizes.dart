import 'package:flutter/material.dart';

class AppSizes {
  // Breakpoints
  static const double webBreakpoint = 1024;
  static const double tabletBreakpoint = 600;

  // Screen width helper
  static double screenWidth(BuildContext context) =>
      MediaQuery.of(context).size.width;

  static bool isWeb(BuildContext context) =>
      screenWidth(context) >= webBreakpoint;

  static bool isTablet(BuildContext context) =>
      screenWidth(context) >= tabletBreakpoint &&
          screenWidth(context) < webBreakpoint;

  static bool isMobile(BuildContext context) =>
      screenWidth(context) < tabletBreakpoint;

  // Button Sizes
  static double buttonHeight(BuildContext context) {
    if (isWeb(context)) return 60;
    if (isTablet(context)) return 50;
    return 45;
  }

  static double buttonWidth(BuildContext context) {
    if (isWeb(context)) return 220;
    if (isTablet(context)) return 180;
    return 150;
  }

  // Card / Container Heights
  static double cardHeight(BuildContext context) {
    if (isWeb(context)) return 200;
    if (isTablet(context)) return 180;
    return 150;
  }

  static double cardWidth(BuildContext context) {
    if (isWeb(context)) return 300;
    if (isTablet(context)) return 260;
    return 220;
  }

  // Padding / Margin
  static double padding(BuildContext context) {
    if (isWeb(context)) return 24;
    if (isTablet(context)) return 20;
    return 16;
  }

  static double horizontalPadding(BuildContext context) {
    if (isWeb(context)) return 32;
    if (isTablet(context)) return 24;
    return 16;
  }

  static double verticalPadding(BuildContext context) {
    if (isWeb(context)) return 24;
    if (isTablet(context)) return 20;
    return 16;
  }

  // Border Radius (for buttons/cards)
  static double borderRadius(BuildContext context) {
    if (isWeb(context)) return 12;
    if (isTablet(context)) return 10;
    return 8;
  }

}
