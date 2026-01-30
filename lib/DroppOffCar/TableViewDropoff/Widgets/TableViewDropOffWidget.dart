import 'package:car_rental_project/DroppOffCar/DropOffController.dart';
import 'package:car_rental_project/DroppOffCar/ReusableWidgetOfDropoff/PrimaryBtnDropOff.dart';
import 'package:car_rental_project/Resources/AppSizes.dart';
import 'package:car_rental_project/Resources/Colors.dart';
import 'package:car_rental_project/Resources/IconStrings.dart';
import 'package:car_rental_project/Resources/ImageString.dart';
import 'package:car_rental_project/Resources/TextTheme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';


class TableViewDropOffWidget extends StatelessWidget {
  TableViewDropOffWidget({super.key});

  final controller = Get.find<DropOffController>();

  final double nameColWidth = 220.0;
  final double vinColWidth = 180.0;
  final double regColWidth = 130.0;
  final double carRentWidth = 150.0;
  final double damageWidth = 100.0;
  final double dateWidth = 130.0;
  final double statusWidth = 120.0;
  final double actionWidth = 100.0;

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
              /// --- TABLE HEADINGS ---///
              Container(
                padding: EdgeInsets.symmetric(horizontal: tablePadding, vertical: 12),
                decoration: BoxDecoration(
                  color: AppColors.secondaryColor,
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
                ),
                child:
                Row(
                  children: [
                    _headerCell("Customer Name", context, customWidth: nameColWidth),
                    _headerCell("Vin Number", context, customWidth: vinColWidth),
                    _headerCell("Registration", context, customWidth: regColWidth),
                    _headerCell("Car Rent", context, customWidth: carRentWidth),

                    SizedBox(
                      width: damageWidth,
                      child: Center(child: _headerCell("Damage", context)),
                    ),

                    _headerCell("Dropoff Date", context, customWidth: dateWidth),

                    SizedBox(
                      width: statusWidth,
                      child: Center(child: _headerCell("Status", context)),
                    ),

                    SizedBox(
                      width: actionWidth,
                      child: Center(child: _headerCell("Action", context, isAction: true)),
                    ),
                  ],
                ),
              ),

              /// --- TABLE BODY ---///
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
                                      Text(car["customerEmail"] ?? "", style: TTextTheme.pFour(context), overflow: TextOverflow.ellipsis),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: vinColWidth, child: _dataCell(car["vin"] ?? "", context)),
                          SizedBox(width: regColWidth, child: _dataCell(car["reg"] ?? "", context)),
                          SizedBox(width: carRentWidth, child: _dataCell(car["carRent"] ?? "", context)),

                          SizedBox(
                            width: 60,
                            child: Center(
                              child: Container(
                                width: 60,
                                height: 26,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: car["damage"] == true ? AppColors.primaryColor: AppColors.availableBackgroundColor,
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Text(car["damage"] == true ? "Yes" : "No",
                                    style:TTextTheme.h10Style(context)),
                              ),
                            ),
                          ),
                           SizedBox(width: 40,),
                          SizedBox(
                            width: dateWidth,
                            child: Row(
                              children: [
                                Text("End  ", style: TTextTheme.smallX(context).copyWith(color: Colors.grey)),
                                Text(car["dropoffDate"] ?? "", style: TTextTheme.pOne(context)),
                              ],
                            ),
                          ),

                          SizedBox(
                            width: statusWidth,
                            child: Padding(
                              padding: EdgeInsets.only(right: 30),
                              child: _statusDataCell(car["status"] ?? "N/A", context, customWidth: 100),
                            ),
                          ),

                          SizedBox(
                            width: actionWidth,
                            child: Padding(
                              padding: EdgeInsetsGeometry.only(right: 30),
                              child: SizedBox(
                                child: PrimaryBthDropOff(
                                  text: "View",
                                  onTap: () => context.push('/dropOffDetail', extra: {"hideMobileAppBar": true}),
                                  borderRadius: BorderRadius.circular(6),
                                ),
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

  /// ------ Extra Widgets ------- ///

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

  Widget _dataCell(String text, BuildContext context, {double? customWidth}) {
    return SizedBox(
      width: customWidth,
      child: Text(text, style: TTextTheme.pOne(context), overflow: TextOverflow.ellipsis),
    );
  }

  Widget _statusDataCell(String text, BuildContext context, {required double customWidth}) {
    return SizedBox(
      width: customWidth,
      child: Container(
        margin: const EdgeInsets.only(right: 15),
        padding: const EdgeInsets.symmetric(vertical: 6),
        decoration: BoxDecoration(
          color: AppColors.textColor,
          borderRadius: BorderRadius.circular(4),
          border:Border.all(color: AppColors.tertiaryTextColor,width: 1),
        ),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: TTextTheme.titleeight(context),
        ),
      ),
    );
  }
}