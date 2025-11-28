import 'package:flutter/material.dart';

class AppTextSizes {
  // Mobile = 600px
  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < 600;

  // Tablet = 600px & < 1024px
  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width >= 600 &&
          MediaQuery.of(context).size.width < 1024;

  // Web/Desktop = 1024px
  static bool isWeb(BuildContext context) =>
      MediaQuery.of(context).size.width >= 1024;

  static double size(BuildContext context, double mobile, double tablet, double web) {
    if (isWeb(context)) return web;
    if (isTablet(context)) return tablet;
    return mobile;
  }
}
