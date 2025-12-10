import 'package:car_rental_project/Car Inventory/AddingCar/AddingCar.dart';
import 'package:car_rental_project/Car Inventory/Car Details/CarDetails.dart';
import 'package:car_rental_project/Car Inventory/Car Directory/CarInventoryMainScreen.dart';
import 'package:car_rental_project/Car Inventory/Car Directory/GridViewScreen/GridViewScreen.dart';
import 'package:car_rental_project/Car Inventory/Car Directory/ListViewScreen/ListViewScreen.dart';
import 'package:car_rental_project/Car Inventory/Car Directory/TableViewScreen/TableViewScreen.dart';
import 'package:car_rental_project/Resources/Theme.dart';
import 'package:car_rental_project/SideScreen/SidebarScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:url_strategy/url_strategy.dart';

void main() {
  setPathUrlStrategy();
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

        /// SHELL ROUTE (Sidebar Layout)
        ShellRoute(
          builder: (context, state, child) {
            return SidebarScreen(
              onTap: (title) {
                switch (title) {
                  case "Car Inventory":
                    GoRouter.of(context).go('/carInventory');
                    break;
                }
              },
              child: child,
            );
          },

          routes: [
            GoRoute(
              path: '/carInventory',
              builder: (context, state) => CarInventoryMainScreen(),
            ),
            GoRoute(
              path: '/carInventory/TableView',
              builder: (context, state) => const TableViewScreen(),
            ),
            GoRoute(
              path: '/carInventory/ListView',
              builder: (context, state) => const ListViewScreen(),
            ),
            GoRoute(
              path: '/carInventory/GridView',
              builder: (context, state) => const GridViewScreen(),
            ),
            GoRoute(
              path: '/addNewCar',
              builder: (context, state) => AddingCarScreen(),
            ),
          ],
        ),

        /// --------------------------------
        GoRoute(
          path: '/cardetails',
          builder: (context, state) {
            final extras = state.extra as Map<String, dynamic>?;
            final hideMobile = extras?["hideMobileAppBar"] == true;

            return SidebarScreen.wrapWithSidebarIfNeeded(
              child: CarDetailsScreen(),
              hideMobileAppBar: hideMobile,
            );
          },
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
