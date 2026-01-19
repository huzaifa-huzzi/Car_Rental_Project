import 'package:car_rental_project/Customers/CustomersController.dart';
import 'package:car_rental_project/Customers/ReusableWidgetOfCustomers/AddButtonOfCustomers.dart';
import 'package:car_rental_project/Resources/Colors.dart';
import 'package:car_rental_project/Resources/IconStrings.dart';
import 'package:car_rental_project/Resources/ImageString.dart';
import 'package:car_rental_project/Resources/TextString.dart';
import 'package:car_rental_project/Resources/TextTheme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:car_rental_project/Resources/AppSizes.dart';
import 'package:go_router/go_router.dart';

class CustomerListTableWidget extends StatelessWidget {
  CustomerListTableWidget({super.key});

  final controller = Get.put(CustomerController());


  final double clientColWidth = 210.0;
  final double ageColWidth = 100.0;
  final double phoneColWidth = 150.0;
  final double addressColWidth = 200.0;
  final double licenseColWidth = 180.0;
  final double cardColWidth = 120.0;
  final double actionColWidth = 100.0;

  @override
  Widget build(BuildContext context) {
    final tablePadding = AppSizes.padding(context);
    final isMobile = AppSizes.isMobile(context);
    final baseVerticalSpace = AppSizes.verticalPadding(context);

    return Container(
      margin: EdgeInsets.all(tablePadding),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppSizes.borderRadius(context)),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// ---------- TABLE HEADINGS ----------
            Container(
              padding: EdgeInsets.only(left: tablePadding, top: 9, bottom: 12),
              decoration: BoxDecoration(
                color: AppColors.secondaryColor,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(AppSizes.borderRadius(context)),
                ),
              ),
              child: Row(
                children: [
                  _headerCell("Client", clientColWidth, context),
                  _headerCell("Age", ageColWidth, context),
                  _headerCell("Phone", phoneColWidth, context),
                  _headerCell("Address", addressColWidth, context),
                  _headerCell("License Details", licenseColWidth, context),
                  _headerCell("Linked Card", cardColWidth, context),
                  _headerCell("Action", actionColWidth, context, isAction: true),
                ],
              ),
            ),

            /// ---------- TABLE BODY ----------
            Column(
              children: controller.displayedCarList.asMap().entries.map((entry) {
                int rowIndex = entry.key;

                return Obx(() {
                  bool isHovered = controller.hoveredRowIndex.value == rowIndex;
                  final bool enableHover = !AppSizes.isMobile(context);

                  return MouseRegion(
                    onEnter: (_) => controller.hoveredRowIndex.value = rowIndex,
                    onExit: (_) => controller.hoveredRowIndex.value = -1,
                    cursor: SystemMouseCursors.click,
                    child: Container(
                      padding: EdgeInsets.only(left: tablePadding, top: 14, bottom: 14),
                      decoration: BoxDecoration(
                        color: (enableHover && isHovered) ? Colors.white :AppColors.backgroundOfScreenColor,
                        border: Border(
                          bottom: BorderSide(color: AppColors.sideBoxesColor, width: 0.5),
                        ),
                      ),
                      child: Row(
                        children: [
                          _clientDataCell(clientColWidth, context),
                          _dataCell("34 years", ageColWidth, context),
                          _dataCell("789-012-3456", phoneColWidth, context),
                          _dataCell("404 Spruce Road", addressColWidth, context),
                          _licenseDataCell(licenseColWidth, context),
                          _dataCell("2 Card", cardColWidth, context),

                          /// ACTION BUTTON
                          SizedBox(
                            width: actionColWidth,
                            child: Center(
                              child: AddButtonOfCustomer(
                                text: "View",
                                width: 71,
                                height: 34,
                                onTap: () {
                                  context.push('/customerDetails', extra: {"hideMobileAppBar": true});
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
  }

  /// --------- Refined Widgets for Spacing & Alignment ---------

  // header cell Widget
  Widget _headerCell(String title, double width, BuildContext context, {bool isAction = false}) {
    return SizedBox(
      width: width,
      child: Row(
        mainAxisAlignment: isAction ? MainAxisAlignment.center : MainAxisAlignment.start,
        children: [
          Text(
              title,
              style: TTextTheme.smallXX(context)),
          const SizedBox(width: 4),
          Image.asset(IconString.sortIcon),
        ],
      ),
    );
  }

  // data cell widget
  Widget _dataCell(String text, double width, BuildContext context) {
    return SizedBox(
      width: width,
      child: Text(
        text,
        style: TTextTheme.pOne(context))
    );
  }

   // client Data cell Widget
  Widget _clientDataCell(double width, BuildContext context) {
    return SizedBox(
      width: width,
      child: Row(
        children: [
          CircleAvatar(
            radius: 18,
            backgroundImage: AssetImage(ImageString.customerUser),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                   TextString.titlename,
                    style: TTextTheme.pOne(context)),
                Text(
                    TextString.Subtitlename,
                    style: TTextTheme.pFour(context)),
              ],
            ),
          ),
        ],
      ),
    );
  }

   // license Data Cell Widget
  Widget _licenseDataCell(double width, BuildContext context) {
    return SizedBox(
      width: width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Container(
                height: 18,
                width: 18,
                decoration: BoxDecoration(
                  color: AppColors.secondaryColor,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Center(
                  child: Image.asset(IconString.licenseIcon),
                ),
              ),
              const SizedBox(width: 6),
              Text(TextString.licenseNumber, style: TTextTheme.pOne(context)),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              Container(
                height: 18,
                width: 18,
                decoration: BoxDecoration(
                  color: AppColors.secondaryColor,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Center(
                  child: Image.asset(IconString.licenseIcon),
                ),
              ),
              const SizedBox(width: 6),
              Text(TextString.licenseDate, style: TTextTheme.pOne(context)),
            ],
          ),
        ],
      ),
    );
  }
}