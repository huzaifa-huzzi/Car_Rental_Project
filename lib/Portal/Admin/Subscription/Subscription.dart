import 'package:car_rental_project/Portal/Admin/Subscription/ReusableWidget/HeaderWebSubscriptionWidget.dart';
import 'package:car_rental_project/Portal/Admin/Subscription/Widget/SubscriptionAdminWidget.dart';
import 'package:flutter/material.dart';
import 'package:car_rental_project/Portal/Admin/Companies/CompaniesController.dart';
import 'package:car_rental_project/Resources/AppSizes.dart';
import 'package:car_rental_project/Resources/Colors.dart';
import 'package:get/get.dart';

class SubscriptionScreen extends StatelessWidget {
  SubscriptionScreen({super.key});

  final controller = Get.put(CompaniesAdminController());

  @override
  Widget build(BuildContext context) {
    final horizontalPadding = AppSizes.horizontalPadding(context);
    final baseVerticalSpace = AppSizes.verticalPadding(context);

    return Scaffold(
      backgroundColor: AppColors.backgroundOfScreenColor,
      body: Center(
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
            child: Column(
              children: [
                if (AppSizes.isWeb(context))
                  HeaderWebSubscriptionWidget(
                    mainTitle: 'Subscription',
                    showProfile: true,
                    showNotification: true,
                    showSettings: true,
                    showSearch: true,
                  ),
                const SizedBox(height: 30),
                SubscriptionAdminWidget(),
                SizedBox(height: baseVerticalSpace * 1.25),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
