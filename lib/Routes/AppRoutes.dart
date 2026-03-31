import 'package:car_rental_project/Authentication/ForgotPassword/ForgotPassword.dart';
import 'package:car_rental_project/Authentication/Login/Login.dart';
import 'package:car_rental_project/Authentication/NewPassword/NewPassword.dart';
import 'package:car_rental_project/Authentication/RecoveryShowScreen/RecoveryShowScreen.dart';
import 'package:car_rental_project/Authentication/RecoveryShowScreen/RecoveryShowScreenTwo.dart';
import 'package:car_rental_project/Authentication/Register/RegisterScreen.dart';
import 'package:car_rental_project/Authentication/TwoStepVerificationOne/TwoStepVerificationOne.dart';
import 'package:car_rental_project/Authentication/TwoStepVerificationTwo/TwoStepVerificationTwo.dart';
import 'package:car_rental_project/Portal/Vendor/Car%20Inventory/AddingCar/AddingCar.dart';
import 'package:car_rental_project/Portal/Vendor/Car%20Inventory/Car%20Details/CarDetails.dart';
import 'package:car_rental_project/Portal/Vendor/Car%20Inventory/Car%20Directory/CarInventoryMainScreen.dart';
import 'package:car_rental_project/Portal/Vendor/Car%20Inventory/Car%20Directory/GridViewScreen/GridViewScreen.dart';
import 'package:car_rental_project/Portal/Vendor/Car%20Inventory/Car%20Directory/ListViewScreen/ListViewScreen.dart';
import 'package:car_rental_project/Portal/Vendor/Car%20Inventory/Car%20Directory/TableViewScreen/TableViewScreen.dart';
import 'package:car_rental_project/Portal/Vendor/Car%20Inventory/Editing%20Car/EditingCar.dart';
import 'package:car_rental_project/Portal/Vendor/Customers/AddCustomers/AddCustomers.dart';
import 'package:car_rental_project/Portal/Vendor/Customers/CustomersDetails/CustomersDetails.dart';
import 'package:car_rental_project/Portal/Vendor/Customers/EditCustomers/EditCustomerScreen.dart';
import 'package:car_rental_project/Portal/Vendor/Customers/TableViewCustomerScreen/TableViewScreen.dart';
import 'package:car_rental_project/Portal/Vendor/Dashboard/DashboardScreen.dart';
import 'package:car_rental_project/Portal/Vendor/DroppOffCar/AddDropOff/AddDropOffScreen.dart';
import 'package:car_rental_project/Portal/Vendor/DroppOffCar/AddDropOff/Widget/StepOneDropOffWidget.dart';
import 'package:car_rental_project/Portal/Vendor/DroppOffCar/AddDropOff/Widget/StepThreeDropOffWidget.dart';
import 'package:car_rental_project/Portal/Vendor/DroppOffCar/AddDropOff/Widget/StepTwoDropOffWidget.dart';
import 'package:car_rental_project/Portal/Vendor/DroppOffCar/DropOffDetails/DropOffDetails.dart';
import 'package:car_rental_project/Portal/Vendor/DroppOffCar/Subtabs/DropOffT&C/AddDropOffT&C.dart';
import 'package:car_rental_project/Portal/Vendor/DroppOffCar/Subtabs/DropOffT&C/DropOffT&C.dart';
import 'package:car_rental_project/Portal/Vendor/DroppOffCar/Subtabs/DropOffT&C/DropOffT&CDescription.dart' show DropOffTandCDescription;
import 'package:car_rental_project/Portal/Vendor/DroppOffCar/TableViewDropoff/TableViewDropoffScreen.dart';
import 'package:car_rental_project/Portal/Vendor/Payment/Add%20Payment/AddPaymentScreen.dart';
import 'package:car_rental_project/Portal/Vendor/Payment/payment.dart';
import 'package:car_rental_project/Portal/Vendor/PickupCar/AddPickUp/AddPickup.dart';
import 'package:car_rental_project/Portal/Vendor/PickupCar/AddPickUp/Widget/StepThreeWidget.dart';
import 'package:car_rental_project/Portal/Vendor/PickupCar/AddPickUp/Widget/StepTwoWidgets.dart';
import 'package:car_rental_project/Portal/Vendor/PickupCar/EditPicUp/EditPickUpScreen.dart';
import 'package:car_rental_project/Portal/Vendor/PickupCar/PickUpDetailScreen/PickUpDetailScreen.dart';
import 'package:car_rental_project/Portal/Vendor/PickupCar/Subtabs/Pickup%20T&C/AddPickupT&C.dart';
import 'package:car_rental_project/Portal/Vendor/PickupCar/Subtabs/Pickup%20T&C/PickupT&C.dart';
import 'package:car_rental_project/Portal/Vendor/PickupCar/Subtabs/Pickup%20T&C/PickupT&CDescription.dart';
import 'package:car_rental_project/Portal/Vendor/PickupCar/TableViewPicukUpScreen/TableViewPickUpScreen.dart';
import 'package:car_rental_project/Portal/Vendor/SideScreen/SidebarScreen.dart';
import 'package:car_rental_project/Portal/Vendor/Staff/AddStaff/AddStaffScreen.dart';
import 'package:car_rental_project/Portal/Vendor/Staff/EditStaff/EditStaffScreen.dart';
import 'package:car_rental_project/Portal/Vendor/Staff/TableViewScreen/StaffScreen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppNavigation {

  static final router = GoRouter(
    initialLocation: '/login',
    routes: [
       // Login Screens Routes
      GoRoute(path: '/login', builder: (context, state) => const LoginScreen()),
      GoRoute(path: '/signUp', builder: (context, state) => const RegisterScreen()),
      GoRoute(path: '/forgotPassword', builder: (context, state) => const ForgotPassword()),
      GoRoute(path: '/newPassword', builder: (context, state) => const NewPassword()),
      GoRoute(path: '/twoStepVerificationOne', builder: (context, state) => const TwoStepVerificationOne()),
      GoRoute(path: '/twoStepVerificationTwo', builder: (context, state) => const TwoStepVerificationTwo()),
      GoRoute(path: '/authSuccess', builder: (context, state) => const RecoveryShowScreenOne()),
      GoRoute(path: '/authSuccess2', builder: (context, state) => RecoveryShowScreenTwo()),
      /// SHELL ROUTE (Sidebar Layout)
      ShellRoute(
        builder: (context, state, child) {
          final extras = state.extra as Map<String, dynamic>?;
          bool hideMobile = extras?["hideMobileAppBar"] == true;
          final String path = state.uri.toString().toLowerCase();

          if (path.contains('t&c') ||
              path.contains('add') ||
              path.contains('edit') ||
              path.contains('detail')) {
            hideMobile = true;
          } else {
            hideMobile = false;
          }

          return SidebarScreen(
            onTap: (route) {
              if (route.startsWith('/')) {
                context.go(route);
              } else {
                if (route == "Dashboard") {
                  context.go('/dashboard');
                } else if (route == "Car Inventory") context.go('/carInventory');
                else if (route == "Customers") context.go('/customers');
                else if (route == "Pickup Car") context.go('/pickupcar');
                else if (route == "Pickup T&C") context.go('/pickupT&C');
                else if (route == "Dropoff Car") context.go('/dropoffCar');
                else if (route == "Staff") context.go('/staff');
                else if (route == "Payment") context.go('/Payment');
              }
            },
            hideMobileAppBar: hideMobile,
            child: child,
          );
        },
        routes: [
          GoRoute(
            path: '/dashboard',
            builder: (context, state) => const DashboardScreen(),
          ),

          // Car Inventory Screen
          GoRoute(path: '/carInventory', builder: (context, state) => CarInventoryMainScreen()),
          GoRoute(path: '/carInventory/TableView', builder: (context, state) => const TableViewScreen()),
          GoRoute(path: '/carInventory/ListView', builder: (context, state) => const ListViewScreen()),
          GoRoute(path: '/carInventory/GridView', builder: (context, state) => const GridViewScreen()),

          //  Customers Screen
          GoRoute(
            path: '/customers',
            builder: (context, state) =>  TableViewCustomerScreen(),
          ),
          // Pickup Car Screen
          GoRoute(
            path: '/pickupcar',
            builder: (context, state) =>  TableViewPickUpScreen(),
          ),
          // Pickup T&C
          GoRoute(path: '/pickupT&C', builder: (context, state) => const PickupTandC()),
          GoRoute(path: '/pickupT&Cdescription', builder: (context, state) =>  PickupTandCDescription()),
          GoRoute(path: '/AddpickupT&C', builder: (context, state) =>  AddPickupTandC()),
          // DropOff
          GoRoute(
            path: '/dropoffCar',
            builder: (context, state) => TableViewDropOffScreen(),
          ),
          GoRoute(path: '/dropOffT&C', builder: (context, state) => const DropOffTandC()),
          GoRoute(path: '/dropOffT&Cdescription', builder: (context, state) =>  DropOffTandCDescription()),
          GoRoute(path: '/AdddropOffT&C', builder: (context, state) => const AddDropOffTandC()),
           // Payment
          GoRoute(path: '/Payment', builder: (context, state) =>  PaymentScreen()),
          // staff
          GoRoute(
            path: '/staff',
            builder: (context, state) =>  TableViewOfStaffScreen(),
          ),
        ],
      ),

      // NO SIDEBAR / SPECIAL APPBAR ROUTES (CarInventory)
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

      // No Sidebar / Special AppBar Routes (Customers)
      GoRoute(
        path: '/customerDetails',
        builder: (context, state) => _wrapSidebar(state,  CustomerDetails()),
      ),
      GoRoute(
        path: '/addNewCustomer',
        builder: (context, state) => _wrapSidebar(state, const AddCustomerScreen()),
      ),
      GoRoute(
        path: '/editCustomers',
        builder: (context, state) => _wrapSidebar(state,  EditCustomerScreen()),
      ),

      // No Sidebar / Special AppBar Routes (Pickup Screen)
      GoRoute(
        path: '/pickupDetail',
        builder: (context, state) => _wrapSidebar(state,  PickUpDetailScreen()),
      ),
      GoRoute(
        path: '/addpickup',
        builder: (context, state) => _wrapSidebar(state, const AddPickup()),
      ),
      GoRoute(
        path: '/stepTwoWidgetScreen',
        builder: (context, state) => _wrapSidebar(state,  StepTwoSelectionWidget()),
      ),
      GoRoute(
        path: '/stepThreeWidgetScreen',
        builder: (context, state) => _wrapSidebar(state,  StepThreeWidget()),
      ),
      GoRoute(
        path: '/editPickUp',
        builder: (context, state) => _wrapSidebar(state,  EditPickScreen()),
      ),

      // No Sidebar / Special AppBar Routes (DropOff Screens)
      GoRoute(
        path: '/dropOffDetail',
        builder: (context, state) => _wrapSidebar(state,  DropOffDetails()),
      ),
      GoRoute(
        path: '/addDropOff',
        builder: (context, state) => _wrapSidebar(state,  AddDropOffScreen()),
      ),
      GoRoute(
        path: '/stepTwoDropoff',
        builder: (context, state) => _wrapSidebar(state,  StepTwoDropOffWidget()),
      ),
      GoRoute(
        path: '/stepThreeDropOff',
        builder: (context, state) => _wrapSidebar(state,  StepThreeDropOffWidget()),
      ),
      GoRoute(
        path: '/addDropOffDetailTwo',
        builder: (context, state) => _wrapSidebar(state,  AddDropOffDetailWidget()),
      ),
      // No Sidebar / Special AppBar Routes (Staff Screens)
      GoRoute(
        path: '/addStaff',
        builder: (context, state) => _wrapSidebar(state,  AddStaffScreen()),
      ),
      GoRoute(
        path: '/EditStaffScreen',
        builder: (context, state) => _wrapSidebar(state,  EditStaffScreen()),
      ),
      // Payment Screens (No Sidebar)
      GoRoute(
        path: '/AddPayment',
        builder: (context, state) => _wrapSidebar(state,  AddPayment()),
      ),
    ],
  );


   // wrapSidebar Widget
  static Widget _wrapSidebar(GoRouterState state, Widget child) {
    final extras = state.extra as Map<String, dynamic>?;

    bool hideMobile = extras?["hideMobileAppBar"] == true;
    final String path = state.uri.toString().toLowerCase();
    if (path.contains('add') || path.contains('edit') || path.contains('detail') || path.contains('PickupTandC')) {
      hideMobile = true;
    }

    return SidebarScreen.wrapWithSidebarIfNeeded(
      child: child,
      hideMobileAppBar: hideMobile,
    );
  }
}