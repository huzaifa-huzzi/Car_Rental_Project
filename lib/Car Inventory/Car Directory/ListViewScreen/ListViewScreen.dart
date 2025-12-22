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
              regId: "HPC-982",
              regId2: "123-567",
              onView: () {
                context.push('/cardetails', extra: {"hideMobileAppBar": true});
              },
              onEdit: () {
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (_) => ResponsiveConfirmDialog(
                    type: DialogType.edit,
                    onCancel: () {
                    context.pop();
                    },
                    onConfirm: () {
                      context.pop();
                    },
                  ),
                );

              },
              onDelete: () {
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (_) => ResponsiveConfirmDialog(
                    type: DialogType.delete,
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
              regId: "HPC-982",
              regId2: "123-567",
              onView: () {
                context.push('/cardetails', extra: {"hideMobileAppBar": true});
              },
              onEdit: () {
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (_) => ResponsiveConfirmDialog(
                    type: DialogType.edit,
                    onCancel: () {
                      context.pop();
                    },
                    onConfirm: () {
                      context.pop();
                    },
                  ),
                );

              },
              onDelete: () {
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (_) => ResponsiveConfirmDialog(
                    type: DialogType.delete,
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
              name: "BMW",
              secondname: "LX3",
              model: "2023",
              transmission: "Automatic",
              capacity: "2 seats",
              price: "\$130/weekly",
              regId2: "123-567",
              status: "Available",
              regId: "HPC-982",
              onView: () {
                context.push('/cardetails', extra: {"hideMobileAppBar": true});
              },
              onEdit: () {
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (_) => ResponsiveConfirmDialog(
                    type: DialogType.edit,
                    onCancel: (){
                      context.pop();
                    },
                    onConfirm: () {
                      context.pop();
                    },
                  ),
                );

              },
              onDelete: () {
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (_) => ResponsiveConfirmDialog(
                    type: DialogType.delete,
                    onCancel: () => Navigator.pop(context),
                    onConfirm: () {
                      Navigator.pop(context);
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
              regId2: "123-567",
              status: "unavailable",
              regId: "HPC-982",
              onView: () {
                context.push('/cardetails', extra: {"hideMobileAppBar": true});
              },
              onEdit: () {
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (_) => ResponsiveConfirmDialog(
                    type: DialogType.edit,
                    onCancel: () => Navigator.pop(context),
                    onConfirm: () {
                      Navigator.pop(context);
                    },
                  ),
                );

              },
              onDelete: () {
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (_) => ResponsiveConfirmDialog(
                    type: DialogType.delete,
                    onCancel: () => Navigator.pop(context),
                    onConfirm: () {
                      Navigator.pop(context);
                    },
                  ),
                );

              },
            ),
            PaginationBar(isMobile: isMobile, tablePadding: tablePadding),
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
                    : isWeb ? 1400:1400,
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
