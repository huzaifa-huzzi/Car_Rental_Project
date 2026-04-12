import 'package:car_rental_project/Portal/Vendor/SideScreen/SidebarScreen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:car_rental_project/Routes/AuthRoutes.dart';
import 'package:car_rental_project/Routes/VendorRoutes.dart';
import 'package:car_rental_project/Routes/AdminRoutes.dart';

class AppNavigation {
  static final router = GoRouter(
    initialLocation: '/login',
    routes: [
      ...AuthRoutes.routes,

      ...VendorRoutes.routes,

      ...AdminRoutes.routes,

    ],
  );

  /// Helper Function
  static Widget wrapWithSidebar(GoRouterState state, Widget child) {
    final String path = state.uri.toString().toLowerCase();
    bool hideMobile = path.contains('add') || path.contains('edit') || path.contains('detail');

    return SidebarScreen.wrapWithSidebarIfNeeded(
      child: child,
      hideMobileAppBar: hideMobile,
    );
  }
}