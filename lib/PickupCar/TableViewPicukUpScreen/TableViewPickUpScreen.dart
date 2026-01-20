import 'package:car_rental_project/PickupCar/PickupCarInventory.dart';
import 'package:car_rental_project/PickupCar/Reusable%20Widget/CarListHeaderPickupWidget.dart';
import 'package:car_rental_project/PickupCar/Reusable%20Widget/HeaderWebPickupWidget.dart';
import 'package:car_rental_project/PickupCar/Reusable%20Widget/PaginationBarOfPickup.dart';
import 'package:car_rental_project/PickupCar/TableViewPicukUpScreen/Widgets/cardListTablePickup.dart';
import 'package:car_rental_project/Resources/AppSizes.dart';
import 'package:car_rental_project/Resources/Colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';


class TableViewPickUpScreen extends StatelessWidget {
  TableViewPickUpScreen({super.key});

  final controller = Get.put(PickupCarController());

  @override
  Widget build(BuildContext context) {
    final isMobile = AppSizes.isMobile(context);
    final tablePadding = AppSizes.padding(context);
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
                HeaderWebPickupWidget(
                    mainTitle: 'Pickup Car',
                    showProfile: true,
                    showNotification: true,
                    showSettings: true,
                    showSearch: true,
                ),
              const SizedBox(height: 3),
              CardListHeaderPickupWidget(),
              const SizedBox(height: 4),
              CardListTablePickup(),
              PaginationBarOfPickup(isMobile: isMobile, tablePadding: tablePadding),
              SizedBox(height: baseVerticalSpace * 1.25),
            ],
          ),
        ),
      ),
    );
  }
}
