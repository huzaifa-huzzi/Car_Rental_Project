import 'package:car_rental_project/Portal/Vendor/Billing/BillingScreen/BillingScreen.dart';
import 'package:car_rental_project/Portal/Vendor/Car%20Inventory/AddingCar/AddingCar.dart';
import 'package:car_rental_project/Portal/Vendor/Car%20Inventory/Car%20Details/CarDetails.dart';
import 'package:car_rental_project/Portal/Vendor/Car%20Inventory/Car%20Directory/CarInventoryController.dart';
import 'package:car_rental_project/Portal/Vendor/Car%20Inventory/Car%20Directory/CarInventoryMainScreen.dart';
import 'package:car_rental_project/Portal/Vendor/Car%20Inventory/Editing%20Car/EditingCar.dart';
import 'package:car_rental_project/Portal/Vendor/Customers/AddCustomers/AddCustomers.dart';
import 'package:car_rental_project/Portal/Vendor/Customers/AddCustomers/Widget/StepTwoCustomerWidget.dart';
import 'package:car_rental_project/Portal/Vendor/Customers/CustomersController.dart';
import 'package:car_rental_project/Portal/Vendor/Customers/CustomersDetails/CustomersDetails.dart';
import 'package:car_rental_project/Portal/Vendor/Customers/EditCustomers/EditCustomerScreen.dart';
import 'package:car_rental_project/Portal/Vendor/Customers/TableViewCustomerScreen/TableViewScreen.dart';
import 'package:car_rental_project/Portal/Vendor/Dashboard/DashboardScreen.dart';
import 'package:car_rental_project/Portal/Vendor/DropOffCar/AddDropOff/AddDropOffScreen.dart';
import 'package:car_rental_project/Portal/Vendor/DropOffCar/AddDropOff/Widget/StepOneDropOffWidget.dart';
import 'package:car_rental_project/Portal/Vendor/DropOffCar/AddDropOff/Widget/StepThreeDropOffWidget.dart';
import 'package:car_rental_project/Portal/Vendor/DropOffCar/AddDropOff/Widget/StepTwoDropOffWidget.dart';
import 'package:car_rental_project/Portal/Vendor/DropOffCar/DropOffController.dart';
import 'package:car_rental_project/Portal/Vendor/DropOffCar/DropOffDetails/DropOffDetails.dart';
import 'package:car_rental_project/Portal/Vendor/DropOffCar/Subtabs/DropOffT&C/AddDropOffT&C.dart';
import 'package:car_rental_project/Portal/Vendor/DropOffCar/Subtabs/DropOffT&C/DropOffT&C.dart';
import 'package:car_rental_project/Portal/Vendor/DropOffCar/Subtabs/DropOffT&C/DropOffT&CDescription.dart';
import 'package:car_rental_project/Portal/Vendor/DropOffCar/TableViewDropoff/TableViewDropoffScreen.dart';
import 'package:car_rental_project/Portal/Vendor/Payment/Add%20Payment/AddPaymentScreen.dart';
import 'package:car_rental_project/Portal/Vendor/Payment/InvoicesDetail/InvoicesDetail.dart';
import 'package:car_rental_project/Portal/Vendor/Payment/InvoicesDetail/Widget/InvoicesDetailAutoWidget.dart';
import 'package:car_rental_project/Portal/Vendor/Payment/payment.dart';
import 'package:car_rental_project/Portal/Vendor/Payment/paymentController.dart';
import 'package:car_rental_project/Portal/Vendor/PickupCar/AddPickUp/AddPickup.dart';
import 'package:car_rental_project/Portal/Vendor/PickupCar/AddPickUp/Widget/StepThreeWidget.dart';
import 'package:car_rental_project/Portal/Vendor/PickupCar/AddPickUp/Widget/StepTwoWidgets.dart';
import 'package:car_rental_project/Portal/Vendor/PickupCar/AddPickUp/Widget/SteponeWidget.dart';
import 'package:car_rental_project/Portal/Vendor/PickupCar/EditPicUp/EditPickUpScreen.dart';
import 'package:car_rental_project/Portal/Vendor/PickupCar/PickUpDetailScreen/PickUpDetailScreen.dart';
import 'package:car_rental_project/Portal/Vendor/PickupCar/PickupCarInventory.dart';
import 'package:car_rental_project/Portal/Vendor/PickupCar/Subtabs/Pickup%20T&C/AddPickupT&C.dart';
import 'package:car_rental_project/Portal/Vendor/PickupCar/Subtabs/Pickup%20T&C/PickupT&C.dart';
import 'package:car_rental_project/Portal/Vendor/PickupCar/Subtabs/Pickup%20T&C/PickupT&CDescription.dart';
import 'package:car_rental_project/Portal/Vendor/PickupCar/TableViewPicukUpScreen/TableViewPickUpScreen.dart';
import 'package:car_rental_project/Portal/Vendor/Reminder/ReminderController.dart';
import 'package:car_rental_project/Portal/Vendor/Reminder/ReminderScreen/Reminder.dart';
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
                case "Reminder":       context.go('/reminder');      break;
                case "Billing":       context.go('/billing');      break;
              }
            }
          },
          hideMobileAppBar: hideMobile,
          child: child,
        );
      },
      routes: [
        // Main module routes
        GoRoute(path: '/dashboard', builder: (_, __) => const DashboardScreen()),
        GoRoute(path: '/carInventory', builder: (_, __) {
          Get.put(CarInventoryController());
          return CarInventoryMainScreen();
        }),
        GoRoute(path: '/customers', builder: (_, __) {
          Get.put(CustomerController());
          return TableViewCustomerScreen();
        }),
        GoRoute(path: '/pickupcar', builder: (_, __) {
          Get.put(PickupCarController());
          return TableViewPickUpScreen();
        }),
        GoRoute(path: '/pickupT&C', builder: (_, __) => const PickupTandC()),
        GoRoute(path: '/dropoffCar', builder: (_, __) {
          Get.put(DropOffController());
          return TableViewDropOffScreen();
        }),
        GoRoute(path: '/Payment', builder: (_, __) => PaymentScreen()),
        GoRoute(path: '/reminder', builder: (_, __) {
          Get.put(ReminderController());
          return ReminderScreen();
        }),
        GoRoute(path: '/staff', builder: (_, __) => TableViewOfStaffScreen()),

        // Car Inventory Details & Add/Edit
        GoRoute(path: '/cardetails', builder: (_, __) {
          Get.put(CarInventoryController());
          return CarDetailsScreen();
        }),
        GoRoute(path: '/addNewCar', builder: (_, __) {
          Get.put(CarInventoryController());
          return AddingCarScreen();
        }),
        GoRoute(path: '/editCar', builder: (_, __) {
          Get.put(CarInventoryController());
          return EditCarScreen();
        }),
        //  Customers Details & Add/Edit
        GoRoute(path: '/customerDetails', builder: (_, __) {
          Get.put(CustomerController());
          return CustomerDetails();
        }),
        GoRoute(path: '/addNewCustomer', builder: (_, __) {
          Get.put(CustomerController());
          return const AddCustomerScreen();
        }),
        GoRoute(path: '/editCustomers', builder: (_, __) {
          Get.put(CustomerController());
          return EditCustomerScreen();
        }),
        GoRoute(path: '/stepTwoCustomer', builder: (_, __) {
          Get.put(CustomerController());
          return StepTwoCustomerWidget();
        }),

        //  Pickup Sub-Routes
        GoRoute(path: '/pickupDetail', builder: (_, __) {
          Get.put(PickupCarController());
          return PickUpDetailScreen();
        }),
        GoRoute(path: '/addpickup', builder: (_, __) {
          Get.put(PickupCarController());
          return const AddPickup();
        }),
        GoRoute(path: '/stepOnePickup', builder: (_, __) {
          Get.put(PickupCarController());
          return StepOneSelectionWidget();
        }),
        GoRoute(path: '/stepTwoWidgetScreen', builder: (_, __) {
          Get.put(PickupCarController());
          return StepTwoSelectionWidget();
        }),
        GoRoute(path: '/stepThreeWidgetScreen', builder: (_, __) {
          Get.put(PickupCarController());
          return StepThreeWidget();
        }),
        GoRoute(path: '/editPickUp', builder: (_, __) {
          Get.put(PickupCarController());
          return EditPickScreen();
        }),
        GoRoute(path: '/AddpickupT&C', builder: (_, __) => AddPickupTandC()),
        GoRoute(path: '/pickupT&Cdescription', builder: (_, __) => PickupTandCDescription()),

        //  DropOff Sub-Routes
        GoRoute(path: '/dropOffDetail', builder: (_, __) {
          Get.put(DropOffController());
          return DropOffDetails();
        }),
        GoRoute(path: '/addDropOff', builder: (_, __) {
          Get.put(DropOffController());
          return const AddDropOffScreen();
        }),
        GoRoute(path: '/addDropOffDetailTwo', builder: (_, __) {
          Get.put(DropOffController());
          return AddDropOffDetailWidget();
        }),
        GoRoute(path: '/stepTwoDropoff', builder: (_, __) {
          Get.put(DropOffController());
          return StepTwoDropOffWidget();
        }),
        GoRoute(path: '/stepThreeDropOff', builder: (_, __) {
          Get.put(DropOffController());
          return StepThreeDropOffWidget();
        }),
        GoRoute(path: '/dropOffT&C', builder: (_, __) => DropOffTandC()),
        GoRoute(path: '/AdddropOffT&C', builder: (_, __) => AddDropOffTandC()),
        GoRoute(path: '/dropOffT&Cdescription', builder: (_, __) => DropOffTandCDescription()),

        //  Staff
        GoRoute(path: '/EditStaffScreen', builder: (_, __) => EditStaffScreen()),
        GoRoute(path: '/addStaff', builder: (_, __) => AddStaffScreen()),
        // Payments
        GoRoute(
          path: '/AddPayment',
          builder: (context, state) {
            if (!Get.isRegistered<PaymentController>()) {
              Get.put(PaymentController());
            }
            return const AddPayment();
          },
        ),

        GoRoute(
          path: '/invoicesDetail',
          builder: (context, state) {
            if (!Get.isRegistered<PaymentController>()) {
              Get.put(PaymentController());
            }
            final data = state.extra as Map<String, dynamic>?;
            return InvoicesDetail(invoiceData: data ?? {});
          },
        ),

        GoRoute(
          path: '/invoicesAutoDetail',
          builder: (context, state) {
            if (!Get.isRegistered<PaymentController>()) {
              Get.put(PaymentController());
            }
            final data = state.extra as Map<String, dynamic>?;
            return InvoicesDetailAutoWidget(invoiceData: data ?? {});
          },
        ),

         // Reminders

         // Billing
        GoRoute(path: '/billings', builder: (_, __) => BillingScreen()),
      ],
    ),
  ];
}