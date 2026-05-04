import 'package:car_rental_project/Portal/Vendor/SideScreen/Widget/MobileAppbar.dart';
import 'package:car_rental_project/Portal/Vendor/SideScreen/Widget/SidebarComponentWidget.dart';
import 'package:car_rental_project/Portal/Vendor/SideScreen/Widget/TabAppBar.dart';
import 'package:car_rental_project/Resources/ImageString.dart';
import 'package:car_rental_project/Resources/TextString.dart';
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
  final bool hideMobileAppBar;

  SidebarScreen(
      {super.key, required this.onTap, this.child, this.hideMobileAppBar = false}) {
    Get.lazyPut<SideBarController>(() => SideBarController(), fenix: true);
  }

  final SideBarController controller = Get.find<SideBarController>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final bool isMobile = AppSizes.isMobile(context);
    final bool isTab = AppSizes.isTablet(context);
    final bool isWeb = AppSizes.isWeb(context);
    final double sidebarWidth = isWeb ? 240 : 150;




    final String currentRoute = GoRouterState.of(context).uri.toString();


 WidgetsBinding.instance.addPostFrameCallback((_) {
  controller.syncWithRoute(currentRoute);
 });

    /// Sidebar content
    Widget sidebarContent({bool showLogo = true}) {
      return SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              if (showLogo)
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: AppSizes.horizontalPadding(context),
                    vertical: AppSizes.verticalPadding(context) / 2,
                  ),
                  child: Row(
                    children: [
                      Image.asset(IconString.symbol, width: isMobile ? 30 : 36,
                          height: isMobile ? 32 : 38),
                      SizedBox(width: AppSizes.horizontalPadding(context) / 2),
                      Text("Softsnip", style: TTextTheme.h6Style(context)),
                    ],
                  ),
                ),

              SizedBox(height: AppSizes.verticalPadding(context) / 2),
              SidebarComponents.menuItem(
                context, controller,
                iconPath: IconString.dashboardIcon,
                title: TextString.dashboardTitle,
                onTap: (val) => context.go('/dashboard'),
                scaffoldKey: _scaffoldKey,
              ),
              SidebarComponents.menuItem(
                context, controller,
                iconPath: IconString.carInventoryIcon,
                title: TextString.carInventoryTitle,
                onTap: (val) => context.go('/carInventory'),
                scaffoldKey: _scaffoldKey,
              ),
              SidebarComponents.menuItem(
                context, controller,
                iconPath: IconString.customerIcon,
                title: TextString.customersTitle,
                onTap: (val) => context.go('/customers'),
                scaffoldKey: _scaffoldKey,
              ),
              SidebarComponents.expandableMenuItem(
                context, controller,
                iconPath: IconString.agreementIcon,
                title: "Pickup Car",
                route: '/pickupcar',
                subItems: [
                  {'title': 'Pickup T&C', 'route': '/pickupT&C','icon': IconString.tandCIcon,'extra': {'hideMobileAppBar': true},},
                ],
                scaffoldKey: _scaffoldKey,
              ),
              SidebarComponents.expandableMenuItem(
                context, controller,
                iconPath: IconString.returnCarIcon,
                title: "Dropoff Car",
                route: '/dropoffCar',
                subItems: [
                  {'title': 'DropOff T&C', 'route': '/dropOffT&C','icon': IconString.tandCIcon,'extra': {'hideMobileAppBar': true},},
                ],
                scaffoldKey: _scaffoldKey,
              ),
              SidebarComponents.menuItem(
                context, controller,
                iconPath: IconString.paymentIconModule,
                title: "Payment",
                onTap: (val) => context.go('/Payment'),
                scaffoldKey: _scaffoldKey,
              ),
              SidebarComponents.menuItem(
                context, controller,
                iconPath: IconString.staffIcon,
                title: TextString.staffTitle,
                onTap: (val) => context.go('/staff'),
                scaffoldKey: _scaffoldKey,
              ),
              const SizedBox(height: 40),

              SidebarComponents.emailNotVerifiedCard(context),

              const SizedBox(height: 10),


              Padding(
                padding: EdgeInsets.only(
                    bottom: AppSizes.verticalPadding(context) * 0.7),
                child: SidebarComponents.menuItem(
                    context, controller, iconPath: IconString.logoutIcon,
                    title: TextString.logoutTitle,
                    onTap: (val) {
                      context.go('/login');
                    },
                    scaffoldKey: _scaffoldKey),
              ),
            ],
          ),
        ),
      );
    }

    void handleAddButtonPressed() {
      if (currentRoute.contains('/customers')) {
        context.push('/customers/addNewCustomer', extra: {"hideMobileAppBar": true});
      }
      else if (currentRoute.contains('/pickupcar')) {
        context.push('/addpickup', extra: {"hideMobileAppBar": true});
      }
      else if (currentRoute.contains('/dropoffCar')) {
        context.push('/addDropOff', extra: {"hideMobileAppBar": true});
      }
      else if (currentRoute.contains('/staff')) {
        context.push('/addStaff', extra: {"hideMobileAppBar": true});
      }
      else if (currentRoute.contains('/Payment')) {
        context.push('/AddPayment', extra: {"hideMobileAppBar": true});
      }
      else {
        context.push('/addNewCar', extra: {"hideMobileAppBar": true});
      }
    }

    // Mobile and Tab check
    if (isMobile || isTab) {
      final bool isDashboardRoute = currentRoute.contains('/dashboard');

      return Scaffold(
        backgroundColor: Colors.white,
        key: _scaffoldKey,
        drawer: Drawer(backgroundColor: Colors.white,
            child: sidebarContent(showLogo: false)),
        appBar: hideMobileAppBar ? null : AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: AppColors.secondaryColor,
          title: isMobile
              ? MobileTopBar(
            scaffoldKey: _scaffoldKey,
            profileImageUrl: ImageString.userImage,
            isDashboard: isDashboardRoute,
            onAddPressed: handleAddButtonPressed,
            onSearchPressed: () => print("Search Clicked"),
          )
              : TabAppBar(
            scaffoldKey: _scaffoldKey,
            profileImageUrl: ImageString.userImage,
            isDashboard: isDashboardRoute,
            onAddPressed: handleAddButtonPressed,
            onSearchPressed: () => print("Search Clicked"),
          ),
        ),
        body: SafeArea(child: child ?? const SizedBox.shrink()),
      );
    } else {
      return Scaffold(
        body: SafeArea(
          child: Row(
            children: [
              Container(
                  width: sidebarWidth,
                  color: Colors.white,
                  child: sidebarContent(showLogo: true)
              ),
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
    required ValueKey<String> key,
  }) {
    return SidebarScreen(
      key: key,
      onTap: (value) {},
      hideMobileAppBar: hideMobileAppBar,
      child: child,
    );
  }


}