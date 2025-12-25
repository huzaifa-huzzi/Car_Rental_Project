import 'package:car_rental_project/Car%20Inventory/AddingCar/AddingCar.dart';
import 'package:car_rental_project/Car%20Inventory/Car%20Details/CarDetails.dart';
import 'package:car_rental_project/Car%20Inventory/Car%20Directory/CarInventoryMainScreen.dart';
import 'package:car_rental_project/Car%20Inventory/Car%20Directory/GridViewScreen/GridViewScreen.dart';
import 'package:car_rental_project/Car%20Inventory/Car%20Directory/ListViewScreen/ListViewScreen.dart';
import 'package:car_rental_project/Car%20Inventory/Car%20Directory/TableViewScreen/TableViewScreen.dart';
import 'package:car_rental_project/Car%20Inventory/Editing%20Car/EditingCar.dart';
import 'package:car_rental_project/SideScreen/SidebarScreen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppNavigation {
  static final router = GoRouter(
    initialLocation: '/carInventory',
    routes: [
      /// SHELL ROUTE (Sidebar Layout)
      ShellRoute(
        builder: (context, state, child) {
          return SidebarScreen(
            onTap: (title) {
              if (title == "Car Inventory") {
                context.go('/carInventory');
              }
            },
            child: child,
          );
        },
        routes: [
          GoRoute(path: '/carInventory', builder: (context, state) => CarInventoryMainScreen()),
          GoRoute(path: '/carInventory/TableView', builder: (context, state) => const TableViewScreen()),
          GoRoute(path: '/carInventory/ListView', builder: (context, state) => const ListViewScreen()),
          GoRoute(path: '/carInventory/GridView', builder: (context, state) => const GridViewScreen()),
        ],
      ),

      /// NO SIDEBAR / SPECIAL APPBAR ROUTES
      GoRoute(
        path: '/cardetails',
        builder: (context, state) => _wrapSidebar(state, CarDetailsScreen()),
      ),
      GoRoute(
        path: '/addNewCar',
        builder: (context, state) => _wrapSidebar(state, AddingCarScreen()),
      ),
      GoRoute(
        path: '/editCar',
        builder: (context, state) => _wrapSidebar(state, EditCarScreen()),
      ),
    ],
  );


  static Widget _wrapSidebar(GoRouterState state, Widget child) {
    final extras = state.extra as Map<String, dynamic>?;
    final hideMobile = extras?["hideMobileAppBar"] == true;
    return SidebarScreen.wrapWithSidebarIfNeeded(
      child: child,
      hideMobileAppBar: hideMobile,
    );
  }
}