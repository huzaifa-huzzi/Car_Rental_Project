import 'package:car_rental_project/Car%20Inventory/Widgets/CardListHeaderWidget.dart';
import 'package:car_rental_project/Car%20Inventory/Widgets/CardListTableWidget.dart';
import 'package:car_rental_project/Car%20Inventory/Widgets/HeaderWebWidget.dart';
import 'package:car_rental_project/Car%20Inventory/Widgets/PaginationWidget.dart';
import 'package:car_rental_project/Resources/Colors.dart';
import 'package:flutter/material.dart';
import 'package:car_rental_project/Resources/AppSizes.dart';

class PreviewOneScreen extends StatelessWidget {
  const PreviewOneScreen({super.key});

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