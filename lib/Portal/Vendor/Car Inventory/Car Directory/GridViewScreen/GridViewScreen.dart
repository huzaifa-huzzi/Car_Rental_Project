import 'package:car_rental_project/Portal/Vendor/Car%20Inventory/Car%20Directory/CarInventoryController.dart';
import 'package:car_rental_project/Portal/Vendor/Car%20Inventory/Car%20Directory/GridViewScreen/Widgets/CarGridItem.dart';
import 'package:car_rental_project/Portal/Vendor/Car%20Inventory/Car%20Directory/ReusableWidget/PaginationWidget.dart';
import 'package:car_rental_project/Resources/AppSizes.dart';
import 'package:car_rental_project/Resources/ImageString.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' ;
import 'package:go_router/go_router.dart';


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

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<CarInventoryController>();

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

    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: isMobile
                ? baseVerticalSpace * 1.2
                : isTablet
                ? baseVerticalSpace * 0.9
                : baseVerticalSpace * 0.4,
          ),
          Obx(() {
            final cars = controller.displayedCarList;

            if (cars.isEmpty) {
              return const Center(
                child: Padding(
                  padding: EdgeInsets.all(50.0),
                  child: Text("No cars found in inventory"),
                ),
              );
            }

            return Padding(
              padding: EdgeInsets.symmetric(
                horizontal: AppSizes.horizontalPadding(context),
              ),
              child: GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: cars.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount,
                  mainAxisSpacing: baseVerticalSpace,
                  crossAxisSpacing: baseVerticalSpace,
                  mainAxisExtent: extent,
                ),
                itemBuilder: (context, index) {
                  final car = cars[index];
                  String currentImage = ImageString.bmwPic;
                  if (index == 0 && controller.currentPage.value == 1) currentImage = ImageString.astonPic;
                  if (index == 1 && controller.currentPage.value == 1) currentImage = ImageString.rangePic;
                  if (index == 2 && controller.currentPage.value == 1) currentImage = ImageString.audiPic;

                  return CarGridItem(
                    image: currentImage,
                    name: car['brand'] ?? "Unknown",
                    model: car['model'] ?? "2025",
                    transmission: car['transmission'] ?? "Auto",
                    capacity: car['capacity'] ?? "4 seats",
                    price: car['price'] ?? "0 / Weekly",
                    status: car['status'] ?? "Available",
                    regId: car['reg'] ?? "1234567890",
                    regId2: car['vin'] ?? "JTNBA3HK003001234",
                    fuelType: car['fuelType'] ?? "Petrol",
                    onView: () => context.go('/cardetails', extra: {"hideMobileAppBar": true}),
                  );
                },
              ),
            );
          }),

          SizedBox(height: baseVerticalSpace * 1.5),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: AppSizes.horizontalPadding(context)),
            child: PaginationBar(
                isMobile: isMobile,
                tablePadding: AppSizes.padding(context)
            ),
          ),

          SizedBox(height: baseVerticalSpace * 1.35),
        ],
      ),
    );
  }
}