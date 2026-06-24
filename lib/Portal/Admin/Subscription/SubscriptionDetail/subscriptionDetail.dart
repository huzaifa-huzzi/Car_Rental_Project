import 'package:car_rental_project/Portal/Admin/Subscription/ReusableWidget/HeaderWebSubscriptionWidget.dart';
import 'package:car_rental_project/Portal/Admin/Subscription/SubscriptionController.dart';
import 'package:car_rental_project/Portal/Admin/Subscription/SubscriptionDetail/Widget/SubscriptionDetailWidget.dart';
import 'package:car_rental_project/Resources/AppSizes.dart';
import 'package:car_rental_project/Resources/Colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SubscriptionDetail extends StatelessWidget {
  SubscriptionDetail({super.key});

  final controller = Get.put(SubscriptionController());

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
                    showBack: true,
                    showNotification: true,
                    showSettings: true,
                    showSearch: true,
                  ),
                const SizedBox(height: 30),
                SubscriptionDetailWidget(),
                SizedBox(height: baseVerticalSpace * 1.25),
              ],
            ),
          ),
        ),
      ),
    );
  }
}