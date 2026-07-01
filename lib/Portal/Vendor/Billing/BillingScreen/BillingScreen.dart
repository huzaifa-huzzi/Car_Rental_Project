import 'package:car_rental_project/Portal/Vendor/Billing/BillingController.dart';
import 'package:car_rental_project/Portal/Vendor/Billing/BillingScreen/Widget/BillingScreenWidget.dart';
import 'package:car_rental_project/Portal/Vendor/Billing/ResuableWidget/HeaderWebBillingWidget.dart';
import 'package:car_rental_project/Resources/AppSizes.dart';
import 'package:car_rental_project/Resources/Colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class BillingScreen extends StatelessWidget {
  BillingScreen({super.key});

  final controller = Get.put(BillingController());

  @override
  Widget build(BuildContext context) {
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
                HeaderWebBillingWidget(
                  mainTitle: 'Billing',
                  showSmallTitle: true,
                  showProfile: true,
                  showNotification: true,
                  showSettings: true,
                  showSearch: true,
                ),
              const SizedBox(height: 10),
              BillingScreenWidget(),
              SizedBox(height: baseVerticalSpace * 1.25),
            ],
          ),
        ),
      ),
    );
  }
}