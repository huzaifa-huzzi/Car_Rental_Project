import 'package:car_rental_project/Portal/Staff/Setting/ReusableWidget/HeaderWebStaffSettingWidget.dart';
import 'package:car_rental_project/Portal/Staff/Setting/Widget/SettingStaffWidget.dart';
import 'package:car_rental_project/Resources/AppSizes.dart';
import 'package:car_rental_project/Resources/Colors.dart';
import 'package:flutter/material.dart';


class SettingStaffScreen extends StatelessWidget {
  SettingStaffScreen({super.key});



  @override
  Widget build(BuildContext context) {
    final horizontalPadding = AppSizes.horizontalPadding(context);
    final baseVerticalSpace = AppSizes.verticalPadding(context);

    return Scaffold(
      backgroundColor: AppColors.backgroundOfScreenColor,
      body: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (AppSizes.isWeb(context))
                HeaderWebStaffSettingWidget(
                  mainTitle: 'Settings',
                  showProfile: true,
                  showNotification: true,
                  showSettings: false,
                  showSearch: false,
                ),
              const SizedBox(height: 30),
              const SettingStaffWidget(),

              SizedBox(height: baseVerticalSpace * 1.25),
            ],
          ),
        ),
      ),
    );
  }
}