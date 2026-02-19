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

  final double vinColumnWidth = 180.0;
  final double columnWidth = 140.0;
  final double actionColumnWidth = 130.0;

  @override
  Widget build(BuildContext context) {
    final tablePadding = AppSizes.padding(context);

    return Obx(() {
      return Container(
        margin: EdgeInsets.all(tablePadding),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// ---------- TABLE HEADINGS ----------
              Container(
                padding: EdgeInsets.only(
                    left: tablePadding,
                    right: tablePadding,
                    top: 9,
                    bottom: 12
                ),
                decoration: BoxDecoration(
                  color: AppColors.secondaryColor,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(AppSizes.borderRadius(context)),
                  ),
                ),
                child: Row(
                  children: [
                    _headerCell("Registration", context),
                    _headerCell("VIN Number", context, customWidth: vinColumnWidth),
                    _headerCell("Car Name", context),
                    _headerCell("Status", context),
                    _headerCell("Transmission", context),
                    _headerCell("Capacity", context),
                    _headerCell("Fuel Type", context),
                    _headerCell("Engine Size", context),
                    _headerCell("Rent Price", context),
                    _headerCell("Action", context, isAction: true),
                  ],
                ),
              ),

              /// ---------- TABLE BODY ----------
              Column(
                children: controller.displayedCarList.asMap().entries.map((entry) {
                  int rowIndex = entry.key;
                  var car = entry.value;

                  return Obx(() {
                    bool isHovered = controller.hoveredRowIndex.value == rowIndex;
                    final bool enableHover = !AppSizes.isMobile(context);

                    return MouseRegion(
                      onEnter: (_) => controller.hoveredRowIndex.value = rowIndex,
                      onExit: (_) => controller.hoveredRowIndex.value = -1,
                      cursor: SystemMouseCursors.click,
                      child: Container(
                        decoration: BoxDecoration(
                          color: (enableHover && isHovered) ? Colors.white : Colors.transparent,
                          border: Border(
                            bottom: BorderSide(color: AppColors.sideBoxesColor, width: 0.5),
                          ),
                        ),
                        padding: EdgeInsets.only(left: tablePadding, top: 12, bottom: 12),
                        child: Row(
                          children: [
                            _dataCell(car["reg"] ?? "N/A", context),
                            _dataCell(car["vin"] ?? "N/A", context, customWidth: vinColumnWidth),
                            _dataCell(car["carName"] ?? "N/A", context),
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
                      ),
                    );
                  });
                }).toList(),
              )
            ],
          ),
        ),
      );
    });
  }

  /// --------- Extra Widgets ---------///


   // header Cell Widget
  Widget _headerCell(String title, BuildContext context, {bool isAction = false, double? customWidth}) {
    return SizedBox(
      width: isAction ? actionColumnWidth : (customWidth ?? columnWidth),
      child: Row(
        mainAxisAlignment: isAction ? MainAxisAlignment.center : MainAxisAlignment.start,
        children: [
          Text(
            title,
            style: TTextTheme.smallXX(context),
          ),
          const SizedBox(width: 6),
          Image.asset(
            IconString.sortIcon,
            color: AppColors.blackColor,
            height: 12,
            width: 12,
          ),
        ],
      ),
    );
  }

  // data cell Widget
  Widget _dataCell(String text, BuildContext context, {double? customWidth}) {
    return SizedBox(
      width: customWidth ?? columnWidth,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4.0),
        child: Text(
          text,
          style: TTextTheme.pOne(context),
          softWrap: false,
          overflow: TextOverflow.visible,
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
              style: TTextTheme.titleseven(context).copyWith(
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