import 'package:car_rental_project/Car%20Inventory/Car%20Directory/ReusableWidget/HeaderWebWidget.dart';
import 'package:car_rental_project/Car%20Inventory/Car%20Directory/CarInventoryController.dart';
import 'package:car_rental_project/Customers/ReusableWidgetOfCustomers/CarListHeaderCustomersWidget.dart';
import 'package:car_rental_project/Customers/ReusableWidgetOfCustomers/PaginationBarOfCustomers.dart';
import 'package:car_rental_project/Customers/TableViewCustomerScreen/Widgets/CustomersLisTableWidget.dart';
import 'package:car_rental_project/Resources/AppSizes.dart';
import 'package:car_rental_project/Resources/Colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class TableViewCustomerScreen extends StatelessWidget {
  TableViewCustomerScreen({super.key});

  final controller = Get.put(CarInventoryController());

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
              if (AppSizes.isWeb(context)) HeaderWebWidget(mainTitle: 'Customers',showProfile: true,showNotification: true,showSettings: true,showSearch: true,),
              SizedBox(height: 3,),
              CardListHeaderCustomerWidget(),
              SizedBox(height: 2,),
              CustomerListTableWidget(),
              PaginationBarOfCustomers(isMobile: isMobile, tablePadding: tablePadding),
              SizedBox(height: baseVerticalSpace * 1.25),
            ],
          ),
        ),
      ),
    );
  }
}