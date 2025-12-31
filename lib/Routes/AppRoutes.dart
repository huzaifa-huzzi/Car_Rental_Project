import 'package:car_rental_project/Car%20Inventory/AddingCar/AddingCar.dart';
import 'package:car_rental_project/Car%20Inventory/Car%20Details/CarDetails.dart';
import 'package:car_rental_project/Car%20Inventory/Car%20Directory/CarInventoryMainScreen.dart';
import 'package:car_rental_project/Car%20Inventory/Car%20Directory/GridViewScreen/GridViewScreen.dart';
import 'package:car_rental_project/Car%20Inventory/Car%20Directory/ListViewScreen/ListViewScreen.dart';
import 'package:car_rental_project/Car%20Inventory/Car%20Directory/TableViewScreen/TableViewScreen.dart';
import 'package:car_rental_project/Car%20Inventory/Editing%20Car/EditingCar.dart';
import 'package:car_rental_project/Customers/AddCustimers/AddCustomers.dart';
import 'package:car_rental_project/Customers/CustomersDetails/CustomersDetails.dart';
import 'package:car_rental_project/Customers/EditCustomers/EditCustomerScreen.dart';
import 'package:car_rental_project/Customers/TableViewCustomerScreen/TableViewScreen.dart';
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
              } else if (title == "Customers") {
                context.go('/customers');
              }
            },
            child: child,
          );
        },
        routes: [
          // Car Inventory Main
          GoRoute(path: '/carInventory', builder: (context, state) => CarInventoryMainScreen()),
          GoRoute(path: '/carInventory/TableView', builder: (context, state) => const TableViewScreen()),
          GoRoute(path: '/carInventory/ListView', builder: (context, state) => const ListViewScreen()),
          GoRoute(path: '/carInventory/GridView', builder: (context, state) => const GridViewScreen()),

          // --- NEW CUSTOMERS SECTION ---
          GoRoute(
            path: '/customers',
            builder: (context, state) =>  TableViewCustomerScreen(),
          ),
        ],
      ),

      // NO SIDEBAR / SPECIAL APPBAR ROUTES (CarInventory)
      GoRoute(path: '/cardetails', builder: (context, state) => _wrapSidebar(state, CarDetailsScreen())),
      GoRoute(path: '/addNewCar', builder: (context, state) => _wrapSidebar(state, AddingCarScreen())),
      GoRoute(path: '/editCar', builder: (context, state) => _wrapSidebar(state, EditCarScreen())),

      // No Sidebar / Special AppBar Routes (Customers)
      GoRoute(
        path: '/customerDetails',
        builder: (context, state) => _wrapSidebar(state, const CustomerDetails()),
      ),
      GoRoute(
        path: '/addNewCustomer',
        builder: (context, state) => _wrapSidebar(state, const AddCustomerScreen()),
      ),
      GoRoute(
        path: '/editCustomers',
        builder: (context, state) => _wrapSidebar(state, const EditCustomerScreen()),
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