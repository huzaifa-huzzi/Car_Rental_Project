


import 'package:car_rental_project/Portal/Staff/SidebarStaff/SidebarStaffController.dart';
import 'package:car_rental_project/Portal/Staff/SidebarStaff/Widget/MobileAppbarStaff.dart';
import 'package:car_rental_project/Portal/Staff/SidebarStaff/Widget/SidebarComponentStaff.dart';
import 'package:car_rental_project/Resources/AppSizes.dart';
import 'package:car_rental_project/Resources/Colors.dart';
import 'package:car_rental_project/Resources/IconStrings.dart';
import 'package:car_rental_project/Resources/ImageString.dart';
import 'package:car_rental_project/Resources/TextTheme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

class SidebarStaff extends StatelessWidget {
  final Function(String) onTap;
  final Widget? child;
  final bool hideMobileAppBar;

  SidebarStaff({
    super.key,
    required this.onTap,
    this.child,
    this.hideMobileAppBar = false
  }) {
    Get.lazyPut<SidebarStaffController>(() => SidebarStaffController(), fenix: true);
  }

  final SidebarStaffController controller = Get.find<SidebarStaffController>();
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
                  SidebarComponentStaff.menuItemStaff( // 🟢 menuItemAdmin ki jagah menuItemStaff use karein
                    context,
                    controller, // Ab ye SidebarStaffController ko accept karega
                    iconPath: IconString.dashboardAdmin,
                    title: "Dashboard",
                    onTap: (val) => context.go('/dashboard-staff'),
                    scaffoldKey: _scaffoldKey,
                  ),
                  SidebarComponentStaff.menuItemStaff(
                    context,
                    controller,
                    iconPath: IconString.carInventoryIcon, //
                    title: "Car Inventory",
                    onTap: (val) => context.go('/car-inventory'),
                    scaffoldKey: _scaffoldKey,
                  ),
                  SidebarComponentStaff.menuItemStaff(
                    context,
                    controller,
                    iconPath: IconString.agreementIcon, //
                    title: "Pick up",
                    onTap: (val) => context.go('/pickup-staff'),
                    scaffoldKey: _scaffoldKey,
                  ),
                ],
              ),
            ),

            Padding(
              padding: EdgeInsets.only(bottom: AppSizes.verticalPadding(context)),
              child: SidebarComponentStaff.menuItemStaff(
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
        context.push('/addCompany');
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
          title: MobileTopBarStaff(
            scaffoldKey: _scaffoldKey,
            profileImageUrl: ImageString.userImage,
            isDashboard: isDashboardRoute,
            onSettingsPressed: () => context.go('/settings-staff'),
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
    return SidebarStaff(
      onTap: (value) {},
      hideMobileAppBar: hideMobileAppBar,
      child: child,
    );
  }
}