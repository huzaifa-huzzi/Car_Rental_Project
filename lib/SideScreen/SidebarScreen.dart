import 'package:car_rental_project/SideScreen/Widget/MobileAppbar.dart';
import 'package:car_rental_project/SideScreen/Widget/SidebarComponentWidget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'SideBarController.dart';
import 'package:car_rental_project/Resources/Colors.dart';
import 'package:car_rental_project/Resources/IconStrings.dart';
import 'package:car_rental_project/Resources/TextTheme.dart';
import 'package:car_rental_project/Car%20Inventory/Car%20Inventory%20Screen.dart';

class SidebarScreen extends StatelessWidget {
  final Function(String) onTap;
  final Widget? child;
  final SideBarController controller = Get.put(SideBarController());
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  SidebarScreen({super.key, required this.onTap, this.child});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final bool isMobile = width < 600;
    final double sidebarWidth = width > 1100 ? 240 : 150;

    /// Sidebar content
    Widget sidebarContent({bool showLogo = true}) {
      return SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (showLogo)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                child: Row(
                  children: [
                    Image.asset(IconString.symbol, width: 30, height: 32),
                    const SizedBox(width: 8),
                    Text(
                      "Softsnip",
                      style: TTextTheme.h6Style(context)
                          .copyWith(fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  SidebarComponents.menuItem(
                    context,
                    controller,
                    iconPath: IconString.dashboardIcon,
                    title: "Dashboard",
                    onTap: onTap,
                  ),
                  SidebarComponents.menuItem(
                    context,
                    controller,
                    iconPath: IconString.carInventoryIcon,
                    title: "Car Inventory",
                    onTap: onTap,
                  ),
                  SidebarComponents.menuItem(
                    context,
                    controller,
                    iconPath: IconString.customerIcon,
                    title: "Customers",
                    onTap: onTap,
                  ),
                  SidebarComponents.menuItem(
                    context,
                    controller,
                    iconPath: IconString.agreementIcon,
                    title: "Re-agreement",
                    onTap: onTap,
                  ),
                  SidebarComponents.menuItem(
                    context,
                    controller,
                    iconPath: IconString.paymentIcon,
                    title: "Payment",
                    onTap: onTap,
                  ),
                  SidebarComponents.expenseMenuItem(
                    context,
                    controller,
                    onTap: onTap,
                  ),
                  SidebarComponents.menuItem(
                    context,
                    controller,
                    iconPath: IconString.maintenanceIcon,
                    title: "Maintenance",
                    onTap: onTap,
                  ),
                  SidebarComponents.menuItem(
                    context,
                    controller,
                    iconPath: IconString.incomeIcon,
                    title: "Income",
                    trailing: SidebarComponents.redDotWithNumber(controller.incomeRedDot.value, context),
                    onTap: onTap,
                  ),
                  const SizedBox(height: 60),
                  SidebarComponents.menuItem(
                    context,
                    controller,
                    iconPath: IconString.logoutIcon,
                    title: "Logout",
                    onTap: onTap,
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ],
        ),
      );
    }

     /// mobile appbar
    if (isMobile) {
      return Scaffold(
        key: _scaffoldKey,
        drawer: Drawer(child: sidebarContent(showLogo: false)),
        appBar: AppBar(
          backgroundColor: AppColors.secondaryColor,
          elevation: 0,
          centerTitle: true,
          title: MobileTopBar(
            scaffoldKey: _scaffoldKey,
            profileImageUrl: "https://i.pravatar.cc/300",
            onAddPressed: () {},
            onNotificationPressed: () {},
          ),
        ),
        body: SafeArea(
          child: child ?? const CarInventory(),
        ),
      );
    }


    /// Web / Tablet layout
    return Scaffold(
      body: SafeArea(
        child: Row(
          children: [
            Container(
              width: sidebarWidth,
              color: Colors.white,
              child: sidebarContent(showLogo: true),
            ),
            Expanded(
              child: child ?? const CarInventory(),
            ),
          ],
        ),
      ),
    );
  }

}
