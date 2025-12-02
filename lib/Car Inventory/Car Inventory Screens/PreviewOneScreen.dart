import 'package:car_rental_project/Car%20Inventory/Widgets/CardListHeaderWidget.dart';
import 'package:car_rental_project/Car%20Inventory/Widgets/CardListTableWidget.dart';
import 'package:car_rental_project/Car%20Inventory/Widgets/HeaderWebWidget.dart';
import 'package:flutter/material.dart';
import 'package:car_rental_project/Resources/AppSizes.dart';

class PreviewOneScreen extends StatelessWidget {
  const PreviewOneScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final isDesktopOrTablet = AppSizes.isWeb(context) || AppSizes.isTablet(context);

    return Scaffold(
      backgroundColor: Colors.grey.shade100,

      body: Column(
        children: [

          if (isDesktopOrTablet)
            HeaderWebWidget(mainTitle: 'Cars',),

          if (isDesktopOrTablet)
            const SizedBox(height: 10),

          /// 2. CAR LIST HEADER

          CardListHeaderWidget(
            onSearch: () {
              print("Search pressed");
            },
            onFilter: () {
              print("Filter pressed");
            },
            onListView: () {
              print("List view pressed");
            },
            onGridView: () {
              print("Grid view pressed");
            },
            onAddCar: () {
              print("Add car pressed");
            },
          ),

          /// 3. Screen Content
          CarListTableWidget(),
        ],
      ),
    );
  }
}