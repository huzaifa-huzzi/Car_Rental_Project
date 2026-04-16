import 'package:car_rental_project/Portal/Admin/Companies/CompaniesController.dart';
import 'package:car_rental_project/Portal/Admin/Companies/CompanyDetail/Widget/CompanyDetailScreenWidget.dart';
import 'package:car_rental_project/Portal/Admin/Companies/ReusableWidget/HeaderWebCompaniesWidget.dart';
import 'package:flutter/material.dart';
import 'package:car_rental_project/Resources/AppSizes.dart';
import 'package:car_rental_project/Resources/Colors.dart';
import 'package:get/get.dart';

class CompaniesDetail extends StatelessWidget {
  CompaniesDetail({super.key});

  final controller = Get.put(CompaniesAdminController());

  @override
  Widget build(BuildContext context) {
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
                    HeaderWebCompaniesWidget(
                      mainTitle: 'Companies Detail',
                      showBack: true,
                      showProfile: true,
                      showNotification: true,
                      showSettings: true,
                      showSearch: false,
                    ),
                const SizedBox(height: 30),
                CompaniesDetailScreenWidget(),
                SizedBox(height: baseVerticalSpace * 1.25),
              ],
            ),
          ),
        ),
      ),
    );
  }
}