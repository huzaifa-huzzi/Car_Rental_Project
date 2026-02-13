import 'package:car_rental_project/Resources/AppSizes.dart';
import 'package:car_rental_project/Resources/Colors.dart';
import 'package:car_rental_project/Staff/ReusableWidgetOfStaff/CardListStaffWidget.dart';
import 'package:car_rental_project/Staff/ReusableWidgetOfStaff/HeaderWebStaffWidget.dart';
import 'package:car_rental_project/Staff/ReusableWidgetOfStaff/PaginationBarOfStaff.dart';
import 'package:car_rental_project/Staff/StaffController.dart';
import 'package:car_rental_project/Staff/TableViewScreen/Widget/TableViewStaffScreenWidget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';


class TableViewOfStaffScreen extends StatelessWidget {
  TableViewOfStaffScreen({super.key});

  final controller = Get.put(StaffController());

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
                  HeaderWebStaffWidget(
                    mainTitle: 'List Staff',
                    showProfile: true,
                    showNotification: true,
                    showSettings: true,
                    showSearch: true,
                    onAddPressed: () {
                      context.push(
                        '/addStaff',
                        extra: {"hideMobileAppBar": true},
                      );
                    },
                  ),
              const SizedBox(height: 3),
              CardListStaffWidget(),
              const SizedBox(height: 4),
              TableViewStaffWidget(),
              PaginationBarOfStaff(isMobile: isMobile, tablePadding: tablePadding),
              SizedBox(height: baseVerticalSpace * 1.25),
            ],
          ),
        ),
      ),
    );
  }
}