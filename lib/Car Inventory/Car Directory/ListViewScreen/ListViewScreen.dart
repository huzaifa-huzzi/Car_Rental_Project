import 'package:car_rental_project/Car%20Inventory/Car%20Directory/ListViewScreen/Widgets/CarListItemWidget.dart';
import 'package:car_rental_project/Car%20Inventory/Car%20Directory/ReusableWidget/AlertDialogs.dart';
import 'package:car_rental_project/Car%20Inventory/Car%20Directory/ReusableWidget/PaginationWidget.dart';
import 'package:car_rental_project/Resources/ImageString.dart';
import 'package:flutter/material.dart';
import 'package:car_rental_project/Resources/AppSizes.dart';
import 'package:go_router/go_router.dart';

class ListViewScreen extends StatelessWidget {
  const ListViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = AppSizes.isMobile(context);
    final isTab = AppSizes.isTablet(context);
    final isWeb = AppSizes.isWeb(context);
    final needHorizontalScroll = isMobile || isTab || isWeb;
    final tablePadding = AppSizes.padding(context);
    final baseVerticalSpace = AppSizes.verticalPadding(context);

    return LayoutBuilder(
      builder: (context, constraints) {
        Widget cardListContent = Column(
          children: [

            SizedBox(
              height: AppSizes.isMobile(context)
                  ? AppSizes.verticalPadding(context) * 1.2
                  : AppSizes.isTablet(context)
                  ? AppSizes.verticalPadding(context) * 0.9
                  : AppSizes.verticalPadding(context) * 0.4,
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
              regId: "1234567890",
              regId2: "JTNBA3HK003001234",
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
                    onCancel: () {
                      context.pop();
                    },
                    onConfirm: () {
                      context.pop();
                    },
                  ),
                );

              },
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
                regId: "1234567890",
                regId2: "JTNBA3HK003001234",
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
                    builder: (_) =>
                        ResponsiveDeleteDialog(
                          onCancel: () {
                            context.pop();
                          },
                          onConfirm: () {
                            context.pop();
                          },
                        ),
                  );
                }
            ),
            CarListCard(
              image: ImageString.bmwPic,
              name: "BMW",
              secondname: "LX3",
              model: "2023",
              transmission: "Automatic",
              capacity: "2 seats",
              price: "\$130/weekly",
              regId2: "JTNBA3HK003001234",
              status: "Available",
              regId: "1234567890",
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
                  builder: (_) =>
                      ResponsiveDeleteDialog(
                        onCancel: () {
                          context.pop();
                        },
                        onConfirm: () {
                          context.pop();
                        },
                      ),
                );
              },
            ),
            CarListCard(
              image: ImageString.audiPic,
              name: "Audi",
              secondname: "Q7",
              model: "2024",
              transmission: "Automatic",
              capacity: "2 seats",
              price: "\$130 / weekly",
              regId2: "JTNBA3HK003001234",
              status: "unavailable",
              regId: "1234567890",
              onView: () {
                context.push('/editCar', extra: {"hideMobileAppBar": true});
              },
              onEdit: () {

              },
              onDelete: () {
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (_) =>
                      ResponsiveDeleteDialog(
                        onCancel: () {
                          context.pop();
                        },
                        onConfirm: () {
                          context.pop();
                        },
                      ),
                );
              },
            ),
            Padding(
              padding: EdgeInsets.only(
                left: isMobile ? tablePadding : 0,
                right: tablePadding,
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


        if (needHorizontalScroll) {
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minWidth: constraints.maxWidth,
              ),
              child: SizedBox(
                width: isMobile
                    ? 900
                    : isTab
                    ? 1000
                    : isWeb ? 1100:1400,
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