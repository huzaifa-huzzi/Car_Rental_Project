import 'package:car_rental_project/Car%20Inventory/Car%20Directory/ReusableWidget/ButtonWidget.dart';
import 'package:car_rental_project/Car%20Inventory/Car%20Directory/ReusableWidget/customPrimaryButton.dart';
import 'package:car_rental_project/Resources/AppSizes.dart';
import 'package:car_rental_project/Resources/IconStrings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dotted_border/dotted_border.dart';
import '../../../Resources/Colors.dart';
import '../../../Resources/TextTheme.dart';
import '../../Car Directory/CarInventoryController.dart';

class CarDocumentPreviewOverlay extends StatelessWidget {
  CarDocumentPreviewOverlay({super.key});

  final controller = Get.find<CarInventoryController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (!controller.isOpen.value) return const SizedBox.shrink();

      double buttonHeight = AppSizes.buttonHeight(context) * 0.7;

      return Positioned.fill(
        child: Material(
          color: Colors.black.withOpacity(0.45),
          child: Center(
            child: LayoutBuilder(
              builder: (context, constraints) {
                double overlayWidth = constraints.maxWidth * 0.55;
                overlayWidth = overlayWidth.clamp(300, 700);

                double buttonWidth = (overlayWidth / 2 - 8).clamp(200, double.infinity);

                return Container(
                  width: overlayWidth,
                  padding: EdgeInsets.all(AppSizes.padding(context)),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(AppSizes.borderRadius(context)),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Align(
                        alignment: Alignment.topRight,
                        child: GestureDetector(
                          onTap: controller.close,
                          child: Image.asset(
                            IconString.crossIcon,
                            width: 18,
                            height: 18,
                          ),
                        ),
                      ),

                      SizedBox(height: AppSizes.verticalPadding(context) / 2),

                      // Title + Logo
                      Row(
                        children: [
                          Text(
                            "Registration",
                            style: TTextTheme.titleOne(context),
                          ),
                          const Spacer(),
                          Image.asset(
                            IconString.symbol,
                            width: 26,
                            height: 26,
                          ),
                          const SizedBox(width: 6),
                           Text(
                            "SoftShip",
                            style: TTextTheme.h6Style(context),
                          ),
                        ],
                      ),

                      SizedBox(height: AppSizes.verticalPadding(context) / 2),

                      // Image Preview
                      DottedBorder(
                        color: Colors.redAccent,
                        strokeWidth: 1,
                        dashPattern: const [6, 4],
                        borderType: BorderType.RRect,
                        radius: Radius.circular(10),
                        child: Container(
                          width: double.infinity,
                          height: AppSizes.cardHeight(context) + 100,
                          padding: EdgeInsets.all(12),
                          child: Center(
                            child: Image.asset(
                              controller.imagePath.value,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ),

                      SizedBox(height: AppSizes.verticalPadding(context)),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Flexible(
                            fit: FlexFit.tight,
                            child: CustomPrimaryButton(
                              text: "Print",
                              iconPath: IconString.printIcon,
                              onTap: () {},
                              height: buttonHeight,
                              backgroundColor: AppColors.iconsBackgroundColor,
                              borderColor: Colors.transparent,
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(5),
                                bottomLeft: Radius.circular(5),
                              ),
                            ),
                          ),
                          Flexible(
                            fit: FlexFit.tight,
                            child: AddButton(
                              text: "Download",
                              onTap: () {},
                              icon: Image.asset(
                                IconString.downloadIcon,
                                color: Colors.white,
                              ),
                              isIconLeft: true,
                              height: buttonHeight,
                              borderRadius: const BorderRadius.only(
                                topRight: Radius.circular(5),
                                bottomRight: Radius.circular(5),
                              ),
                            ),
                          ),
                        ],
                      ),

                    ],
                  ),
                );
              },
            ),
          ),
        ),
      );
    });
  }
}
