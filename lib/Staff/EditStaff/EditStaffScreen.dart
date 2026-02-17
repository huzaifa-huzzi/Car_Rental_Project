import 'package:car_rental_project/Resources/AppSizes.dart';
import 'package:car_rental_project/Resources/Colors.dart';
import 'package:car_rental_project/Staff/EditStaff/Widget/EditStaffScreenWidget.dart';
import 'package:car_rental_project/Staff/ReusableWidgetOfStaff/HeaderWebStaffWidget.dart';
import 'package:car_rental_project/Staff/StaffController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditStaffScreen extends StatelessWidget {
  EditStaffScreen({super.key});


  final controller = Get.put(StaffController());

  @override
  Widget build(BuildContext context) {
    final horizontalPadding = AppSizes.horizontalPadding(context);
    final baseVerticalSpace = AppSizes.verticalPadding(context);
    bool isWeb = AppSizes.isWeb(context);

    return Scaffold(
      backgroundColor: AppColors.backgroundOfScreenColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                HeaderWebStaffWidget(
                  mainTitle: 'Edit Staff',
                  smallTitle: 'Staff/Edit Staff',
                  showSmallTitle: true,
                  showProfile: true,
                  showNotification: true,
                  showSearch: isWeb,
                  showSettings: isWeb,
                  showBack: true,
                ),
                SizedBox(
                  height: AppSizes.isWeb(context)
                      ? 30
                      : AppSizes.isTablet(context)
                      ? 50
                      : 40,
                ),
                const EditStaffScreenWidget(),
                SizedBox(height: baseVerticalSpace * 1.25),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
