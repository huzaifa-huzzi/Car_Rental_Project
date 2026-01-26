import 'package:car_rental_project/PickupCar/EditPicUp/Widget/EditPickupWidget.dart';
import 'package:car_rental_project/PickupCar/PickUpDetailScreen/Widget/PickupCarDetailWidget.dart';
import 'package:car_rental_project/PickupCar/ReusableWidgetOfPickup/HeaderWebPickupWidget.dart';
import 'package:car_rental_project/Resources/AppSizes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class EditPickScreen extends StatelessWidget {
  const EditPickScreen({super.key});

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
                        mainTitle: 'Edit Pickup Car ',
                        showBack: true,
                        showSmallTitle: true,
                        smallTitle: 'Pickup Car Details/Edit Pickup Car',
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
                      EditPickupWidget(),
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
