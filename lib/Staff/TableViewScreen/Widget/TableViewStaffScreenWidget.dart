import 'package:car_rental_project/Resources/AppSizes.dart';
import 'package:car_rental_project/Resources/Colors.dart';
import 'package:car_rental_project/Resources/IconStrings.dart';
import 'package:car_rental_project/Resources/ImageString.dart';
import 'package:car_rental_project/Resources/TextTheme.dart';
import 'package:car_rental_project/Staff/ReusableWidgetOfStaff/PrimaryBtnStaff.dart';
import 'package:car_rental_project/Staff/ReusableWidgetOfStaff/StaffDeletePopup.dart';
import 'package:car_rental_project/Staff/StaffController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

class TableViewStaffWidget extends StatelessWidget {
  TableViewStaffWidget({super.key});

  final controller = Get.find<StaffController>();

  final double nameColWidth = 230.0;
  final double contactColWidth = 140.0;
  final double permissionColWidth = 505;
  final double positionWidth = 110.0;
  final double statusWidth = 160.0;
  final double actionWidth = 80.0;

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
                    _headerCell("Name", context, customWidth: nameColWidth),
                    _headerCell("Contact Number", context, customWidth: contactColWidth),
                    _headerCell("Access permission", context, customWidth: permissionColWidth),
                    _headerCell("Job Position", context, customWidth: positionWidth),
                    _headerCell("Status", context, customWidth: statusWidth),
                    _headerCell("Action", context, isAction: true, customWidth: actionWidth),
                  ],
                ),
              ),

              /// --- TABLE BODY --- ///
              Column(
                children: controller.carList3.asMap().entries.map((entry) {
                  int rowIndex = entry.key;
                  var staff = entry.value;
                  bool isHovered = controller.hoveredRowIndex.value == rowIndex;
                  List<String> permissionsList = ["Car Inventory", "Customers", "Pickup Car", "Dropoff Car"];
                  List<String> displayPermissions;
                  int patternIndex = rowIndex % 3;
                  if (patternIndex == 0) {
                    displayPermissions = permissionsList;
                  } else if (patternIndex == 1) displayPermissions = permissionsList.sublist(0, 2);
                  else displayPermissions = permissionsList.sublist(0, 1);

                  String currentStatus = (patternIndex == 0) ? "Active" : (patternIndex == 1) ? "Inactive" : "Suspended";

                  return MouseRegion(
                    onEnter: (_) => controller.hoveredRowIndex.value = rowIndex,
                    onExit: (_) => controller.hoveredRowIndex.value = -1,
                    child: Container(
                      decoration: BoxDecoration(
                        color: isHovered ? Colors.white : Colors.transparent,
                        border: Border(bottom: BorderSide(color: AppColors.sideBoxesColor, width: 0.5)),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: tablePadding, vertical: 12),
                      child: Row(
                        children: [
                          //  Name & Email
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
                                      Text(staff["name"] ?? "Jack Morrison", style: TTextTheme.pOne(context)),
                                      Text(staff["email"] ?? "jackmorrison@rhyta.com", style: TTextTheme.pFour(context).copyWith(fontSize: 10)),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),

                          //  Contact Number
                          SizedBox(width: contactColWidth, child: _dataCell(staff["contact"] ?? "058654312338", context)),

                          //  Access Permission
                          SizedBox(
                            width: permissionColWidth,
                            child: Row(
                              children: displayPermissions.map((text) => Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: PrimaryBtnStaff(
                                  text: text,
                                  onTap: () => _navigateToModule(text, context),
                                  height: 38,
                                  width: text.length * 8.5 + 21,
                                  borderRadius: BorderRadius.circular(6),
                                ),
                              )).toList(),
                            ),
                          ),

                          //  Job Position
                          SizedBox(width: positionWidth, child: _dataCell("Manager", context)),

                          //  Status & Resend
                          SizedBox(
                            width: statusWidth,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                _statusDataCell(currentStatus, context),
                                if (currentStatus == "Inactive") ...[
                                  const SizedBox(width: 12),
                                  GestureDetector(
                                    onTap: () {},
                                    child: Text(
                                      "Resend",
                                      style:TTextTheme.resendText(context).copyWith(
                                        decoration: TextDecoration.underline,
                                        decorationColor: AppColors.primaryColor,
                                        decorationThickness:1,
                                      ),
                                    ),
                                  ),
                                ]
                              ],
                            ),
                          ),

                          //  Action
                          SizedBox(
                            width: actionWidth,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(IconString.editIcon2,color: AppColors.primaryColor,),
                                const SizedBox(width: 15),
                                GestureDetector(
                                  onTap: () {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return ResponsiveDeleteStaffDialog(
                                          onCancel: () {
                                            context.pop();
                                          },
                                          onConfirm: () {
                                            context.pop();
                                          },
                                        );
                                      },
                                    );
                                  },
                                  child: Image.asset(
                                    IconString.deleteIcon,
                                    color: AppColors.primaryColor,
                                  ),
                                )

                              ],
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

  /// -------------- Extra Widgets ----------- ///

  // Header Cell
  Widget _headerCell(String title, BuildContext context, {bool isAction = false, double? customWidth}) {
    return SizedBox(
      width: customWidth,
      child: Row(
        mainAxisAlignment: isAction ? MainAxisAlignment.center : MainAxisAlignment.start,
        children: [
          Text(title, style: TTextTheme.smallXX(context)),
          const SizedBox(width: 4),
          if (!isAction) Image.asset(IconString.sortIcon, height: 10, color: AppColors.secondTextColor),
        ],
      ),
    );
  }

   // Data cell
  Widget _dataCell(String text, BuildContext context) {
    return Text(text, style: TTextTheme.pOne(context), overflow: TextOverflow.ellipsis);
  }
   // Status Data cell
  Widget _statusDataCell(String status, BuildContext context) {
    Color bgColor;
    Color textColor;

    switch (status) {
      case "Active":
        bgColor = AppColors.textColor;
        textColor = Colors.white;
        break;
      case "Inactive":
        bgColor = AppColors.secondaryColor;
        textColor = AppColors.textColor;
        break;
      case "Suspended":
        bgColor = AppColors.backgroundOfPickupsWidget;
        textColor = AppColors.primaryColor;
        break;
      default:
        bgColor = Colors.grey;
        textColor = Colors.white;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: AppColors.sideBoxesColor),
      ),
      child: Text(
        status,
        style: TTextTheme.pFour(context).copyWith(
          color: textColor,
        ),
      ),
    );
  }

   // Navigation Through Buttons
  void _navigateToModule(String moduleName, BuildContext context) {
    switch (moduleName) {
      case "Car Inventory":
        context.push('/carInventory');
        break;
      case "Customers":
        context.push('/customers');
        break;
      case "Pickup Car":
        context.push('/pickupcar');
        break;
      case "Dropoff Car":
        context.push('/dropoffCar');
        break;
      default:
        print("No route defined for $moduleName");
    }
  }
}