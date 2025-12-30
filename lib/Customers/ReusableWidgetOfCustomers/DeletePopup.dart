import 'package:car_rental_project/Car%20Inventory/Car%20Directory/ReusableWidget/ButtonWidget.dart';
import 'package:car_rental_project/Car%20Inventory/Car%20Directory/ReusableWidget/customPrimaryButton.dart';
import 'package:car_rental_project/Customers/CustomersController.dart';
import 'package:car_rental_project/Resources/AppSizes.dart';
import 'package:car_rental_project/Resources/IconStrings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dotted_border/dotted_border.dart';
import '../../../Resources/Colors.dart';
import '../../../Resources/TextTheme.dart';

class CustomerDeletePopup extends StatelessWidget {
  CustomerDeletePopup({super.key});

  final controller = Get.find<CustomerController>();

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
                final bool isWeb = AppSizes.isWeb(context);
                final bool isMobile = AppSizes.isMobile(context);
                final screenwidth = MediaQuery.sizeOf(context).width;
                final bool isTablet = !isWeb && screenwidth >= 600;

                double buttonWidth = (overlayWidth / 2 - 8).clamp(200, double.infinity);

                return Container(
                  width: isWeb
                      ? overlayWidth * 0.75
                      : isTablet
                      ? overlayWidth * 0.85
                      : isMobile ? overlayWidth * 0.95:overlayWidth,
                  padding: EdgeInsets.all(AppSizes.padding(context)/2),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(
                      AppSizes.borderRadius(context),
                    ),
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
                          Text("Registration", style: TTextTheme.titleOne(context)),
                          const Spacer(),
                          Image.asset(IconString.symbol, width: 26, height: 26),
                          const SizedBox(width: 6),
                          Text("SoftShip", style: TTextTheme.h6Style(context)),
                        ],
                      ),

                      SizedBox(height: AppSizes.verticalPadding(context) / 2),

                      // Image Preview
                      Center(
                        child: SizedBox(
                          width: isWeb
                              ? 300
                              : isTablet
                              ? 270
                              : isMobile ? 230 :overlayWidth,
                          child: DottedBorder(
                            color: AppColors.primaryColor,
                            strokeWidth: 1,
                            dashPattern: const [6, 4],
                            borderType: BorderType.RRect,
                            radius: const Radius.circular(10),
                            child: Container(
                              height: AppSizes.cardHeight(context) + 80,
                              padding: const EdgeInsets.all(8),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.asset(
                                  controller.imagePath.value,
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),



                      SizedBox(height: AppSizes.verticalPadding(context)),

                      Center(
                        child: SizedBox(
                          width: AppSizes.isWeb(context) ? 260 : double.infinity,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Expanded(
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
                              Expanded(
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
                        ),
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
