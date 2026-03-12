import 'package:car_rental_project/Portal/Vendor/DroppOffCar/DropOffController.dart';
import 'package:car_rental_project/Portal/Vendor/DroppOffCar/ReusableWidgetOfDropoff/HeaderWebDropOffWidget.dart';
import 'package:car_rental_project/Portal/Vendor/DroppOffCar/Subtabs/DropOffT&C/Widget/DropOffT&CWidget.dart';
import 'package:car_rental_project/Resources/AppSizes.dart';
import 'package:car_rental_project/Resources/Colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

class DropOffTandC extends StatelessWidget {
  const DropOffTandC({super.key});

  @override
  Widget build(BuildContext context) {
    if (!Get.isRegistered<DropOffController>()) {
      Get.put(DropOffController());
    }

    bool isWeb = AppSizes.isWeb(context);

    return Scaffold(
      backgroundColor: AppColors.backgroundOfScreenColor,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.all(AppSizes.horizontalPadding(context)),
                child: HeaderWebDropOffWidget(
                  mainTitle: 'DropOff T&C',
                  showBack: true,
                  showSmallTitle: true,
                  smallTitle: 'DropOff Car/DropOff T&C',
                  showSearch: isWeb,
                  showSettings: isWeb,
                  showAddButton: true,
                  showNotification: true,
                  showProfile: true,
                  onAddPressed: () {
                    context.push('/addDropOff', extra: {"hideMobileAppBar": true});
                  },
                ),
              ),

              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: AppSizes.horizontalPadding(context)
                ),
                child: const DropOffTandCWidget(),
              ),

              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}