import 'package:car_rental_project/Car%20Inventory/Car%20Directory/ReusableWidget/ButtonWidget.dart';
import 'package:car_rental_project/Car%20Inventory/Car%20Directory/CarInventoryController.dart';
import 'package:car_rental_project/Resources/Colors.dart';
import 'package:car_rental_project/Resources/IconStrings.dart';
import 'package:car_rental_project/Resources/TextTheme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:car_rental_project/Resources/AppSizes.dart';
import 'package:go_router/go_router.dart';

class CarListTableWidget extends StatelessWidget {
  CarListTableWidget({super.key});

  final controller = Get.put(CarInventoryController());

  final double columnWidth = 120.0;
  final double actionColumnWidth = 100.0;

  @override
  Widget build(BuildContext context) {
    final tablePadding = AppSizes.padding(context);

    return Obx(() {
      return Container(
        margin: EdgeInsets.all(tablePadding),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// ---------- TABLE HEADINGS ----------
              Container(
                padding: EdgeInsets.only(left: tablePadding, top: 12, bottom: 12),
                decoration: BoxDecoration(
                  color: AppColors.secondaryColor,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(AppSizes.borderRadius(context)),
                  ),
                ),
                child: Row(
                  children: [
                    _headerCell("VIN Number", context),
                    _headerCell("Car Registration", context),
                    _headerCell("Car Brand", context),
                    _headerCell("Car Make", context),
                    _headerCell("Car Model", context),
                    _headerCell("Car Year", context),
                    _headerCell("Body Type", context),
                    _headerCell("Car Status", context),
                    _headerCell("Car Transmission", context),
                    _headerCell("Car Capacity", context),
                    _headerCell("Fuel Type", context),
                    _headerCell("Engine Size", context),
                    _headerCell("Price List", context),
                    _headerCell("Action", context, isAction: true),
                  ],
                ),
              ),

              /// ---------- TABLE BODY ----------///

              Column(
                children: controller.displayedCarList.asMap().entries.map((entry) {
                  int rowIndex = entry.key;
                  var car = entry.value;

                  return Obx(() {
                    bool isHovered = controller.hoveredRowIndex.value == rowIndex;

                    final bool enableHover = !AppSizes.isMobile(context);

                    Widget rowContent = Container(
                      color: (enableHover && isHovered) ? Colors.white : Colors.transparent,
                      padding: EdgeInsets.only(left: tablePadding, top: 12, bottom: 12),
                      child: Row(
                        children: [
                          _dataCell(car["vin"] ?? "N/A", context),
                          _dataCell(car["reg"] ?? "N/A", context),
                          _dataCell(car["brand"] ?? "N/A", context),
                          _dataCell(car["make"] ?? "N/A", context),
                          _dataCell(car["model"] ?? "N/A", context),
                          _dataCell(car["year"] ?? "N/A", context),
                          _styledDataCell(car["bodyType"] ?? "N/A", context),
                          _statusDataCell(car["status"] ?? "N/A", context),
                          _styledDataCell(car["transmission"] ?? "N/A", context),
                          _dataCell(car["capacity"] ?? "N/A", context),
                          _dataCell(car["fuel"] ?? "N/A", context),
                          _dataCell(car["engine"] ?? "N/A", context),
                          _dataCell(car["price"] ?? "N/A", context),

                          /// ACTION BUTTON
                          SizedBox(
                            width: actionColumnWidth,
                            child: Center(
                              child: AddButton(
                                text: "View",
                                onTap: () {
                                  context.push('/cardetails', extra: {"hideMobileAppBar": true});
                                },
                                borderRadius: BorderRadius.circular(6),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );

                    if (enableHover) {
                      return MouseRegion(
                        onEnter: (_) => controller.hoveredRowIndex.value = rowIndex,
                        onExit: (_) => controller.hoveredRowIndex.value = -1,
                        cursor: SystemMouseCursors.click,
                        child: rowContent,
                      );
                    } else {
                      return rowContent;
                    }
                  });
                }).toList(),
              ),
            ],
          ),
        ),
      );
    });
  }

  /// --------- Extra Widgets ---------///

  // HEADER CELL Widget
  Widget _headerCell(String title, BuildContext context,
      {bool isAction = false}) {
    return SizedBox(
      width: isAction ? actionColumnWidth : columnWidth,
      child: Row(
        mainAxisAlignment: isAction
            ? MainAxisAlignment.center
            : MainAxisAlignment.start,
        children: [
          if (isAction) const Spacer(),
          Text(title, style: TTextTheme.smallXX(context)),
          const SizedBox(width: 6),
          Image.asset(
            IconString.sortIcon,
            color: AppColors.blackColor,
            height: 16,
            width: 16,
          ),
          if (isAction) const Spacer(),
        ],
      ),
    );
  }

  // DATA CELL Widget
  Widget _dataCell(String text, BuildContext context) {
    return SizedBox(
      width: columnWidth,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4.0),
        child: Text(
          text,
          style: TTextTheme.pOne(context),
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }

  // STATUS DATA CELL Widget
  Widget _statusDataCell(String text, BuildContext context) {
    Color statusColor = Colors.transparent;
    Color textColor = Colors.black;
    String status = text.toLowerCase();

    if (status == "available") {
      statusColor = AppColors.availableBackgroundColor;
      textColor = Colors.white;
    } else if (status == "maintenance") {
      statusColor = AppColors.maintenanceBackgroundColor;
      textColor = Colors.black;
    } else if (status == "unavailable") {
      statusColor = AppColors.sideBoxesColor;
      textColor = AppColors.secondTextColor;
    }

    return SizedBox(
      width: columnWidth,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4.0),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Container(
            padding: statusColor == Colors.transparent
                ? EdgeInsets.zero
                : const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: statusColor,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              text,
              style: TTextTheme.titleseven(context)?.copyWith(
                color: textColor,
              ),
            ),
          ),
        ),
      ),
    );
  }

  // STYLED DATA CELL Widget
  Widget _styledDataCell(String text, BuildContext context) {
    return SizedBox(
      width: columnWidth,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4.0),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: AppColors.secondaryColor,
              borderRadius: BorderRadius.circular(4),
              border: Border.all(color: AppColors.sideBoxesColor, width: 1),
            ),
            child: Text(
              text,
              overflow: TextOverflow.ellipsis,
              style: TTextTheme.pOne(context),
            ),
          ),
        ),
      ),
    );
  }
}