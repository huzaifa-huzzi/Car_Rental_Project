import 'package:car_rental_project/Car%20Inventory/Car%20Directory/ReusableWidget/HeaderWebWidget.dart';
import 'package:car_rental_project/Car%20Inventory/Editing%20Car/Widgets/EditCarWidget.dart';
import 'package:car_rental_project/Resources/AppSizes.dart';
import 'package:flutter/material.dart';

class EditCarScreen extends StatelessWidget {
  const EditCarScreen({super.key});

  @override
  Widget build(BuildContext context) {


    final bool isMobile = AppSizes.isMobile(context);
    final bool isTablet = AppSizes.isTablet(context);
    final bool isWeb = AppSizes.isWeb(context);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
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
                  mainTitle: 'Edit Car',
                  showBack: true,
                  showSmallTitle: true,
                  smallTitle: 'Car/Edit Car',

                  /// Responsive Icons
                  showSearch: isWeb,
                  showSettings: isWeb,
                  showAddButton: false,
                  showNotification: true,
                  showProfile: true,
                ),

                SizedBox(height: AppSizes.verticalPadding(context) * 0.8),

                /// FORM AREA
                EditCarWidget(),

                SizedBox(height: AppSizes.verticalPadding(context) * 1),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
