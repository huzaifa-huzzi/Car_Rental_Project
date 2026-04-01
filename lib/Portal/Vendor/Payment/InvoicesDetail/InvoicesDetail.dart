import 'package:car_rental_project/Portal/Vendor/Payment/InvoicesDetail/Widget/InvoicesDetailWidget.dart';
import 'package:car_rental_project/Portal/Vendor/Payment/ReusableWidget/HeaderWebPaymentWidget.dart';
import 'package:car_rental_project/Resources/AppSizes.dart';
import 'package:car_rental_project/Resources/Colors.dart';
import 'package:flutter/material.dart';


class InvoicesDetail extends StatelessWidget {
  final Map invoiceData;
  const InvoicesDetail({super.key,required this.invoiceData});


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
                  showSmallTitle: true,
                  smallTitle: 'Payment / Add Payment',
                  showProfile:isWeb || isTab ? true : false,
                  showNotification: true,
                  showSettings: true,
                  showBack: true,
                ),
                const SizedBox(height: 40),
                InvoicesDetailWidget(data: invoiceData),
              ],
            ),
          ),
        ),
      ),
    );
  }
}