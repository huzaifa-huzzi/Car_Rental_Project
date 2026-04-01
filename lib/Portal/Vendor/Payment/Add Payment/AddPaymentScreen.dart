import 'package:car_rental_project/Portal/Vendor/Payment/Add%20Payment/Widget/AddPaymentWidget.dart';
import 'package:car_rental_project/Portal/Vendor/Payment/ReusableWidget/HeaderWebPaymentWidget.dart';
import 'package:car_rental_project/Resources/AppSizes.dart';
import 'package:car_rental_project/Resources/Colors.dart';
import 'package:flutter/material.dart';


class AddPayment extends StatelessWidget {
  const AddPayment({super.key});


  @override
  Widget build(BuildContext context) {
    final isWeb = AppSizes.isWeb(context);
    final isTab = AppSizes.isTablet(context);
    return Scaffold(
      backgroundColor: AppColors.backgroundOfScreenColor,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: AppSizes.horizontalPadding(context)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                HeaderWebPaymentWidget(
                  mainTitle: 'Payment',
                  showProfile:isWeb || isTab ? true : false,
                  showNotification: true,
                  showSettings: true,
                  showBack: true,
                ),
                const SizedBox(height: 40),
                AddPaymentWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}