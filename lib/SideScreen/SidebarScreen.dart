import 'package:car_rental_project/Resources/ImageString.dart';
import 'package:car_rental_project/Resources/TextString.dart';
import 'package:car_rental_project/SideScreen/Widget/MobileAppbar.dart';
import 'package:car_rental_project/SideScreen/Widget/SidebarComponentWidget.dart';
import 'package:car_rental_project/SideScreen/Widget/TabAppBar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'SideBarController.dart';
import 'package:car_rental_project/Resources/Colors.dart';
import 'package:car_rental_project/Resources/IconStrings.dart';
import 'package:car_rental_project/Resources/TextTheme.dart';
import 'package:car_rental_project/Resources/AppSizes.dart';

class SidebarScreen extends StatelessWidget {
  final Function(String) onTap;
  final Widget? child;
  final SideBarController controller = Get.put(SideBarController());
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final bool hideMobileAppBar;

  SidebarScreen({super.key, required this.onTap, this.child, this.hideMobileAppBar = false});

  @override
  Widget build(BuildContext context) {
    final bool isMobile = AppSizes.isMobile(context);
    final bool isTab = AppSizes.isTablet(context);
    final bool isWeb = AppSizes.isWeb(context);
    final double sidebarWidth = isWeb ? 240 : 150;

    final String currentRoute = GoRouterState.of(context).uri.toString();

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
                  vertical: AppSizes.verticalPadding(context) / 2,
                ),
                child: Row(
                  children: [
                    Image.asset(IconString.symbol, width: isMobile ? 30 : 36, height: isMobile ? 32 : 38),
                    SizedBox(width: AppSizes.horizontalPadding(context) / 2),
                    Text("Softsnip", style: TTextTheme.h6Style(context).copyWith(fontWeight: FontWeight.w600)),
                  ],
                ),
              ),
            SizedBox(height: AppSizes.verticalPadding(context) / 2),
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                children: [
                  // Dashboard
                  SidebarComponents.menuItem(context, controller, iconPath: IconString.dashboardIcon, title: TextString.dashboardTitle,
                      onTap: (val) => context.go('/dashboard'), scaffoldKey: _scaffoldKey),

                  SidebarComponents.menuItem(context, controller, iconPath: IconString.carInventoryIcon, title: TextString.carInventoryTitle,
                      onTap: (val) => context.go('/carInventory'), scaffoldKey: _scaffoldKey),

                  SidebarComponents.menuItem(context, controller, iconPath: IconString.customerIcon, title: TextString.customersTitle,
                      onTap: (val) => context.go('/customers'), scaffoldKey: _scaffoldKey),

                  SidebarComponents.menuItem(context, controller, iconPath: IconString.agreementIcon, title: TextString.reAgreementTitle, onTap: onTap, scaffoldKey: _scaffoldKey),
                  SidebarComponents.menuItem(context, controller, iconPath: IconString.returnCarIcon, title: TextString.returnCar, onTap: onTap, scaffoldKey: _scaffoldKey),
                  SidebarComponents.expenseMenuItem(context, controller, onTap: onTap, scaffoldKey: _scaffoldKey),
                  SidebarComponents.menuItem(context, controller, iconPath: IconString.maintenanceIcon, title: TextString.maintenanceTitle, onTap: onTap, scaffoldKey: _scaffoldKey),
                  SidebarComponents.menuItem(context, controller, iconPath: IconString.incomeIcon, title: TextString.incomeTitle,
                      trailing: SidebarComponents.redDotWithNumber(controller.incomeRedDot.value, context), onTap: onTap, scaffoldKey: _scaffoldKey),
                ],
              ),
            ),
            SizedBox(height: 30,),
            Padding(
              padding: EdgeInsets.only(bottom: AppSizes.verticalPadding(context) * 0.7),
              child: SidebarComponents.menuItem(context, controller, iconPath: IconString.logoutIcon, title: TextString.logoutTitle, onTap: onTap, scaffoldKey: _scaffoldKey),
            ),
          ],
        ),
      );
    }

    void handleAddButtonPressed() {
      if (currentRoute.contains('/customers')) {
        context.push('/addNewCustomer', extra: {"hideMobileAppBar": true});
      } else {
        context.push('/addNewCar', extra: {"hideMobileAppBar": true});
      }
    }

    // Mobile/Tablet/Web Appbars
    if (isMobile || isTab) {
      return Scaffold(
        backgroundColor: Colors.white,
        key: _scaffoldKey,
        drawer: Drawer(backgroundColor: Colors.white, child: sidebarContent(showLogo: false)),
        appBar: hideMobileAppBar ? null : AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: AppColors.secondaryColor,
          title: isMobile
              ? MobileTopBar(scaffoldKey: _scaffoldKey, profileImageUrl: ImageString.userImage, onAddPressed: handleAddButtonPressed)
              : TabAppBar(scaffoldKey: _scaffoldKey, profileImageUrl: ImageString.userImage, onAddPressed: handleAddButtonPressed),
        ),
        body: SafeArea(child: child ?? const SizedBox.shrink()),
      );
    } else {
      return Scaffold(
        body: SafeArea(
          child: Row(
            children: [
              Container(width: sidebarWidth, color: Colors.white, child: sidebarContent(showLogo: true)),
              Expanded(child: child ?? const SizedBox.shrink()),
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
    return SidebarScreen(
      onTap: (value) {},
      hideMobileAppBar: hideMobileAppBar,
      child: child,
    );
  }



}