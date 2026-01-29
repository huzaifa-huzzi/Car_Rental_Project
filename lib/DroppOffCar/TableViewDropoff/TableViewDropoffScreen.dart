import 'package:car_rental_project/DroppOffCar/DropOffController.dart';
import 'package:car_rental_project/DroppOffCar/ReusableWidgetOfDropoff/HeaderWebDropOffWidget.dart';
import 'package:car_rental_project/DroppOffCar/ReusableWidgetOfDropoff/PaginationBarOfDropOff.dart';
import 'package:car_rental_project/DroppOffCar/TableViewDropoff/Widgets/TableViewDropOffWidget.dart';
import 'package:car_rental_project/Resources/AppSizes.dart';
import 'package:car_rental_project/Resources/Colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';


class TableViewDropOffScreen extends StatelessWidget {
  TableViewDropOffScreen({super.key});

  final controller = Get.put(DropOffController());

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
                if (AppSizes.isWeb(context))
                  HeaderWebDropOffWidget(
                    mainTitle: 'DropOff Car',
                    showProfile: true,
                    showNotification: true,
                    showSettings: true,
                    showSearch: true,
                    onAddPressed: () {
                      context.push(
                        '/addpickup',
                        extra: {"hideMobileAppBar": true},
                      );
                    },
                  ),
              const SizedBox(height: 3),
              const SizedBox(height: 4),
              TableViewDropOffWidget(),
              PaginationBarOfDropOff(isMobile: isMobile, tablePadding: tablePadding),
              SizedBox(height: baseVerticalSpace * 1.25),
            ],
          ),
        ),
      ),
    );
  }
}