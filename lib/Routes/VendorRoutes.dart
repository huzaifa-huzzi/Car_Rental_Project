import 'package:car_rental_project/Portal/Vendor/Car%20Inventory/AddingCar/AddingCar.dart';
import 'package:car_rental_project/Portal/Vendor/Car%20Inventory/Car%20Details/CarDetails.dart';
import 'package:car_rental_project/Portal/Vendor/Car%20Inventory/Car%20Directory/CarInventoryMainScreen.dart';
import 'package:car_rental_project/Portal/Vendor/Car%20Inventory/Editing%20Car/EditingCar.dart';
import 'package:car_rental_project/Portal/Vendor/Customers/AddCustomers/AddCustomers.dart';
import 'package:car_rental_project/Portal/Vendor/Customers/AddCustomers/Widget/StepTwoCustomerWidget.dart';
import 'package:car_rental_project/Portal/Vendor/Customers/CustomersDetails/CustomersDetails.dart';
import 'package:car_rental_project/Portal/Vendor/Customers/EditCustomers/EditCustomerScreen.dart';
import 'package:car_rental_project/Portal/Vendor/Customers/TableViewCustomerScreen/TableViewScreen.dart';
import 'package:car_rental_project/Portal/Vendor/Dashboard/DashboardScreen.dart';
import 'package:car_rental_project/Portal/Vendor/DropOffCar/AddDropOff/AddDropOffScreen.dart';
import 'package:car_rental_project/Portal/Vendor/DropOffCar/AddDropOff/Widget/StepOneDropOffWidget.dart';
import 'package:car_rental_project/Portal/Vendor/DropOffCar/AddDropOff/Widget/StepThreeDropOffWidget.dart';
import 'package:car_rental_project/Portal/Vendor/DropOffCar/AddDropOff/Widget/StepTwoDropOffWidget.dart';
import 'package:car_rental_project/Portal/Vendor/DropOffCar/DropOffDetails/DropOffDetails.dart';
import 'package:car_rental_project/Portal/Vendor/DropOffCar/Subtabs/DropOffT&C/AddDropOffT&C.dart';
import 'package:car_rental_project/Portal/Vendor/DropOffCar/Subtabs/DropOffT&C/DropOffT&C.dart';
import 'package:car_rental_project/Portal/Vendor/DropOffCar/Subtabs/DropOffT&C/DropOffT&CDescription.dart';
import 'package:car_rental_project/Portal/Vendor/DropOffCar/TableViewDropoff/TableViewDropoffScreen.dart';
import 'package:car_rental_project/Portal/Vendor/Payment/Add%20Payment/AddPaymentScreen.dart';
import 'package:car_rental_project/Portal/Vendor/Payment/InvoicesDetail/InvoicesDetail.dart';
import 'package:car_rental_project/Portal/Vendor/Payment/payment.dart';
import 'package:car_rental_project/Portal/Vendor/PickupCar/AddPickUp/AddPickup.dart';
import 'package:car_rental_project/Portal/Vendor/PickupCar/AddPickUp/Widget/StepThreeWidget.dart';
import 'package:car_rental_project/Portal/Vendor/PickupCar/AddPickUp/Widget/StepTwoWidgets.dart';
import 'package:car_rental_project/Portal/Vendor/PickupCar/AddPickUp/Widget/SteponeWidget.dart';
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

class VendorRoutes {
  static List<RouteBase> routes = [


    ShellRoute(
      builder: (context, state, child) {
        final String path = state.uri.toString().toLowerCase();
        bool hideMobile = path.contains('t&c') || path.contains('add') ||
            path.contains('edit') || path.contains('detail');

        return SidebarScreen(
          onTap: (route) {
            if (route.startsWith('/')) {
              context.go(route);
            } else {
              switch (route) {
                case "Dashboard": context.go('/dashboard'); break;
                case "Car Inventory": context.go('/carInventory'); break;
                case "Customers": context.go('/customers'); break;
                case "Pickup Car": context.go('/pickupcar'); break;
                case "Pickup T&C": context.go('/pickupT&C'); break;
                case "Dropoff Car": context.go('/dropoffCar'); break;
                case "Staff": context.go('/staff'); break;
                case "Payment": context.go('/Payment'); break;
              }
            }
          },
          hideMobileAppBar: hideMobile,
          child: child,
        );
      },
      routes: [
        GoRoute(path: '/dashboard', builder: (context, state) => const DashboardScreen()),
        GoRoute(path: '/carInventory', builder: (context, state) => CarInventoryMainScreen()),
        GoRoute(path: '/customers', builder: (context, state) => TableViewCustomerScreen()),
        GoRoute(path: '/pickupcar', builder: (context, state) => TableViewPickUpScreen()),
        GoRoute(path: '/pickupT&C', builder: (context, state) => const PickupTandC()),
        GoRoute(path: '/dropoffCar', builder: (context, state) => TableViewDropOffScreen()),
        GoRoute(path: '/Payment', builder: (context, state) => PaymentScreen()),
        GoRoute(path: '/staff', builder: (context, state) => TableViewOfStaffScreen()),
      ],
    ),

    GoRoute(path: '/cardetails', builder: (context, state) => _wrapSidebar(state, CarDetailsScreen())),
    GoRoute(path: '/addNewCar', builder: (context, state) => _wrapSidebar(state, AddingCarScreen())),
    GoRoute(path: '/editCar', builder: (context, state) => _wrapSidebar(state, EditCarScreen())),

    // Customers
    GoRoute(path: '/customerDetails', builder: (context, state) => _wrapSidebar(state, CustomerDetails())),
    GoRoute(path: '/addNewCustomer', builder: (context, state) => _wrapSidebar(state, const AddCustomerScreen())),
    GoRoute(path: '/editCustomers', builder: (context, state) => _wrapSidebar(state, EditCustomerScreen())),
    GoRoute(path: '/stepTwoCustomer', builder: (context, state) => _wrapSidebar(state, StepTwoCustomerWidget())),

    // Pickup
    GoRoute(path: '/pickupDetail', builder: (context, state) => _wrapSidebar(state, PickUpDetailScreen())),
    GoRoute(path: '/addpickup', builder: (context, state) => _wrapSidebar(state, const AddPickup())),
    GoRoute(path: '/stepOnePickup', builder: (context, state) => _wrapSidebar(state,  StepOneSelectionWidget())),
    GoRoute(path: '/stepTwoWidgetScreen', builder: (context, state) => _wrapSidebar(state,  StepTwoSelectionWidget())),
    GoRoute(path: '/stepThreeWidgetScreen', builder: (context, state) => _wrapSidebar(state,  StepThreeWidget())),
    GoRoute(path: '/editPickUp', builder: (context, state) => _wrapSidebar(state, EditPickScreen())),
    GoRoute(path: '/pickupT&C', builder: (context, state) => _wrapSidebar(state, PickupTandC())),
    GoRoute(path: '/AddpickupT&C', builder: (context, state) => _wrapSidebar(state, AddPickupTandC())),
    GoRoute(path: '/pickupT&Cdescription', builder: (context, state) => _wrapSidebar(state, PickupTandCDescription())),

    // DropOff
    GoRoute(path: '/dropOffDetail', builder: (context, state) => _wrapSidebar(state, DropOffDetails())),
    GoRoute(path: '/addDropOff', builder: (context, state) => _wrapSidebar(state, const AddDropOffScreen())),
    GoRoute(path: '/addDropOffDetailTwo', builder: (context, state) => _wrapSidebar(state,  AddDropOffDetailWidget())),
    GoRoute(path: '/stepTwoDropoff', builder: (context, state) => _wrapSidebar(state,  StepTwoDropOffWidget())),
    GoRoute(path: '/stepThreeDropOff', builder: (context, state) => _wrapSidebar(state,  StepThreeDropOffWidget())),
    GoRoute(path: '/dropOffT&C', builder: (context, state) => _wrapSidebar(state, DropOffTandC())),
    GoRoute(path: '/AdddropOffT&C', builder: (context, state) => _wrapSidebar(state, AddDropOffTandC())),
    GoRoute(path: '/dropOffT&Cdescription', builder: (context, state) => _wrapSidebar(state, DropOffTandCDescription())),

     // Staff
    GoRoute(path: '/EditStaffScreen', builder: (context, state) => _wrapSidebar(state, EditStaffScreen())),
    GoRoute(path: '/addStaff', builder: (context, state) => _wrapSidebar(state, AddStaffScreen())),

    // Payment & Others
    GoRoute(path: '/AddPayment', builder: (context, state) => _wrapSidebar(state, AddPayment())),
    GoRoute(
      path: '/invoicesDetail',
      builder: (context, state) {
        final data = state.extra as Map<String, dynamic>?;
        return _wrapSidebar(state, InvoicesDetail(invoiceData: data ?? {}));
      },
    ),
  ];


  static Widget _wrapSidebar(GoRouterState state, Widget child) {
    final String path = state.uri.toString().toLowerCase();
    bool hideMobile = path.contains('t&c') || path.contains('add') ||
        path.contains('edit') || path.contains('detail');

    return SidebarScreen.wrapWithSidebarIfNeeded(
      child: child,
      hideMobileAppBar: hideMobile,
    );
  }
}