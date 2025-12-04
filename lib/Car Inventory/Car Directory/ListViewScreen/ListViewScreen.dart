import 'package:car_rental_project/Car%20Inventory/Car%20Directory/ListViewScreen/Widgets/CarListItemWidget.dart';
import 'package:car_rental_project/Car%20Inventory/Car%20Directory/ReusableWidget/PaginationWidget.dart';
import 'package:car_rental_project/Resources/ImageString.dart';
import 'package:flutter/material.dart';
import 'package:car_rental_project/Resources/AppSizes.dart';

class ListViewScreen extends StatelessWidget {
  const ListViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = AppSizes.isMobile(context);
    final isTab = AppSizes.isTablet(context);
    final needHorizontalScroll = isMobile || isTab;
    final tablePadding = AppSizes.padding(context);
    final baseVerticalSpace = AppSizes.verticalPadding(context);

    return LayoutBuilder(
      builder: (context, constraints) {
        Widget cardListContent = Column(
          children: [

            CarListCard(
              image: ImageString.astonPic,
              name: "Aston",
              secondname: "Matrin",
              model: "2025",
              transmission: "Automatic",
              capacity: "2 seats",
              price: "\$130 / weekly",
              status: "Available",
              regId: "HPC-982",
              onView: () {},
              onEdit: () {},
              onDelete: () {},
            ),

            CarListCard(
              image: ImageString.bmwPic,
              name: "Range Rover",
              secondname: "Velar",
              model: "2024",
              transmission: "Automatic",
              capacity: "2 seats",
              price: "\$130 / weekly",
              status: "Maintenance",
              regId: "HPC-982",
              onView: () {},
              onEdit: () {},
              onDelete: () {},
            ),

            CarListCard(
              image:ImageString.bmwPic ,
              name: "BMW",
              secondname: "LX3",
              model: "2023",
              transmission: "Automatic",
              capacity: "2 seats",
              price: "\$130/weekly",
              status: "Available",
              regId: "HPC-982",
              onView: () {},
              onEdit: () {},
              onDelete: () {},
            ),

            CarListCard(
              image: ImageString.audiPic,
              name: "Audi",
              secondname: "Q7",
              model: "2024",
              transmission: "Automatic",
              capacity: "2 seats",
              price: "\$130 / weekly",
              status: "unavailable",
              regId: "HPC-982",
              onView: () {},
              onEdit: () {},
              onDelete: () {},
            ),
            CarListCard(
              image: ImageString.astonPic,
              name: "Aston",
              secondname: "Matrin",
              model: "2025",
              transmission: "Automatic",
              capacity: "2 seats",
              price: "\$130 / weekly",
              status: "Available",
              regId: "HPC-982",
              onView: () {},
              onEdit: () {},
              onDelete: () {},
            ),


            PaginationBar(isMobile: isMobile, tablePadding: tablePadding),

            SizedBox(height: baseVerticalSpace * 1.25),
          ],
        );


        if (needHorizontalScroll) {
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: SizedBox(
              width: 900,
              child: cardListContent,
            ),
          );
        } else {
          return cardListContent;
        }
      },
    );
  }
}