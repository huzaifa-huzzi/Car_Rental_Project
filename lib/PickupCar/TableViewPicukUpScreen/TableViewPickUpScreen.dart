import 'package:car_rental_project/PickupCar/PickupCarInventory.dart';
import 'package:car_rental_project/PickupCar/Reusable%20Widget/CarListHeaderPickupWidget.dart';
import 'package:car_rental_project/PickupCar/Reusable%20Widget/HeaderWebPickupWidget.dart';
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
    final horizontalPadding = AppSizes.horizontalPadding(context);
    final isMobile = AppSizes.isMobile(context);
    final tablePadding = AppSizes.padding(context);
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
                    onAddPressed: () {
                      context.push(
                        '/addNewCustomer',
                        extra: {"hideMobileAppBar": true},
                      );
                    }
                ),
              SizedBox(height: 3,),
              CardListHeaderPickupWidget(),
              SizedBox(height: baseVerticalSpace * 1.25),
            ],
          ),
        ),
      ),
    );
  }
}
