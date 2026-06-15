import 'package:car_rental_project/Portal/Vendor/Reminder/ReminderScreen/widget/ReminderWidget.dart';
import 'package:car_rental_project/Portal/Vendor/Reminder/ReusableWidgetOfReminder/HeaderWebReminder.dart';
import 'package:car_rental_project/Resources/AppSizes.dart';
import 'package:car_rental_project/Resources/Colors.dart';
import 'package:flutter/material.dart';


class ReminderScreen extends StatelessWidget {
  const ReminderScreen({super.key}); // const add kar diya constructor par

  @override
  Widget build(BuildContext context) {
    final tablePadding = AppSizes.padding(context);
    final horizontalPadding = AppSizes.horizontalPadding(context);

    return Scaffold(
      backgroundColor: AppColors.backgroundOfScreenColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. Web Header Section
              if (AppSizes.isWeb(context)) ...[
                HeaderWebReminder(
                  mainTitle: 'Whatsapp',
                  showBack: true,
                  showSmallTitle: true,
                  smallTitle: "Whatsapp / Whatsapp Alerts",
                  showProfile: true,
                  showNotification: true,
                  showSettings: true,
                  showSearch: true,
                ),
                const SizedBox(height: 16),
              ],
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: tablePadding),
                  child: const ReminderWidget(), // const keyword laga rehne dein agar widget independent hai
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
