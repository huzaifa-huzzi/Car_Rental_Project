import 'package:car_rental_project/Car%20Inventory/Car%20Directory/CarInventoryMainScreen.dart';
import 'package:car_rental_project/Car%20Inventory/Car%20Directory/GridViewScreen/GridViewScreen.dart';
import 'package:car_rental_project/Car%20Inventory/Car%20Directory/ListViewScreen/ListViewScreen.dart';
import 'package:car_rental_project/Car%20Inventory/Car%20Directory/TableViewScreen/TableViewScreen.dart';
import 'package:car_rental_project/Resources/Theme.dart';
import 'package:car_rental_project/SideScreen/SidebarScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:go_router/go_router.dart';

void main() {
  setUrlStrategy(PathUrlStrategy());
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String selected = "Car Inventory";

  @override
  Widget build(BuildContext context) {
    final router = GoRouter(
      initialLocation: '/carInventory',
      routes: [
        ShellRoute(
          builder: (context, state, child) {
            return SidebarScreen(
              onTap: (title) {
                switch (title) {
                  case "Car Inventory":
                    GoRouter.of(context).go('/carInventory');
                    break;
                // Add other cases for other screens
                }
              },
              child: child,
            );
          },
          routes: [
            GoRoute(
              path: '/TableView',
              builder: (context, state) => const TableViewScreen(),
            ),GoRoute(
              path: '/ListView',
              builder: (context, state) => const ListViewScreen(),
            ),GoRoute(
              path: '/GridView',
              builder: (context, state) => const GridViewScreen(),
            ),
            GoRoute(
              path: '/carInventory',
              builder: (context, state) =>  CarInventoryMainScreen(),
            ),
          ],
        ),
      ],
    );

    return GetMaterialApp.router(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.light,
      theme: TAppTheme.lightTheme(context),
      darkTheme: ThemeData(),
      routerDelegate: router.routerDelegate,
      routeInformationParser: router.routeInformationParser,
      routeInformationProvider: router.routeInformationProvider,
    );
  }
}
