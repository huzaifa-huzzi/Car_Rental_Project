import 'package:car_rental_project/Customers/EditCustomers/Widget/EditCustomerWidget.dart';
import 'package:car_rental_project/Customers/ReusableWidgetOfCustomers/DeletePopup.dart';
import 'package:car_rental_project/Customers/ReusableWidgetOfCustomers/HeaderWebCustomersWidget.dart';
import 'package:car_rental_project/Resources/AppSizes.dart';
import 'package:flutter/material.dart';

class EditCustomerScreen extends StatelessWidget {
  const EditCustomerScreen({super.key});

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
                      HeaderWebCustomersWidget(
                        mainTitle: 'Edit Customer',
                        showBack: true,
                        showSmallTitle: true,
                        smallTitle: 'Edit Customers/Edit Customer Details',
                        showSearch: isWeb,
                        showSettings: isWeb,
                        showAddButton: false,
                        showNotification: true,
                        showProfile: true,
                      ),
                      SizedBox(height: AppSizes.verticalPadding(context) * 1.2),
                       EditCustomerWidget(),
                    ],
                  ),
                ),
              ),
            ),

            Positioned.fill(
              child: CustomerDeletePopup(),
            ),
          ],
        ),
      ),
    );
  }
}
