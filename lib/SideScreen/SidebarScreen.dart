import 'package:car_rental_project/Car%20Inventory/Car%20Directory/TableViewScreen/TableViewScreen.dart';
import 'package:car_rental_project/Resources/ImageString.dart';
import 'package:car_rental_project/SideScreen/Widget/MobileAppbar.dart';
import 'package:car_rental_project/SideScreen/Widget/SidebarComponentWidget.dart';
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

  SidebarScreen({super.key, required this.onTap, this.child,  this.hideMobileAppBar = false});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final bool isMobile = AppSizes.isMobile(context);
    final bool isTab = AppSizes.isMobile(context);
    final double sidebarWidth = width > 1100 ? 240 : 150;

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
                    Image.asset(
                      IconString.symbol,
                      width: AppSizes.isMobile(context) ? 30 : 36,
                      height: AppSizes.isMobile(context) ? 32 : 38,
                    ),
                    SizedBox(width: AppSizes.horizontalPadding(context) / 2),
                    Text(
                      "Softsnip",
                      style: TTextTheme.h6Style(context)
                          .copyWith(fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
            SizedBox(height: AppSizes.verticalPadding(context) / 2),
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
                    scaffoldKey: _scaffoldKey,
                  ),
                  SidebarComponents.menuItem(
                    context,
                    controller,
                    iconPath: IconString.carInventoryIcon,
                    title: "Car Inventory",
                    onTap: onTap,
                    scaffoldKey: _scaffoldKey,
                  ),
                  SidebarComponents.menuItem(
                    context,
                    controller,
                    iconPath: IconString.customerIcon,
                    title: "Customers",
                    onTap: onTap,
                    scaffoldKey: _scaffoldKey,
                  ),
                  SidebarComponents.menuItem(
                    context,
                    controller,
                    iconPath: IconString.agreementIcon,
                    title: "Re-agreement",
                    onTap: onTap,
                    scaffoldKey: _scaffoldKey,
                  ),
                  SidebarComponents.menuItem(
                    context,
                    controller,
                    iconPath: IconString.paymentIcon,
                    title: "Payment",
                    onTap: onTap,
                    scaffoldKey: _scaffoldKey,
                  ),
                  SidebarComponents.expenseMenuItem(
                    context,
                    controller,
                    onTap: onTap,
                    scaffoldKey: _scaffoldKey,
                  ),
                  SidebarComponents.menuItem(
                    context,
                    controller,
                    iconPath: IconString.maintenanceIcon,
                    title: "Maintenance",
                    onTap: onTap,
                    scaffoldKey: _scaffoldKey,
                  ),
                  SidebarComponents.menuItem(
                    context,
                    controller,
                    iconPath: IconString.incomeIcon,
                    title: "Income",
                    trailing: SidebarComponents.redDotWithNumber(
                        controller.incomeRedDot.value, context),
                    onTap: onTap,
                    scaffoldKey: _scaffoldKey,
                  ),
                  SizedBox(height: AppSizes.verticalPadding(context) * 2),
                  SidebarComponents.menuItem(
                    context,
                    controller,
                    iconPath: IconString.logoutIcon,
                    title: "Logout",
                    onTap: onTap,
                    scaffoldKey: _scaffoldKey,
                  ),
                  SizedBox(height: AppSizes.verticalPadding(context) / 2),
                ],
              ),
            ),
          ],
        ),
      );
    }


    /// Mobile AppBar
    if (isMobile) {
    return Scaffold(
    key: _scaffoldKey,
      drawer: Drawer(
        backgroundColor: Colors.white,
        child: sidebarContent(showLogo: false),
      ),

    appBar: hideMobileAppBar
    ? null
        : AppBar(
    automaticallyImplyLeading: false,
    backgroundColor: AppColors.secondaryColor,
    elevation: 0,
    centerTitle: true,
    title: MobileTopBar(
    scaffoldKey: _scaffoldKey,
    profileImageUrl: ImageString.userImage,
    onAddPressed: () {
      context.push(
        '/addNewCar',
        extra: {"hideMobileAppBar": true},
      );
    },
    onNotificationPressed: () {},
    ),
    ),

    body: SafeArea(
    child: child ?? const TableViewScreen(),
    ),
    );
    }
    /// Tab Appbar
    if (isTab) {
      return Scaffold(
        key: _scaffoldKey,
        drawer: Drawer(
          backgroundColor: Colors.white,
          child: sidebarContent(showLogo: false),
        ),

        appBar: hideMobileAppBar
            ? null
            : AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: AppColors.secondaryColor,
          elevation: 0,
          centerTitle: true,
          title: MobileTopBar(
            scaffoldKey: _scaffoldKey,
            profileImageUrl: ImageString.userImage,
            onAddPressed: () {
              context.push(
                '/addNewCar',
                extra: {"hideMobileAppBar": true},
              );
            },
            onNotificationPressed: () {},
          ),
        ),

        body: SafeArea(
          child: child ?? const TableViewScreen(),
        ),
      );
    }


    /// Web
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
              child: child ?? const TableViewScreen(),
            ),
          ],
        ),
      ),
    );


  }

  static Widget wrapWithSidebarIfNeeded({
    required Widget child,
    bool hideMobileAppBar = false,
  }) {
    return Builder(builder: (context) {
      bool isMobile = AppSizes.isMobile(context);

      if (isMobile && hideMobileAppBar) {
        return child;
      } else {
        return SidebarScreen(
          onTap: (value) {},
          hideMobileAppBar: hideMobileAppBar,
          child: child,
        );
      }
    });
  }

}
