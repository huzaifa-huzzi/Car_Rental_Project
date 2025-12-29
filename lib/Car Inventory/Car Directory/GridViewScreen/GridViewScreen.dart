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
    'regId': '1234567890',
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
    'regId': '1234567890',
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
    'regId': '1234567890',
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
    'regId': '1234567890',
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
    'regId': '1234567890',
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
    'regId': '1234567890',
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
        regId2: 'JTNBA3HK003001234',
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = AppSizes.isMobile(context);
    final isTablet = AppSizes.isTablet(context);
    final baseVerticalSpace = AppSizes.verticalPadding(context);

    int crossAxisCount;
    double extent;

    if (AppSizes.isWeb(context)) {
      crossAxisCount = 3;
      extent = 360;
    } else if (isTablet) {
      crossAxisCount = 2;
      extent = 340;
    } else {
      crossAxisCount = 1;
      extent = 260;
    }

    final carGridItems = _buildCarGridItems();

    return SingleChildScrollView(
      child: Column(
        children: [
          // Top Spacing
          SizedBox(
            height: isMobile
                ? baseVerticalSpace * 1.2
                : isTablet
                ? baseVerticalSpace * 0.9
                : baseVerticalSpace * 0.4,
          ),

          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: AppSizes.horizontalPadding(context),
            ),
            child: GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: carGridItems.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
                mainAxisSpacing: baseVerticalSpace,
                crossAxisSpacing: baseVerticalSpace,
                mainAxisExtent: extent,
              ),
              itemBuilder: (context, index) => carGridItems[index],
            ),
          ),

          SizedBox(height: baseVerticalSpace * 1.5),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: AppSizes.horizontalPadding(context)),
            child: PaginationBar(isMobile: isMobile, tablePadding: AppSizes.padding(context)),
          ),
          SizedBox(height: baseVerticalSpace * 1.35),
        ],
      ),
    );
  }
}