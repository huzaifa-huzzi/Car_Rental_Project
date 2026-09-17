
import 'package:car_rental_project/Portal/Vendor/Customers/CustomersController.dart';
import 'package:car_rental_project/Resources/Colors.dart';
import 'package:car_rental_project/Resources/IconStrings.dart';
import 'package:car_rental_project/Resources/TextString.dart';
import 'package:car_rental_project/Resources/TextTheme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:car_rental_project/Resources/AppSizes.dart';
import 'package:go_router/go_router.dart';

class CustomerListTableWidget extends StatelessWidget {
  CustomerListTableWidget({super.key});

  final controller = Get.put(CustomerController());
  final double clientColWidth = 220.0;
  final double ageColWidth = 100.0;
  final double phoneColWidth = 140.0;
  final double addressColWidth = 200.0;
  final double licenseColWidth = 180.0;
  final double editReqColWidth = 140.0;
  final double cardColWidth = 110.0;
  final double actionColWidth = 140.0;

  final double fixedTablePadding = 16.0;

  double get totalTableWidth =>
      clientColWidth +
          ageColWidth +
          phoneColWidth +
          addressColWidth +
          licenseColWidth +
          editReqColWidth +
          cardColWidth +
          actionColWidth +
          (fixedTablePadding * 2);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        LayoutBuilder(
          builder: (context, constraints) {
            double containerWidth = constraints.maxWidth > totalTableWidth
                ? constraints.maxWidth
                : totalTableWidth;

            return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              child: Container(
                width: containerWidth,
                decoration: BoxDecoration(
                  color: AppColors.backgroundOfScreenColor,
                  borderRadius: BorderRadius.circular(AppSizes.borderRadius(context)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: containerWidth,
                      padding: EdgeInsets.symmetric(
                        horizontal: fixedTablePadding,
                        vertical: 12,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.secondaryColor,
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(AppSizes.borderRadius(context)),
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          _headerCell(TextString.customerTableOne, clientColWidth, context),
                          _headerCell(TextString.customerTableTwo, ageColWidth, context),
                          _headerCell(TextString.customerTableThree, phoneColWidth, context),
                          _headerCell(TextString.customerTableFour, addressColWidth, context),
                          _headerCell(TextString.customerTableFive, licenseColWidth, context),
                          _headerCell(TextString.customerTableSix, editReqColWidth, context),
                          _headerCell(TextString.customerTableSeven, cardColWidth, context),
                          _headerCell(TextString.header6payment, actionColWidth, context, isAction: true),
                        ],
                      ),
                    ),
                    Obx(() {
                      final customers = controller.displayedCarList;
                      final bool enableHover = !AppSizes.isMobile(context);

                      if (customers.isEmpty) {
                        return Container(
                          width: containerWidth,
                          padding: const EdgeInsets.all(32.0),
                          child: Center(
                            child: Text(
                              "No customers found",
                              style: TTextTheme.pOne(context),
                            ),
                          ),
                        );
                      }

                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        children: List.generate(customers.length, (rowIndex) {
                          return Obx(() {
                            bool isHovered = controller.hoveredRowIndex.value == rowIndex;

                            return MouseRegion(
                              onEnter: (_) {
                                WidgetsBinding.instance.addPostFrameCallback((_) {
                                  controller.hoveredRowIndex.value = rowIndex;
                                });
                              },
                              onExit: (_) {
                                WidgetsBinding.instance.addPostFrameCallback((_) {
                                  controller.hoveredRowIndex.value = -1;
                                });
                              },
                              cursor: SystemMouseCursors.click,
                              child: Container(
                                width: containerWidth,
                                padding: EdgeInsets.symmetric(
                                  horizontal: fixedTablePadding,
                                  vertical: 12,
                                ),
                                decoration: BoxDecoration(
                                  color: (enableHover && isHovered)
                                      ? Colors.white
                                      : AppColors.backgroundOfScreenColor,
                                  border: Border(
                                    bottom: BorderSide(
                                      color: AppColors.sideBoxesColor,
                                      width: 0.5,
                                    ),
                                  ),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    _clientDataCell(clientColWidth, context),
                                    _dataCell(TextString.customerTableAnswerOne, ageColWidth, context),
                                    _dataCell(TextString.customerTableAnswerTwo, phoneColWidth, context),
                                    _dataCell(TextString.customerTableAnswerThree, addressColWidth, context),
                                    _licenseDataCell(licenseColWidth, context),
                                    _statusBadgeCell(rowIndex, editReqColWidth, context),
                                    _dataCell(TextString.customerTableAnswerFour, cardColWidth, context),
                                    _actionDataCell(actionColWidth, context),
                                  ],
                                ),
                              ),
                            );
                          });
                        }),
                      );
                    }),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  // Header Cell
  Widget _headerCell(String title, double width, BuildContext context, {bool isAction = false}) {
    return SizedBox(
      width: width,
      child: InkWell(
        onTap: isAction ? null : () => controller.toggleSort(title),
        child: Row(
          mainAxisAlignment: isAction ? MainAxisAlignment.center : MainAxisAlignment.start,
          children: [
            Flexible(
              child: Text(
                title,
                style: TTextTheme.smallXX(context),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(width: 4),
            if (!isAction)
              Obx(() {
                bool isCurrent = controller.sortColumn.value == title;
                int order = isCurrent ? controller.sortOrder.value : 0;

                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ClipRect(
                      child: Align(
                        alignment: Alignment.topCenter,
                        heightFactor: 0.5,
                        child: Image.asset(
                          IconString.sortIcon,
                          height: 12,
                          color: order == 1
                              ? AppColors.primaryColor
                              : AppColors.secondTextColor,
                        ),
                      ),
                    ),
                    const SizedBox(height: 1),
                    ClipRect(
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        heightFactor: 0.5,
                        child: Image.asset(
                          IconString.sortIcon,
                          height: 12,
                          color: order == 2
                              ? AppColors.primaryColor
                              : AppColors.secondTextColor,
                        ),
                      ),
                    ),
                  ],
                );
              }),
          ],
        ),
      ),
    );
  }

  // data Cell
  Widget _dataCell(String text, double width, BuildContext context) {
    return SizedBox(
      width: width,
      child: Text(
        text,
        style: TTextTheme.pOne(context),
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  // Client Data Cell
  Widget _clientDataCell(double width, BuildContext context) {
    return SizedBox(
      width: width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            TextString.clientDataCellTitle,
            style: TTextTheme.pOne(context).copyWith(fontWeight: FontWeight.bold),
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 2),
          Text(
            TextString.clientDataCellSubtitle,
            style: TTextTheme.pFour(context),
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  // license Data Cell
  Widget _licenseDataCell(double width, BuildContext context) {
    return SizedBox(
      width: width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Image.asset(IconString.licenseIcon, height: 14, width: 14),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  "1234HGYTSA",
                  style: TTextTheme.pOne(context),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              Image.asset(IconString.licenseIcon, height: 14, width: 14),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  "12/2/2030",
                  style: TTextTheme.pOne(context),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }


  Widget _statusBadgeCell(int rowIndex, double width, BuildContext context) {
    List<String> mockStatuses = ["Can Edit", "Requested", "Updated", "No"];
    String status = mockStatuses[rowIndex % mockStatuses.length];

    Color badgeColor;
    if (status == "Can Edit") {
      badgeColor = AppColors.activeColor2;
    } else if (status == "Requested") {
      badgeColor = AppColors.pendingColor;
    } else if (status == "Updated") {
      badgeColor = AppColors.fourBackground;
    } else if (status == "No") {
      badgeColor = AppColors.Card1Color;
    } else {
      return SizedBox(
        width: width,
        child: Text("---------", style: TTextTheme.pOne(context)),
      );
    }

    return SizedBox(
      width: width,
      child: Align(
        alignment: Alignment.centerLeft,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
          decoration: BoxDecoration(
            color: badgeColor,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            status,
            style: TTextTheme.pFour(context)
                .copyWith(color: Colors.white, fontWeight: FontWeight.w400),
          ),
        ),
      ),
    );
  }

  Widget _actionDataCell(double width, BuildContext context) {
    return SizedBox(
      width: width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildActionButton(
            icon: Icons.remove_red_eye_outlined,
            onTap: () {
              context.go('/customerDetails', extra: {"hideMobileAppBar": true});
            },
          ),
          const SizedBox(width: 6),
          _buildActionButton(
            imageAsset: IconString.approvedIconTwo,
            icon: Icons.note_alt_outlined,
            onTap: () {
             showApproveRequestDialog(context);
            },
          ),
          const SizedBox(width: 6),

          _buildActionButton(
            imageAsset: IconString.tableEdit,
            onTap: () {
              context.go('/changeDetails');
            },
          ),
        ],
      ),
    );
  }
  Widget _buildActionButton({
    IconData? icon,
    String? imageAsset,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(6),
      child: Container(
        width: 28,
        height: 28,
        decoration: BoxDecoration(
          color: AppColors.primaryColor,
          borderRadius: BorderRadius.circular(6),
          boxShadow: [
            BoxShadow(
              color: AppColors.primaryColor.withValues(alpha: 0.25),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Center(
          child: imageAsset != null
              ? Image.asset(
            imageAsset,
            width: 15,
            height: 15,
            color: Colors.white,
          )
              : Icon(
            icon,
            size: 16,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  /// Dialogs
  void showApproveRequestDialog(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final bool isMobile = screenWidth < 600;

    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return Dialog(
          insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          backgroundColor: Colors.white,
          child: Container(
            constraints: const BoxConstraints(maxWidth: 480),
            padding: EdgeInsets.all(isMobile ? 16 : 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: const BoxDecoration(
                        color: AppColors.secondaryColor,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.close, size: 16, color: AppColors.blackColor),
                    ),
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: AppColors.emojiBackground,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      alignment: Alignment.center,
                      child: const Text('🤨', style: TextStyle(fontSize: 24)),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            TextString.customerDataDialogOne,
                            style: TTextTheme.h13Style(context).copyWith(
                              fontWeight: FontWeight.bold,
                              color: AppColors.textColor,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            TextString.customerDataDialogTwo,
                            style: TTextTheme.bodyRegular14(context).copyWith(
                              color: AppColors.secondTextColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 42,
                        child: OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            padding: EdgeInsets.zero,
                            side: const BorderSide(color: AppColors.primaryColor, width: 1.2),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                            showSuccessDialog(context);
                          },
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text(
                              'Save',
                              style: TTextTheme.btnSavePrimary(context),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: SizedBox(
                        height: 42,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.zero,
                            backgroundColor: AppColors.primaryColor,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          onPressed: () => Navigator.of(context).pop(),
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text(
                              'Cancel',
                              style: TTextTheme.btnSave(context),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void showSuccessDialog(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final bool isMobile = screenWidth < 600;

    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return Dialog(
          insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          backgroundColor: Colors.white,
          child: Container(
            constraints: const BoxConstraints(maxWidth: 440),
            padding: EdgeInsets.all(isMobile ? 16 : 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: const BoxDecoration(
                        color: AppColors.secondaryColor,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.close, size: 16, color: AppColors.blackColor),
                    ),
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: AppColors.emojiBackground,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      alignment: Alignment.center,
                      child: const Text('👍', style: TextStyle(fontSize: 24)),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            TextString.customerDataDialogThree,
                            style: TTextTheme.h13Style(context).copyWith(
                              fontWeight: FontWeight.bold,
                              color: AppColors.textColor,
                              height: 1.2,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            TextString.customerDataDialogFour,
                            style: TTextTheme.bodyRegular14(context).copyWith(
                              color: AppColors.secondTextColor,
                              height: 1.3,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}