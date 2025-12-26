import 'package:car_rental_project/Car%20Inventory/Car%20Directory/GridViewScreen/GridViewScreen.dart' show GridViewScreen;
import 'package:car_rental_project/Car%20Inventory/Car%20Directory/ListViewScreen/ListViewScreen.dart';
import 'package:car_rental_project/Car%20Inventory/Car%20Directory/ReusableWidget/CardListHeaderWidget.dart';
import 'package:car_rental_project/Car%20Inventory/Car%20Directory/ReusableWidget/HeaderWebWidget.dart';
import 'package:car_rental_project/Car%20Inventory/Car%20Directory/CarInventoryController.dart';
import 'package:car_rental_project/Car%20Inventory/Car%20Directory/TableViewScreen/TableViewScreen.dart';
import 'package:car_rental_project/Resources/AppSizes.dart';
import 'package:car_rental_project/Resources/Colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class CarInventoryMainScreen extends StatelessWidget {
  CarInventoryMainScreen({super.key});

  final controller = Get.put(CarInventoryController());

  @override
  Widget build(BuildContext context) {
    final horizontalPadding = AppSizes.horizontalPadding(context);

    return Scaffold(
      backgroundColor: AppColors.backgroundOfScreenColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
          child: Column(
            children: [
              if (AppSizes.isWeb(context)) HeaderWebWidget(mainTitle: 'Cars',showProfile: true,showNotification: true,showSettings: true,showSearch: true,),
              SizedBox(height: 3,),
              CardListHeaderWidget(),
              Obx(() {
                switch (controller.selectedView.value) {
                  case 0:
                    return const TableViewScreen();
                  case 1:
                    return const ListViewScreen();
                  case 2:
                    return const GridViewScreen();
                  default:
                    return const TableViewScreen();
                }
              }),
            ],
          ),
        ),
      ),
    );
  }
}



