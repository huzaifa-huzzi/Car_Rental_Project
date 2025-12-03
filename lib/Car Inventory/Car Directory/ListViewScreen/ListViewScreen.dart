import 'package:car_rental_project/Car%20Inventory/Car%20Directory/ListViewScreen/Widgets/CarListItemWidget.dart';
import 'package:car_rental_project/Car%20Inventory/Car%20Directory/ReusableWidget/CardListHeaderWidget.dart';
import 'package:car_rental_project/Car%20Inventory/Car%20Directory/ReusableWidget/HeaderWebWidget.dart';
import 'package:car_rental_project/Car%20Inventory/Car%20Directory/ReusableWidget/PaginationWidget.dart';
import 'package:car_rental_project/Resources/Colors.dart';
import 'package:car_rental_project/Resources/ImageString.dart';
import 'package:flutter/material.dart';
import 'package:car_rental_project/Resources/AppSizes.dart';

class ListViewScreen extends StatelessWidget {
  const ListViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = AppSizes.isMobile(context);
    final tablePadding = AppSizes.padding(context);
    final baseVerticalSpace = AppSizes.verticalPadding(context);

    return Column(
      children: [
        // --- Direct use of CarListItemWidget ---
        CarListItemWidget(
          carImage: ImageString.astonPic,
          carName: 'Aston Martin',
          carYear: '2025',
          transmission: 'Automatic',
          capacity: '2 seats',
          price: '\$130 /Weekly',
          status: 'Available',
          registrationId: 'HFC-052',
        ),
        CarListItemWidget(
          carImage: ImageString.rangePic,
          carName: 'Range Rover Velar',
          carYear: '2024',
          transmission: 'Automatic',
          capacity: '4 seats',
          price: '\$130 /Weekly',
          status: 'Available',
          registrationId: 'HFC-053',
        ),
        CarListItemWidget(
          carImage: ImageString.bmwPic,
          carName: 'BMW LX3',
          carYear: '2023',
          transmission: 'Automatic',
          capacity: '4 seats',
          price: '\$130 /Weekly',
          status: 'Available',
          registrationId: 'HFC-054',
        ),
        CarListItemWidget(
          carImage: ImageString.audiPic,
          carName: 'AUDI Q7',
          carYear: '2024',
          transmission: 'Automatic',
          capacity: '4 seats',
          price: '\$130 /Weekly',
          status: 'Available',
          registrationId: 'HFC-055',
        ),

        PaginationBar(isMobile: isMobile, tablePadding: tablePadding),

        SizedBox(height: baseVerticalSpace * 1.25),
      ],
    );
  }
}
