import 'package:car_rental_project/Portal/Routes/AppRoutes.dart';
import 'package:car_rental_project/Portal/Vendor/SideScreen/SidebarBinding.dart';
import 'package:car_rental_project/Resources/Theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' show FlutterQuillLocalizations;
import 'package:get/get.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:url_strategy/url_strategy.dart';

void main() {
  setPathUrlStrategy();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp.router(

      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        FlutterQuillLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],

      supportedLocales: const [
        Locale('en'),
      ],

      /// ROUTER
      initialBinding: SidebarBinding(),

      themeMode: ThemeMode.light,
      theme: TAppTheme.lightTheme(context),
      darkTheme: ThemeData(),
      routerDelegate: AppNavigation.router.routerDelegate,
      routeInformationParser: AppNavigation.router.routeInformationParser,
      routeInformationProvider: AppNavigation.router.routeInformationProvider,
    );
  }
}