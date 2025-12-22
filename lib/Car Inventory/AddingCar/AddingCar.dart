import 'package:car_rental_project/Car%20Inventory/AddingCar/Widgets/AddCarFormWidget.dart';
import 'package:car_rental_project/Car%20Inventory/Car%20Directory/ReusableWidget/HeaderWebWidget.dart';
import 'package:car_rental_project/Resources/AppSizes.dart';
import 'package:flutter/material.dart';

class AddingCarScreen extends StatelessWidget {
  const AddingCarScreen({super.key});

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
                  mainTitle: 'Add New Car',
                  showBack: true,
                  showSmallTitle: true,
                  smallTitle: 'Car/Add car Details',

                  /// Responsive Icons
                  showSearch: isWeb,
                  showSettings: isWeb,
                  showAddButton: false,
                  showNotification: true,
                  showProfile: true,
                ),

                SizedBox(height: AppSizes.verticalPadding(context) * 1.2),

                /// FORM AREA
                AddCarFormWidget(),

                SizedBox(height: AppSizes.verticalPadding(context) * 2),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
