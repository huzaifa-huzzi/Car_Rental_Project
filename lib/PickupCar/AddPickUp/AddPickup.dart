import 'package:car_rental_project/PickupCar/AddPickUp/Widget/SteponeWidget.dart';
import 'package:car_rental_project/PickupCar/ReusableWidgetOfPickup/HeaderWebPickupWidget.dart';
import 'package:car_rental_project/Resources/AppSizes.dart';
import 'package:flutter/material.dart';

class AddPickup extends StatelessWidget {
  const AddPickup({super.key});

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
                      HeaderWebPickupWidget(
                        mainTitle: 'Add Pickup Car ',
                        showBack: true,
                        showSmallTitle: true,
                        smallTitle: 'Pickup Car/Add Pickup Car',
                        showSearch: isWeb,
                        showSettings: isWeb,
                        showAddButton: false,
                        showNotification: true,
                        showProfile: true,
                      ),
                      SizedBox(height: AppSizes.verticalPadding(context) * 1.2),
                      StepOneSelectionWidget(),
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

