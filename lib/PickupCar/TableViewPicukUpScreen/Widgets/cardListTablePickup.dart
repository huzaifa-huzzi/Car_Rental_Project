import 'package:car_rental_project/PickupCar/PickupCarInventory.dart';
import 'package:car_rental_project/PickupCar/ReusableWidgetOfPickup/AddButtonOfPickup.dart';
import 'package:car_rental_project/Resources/AppSizes.dart';
import 'package:car_rental_project/Resources/Colors.dart';
import 'package:car_rental_project/Resources/IconStrings.dart';
import 'package:car_rental_project/Resources/TextString.dart';
import 'package:car_rental_project/Resources/TextTheme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

class CardListTablePickup extends StatelessWidget {
  CardListTablePickup({super.key});

  final controller = Get.find<PickupCarController>();

  final double nameColumnWidth = 160.0;
  final double vinColumnWidth = 180.0;
  final double dateColumnWidth = 140.0;
  final double statusColumnWidth = 130.0;
  final double standardWidth = 100.0;
  final double actionColumnWidth = 90.0;

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
              ///  TABLE HEADINGS
              Container(
                padding: EdgeInsets.only(left: tablePadding, top: 12, bottom: 12),
                decoration: BoxDecoration(
                  color: AppColors.secondaryColor,
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
                ),
                child: Row(
                  children: [
                    _headerCell(TextString.tableOne, context, customWidth: nameColumnWidth),
                    _headerCell(TextString.tableTwo, context, customWidth: vinColumnWidth),
                    _headerCell(TextString.tableThree, context, customWidth: standardWidth),
                    _headerCell(TextString.tableFour, context, customWidth: standardWidth),
                    _headerCell(TextString.tableFive, context, customWidth: standardWidth),
                    _headerCell(TextString.tableSix, context, customWidth: 80),
                    _headerCell(TextString.tableSeven, context, customWidth: standardWidth ),
                    const SizedBox(width: 30),
                    _headerCell(TextString.tableEight, context, customWidth: standardWidth ),
                    const SizedBox(width: 35),
                    _headerCell(TextString.tableNine, context, customWidth: dateColumnWidth),
                    const SizedBox(width: 18),
                    _headerCell(TextString.tableTen, context, customWidth: statusColumnWidth),
                    const SizedBox(width: 12),
                    _headerCell(TextString.tableEleven, context, isAction: true, customWidth: actionColumnWidth),
                  ],
                ),
              ),

              ///  TABLE BODY
              Column(
                children: controller.displayedCarList.asMap().entries.map((entry) {
                  int rowIndex = entry.key;
                  var car = entry.value;

                  return Obx(() {
                    bool isHovered = controller.hoveredRowIndex.value == rowIndex;
                    return MouseRegion(
                      onEnter: (_) => controller.hoveredRowIndex.value = rowIndex,
                      onExit: (_) => controller.hoveredRowIndex.value = -1,
                      child: Container(
                        decoration: BoxDecoration(
                          color: isHovered ? Colors.white : Colors.transparent,
                          border: Border(bottom: BorderSide(color: AppColors.sideBoxesColor, width: 0.5)),
                        ),
                        padding: EdgeInsets.only(left: tablePadding, top: 10, bottom: 10),
                        child: Row(
                          children: [
                            _dataCell(car["customerName"]?.toString() ?? "Key Missing", context, customWidth: nameColumnWidth),
                            _dataCell(car["vin"]?.toString() ?? "Key Missing", context, customWidth: vinColumnWidth),
                            _dataCell(car["reg"]?.toString() ?? "Key Missing", context, customWidth: standardWidth),
                            _dataCell(car["make"]?.toString() ?? "Key Missing", context, customWidth: standardWidth),
                            _dataCell(car["model"]?.toString() ?? "Key Missing", context, customWidth: standardWidth),
                            _dataCell(car["year"]?.toString() ?? "-", context, customWidth: 80),
                            const SizedBox(width: 15),
                            _dataCell(car["rentPerWeek"]?.toString() ?? "-", context, customWidth: standardWidth ),
                            const SizedBox(width: 30),
                            _dataCell(car["rentalPeriod"]?.toString() ?? "-", context, customWidth: standardWidth ),
                            const SizedBox(width: 15),
                            _dateDataCell(
                                car["pickupStart"]?.toString() ?? "N/A",
                                car["pickupEnd"]?.toString() ?? "N/A",
                                context,
                                customWidth: dateColumnWidth
                            ),
                            const SizedBox(width: 15),
                            _statusDataCell(car["status"]?.toString() ?? "N/A", context, customWidth: statusColumnWidth),
                            const SizedBox(width: 8),
                            SizedBox(
                              width: actionColumnWidth,
                              child: Center(
                                child: AddButtonOfPickup(
                                  text: "View",
                                  onTap: () {
                                    context.push('/pickupDetail', extra: {"hideMobileAppBar": true});
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

  // Pickup dates cell Widget
  Widget _dateDataCell(String start, String end, BuildContext context, {required double customWidth}) {
    return SizedBox(
      width: customWidth,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [
            Text(TextString.dataCellStart, style: TTextTheme.smallX(context)),
            Text(start, style: TTextTheme.pOne(context)),
          ]),
          Row(children: [
            Text(TextString.dataCellStart, style: TTextTheme.titleFour(context)),
            Text(end, style: TTextTheme.pOne(context)),
          ]),
        ],
      ),
    );
  }

  // status data cells Widget
  Widget _statusDataCell(String text, BuildContext context, {required double customWidth}) {
    Color bgColor = AppColors.sideBoxesColor;
    Color textColor = AppColors.secondTextColor;
    Color borderColor = Colors.transparent;
    String status = text.toLowerCase();

    if (status == "completed") {
      bgColor = AppColors.textColor;
      textColor = Colors.white;
    } else if (status == "awaiting") {
      bgColor = AppColors.secondaryColor;
      textColor = AppColors.textColor;
    } else if (status == "overdue") {
      bgColor = AppColors.iconsBackgroundColor;
      textColor = AppColors.primaryColor;
    } else if (status == "processing") {
      bgColor = AppColors.iconsBackgroundColor;
      textColor = AppColors.primaryColor;
    }

    return SizedBox(
      width: customWidth,
      child: Align(
        alignment: Alignment.centerLeft,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: AppColors.sideBoxesColor),
          ),
          child: Text(
            text,
            style: TTextTheme.titleseven(context).copyWith(
              color: textColor,
            ),
          ),
        ),
      ),
    );
  }

   // header of table Widget Widget
  Widget _headerCell(String title, BuildContext context, {bool isAction = false, double? customWidth}) {
    return SizedBox(
      width: customWidth,
      child: Row(
        children: [
          Text(title, style: TTextTheme.smallXX(context)),
          const SizedBox(width: 4),
          Image.asset(IconString.sortIcon, height: 12, color: AppColors.secondTextColor),
        ],
      ),
    );
  }

  // table inside text Widget
  Widget _dataCell(String text, BuildContext context, {double? customWidth}) {
    return SizedBox(
      width: customWidth,
      child: Text(text, style: TTextTheme.pOne(context), overflow: TextOverflow.ellipsis),
    );
  }
}