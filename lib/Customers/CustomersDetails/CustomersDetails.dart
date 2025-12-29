import 'package:car_rental_project/Customers/CustomersDetails/Widget/CustomerDetailWidget.dart';
import 'package:car_rental_project/Customers/ReusableWidgetOfCustomers/DeletePopup.dart';
import 'package:car_rental_project/Customers/ReusableWidgetOfCustomers/HeaderWebCustomersWidget.dart';
import 'package:car_rental_project/Resources/AppSizes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomerDetails extends StatelessWidget {
  const CustomerDetails({super.key});

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
                        mainTitle: 'Customer',
                        showBack: true,
                        showSmallTitle: true,
                        smallTitle: 'Customer/Customer Details',
                        showSearch: isWeb,
                        showSettings: isWeb,
                        showAddButton: true,
                        showNotification: true,
                        showProfile: true,
                        onAddPressed: () {
                          context.push(
                            '/addNewCustomer',
                            extra: {"hideMobileAppBar": true},
                          );
                        },
                      ),
                      SizedBox(height: AppSizes.verticalPadding(context) * 1.2),
                      const CustomerDetailWidget(),
                    ],
                  ),
                ),
              ),
            ),

            Positioned.fill(
              child: CustomersDeletePopup(),
            ),
          ],
        ),
      ),
    );
  }
}
