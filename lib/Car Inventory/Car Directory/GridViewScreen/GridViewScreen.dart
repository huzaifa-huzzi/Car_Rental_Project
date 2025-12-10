import 'package:car_rental_project/Car%20Inventory/Car%20Directory/GridViewScreen/Widgets/CarGridItem.dart';
import 'package:car_rental_project/Car%20Inventory/Car%20Directory/ReusableWidget/PaginationWidget.dart';
import 'package:car_rental_project/Resources/AppSizes.dart';
import 'package:car_rental_project/Resources/ImageString.dart';
import 'package:flutter/material.dart';


final List<Map<String, String>> dummyCarData = [
  {
    'image': ImageString.astonPic,
    'name': 'Aston Martin',
    'model': '2025',
    'transmission': 'Automatic',
    'capacity': '2',
    'price': '120 /Weekly',
    'status': 'Available',
    'regId': 'NFC-053',
    'fuelType': 'Petrol',
  },
  {
    'image': ImageString.astonPic,
    'name': 'Range Rover Valar',
    'model': '2023',
    'transmission': 'Automatic',
    'capacity': '4',
    'price': '120 /Weekly',
    'status': 'Available',
    'regId': 'NFC-054',
    'fuelType': 'Petrol',
  },
  {
    'image': ImageString.audiPic,
    'name': 'Audi Q7',
    'model': '2022',
    'transmission': 'Automatic',
    'capacity': '6',
    'price': '120 /Weekly',
    'status': 'Maintenance',
    'regId': 'NFC-055',
    'fuelType': 'Petrol',
  },
  {
    'image': ImageString.rangePic,
    'name': 'Range Rover Valar',
    'model': '2023',
    'transmission': 'Automatic',
    'capacity': '4',
    'price': '120 /Weekly',
    'status': 'Available',
    'regId': 'NFC-052',
    'fuelType': 'Petrol',
  },
  {
    'image': ImageString.audiPic,
    'name': 'Audi Q7',
    'model': '2022',
    'transmission': 'Automatic',
    'capacity': '6',
    'price': '120 /Weekly',
    'status': 'Maintenance',
    'regId': 'NFC-052',
    'fuelType': 'Petrol',
  },
  {
    'image': ImageString.astonPic,
    'name': 'Aston Martin',
    'model': '2025',
    'transmission': 'Automatic',
    'capacity': '2',
    'price': '120 /Weekly',
    'status': 'Available',
    'regId': 'NFC-052',
    'fuelType': 'Petrol',
  },
];


class GridViewScreen extends StatelessWidget {
  const GridViewScreen({super.key});


  List<Widget> _buildCarGridItems() {
    return dummyCarData.map((car) {
      return CarGridItem(
        image: car['image']!,
        name: car['name']!,
        model: car['model']!,
        transmission: car['transmission']!,
        capacity: "${car['capacity']} seats",
        price: car['price']!,
        status: car['status']!,
        regId: car['regId']!,
        fuelType: car['fuelType']!,
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = AppSizes.isMobile(context);
    final tablePadding = AppSizes.padding(context);
    final baseVerticalSpace = AppSizes.verticalPadding(context);


    int crossAxisCount;
    double childAspectRatio;

    if (AppSizes.isWeb(context)) {
      crossAxisCount = 3;
      childAspectRatio = 0.85;
    } else if (AppSizes.isTablet(context)) {
      crossAxisCount = 2;
      childAspectRatio = 0.8;
    } else {
      crossAxisCount = 1;
      childAspectRatio = 1.8;
    }


    final carGridItems = _buildCarGridItems();

    return SingleChildScrollView(
      child: Column(
        children: [

          Padding(
            padding: EdgeInsets.symmetric(horizontal: AppSizes.horizontalPadding(context)),
            child: GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: crossAxisCount,
              mainAxisSpacing: baseVerticalSpace,
              crossAxisSpacing: baseVerticalSpace,
              childAspectRatio: childAspectRatio,
              children: carGridItems,
            ),
          ),

          SizedBox(height: baseVerticalSpace * 1.5),


          Padding(
            padding: EdgeInsets.symmetric(horizontal: AppSizes.horizontalPadding(context)),
            child: PaginationBar(isMobile: isMobile, tablePadding: tablePadding),
          ),
          SizedBox(height: baseVerticalSpace * 1.25),
        ],
      ),
    );
  }
}