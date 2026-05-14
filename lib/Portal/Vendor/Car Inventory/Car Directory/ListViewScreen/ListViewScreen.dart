import 'package:car_rental_project/Portal/Vendor/Car%20Inventory/Car%20Directory/CarInventoryController.dart';
import 'package:car_rental_project/Portal/Vendor/Car%20Inventory/Car%20Directory/ListViewScreen/Widgets/CarListItemWidget.dart';
import 'package:car_rental_project/Portal/Vendor/Car%20Inventory/Car%20Directory/ReusableWidget/AlertDialogs.dart';
import 'package:car_rental_project/Portal/Vendor/Car%20Inventory/Car%20Directory/ReusableWidget/PaginationWidget.dart';
import 'package:car_rental_project/Resources/ImageString.dart';
import 'package:flutter/material.dart';
import 'package:car_rental_project/Resources/AppSizes.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

class ListViewScreen extends StatelessWidget {
  const ListViewScreen({super.key});

  @override
  @override
  Widget build(BuildContext context) {
    final isMobile = AppSizes.isMobile(context);
    final isTab = AppSizes.isTablet(context);
    final isWeb = AppSizes.isWeb(context);
    final needHorizontalScroll = isMobile || isTab || isWeb;
    final tablePadding = AppSizes.padding(context);
    final baseVerticalSpace = AppSizes.verticalPadding(context);
    // Controller link
    final controller = Get.find<CarInventoryController>();

    return LayoutBuilder(
      builder: (context, constraints) {
        Widget cardListContent = Obx(() {
          final cars = controller.displayedCarList;

          return Column(
            children: [
              SizedBox(
                height: isMobile
                    ? AppSizes.verticalPadding(context) * 1.2
                    : isTab
                    ? AppSizes.verticalPadding(context) * 0.9
                    : AppSizes.verticalPadding(context) * 0.4,
              ),

              if (cars.isEmpty)
                const Center(child: Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Text("No cars found"),
                ))
              else
              // Loop with index to maintain your original design for first items
                ...List.generate(cars.length, (index) {
                  var car = cars[index];

                  // --- EXACT DESIGN LOGIC ---
                  // Hum index check karenge taake exact wahi pics dikhein jo aapne pehle lagayi thin
                  String currentImage = ImageString.bmwPic; // Default
                  String currentName = car['brand'] ?? "";
                  String currentSecondName = car['carName'] ?? "";

                  if (index == 0 && controller.currentPage.value == 1) {
                    currentImage = ImageString.astonPic;
                    currentName = "Aston";
                    currentSecondName = "Martin";
                  } else if (index == 1 && controller.currentPage.value == 1) {
                    currentImage = ImageString.bmwPic; // Range Rover pic variant
                    currentName = "Range Rover";
                    currentSecondName = "Velar";
                  } else if (index == 2 && controller.currentPage.value == 1) {
                    currentImage = ImageString.bmwPic;
                    currentName = "BMW";
                    currentSecondName = "LX3";
                  } else if (index == 3 && controller.currentPage.value == 1) {
                    currentImage = ImageString.audiPic;
                    currentName = "Audi";
                    currentSecondName = "Q7";
                  }

                  return CarListCard(
                    image: currentImage, // Exact images as before
                    name: currentName,
                    secondname: currentSecondName,
                    model: car['model'] ?? "2025",
                    transmission: car['transmission'] ?? "Automatic",
                    capacity: car['capacity'] ?? "2 seats",
                    price: car['price'] ?? "\$130 / weekly",
                    status: car['status'] ?? "Available",
                    regId: car['reg'] ?? "1234567890",
                    regId2: car['vin'] ?? "JTNBA3HK003001234",
                    onView: () {
                      context.push('/cardetails', extra: {"hideMobileAppBar": true});
                    },
                    onEdit: () {
                      context.push('/editCar', extra: {"hideMobileAppBar": true});
                    },
                    onDelete: () {
                      showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (_) => ResponsiveDeleteDialog(
                          onCancel: () => context.pop(),
                          onConfirm: () => context.pop(),
                        ),
                      );
                    },
                  );
                }),

              // PAGINATION BAR
              Padding(
                padding: EdgeInsets.only(
                  left: isMobile ? tablePadding : 0,
                  right: tablePadding,
                  top: 20,
                ),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: PaginationBar(
                    isMobile: isMobile,
                    tablePadding: tablePadding,
                  ),
                ),
              ),

              SizedBox(height: baseVerticalSpace * 1.25),
            ],
          );
        });

        if (needHorizontalScroll) {
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: ConstrainedBox(
              constraints: BoxConstraints(minWidth: constraints.maxWidth),
              child: SizedBox(
                width: isMobile ? 900 : isTab ? 1000 : isWeb ? 1100 : 1400,
                child: cardListContent,
              ),
            ),
          );
        } else {
          return cardListContent;
        }
      },
    );
  }
}