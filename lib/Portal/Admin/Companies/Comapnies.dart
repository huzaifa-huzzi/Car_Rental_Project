
import 'package:car_rental_project/Portal/Admin/Companies/CompaniesController.dart';
import 'package:car_rental_project/Portal/Admin/Companies/ReusableWidget/HeaderWebCompaniesWidget.dart';
import 'package:car_rental_project/Portal/Admin/Companies/Widget/CompaniesAdminWidget.dart';
import 'package:car_rental_project/Resources/AppSizes.dart';
import 'package:car_rental_project/Resources/Colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ComapaniesAdmin extends StatelessWidget {
  ComapaniesAdmin({super.key});

  final controller = Get.put(CompaniesAdminController());

  @override
  Widget build(BuildContext context) {
    final isMobile = AppSizes.isMobile(context);
    final tablePadding = AppSizes.padding(context);
    final horizontalPadding = AppSizes.horizontalPadding(context);
    final baseVerticalSpace = AppSizes.verticalPadding(context);

    return Scaffold(
      backgroundColor: AppColors.backgroundOfScreenColor,
      body: Center(
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
            child: Column(
              children: [
                if (AppSizes.isWeb(context))
                  if (AppSizes.isWeb(context))
                    HeaderWebCompaniesWidget(
                      mainTitle: 'Companies',
                      showProfile: true,
                      showNotification: true,
                      showSettings: true,
                      showSearch: true,
                    ),
                const SizedBox(height: 30),
                CompaniesAdminWidget(),
                SizedBox(height: baseVerticalSpace * 1.25),
              ],
            ),
          ),
        ),
      ),
    );
  }
}