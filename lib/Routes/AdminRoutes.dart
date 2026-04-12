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
import 'package:go_router/go_router.dart';
import 'package:get/get.dart';

class AdminRoutes {
  static List<RouteBase> routes = [

    /// ADMIN SHELL ROUTE
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

    /// External Routes
  ];
}