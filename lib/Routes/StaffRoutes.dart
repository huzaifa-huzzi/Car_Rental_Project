
import 'package:car_rental_project/Portal/Staff/CarInventoryStaff/CarInventoryStaff.dart';
import 'package:car_rental_project/Portal/Staff/DashboardStaff/DashboardStaff.dart';
import 'package:car_rental_project/Portal/Staff/PickupStaff/pickupStaff.dart';
import 'package:car_rental_project/Portal/Staff/Setting/SettingStaff.dart';
import 'package:car_rental_project/Portal/Staff/SidebarStaff/SidebarStaff.dart';
import 'package:car_rental_project/Portal/Staff/SidebarStaff/SidebarStaffController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

class StaffRoutes {

  static List<RouteBase> routes = [


    /// STAFF SHELL ROUTE
    ShellRoute(

      builder: (context, state, child) {
        Get.put(SidebarStaffController());

        final String path = state.uri.toString().toLowerCase();
        bool hideMobile = path.contains('edit');

        return SidebarStaff(
          onTap: (route) {
            switch (route) {
              case "Dashboard": context.go('/dashboard-staff'); break;
              case "Car Inventory": context.go('/car-inventory'); break;
              case "Pick up": context.go('/pickup-staff'); break;
            }
          },
          hideMobileAppBar: hideMobile,
          child: child,
        );
      },
      routes: [
        // Main Staff Modules
        GoRoute(path: '/dashboard-staff', builder: (context, state) =>  DashboardStaff()),
        GoRoute(path: '/car-inventory', builder: (context, state) => const CerInventoryStaff()),
        GoRoute(path: '/pickup-staff', builder: (context, state) => const PickupStaff()),

        // Settings
        GoRoute(
            path: '/settings-staff',
            builder: (context, state) =>  SettingStaffScreen()
        ),
      ],
    ),
  ];

  // Helper
  static Widget _wrapStaffSidebar(GoRouterState state, Widget child) {
    final String path = state.uri.toString().toLowerCase();
    bool hideMobile = path.contains('add') || path.contains('edit') || path.contains('detail');

    return SidebarStaff.wrapWithSidebarIfNeeded(
      child: child,
      hideMobileAppBar: hideMobile,
    );
  }
}