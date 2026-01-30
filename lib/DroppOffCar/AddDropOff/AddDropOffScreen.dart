import 'package:car_rental_project/DroppOffCar/AddDropOff/Widget/AddDropOffWidget.dart';
import 'package:car_rental_project/DroppOffCar/ReusableWidgetOfDropoff/HeaderWebDropOffWidget.dart';
import 'package:car_rental_project/Resources/AppSizes.dart';
import 'package:flutter/material.dart';


class AddDropOffScreen extends StatelessWidget {
  const AddDropOffScreen({super.key});

  @override
  Widget build(BuildContext context) {
    bool isWeb = AppSizes.isWeb(context);

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Positioned.fill(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: AppSizes.horizontalPadding(context),
                    vertical: AppSizes.verticalPadding(context),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      HeaderWebDropOffWidget(
                        mainTitle: 'Add DropOff Car',
                        showBack: true,
                        showSmallTitle: true,
                        smallTitle: 'DropOff Car/Add DropOff Car',
                        showSearch: isWeb,
                        showSettings: isWeb,
                        showAddButton: false,
                        showNotification: true,
                        showProfile: true,
                      ),
                      SizedBox(height: AppSizes.verticalPadding(context) * 1.2),
                      AddDropOffWidget(),
                      SizedBox(height: AppSizes.verticalPadding(context) * 1.2),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
