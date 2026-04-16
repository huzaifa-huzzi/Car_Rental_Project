import 'package:car_rental_project/Portal/Staff/DashboardStaff/Widget/HeaderWebDashboardStaffl.dart';
import 'package:car_rental_project/Resources/AppSizes.dart';
import 'package:car_rental_project/Resources/Colors.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';


class DashboardStaff extends StatelessWidget {
  DashboardStaff({super.key});


  @override
  Widget build(BuildContext context) {
    final baseVerticalSpace = AppSizes.verticalPadding(context);

    return Scaffold(
      backgroundColor: AppColors.backgroundOfScreenColor,
      body: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (AppSizes.isWeb(context))
              HeaderWebDashboardStaff(
                mainTitle: 'Dashboard',
                showProfile: true,
                showNotification: true,
                showSettings: true,
                onSettingsPressed: () {
                  context.go('/settings-staff');
                },
                showSearch: false,
              ),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: AppSizes.horizontalPadding(context)),
              child: Column(
                children: [
                  const SizedBox(height: 30),

                  Center(child: Text("Dashboard Staff Coming Soon"),),

                  SizedBox(height: baseVerticalSpace * 1.25),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
