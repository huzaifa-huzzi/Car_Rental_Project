import 'package:car_rental_project/Authentication/ForgotPassword/ForgotPassword.dart';
import 'package:car_rental_project/Authentication/Login/Login.dart';
import 'package:car_rental_project/Authentication/NewPassword/NewPassword.dart';
import 'package:car_rental_project/Authentication/RecoveryShowScreen/RecoveryShowScreen.dart';
import 'package:car_rental_project/Authentication/RecoveryShowScreen/RecoveryShowScreenTwo.dart';
import 'package:car_rental_project/Authentication/Register/RegisterScreen.dart';
import 'package:car_rental_project/Portal/Admin/Branding/Branding.dart';
import 'package:car_rental_project/Portal/Admin/Comapnies/Comapnies.dart';
import 'package:car_rental_project/Portal/Admin/DashboardAdmin/DashboardAdmin.dart';
import 'package:car_rental_project/Portal/Admin/HelpandCenter/HelpCenter.dart';
import 'package:car_rental_project/Portal/Admin/PaymentAdmin/PaymentAdmin.dart';
import 'package:car_rental_project/Portal/Admin/Reports/Reports.dart';
import 'package:car_rental_project/Portal/Admin/SidebarAdmin/SidebarAdmin.dart';
import 'package:car_rental_project/Portal/Admin/SidebarAdmin/SidebarController.dart';
import 'package:car_rental_project/Portal/Admin/Subscription/Subscription.dart';
import 'package:car_rental_project/Portal/Admin/UserandRole/userandRole.dart';
import 'package:car_rental_project/Portal/Vendor/Car%20Inventory/AddingCar/AddingCar.dart';
import 'package:car_rental_project/Portal/Vendor/Car%20Inventory/Car%20Details/CarDetails.dart';
import 'package:car_rental_project/Portal/Vendor/Car%20Inventory/Car%20Directory/CarInventoryMainScreen.dart';
import 'package:car_rental_project/Portal/Vendor/Car%20Inventory/Editing%20Car/EditingCar.dart';
import 'package:car_rental_project/Portal/Vendor/Customers/AddCustomers/AddCustomers.dart';
import 'package:car_rental_project/Portal/Vendor/Customers/CustomersDetails/CustomersDetails.dart';
import 'package:car_rental_project/Portal/Vendor/Customers/EditCustomers/EditCustomerScreen.dart';
import 'package:car_rental_project/Portal/Vendor/Customers/TableViewCustomerScreen/TableViewScreen.dart';
import 'package:car_rental_project/Portal/Vendor/Dashboard/DashboardScreen.dart';
import 'package:car_rental_project/Portal/Vendor/DropOffCar/TableViewDropoff/TableViewDropoffScreen.dart';
import 'package:car_rental_project/Portal/Vendor/Payment/Add%20Payment/AddPaymentScreen.dart';
import 'package:car_rental_project/Portal/Vendor/Payment/InvoicesDetail/InvoicesDetail.dart';
import 'package:car_rental_project/Portal/Vendor/Payment/payment.dart';
import 'package:car_rental_project/Portal/Vendor/PickupCar/AddPickUp/AddPickup.dart';
import 'package:car_rental_project/Portal/Vendor/PickupCar/EditPicUp/EditPickUpScreen.dart';
import 'package:car_rental_project/Portal/Vendor/PickupCar/PickUpDetailScreen/PickUpDetailScreen.dart';
import 'package:car_rental_project/Portal/Vendor/PickupCar/Subtabs/Pickup%20T&C/PickupT&C.dart';
import 'package:car_rental_project/Portal/Vendor/PickupCar/TableViewPicukUpScreen/TableViewPickUpScreen.dart';
import 'package:car_rental_project/Portal/Vendor/SideScreen/SidebarScreen.dart';
import 'package:car_rental_project/Portal/Vendor/Staff/TableViewScreen/StaffScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

class AppNavigation {
  static final router = GoRouter(
    initialLocation: '/login',
    routes: [
      ///  AUTH ROUTES
      GoRoute(path: '/login', builder: (context, state) => const LoginScreen()),
      GoRoute(path: '/signUp', builder: (context, state) => const RegisterScreen()),
      GoRoute(path: '/forgotPassword', builder: (context, state) => const ForgotPassword()),
      GoRoute(path: '/newPassword', builder: (context, state) => const NewPassword()),
      GoRoute(path: '/authSuccess', builder: (context, state) => const RecoveryShowScreenOne()),
      GoRoute(path: '/authSuccess2', builder: (context, state) => RecoveryShowScreenTwo()),

      /// VENDOR SHELL ROUTE
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

        /// Admin Shell Route
      ShellRoute(
        builder: (context, state, child) {
          Get.put(SideBarAdminController());
          final String path = state.uri.toString().toLowerCase();
          bool hideMobile = path.contains('add') || path.contains('edit') || path.contains('detail');

          return SidebarAdmin(
            onTap: (route) {
              switch (route) {
                case "Dashboard": context.go('/dashboard-admin'); break;
                case "Companies": context.go('/companies'); break;
                case "Reports": context.go('/reports'); break;
                case "Subscription": context.go('/subscription'); break;
                case "Payment": context.go('/payment-admin'); break;
                case "Branding": context.go('/branding'); break;
                case "User and Role": context.go('/user-role-admin'); break;
                case "Help Center": context.go('/help-admin'); break;
              }
            },
            hideMobileAppBar: hideMobile,
            child: child,
          );
        },
        routes: [
          GoRoute(path: '/dashboard-admin', builder: (context, state) => const DashBoardAdmin()),
          GoRoute(path: '/companies', builder: (context, state) => const CompaniesAdmin()),
          GoRoute(path: '/reports', builder: (context, state) => const ReportScreen()),
          GoRoute(path: '/subscription', builder: (context, state) => const SubscriptionScreen()),
          GoRoute(path: '/payment-admin', builder: (context, state) => const PaymentAdmin()),
          GoRoute(path: '/branding', builder: (context, state) => const BrandingScreen()),
          GoRoute(path: '/user-role-admin', builder: (context, state) => const UserandRole()),
          GoRoute(path: '/help-admin', builder: (context, state) => const HelpCenter()),
        ],
      ),
      ///  EXTERNAL ROUTES
      // Car Inventory
      GoRoute(path: '/cardetails', builder: (context, state) => _wrapSidebar(state, CarDetailsScreen())),
      GoRoute(path: '/addNewCar', builder: (context, state) => _wrapSidebar(state, AddingCarScreen())),
      GoRoute(path: '/editCar', builder: (context, state) => _wrapSidebar(state, EditCarScreen())),

      // Customers
      GoRoute(path: '/customerDetails', builder: (context, state) => _wrapSidebar(state, CustomerDetails())),
      GoRoute(path: '/addNewCustomer', builder: (context, state) => _wrapSidebar(state, const AddCustomerScreen())),
      GoRoute(path: '/editCustomers', builder: (context, state) => _wrapSidebar(state, EditCustomerScreen())),

      // Pickup
      GoRoute(path: '/pickupDetail', builder: (context, state) => _wrapSidebar(state, PickUpDetailScreen())),
      GoRoute(path: '/addpickup', builder: (context, state) => _wrapSidebar(state, const AddPickup())),
      GoRoute(path: '/editPickUp', builder: (context, state) => _wrapSidebar(state, EditPickScreen())),

      // Payment & Others
      GoRoute(path: '/AddPayment', builder: (context, state) => _wrapSidebar(state, AddPayment())),
      GoRoute(
        path: '/invoicesDetail',
        builder: (context, state) {
          final data = state.extra as Map<String, dynamic>?;
          return _wrapSidebar(state, InvoicesDetail(invoiceData: data ?? {}));
        },
      ),
    ],
  );

  /// Helper to wrap screens with Sidebar if needed
  static Widget _wrapSidebar(GoRouterState state, Widget child) {
    final String path = state.uri.toString().toLowerCase();
    bool hideMobile = path.contains('add') || path.contains('edit') || path.contains('detail');

    return SidebarScreen.wrapWithSidebarIfNeeded(
      child: child,
      hideMobileAppBar: hideMobile,
    );
  }
}