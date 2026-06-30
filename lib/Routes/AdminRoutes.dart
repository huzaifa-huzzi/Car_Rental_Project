import 'package:car_rental_project/Portal/Admin/Branding/Branding.dart';
import 'package:car_rental_project/Portal/Admin/Companies/AddCompany/AddCompany.dart';
import 'package:car_rental_project/Portal/Admin/Companies/Comapnies.dart';
import 'package:car_rental_project/Portal/Admin/Companies/CompanyDetail/CompanyDetailScreen.dart';
import 'package:car_rental_project/Portal/Admin/DashboardAdmin/DashboardAdmin.dart';
import 'package:car_rental_project/Portal/Admin/HelpandCenter/HelpCenter.dart';
import 'package:car_rental_project/Portal/Admin/PaymentAdmin/PaymentAdmin.dart';
import 'package:car_rental_project/Portal/Admin/Reports/Reports.dart';
import 'package:car_rental_project/Portal/Admin/SidebarAdmin/SidebarAdmin.dart';
import 'package:car_rental_project/Portal/Admin/SidebarAdmin/SidebarController.dart';
import 'package:car_rental_project/Portal/Admin/Subscription/AddSubscrition/AddSubscription.dart';
import 'package:car_rental_project/Portal/Admin/Subscription/Subscription.dart';
import 'package:car_rental_project/Portal/Admin/Subscription/SubscriptionDetail/subscriptionDetail.dart';
import 'package:car_rental_project/Portal/Admin/Subscription/SubscriptionFeeScreen/subscriptionFeeScreen.dart';
import 'package:car_rental_project/Portal/Admin/Subscription/SubscriptionInvoiceDetail/SubscriptionInvoiceDetail.dart';
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
        // Dynamic hiding check update
        bool hideMobile = path.contains('edit') ||
            path.contains('add') ||
            path.contains('detail') ||
            path.contains('fee');

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
        GoRoute(
          path: '/companies',
          builder: (context, state) => ComapaniesAdmin(),
          routes: [
            GoRoute(
              path: 'addCompany',
              builder: (context, state) => AddCompany(),
            ),
            GoRoute(
              path: 'detailCompany',
              builder: (context, state) => CompaniesDetail(),
            ),
          ],
        ),

        GoRoute(path: '/reports', builder: (context, state) => const ReportScreen()),
        GoRoute(
          path: '/subscription',
          builder: (context, state) => SubscriptionScreen(),
          routes: [
            GoRoute(
              path: 'subscriptionFee',
              builder: (context, state) => SubscriptionFreeScreen(),
            ),
            GoRoute(
              path: 'addSubscription',
              builder: (context, state) => AddSubscriptionScreen(),
            ),
            GoRoute(
              path: 'SubscriptionDetail',
              builder: (context, state) => SubscriptionDetail(),
            ),
            GoRoute(
              path: 'subscriptionInvoiceDetail',
              builder: (context, state) => SubscriptionInvoiceDetail(),
            ),
          ],
        ),

        GoRoute(path: '/payment-admin', builder: (context, state) => const PaymentAdmin()),
        GoRoute(path: '/branding', builder: (context, state) => const BrandingScreen()),
        GoRoute(path: '/user-role-admin', builder: (context, state) => const UserandRole()),
        GoRoute(path: '/help-admin', builder: (context, state) => const HelpCenter()),
      ],
    ),
  ];
}