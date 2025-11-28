import 'package:flutter/material.dart';

class AppIconSizes {
  //  WEB SIZES
  static double webLarge = 20;
  static double webMedium = 18;
  static double webSmall = 14;

  //  TABLET SIZES ( will be provide later)
  static double tabletLarge = 18;
  static double tabletMedium = 16;
  static double tabletSmall = 12;

  //  MOBILE SIZES ( will be provide later)
  static double mobileLarge = 16;
  static double mobileMedium = 12;
  static double mobileSmall = 10;

  static bool get isWeb {
    double width = WidgetsBinding.instance.platformDispatcher.views.first.physicalSize.width /
        WidgetsBinding.instance.platformDispatcher.views.first.devicePixelRatio;
    return width >= 1024;
  }

  static bool get isTablet {
    double width = WidgetsBinding.instance.platformDispatcher.views.first.physicalSize.width /
        WidgetsBinding.instance.platformDispatcher.views.first.devicePixelRatio;
    return width >= 600 && width < 1024;
  }

  //  AUTO return large size
  static double get large {
    if (isWeb) return webLarge;
    if (isTablet) return tabletLarge;
    return mobileLarge;
  }

  //  AUTO return large size
  static double get medium {
    if (isWeb) return webMedium;
    if (isTablet) return tabletSmall;
    return mobileSmall;
  }


  //  AUTO return small size
  static double get small {
    if (isWeb) return webSmall;
    if (isTablet) return tabletSmall;
    return mobileSmall;
  }
}
