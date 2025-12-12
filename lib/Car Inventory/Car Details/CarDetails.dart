import 'package:car_rental_project/Car%20Inventory/Car%20Details/Widget/CarDetailWidget.dart';
import 'package:car_rental_project/Car%20Inventory/Car%20Directory/ReusableWidget/HeaderWebWidget.dart';
import 'package:car_rental_project/Resources/AppSizes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CarDetailsScreen extends StatelessWidget {
  const CarDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    bool isMobile = AppSizes.isMobile(context);

    Widget body = SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: AppSizes.horizontalPadding(context),
          vertical: AppSizes.verticalPadding(context),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// HEADER
            HeaderWebWidget(
              mainTitle: 'Car Details',
              showBack: true,
              showSmallTitle: true,
              smallTitle: 'Cars/Cars Details',
              showSearch: !isMobile,
              showSettings: !isMobile,
              showAddButton: true,
              showNotification: true,
              showProfile: true,
              onAddPressed: () {
                context.push(
                  '/addNewCar',
                  extra: {"hideMobileAppBar": true},
                );
              },
            ),

            SizedBox(height: AppSizes.verticalPadding(context) * 1.2),

            CarDetailBodyWidget(),
          ],
        ),
      ),
    );

    return Scaffold(
      body: SafeArea(child: body),
    );

  }
}