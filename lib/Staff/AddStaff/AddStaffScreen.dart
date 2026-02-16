import 'package:car_rental_project/Resources/AppSizes.dart';
import 'package:car_rental_project/Resources/Colors.dart';
import 'package:car_rental_project/Staff/AddStaff/Widget/AddStaffScreenWidget.dart';
import 'package:car_rental_project/Staff/ReusableWidgetOfStaff/HeaderWebStaffWidget.dart';
import 'package:car_rental_project/Staff/StaffController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddStaffScreen extends StatelessWidget {
  AddStaffScreen({super.key});


  final controller = Get.put(StaffController());

  @override
  Widget build(BuildContext context) {
    final horizontalPadding = AppSizes.horizontalPadding(context);
    final baseVerticalSpace = AppSizes.verticalPadding(context);

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
                    mainTitle: 'Add New Staff',
                    smallTitle: 'Staff/Add New Staff',
                    showSmallTitle: true,
                    showProfile: true,
                    showNotification: true,
                    showSettings: true,
                    showSearch: true,
                    showBack: true,
                  ),
                SizedBox(
                  height: AppSizes.isWeb(context)
                      ? 30
                      : AppSizes.isTablet(context)
                      ? 50
                      : 40,
                ),
                const AddStaffScreenWidget(),

                SizedBox(height: baseVerticalSpace * 1.25),
              ],
            ),
          ),
        ),
      ),
    );
  }
}