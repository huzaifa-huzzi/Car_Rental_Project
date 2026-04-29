import 'package:car_rental_project/Portal/Vendor/PickupCar/PickupCarInventory.dart';
import 'package:car_rental_project/Portal/Vendor/PickupCar/ReusableWidgetOfPickup/HeaderWebPickupWidget.dart';
import 'package:car_rental_project/Portal/Vendor/PickupCar/Subtabs/Pickup%20T&C/Widget/PickupT&CWidget.dart';
import 'package:car_rental_project/Resources/AppSizes.dart';
import 'package:car_rental_project/Resources/Colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

class PickupTandC extends StatelessWidget {
  const PickupTandC({super.key});

  @override
  Widget build(BuildContext context) {
    if (!Get.isRegistered<PickupCarController>()) {
      Get.put(PickupCarController());
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
                child: HeaderWebPickupWidget(
                  mainTitle: 'Pickup T&C',
                  showBack: true,
                  showSmallTitle: true,
                  smallTitle: 'Pickup Car/Pickup T&C',
                  showSearch: isWeb,
                  showSettings: isWeb,
                  showAddButton: true,
                  showNotification: true,
                  showProfile: true,
                  onAddPressed: () {
                    context.go('/addpickup', extra: {"hideMobileAppBar": true});
                  },
                ),
              ),

              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: AppSizes.horizontalPadding(context)
                ),
                child: const PickupTandCWidget(),
              ),

              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}