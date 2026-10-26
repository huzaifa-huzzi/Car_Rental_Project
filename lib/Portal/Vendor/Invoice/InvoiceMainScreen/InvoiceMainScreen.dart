import 'package:car_rental_project/Portal/Vendor/Invoice/InvoiceController.dart';
import 'package:car_rental_project/Portal/Vendor/Invoice/InvoiceMainScreen/InvoiceWidget.dart';
import 'package:car_rental_project/Portal/Vendor/Invoice/ReusableWidget/HeaderWebInvoiceWidget.dart';
import 'package:car_rental_project/Resources/AppSizes.dart';
import 'package:car_rental_project/Resources/Colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InvoiceScreen extends StatelessWidget {
  InvoiceScreen({super.key});

  final controller = Get.put(InvoiceController());

  @override
  Widget build(BuildContext context) {
    final isWeb = AppSizes.isWeb(context);

    return Scaffold(
      backgroundColor: AppColors.backgroundOfScreenColor,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: AppSizes.horizontalPadding(context),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (isWeb)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 24.0, top: 10),
                    child: HeaderWebInvoiceWidget(
                      mainTitle: 'Invoice Detail',
                      showProfile: true,
                      showNotification: true,
                      showSettings: true,
                    ),
                  ),

                const SizedBox(height: 10),

                const InvoiceWidget(),

                SizedBox(height: AppSizes.verticalPadding(context) * 4),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
