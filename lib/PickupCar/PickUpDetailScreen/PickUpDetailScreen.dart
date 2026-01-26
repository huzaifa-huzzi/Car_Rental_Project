import 'package:car_rental_project/PickupCar/PickUpDetailScreen/Widget/PickupCarDetailWidget.dart';
import 'package:car_rental_project/PickupCar/ReusableWidgetOfPickup/HeaderWebPickupWidget.dart';
import 'package:car_rental_project/Resources/AppSizes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PickUpDetailScreen extends StatelessWidget {
  const PickUpDetailScreen({super.key});

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
                        mainTitle: 'Pickup Car Details',
                        showBack: true,
                        showSmallTitle: true,
                        smallTitle: 'Pickup Car/Pickup Car Details',
                        showSearch: isWeb,
                        showSettings: isWeb,
                        showAddButton: true,
                        showNotification: true,
                        showProfile: true,
                        onAddPressed: () {
                          context.push(
                          '/addpickup',
                            extra: {"hideMobileAppBar": true},
                          );
                        },
                      ),
                      SizedBox(height: AppSizes.verticalPadding(context) * 1.2),
                      PickupDetailWidget(),
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
