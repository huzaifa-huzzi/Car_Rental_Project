import 'package:car_rental_project/Car%20Inventory/Car%20Directory/TableViewScreen/Widgets/CardListHeaderWidget.dart';
import 'package:car_rental_project/Car%20Inventory/Car%20Directory/TableViewScreen/Widgets/CardListTableWidget.dart';
import 'package:car_rental_project/Car%20Inventory/Car%20Directory/TableViewScreen/Widgets/HeaderWebWidget.dart';
import 'package:car_rental_project/Car%20Inventory/Car%20Directory/ReusableWidget/PaginationWidget.dart';
import 'package:car_rental_project/Resources/Colors.dart';
import 'package:flutter/material.dart';
import 'package:car_rental_project/Resources/AppSizes.dart';

class TableViewScreen extends StatelessWidget {
  const TableViewScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final isDesktopOrTablet = AppSizes.isWeb(context) || AppSizes.isTablet(context);
    final isMobile = AppSizes.isMobile(context);
    final tablePadding = AppSizes.padding(context);

    final baseVerticalSpace = AppSizes.verticalPadding(context);

    return Scaffold(
      backgroundColor: AppColors.backgroundOfScreenColor,
      body: Column(
        children: [
          if (isDesktopOrTablet)
            HeaderWebWidget(mainTitle: 'Cars'),
          if (isDesktopOrTablet)
            SizedBox(height: baseVerticalSpace * 0.5),

          CardListHeaderWidget(),

          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  CarListTableWidget(),

                  PaginationBar(isMobile: isMobile, tablePadding: tablePadding),


                  SizedBox(height: baseVerticalSpace * 1.25),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}