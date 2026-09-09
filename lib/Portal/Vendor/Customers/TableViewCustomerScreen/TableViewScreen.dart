import 'package:car_rental_project/Portal/Vendor/Customers/CustomersController.dart';
import 'package:car_rental_project/Portal/Vendor/Customers/ReusableWidgetOfCustomers/CarListHeaderCustomersWidget.dart';
import 'package:car_rental_project/Portal/Vendor/Customers/ReusableWidgetOfCustomers/HeaderWebCustomersWidget.dart';
import 'package:car_rental_project/Portal/Vendor/Customers/ReusableWidgetOfCustomers/PaginationBarOfCustomers.dart';
import 'package:car_rental_project/Portal/Vendor/Customers/TableViewCustomerScreen/Widgets/CustomersLisTableWidget.dart';
import 'package:car_rental_project/Resources/AppSizes.dart';
import 'package:car_rental_project/Resources/Colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';




class TableViewCustomerScreen extends StatelessWidget {
  TableViewCustomerScreen({super.key});

  final controller = Get.put(CustomerController());

  @override
  Widget build(BuildContext context) {
    final horizontalPadding = AppSizes.horizontalPadding(context);
    final isMobile = AppSizes.isMobile(context);
    final tablePadding = AppSizes.padding(context);
    final baseVerticalSpace = AppSizes.verticalPadding(context);

    return Scaffold(
      backgroundColor: AppColors.backgroundOfScreenColor,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (AppSizes.isWeb(context)) ...[
                  HeaderWebCustomersWidget(
                    mainTitle: 'Customers',
                    showProfile: true,
                    showNotification: true,
                    showSettings: true,
                    showSearch: true,
                    onAddPressed: () {
                      context.push(
                        '/addNewCustomer',
                        extra: {"hideMobileAppBar": true},
                      );
                    },
                  ),
                  const SizedBox(height: 8),
                ],
                CardListHeaderCustomerWidget(),
                const SizedBox(height: 12),

                /// ---------- CUSTOMER TABLE ----------
                CustomerListTableWidget(),

                const SizedBox(height: 16),
                PaginationBarOfCustomer(
                  isMobile: isMobile,
                  tablePadding: tablePadding,
                ),
                SizedBox(height: baseVerticalSpace * 1.25),
              ],
            ),
          ),
        ),
      ),
    );
  }
}