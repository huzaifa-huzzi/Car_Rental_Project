import 'package:car_rental_project/Portal/Vendor/Payment/paymentController.dart' show PaymentController;
import 'package:car_rental_project/Resources/Colors.dart';
import 'package:car_rental_project/Resources/TextTheme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PaymentScreen extends StatelessWidget {
  PaymentScreen({super.key});

  final controller = Get.put(PaymentController());

  @override
  Widget build(BuildContext context) {
    // final isWeb = MediaQuery.of(context).size.width > 1000;

    return Scaffold(
      backgroundColor: AppColors.backgroundOfScreenColor,
      body: SafeArea(
        child: Center(
          child: Text(
            'Coming Soon',
            style: TTextTheme.titleOne(context).copyWith(
              color: AppColors.blackColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        /*
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: AppSizes.horizontalPadding(context)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (isWeb)
                Padding(
                  padding: const EdgeInsets.only(bottom: 24.0, top: 10),
                  child: HeaderWebPaymentWidget(
                    mainTitle: 'Payment',
                    showProfile: true,
                    showNotification: true,
                    showSettings: true,
                  ),
                ),

              const SizedBox(height: 10),
              PaymentWidget(),
              SizedBox(height: AppSizes.verticalPadding(context) * 4),
            ],
          ),
        ),
      ),
      */
      ),
    );
  }
}

