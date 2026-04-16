import 'package:car_rental_project/Portal/Admin/Companies/AddCompany/Widget/AddCompanyWidget.dart';
import 'package:car_rental_project/Portal/Admin/Companies/ReusableWidget/HeaderWebCompaniesWidget.dart';
import 'package:car_rental_project/Resources/AppSizes.dart';
import 'package:car_rental_project/Resources/Colors.dart';
import 'package:flutter/material.dart';


class AddCompany extends StatelessWidget {
  const AddCompany({super.key});



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
                    HeaderWebCompaniesWidget(
                      mainTitle: 'Add Company',
                      showBack: true,
                      showProfile: true,
                      showNotification: true,
                      showSettings: true,
                      showSearch: false,
                    ),
                const SizedBox(height: 35),
                AddCompanyWidget(),
                SizedBox(height: baseVerticalSpace * 1.25),
              ],
            ),
          ),
        ),
      ),
    );
  }
}