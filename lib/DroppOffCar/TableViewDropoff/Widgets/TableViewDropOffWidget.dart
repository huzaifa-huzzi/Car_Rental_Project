import 'package:car_rental_project/DroppOffCar/DropOffController.dart';
import 'package:car_rental_project/DroppOffCar/ReusableWidgetOfDropoff/PrimaryBtnDropOff.dart';
import 'package:car_rental_project/Resources/AppSizes.dart';
import 'package:car_rental_project/Resources/Colors.dart';
import 'package:car_rental_project/Resources/IconStrings.dart';
import 'package:car_rental_project/Resources/ImageString.dart';
import 'package:car_rental_project/Resources/TextString.dart';
import 'package:car_rental_project/Resources/TextTheme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';


class TableViewDropOffWidget extends StatelessWidget {
  TableViewDropOffWidget({super.key});

  final controller = Get.find<DropOffController>();

  final double carRentWidth = 160.0;
  final double regColWidth = 140.0;
  final double vinColWidth = 190.0;
  final double nameColWidth = 240.0;
  final double damageWidth = 110.0;
  final double dateWidth = 160.0;
  final double statusWidth = 100.0;
  final double actionWidth = 140.0;

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
              /// --- TABLE HEADINGS --- ///
              Container(
                padding: EdgeInsets.symmetric(horizontal: tablePadding, vertical: 12),
                decoration: BoxDecoration(
                  color: AppColors.secondaryColor,
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
                ),
                child: Row(
                  children: [
                    _headerCell(TextString.tableThreeRentDropOff, context, customWidth: carRentWidth),
                    _headerCell(TextString.tableThreeDropOff, context, customWidth: regColWidth),
                    _headerCell(TextString.tableTwoDropOff, context, customWidth: vinColWidth),
                    _headerCell(TextString.tableOneDropOff, context, customWidth: nameColWidth),

                    SizedBox(
                      width: damageWidth,
                      child: _headerCell("Damage", context),
                    ),

                    _headerCell(TextString.tableNineDropOff, context, customWidth: dateWidth),

                    SizedBox(
                      width: statusWidth,
                      child: Center(child: _headerCell(TextString.tableTenDropOff, context)),
                    ),

                    SizedBox(
                      width: actionWidth,
                      child: Center(child: _headerCell(TextString.tableElevenDropOff, context, isAction: true)),
                    ),
                  ],
                ),
              ),

              /// --- TABLE BODY --- ///
              Column(
                children: controller.carList3.asMap().entries.map((entry) {
                  int rowIndex = entry.key;
                  var car = entry.value;
                  bool isHovered = controller.hoveredRowIndex.value == rowIndex;

                  return MouseRegion(
                    onEnter: (_) => controller.hoveredRowIndex.value = rowIndex,
                    onExit: (_) => controller.hoveredRowIndex.value = -1,
                    child: Container(
                      decoration: BoxDecoration(
                        color: isHovered ? Colors.white : Colors.transparent,
                        border: Border(bottom: BorderSide(color: AppColors.sideBoxesColor, width: 0.5)),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: tablePadding, vertical: 10),
                      child: Row(
                        children: [
                          _dataCell(car["carRent"] ?? "", context, customWidth: carRentWidth),
                          _dataCell(car["reg"] ?? "", context, customWidth: regColWidth),
                          _dataCell(car["vin"] ?? "", context, customWidth: vinColWidth),

                          // Customer Info
                          SizedBox(
                            width: nameColWidth,
                            child: Row(
                              children: [
                                CircleAvatar(
                                  radius: 18,
                                  backgroundColor: AppColors.sideBoxesColor,
                                  backgroundImage: AssetImage(ImageString.userImage),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(car["customerName"] ?? "", style: TTextTheme.pOne(context), overflow: TextOverflow.ellipsis),
                                      Text(car["customerEmail"] ?? "", style: TTextTheme.pFour(context).copyWith(fontSize: 10), overflow: TextOverflow.ellipsis),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),

                          SizedBox(
                            width: damageWidth,
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Container(
                                width: 55,
                                height: 24,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: car["damage"] == true ? AppColors.primaryColor : AppColors.availableBackgroundColor,
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Text(
                                  car["damage"] == true ? "Yes" : "No",
                                  style: TTextTheme.h10Style(context).copyWith(color: Colors.white, fontSize: 11),
                                ),
                              ),
                            ),
                          ),

                          // Date
                          SizedBox(
                            width: dateWidth,
                            child: Row(
                              children: [
                                Text("End ", style: TTextTheme.smallX(context)),
                                Expanded(child: Text(car["dropoffDate"] ?? "", style: TTextTheme.pOne(context), overflow: TextOverflow.ellipsis)),
                              ],
                            ),
                          ),

                          // Status
                          SizedBox(
                            width: statusWidth,
                            child: Center(
                              child: _statusDataCell(car["status"] ?? "N/A", context, customWidth: 90),
                            ),
                          ),

                          // Action
                          SizedBox(
                            width: actionWidth,
                            child: Center(
                              child: PrimaryBthDropOff(
                                text: "View",
                                onTap: () => context.push('/dropOffDetail', extra: {"hideMobileAppBar": true}),
                                borderRadius: BorderRadius.circular(6),
                                width: 80,
                                height: 35,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              )
            ],
          ),
        ),
      );
    });
  }

   /// -------------- Extra Widget ------- ///
  //  Header Cell
  Widget _headerCell(String title, BuildContext context, {bool isAction = false, double? customWidth}) {
    return SizedBox(
      width: customWidth,
      child: Row(
        mainAxisAlignment: isAction ? MainAxisAlignment.center : MainAxisAlignment.start,
        children: [
          Text(title, style: TTextTheme.smallXX(context)),
          const SizedBox(width: 4),
          Image.asset(IconString.sortIcon, height: 10, color: AppColors.secondTextColor),
        ],
      ),
    );
  }

  //  Data Cell
  Widget _dataCell(String text, BuildContext context, {double? customWidth}) {
    return SizedBox(
      width: customWidth,
      child: Text(text, style: TTextTheme.pOne(context), overflow: TextOverflow.ellipsis),
    );
  }

  //  Status Data Cell
  Widget _statusDataCell(String text, BuildContext context, {required double customWidth}) {
    return Container(
      width: customWidth,
      padding: const EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        color: AppColors.textColor,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: AppColors.tertiaryTextColor, width: 0.5),
      ),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: TTextTheme.titleeight(context).copyWith(color: Colors.white, fontSize: 11),
      ),
    );
  }
}