import 'package:car_rental_project/Dashboard/ReusableWidgetOfDashboard/HeaderWebDashboardWidget.dart';
import 'package:car_rental_project/Resources/AppSizes.dart';
import 'package:car_rental_project/Resources/Colors.dart';
import 'package:flutter/material.dart';
import 'package:car_rental_project/Dashboard/Widget/DashboardWidget.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    final isMobile = AppSizes.isMobile(context);
    final isTablet = AppSizes.isTablet(context);
    final horizontalPadding = AppSizes.horizontalPadding(context);
    final baseVerticalSpace = AppSizes.verticalPadding(context);

    return Scaffold(
      backgroundColor: AppColors.backgroundOfScreenColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
          child: Column(
            children: [
              if (AppSizes.isWeb(context))
                if (AppSizes.isWeb(context))
                  HeaderWebDashboardWidget(
                    mainTitle: 'Dashboard',
                    showProfile: true,
                    showNotification: true,
                    showSettings: true,
                    showSearch: true,
                  ),
                DashboardContent(isMobile: isMobile, isTablet: isTablet,),
              SizedBox(height: baseVerticalSpace * 1.25),
            ],
          ),
        ),
      ),
    );
  }
}
