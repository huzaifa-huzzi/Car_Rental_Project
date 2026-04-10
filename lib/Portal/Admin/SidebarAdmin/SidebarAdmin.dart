import 'package:car_rental_project/Portal/Admin/SidebarAdmin/SidebarController.dart';
import 'package:car_rental_project/Portal/Admin/SidebarAdmin/Widget/MobileAppbarAdmin.dart';
import 'package:car_rental_project/Portal/Admin/SidebarAdmin/Widget/SidebarComponentAdminWidget.dart';
import 'package:car_rental_project/Resources/AppSizes.dart';
import 'package:car_rental_project/Resources/Colors.dart';
import 'package:car_rental_project/Resources/IconStrings.dart' show IconString;
import 'package:car_rental_project/Resources/ImageString.dart';
import 'package:car_rental_project/Resources/TextTheme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';



class SidebarAdmin extends StatelessWidget {
  final Function(String) onTap;
  final Widget? child;
  final bool hideMobileAppBar;

  SidebarAdmin({
    super.key,
    required this.onTap,
    this.child,
    this.hideMobileAppBar = false
  }) {
    Get.lazyPut<SideBarAdminController>(() => SideBarAdminController(), fenix: true);
  }

  final SideBarAdminController controller = Get.find<SideBarAdminController>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final bool isMobile = AppSizes.isMobile(context);
    final bool isTab = AppSizes.isTablet(context);
    final bool isWeb = AppSizes.isWeb(context);
    final double sidebarWidth = isWeb ? 260 : 200;

    final String currentRoute = GoRouterState.of(context).uri.toString();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.syncWithRoute(currentRoute);
    });

    /// Sidebar content
    Widget sidebarContent({bool showLogo = true}) {
      return SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (showLogo)
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: AppSizes.horizontalPadding(context),
                  vertical: AppSizes.verticalPadding(context),
                ),
                child: Row(
                  children: [
                    Image.asset(IconString.symbol, width: isMobile ? 30 : 36, height: isMobile ? 32 : 38),
                    SizedBox(width: AppSizes.horizontalPadding(context) / 2),
                    Text("Softsnip", style: TTextTheme.h6Style(context).copyWith(fontWeight: FontWeight.bold)),
                  ],
                ),
              ),

            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                shrinkWrap: true,
                children: [
                  SidebarComponentAdmin.menuItemAdmin(
                    context, controller,
                    iconPath: IconString.dashboardIcon,
                    title: "Dashboard",
                    onTap: (val) => context.go('/dashboard-admin'),
                    scaffoldKey: _scaffoldKey,
                  ),
                  SidebarComponentAdmin.menuItemAdmin(
                    context, controller,
                    iconPath: IconString.carInventoryIcon,
                    title: "Companies",
                    onTap: (val) => context.go('/companies'),
                    scaffoldKey: _scaffoldKey,
                  ),

                  SidebarComponentAdmin.menuItemAdmin(
                    context, controller,
                    iconPath: IconString.staffIcon,
                    title: "Reports",
                    onTap: (val) => context.go('/reports'),
                    scaffoldKey: _scaffoldKey,
                  ),


                  SidebarComponentAdmin.menuItemAdmin(
                    context, controller,
                    iconPath: IconString.paymentIconModule,
                    title: "Subscription",
                    onTap: (val) => context.go('/subscription'),
                    scaffoldKey: _scaffoldKey,
                  ),

                  SidebarComponentAdmin.menuItemAdmin(
                    context, controller,
                    iconPath: IconString.paymentIconModule,
                    title: "Payment",
                    onTap: (val) => context.go('/payment-admin'),
                    scaffoldKey: _scaffoldKey,
                  ),
                  SidebarComponentAdmin.menuItemAdmin(
                    context, controller,
                    iconPath: IconString.symbol,
                    title: "Branding",
                    onTap: (val) => context.go('/branding'),
                    scaffoldKey: _scaffoldKey,
                  ),
                  SidebarComponentAdmin.menuItemAdmin(
                    context, controller,
                    iconPath: IconString.customerIcon,
                    title: "User and Role",
                    onTap: (val) => context.go('/user-role-admin'),
                    scaffoldKey: _scaffoldKey,
                  ),
                  SidebarComponentAdmin.menuItemAdmin(
                    context, controller,
                    iconPath: IconString.notificationIcon,
                    title: "Help Center",
                    onTap: (val) => context.go('/help-admin'),
                    scaffoldKey: _scaffoldKey,
                  ),
                ],
              ),
            ),

            Padding(
              padding: EdgeInsets.only(bottom: AppSizes.verticalPadding(context)),
              child: SidebarComponentAdmin.menuItemAdmin(
                  context, controller,
                  iconPath: IconString.logoutIcon,
                  title: "Logout",
                  onTap: (val) => context.go('/login'),
                  scaffoldKey: _scaffoldKey
              ),
            ),
          ],
        ),
      );
    }

     // Add Buttons logic
    void handleAddButtonPressed() {
      if (currentRoute.contains('/companies')) {
        context.push('/add-company', extra: {"hideMobileAppBar": true});
      } else {

        print("Add pressed on $currentRoute");
      }
    }

    if (isMobile || isTab) {
      final bool isDashboardRoute = currentRoute.contains('/dashboard-admin');

      return Scaffold(
        backgroundColor: Colors.white,
        key: _scaffoldKey,
        drawer: Drawer(
            backgroundColor: Colors.white,
            child: sidebarContent(showLogo: false)
        ),
        appBar: hideMobileAppBar ? null : AppBar(
          automaticallyImplyLeading: false,
          elevation: 0,
          backgroundColor: AppColors.secondaryColor,
          title: MobileTopBarAdmin(
            scaffoldKey: _scaffoldKey,
            profileImageUrl: ImageString.userImage,
            isDashboard: isDashboardRoute,
            onAddPressed: handleAddButtonPressed,
          ),
        ),
        body: SafeArea(child: child ?? const SizedBox.shrink()),
      );
    } else {
      // Desktop / Web View
      return Scaffold(
        backgroundColor: AppColors.backgroundOfScreenColor,
        body: SafeArea(
          child: Row(
            children: [
              Container(
                  width: sidebarWidth,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10)
                      ]
                  ),
                  child: sidebarContent(showLogo: true)
              ),
              Expanded(
                child: child ?? const SizedBox.shrink(),
              ),
            ],
          ),
        ),
      );
    }
  }

  static Widget wrapWithSidebarIfNeeded({
    required Widget child,
    bool hideMobileAppBar = false,
  }) {
    return SidebarAdmin(
      onTap: (value) {},
      hideMobileAppBar: hideMobileAppBar,
      child: child,
    );
  }
}