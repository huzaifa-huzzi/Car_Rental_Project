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
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import '../Portal/Vendor/SideScreen/SidebarController.dart';

class VendorRoutes {
  static List<RouteBase> routes = [
    ShellRoute(
      builder: (context, state, child) {
        final String path = state.uri.toString().toLowerCase();
        bool hideMobile = path.contains('t&c') ||
            path.contains('add') ||
            path.contains('edit') ||
            path.contains('detail') ||
            path.contains('step');

        WidgetsBinding.instance.addPostFrameCallback((_) {

          final SideBarController controller = Get.put(
            SideBarController(),
            permanent: true,
            tag: 'sidebar',
          );
          controller.syncWithRoute(state.uri.toString());
        });

        return SidebarScreen(
          onTap: (route) {
            if (route.startsWith('/')) {
              context.go(route);
            } else {
              switch (route) {
                case "Dashboard":     context.go('/dashboard');    break;
                case "Car Inventory": context.go('/carInventory'); break;
                case "Customers":     context.go('/customers');    break;
                case "Pickup Car":    context.go('/pickupcar');    break;
                case "Pickup T&C":    context.go('/pickupT&C');    break;
                case "Dropoff Car":   context.go('/dropoffCar');   break;
                case "Staff":         context.go('/staff');        break;
                case "Payment":       context.go('/Payment');      break;
              }
            }
          },
          hideMobileAppBar: hideMobile,
          child: child,
        );
      },
      routes: [
        // ── Main module routes
        GoRoute(path: '/dashboard',    builder: (_, __) => const DashboardScreen()),
        GoRoute(path: '/carInventory', builder: (_, __) => CarInventoryMainScreen()),
        GoRoute(path: '/customers',    builder: (_, __) => TableViewCustomerScreen()),
        GoRoute(path: '/pickupcar',    builder: (_, __) => TableViewPickUpScreen()),
        GoRoute(path: '/pickupT&C',    builder: (_, __) => const PickupTandC()),
        GoRoute(path: '/dropoffCar',   builder: (_, __) => TableViewDropOffScreen()),
        GoRoute(path: '/Payment',      builder: (_, __) => PaymentScreen()),
        GoRoute(path: '/staff',        builder: (_, __) => TableViewOfStaffScreen()),

        // ── Inventory
        GoRoute(path: '/cardetails',   builder: (_, __) => CarDetailsScreen()),
        GoRoute(path: '/addNewCar',    builder: (_, __) => AddingCarScreen()),
        GoRoute(path: '/editCar',      builder: (_, __) => EditCarScreen()),

        // ── Customers
        GoRoute(path: '/customerDetails',  builder: (_, __) => CustomerDetails()),
        GoRoute(path: '/addNewCustomer',   builder: (_, __) => const AddCustomerScreen()),
        GoRoute(path: '/editCustomers',    builder: (_, __) => EditCustomerScreen()),
        GoRoute(path: '/stepTwoCustomer',  builder: (_, __) => StepTwoCustomerWidget()),

        // ── Pickup
        GoRoute(path: '/pickupDetail',          builder: (_, __) => PickUpDetailScreen()),
        GoRoute(path: '/addpickup',             builder: (_, __) => const AddPickup()),
        GoRoute(path: '/stepOnePickup',         builder: (_, __) => StepOneSelectionWidget()),
        GoRoute(path: '/stepTwoWidgetScreen',   builder: (_, __) => StepTwoSelectionWidget()),
        GoRoute(path: '/stepThreeWidgetScreen', builder: (_, __) => StepThreeWidget()),
        GoRoute(path: '/editPickUp',            builder: (_, __) => EditPickScreen()),
        GoRoute(path: '/AddpickupT&C',          builder: (_, __) => AddPickupTandC()),
        GoRoute(path: '/pickupT&Cdescription',  builder: (_, __) => PickupTandCDescription()),

        // ── DropOff
        GoRoute(path: '/dropOffDetail',       builder: (_, __) => DropOffDetails()),
        GoRoute(path: '/addDropOff',          builder: (_, __) => const AddDropOffScreen()),
        GoRoute(path: '/addDropOffDetailTwo', builder: (_, __) => AddDropOffDetailWidget()),
        GoRoute(path: '/stepTwoDropoff',      builder: (_, __) => StepTwoDropOffWidget()),
        GoRoute(path: '/stepThreeDropOff',    builder: (_, __) => StepThreeDropOffWidget()),
        GoRoute(path: '/dropOffT&C',          builder: (_, __) => DropOffTandC()),
        GoRoute(path: '/AdddropOffT&C',       builder: (_, __) => AddDropOffTandC()),
        GoRoute(path: '/dropOffT&Cdescription', builder: (_, __) => DropOffTandCDescription()),

        // ── Staff
        GoRoute(path: '/EditStaffScreen', builder: (_, __) => EditStaffScreen()),
        GoRoute(path: '/addStaff',        builder: (_, __) => AddStaffScreen()),

        // ── Payment & Others
        GoRoute(path: '/AddPayment', builder: (_, __) => AddPayment()),
        GoRoute(
          path: '/invoicesDetail',
          builder: (context, state) {
            final data = state.extra as Map<String, dynamic>?;
            return InvoicesDetail(invoiceData: data ?? {});
          },
        ),
      ],
    ),
  ];
}