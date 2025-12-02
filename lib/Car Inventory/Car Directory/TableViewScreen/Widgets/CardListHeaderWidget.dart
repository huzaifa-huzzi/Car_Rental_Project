import 'package:car_rental_project/Car%20Inventory/Car%20Directory/CarDirectoryController.dart';
import 'package:car_rental_project/Resources/Colors.dart';
import 'package:car_rental_project/Resources/TextTheme.dart';
import 'package:flutter/material.dart';
import 'package:car_rental_project/Resources/AppSizes.dart';
import 'package:car_rental_project/Resources/IconStrings.dart';
import 'package:car_rental_project/Car%20Inventory/Car%20Directory/ReusableWidget/ButtonWidget.dart';
import 'package:get/get.dart';

class CardListHeaderWidget extends StatelessWidget {
  final VoidCallback? onSearch;
  final VoidCallback? onFilter;
  final VoidCallback? onListView;
  final VoidCallback? onGridView;
  final VoidCallback? onGridModernView;
  final VoidCallback? onAddCar;

  CardListHeaderWidget({
    super.key,
    this.onSearch,
    this.onFilter,
    this.onListView,
    this.onGridView,
    this.onGridModernView,
    this.onAddCar,
  });


  @override
  Widget build(BuildContext context) {
    bool isMobile = AppSizes.isMobile(context);
    final CarInventoryController controller = Get.put(CarInventoryController());

    final double buttonHeight = isMobile ? 38.0 : 45.0;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: AppSizes.horizontalPadding(context),
        vertical: AppSizes.verticalPadding(context),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [

          /// LEFT SECTION
          Row(
            children: [
              Container(

                width: isMobile ? 140 : 300,
                height: buttonHeight,
                padding: EdgeInsets.symmetric(
                  horizontal: AppSizes.padding(context) * (isMobile ? 0.5 : 1.0),
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(
                    AppSizes.borderRadius(context),
                  ),
                ),


                child: Row(
                  children: [
                    Image.asset(IconString.searchIcon, color: AppColors.secondTextColor, width: 18, height: 18), // Icon size set

                    const SizedBox(width: 10),

                    Expanded(
                      child: TextField(
                          cursorColor: AppColors.blackColor,
                        style: TTextTheme.smallX(context),
                        decoration: InputDecoration(
                          isCollapsed: true,
                          contentPadding: EdgeInsets.zero,

                          hintText: "Search client name, car, etc",
                          hintStyle: TTextTheme.smallX(context),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ],
                ),
              ),


              SizedBox(width: AppSizes.padding(context) * (isMobile ? 0.5 : 1.0)),

              /// Filter Button
              _headerButton(
                context: context,
                icon: IconString.filterIcon,
                text: "Filter",
                onTap: onFilter,
              ),
            ],
          ),

          /// RIGHT SECTION
          Obx(() {
            return Row(
              children: [
                Container(
                  child: Row(
                    children: [
                      _selectableIconButton(
                        context: context,
                        iconPath: IconString.previewOne,
                        isSelected: controller.selectedView.value == 0,
                        onTap: () {
                          controller.selectedView.value = 0;
                          if (onListView != null) onListView!();
                        },
                        size: isMobile ? 32.0 : 38.0,
                      ),
                      _selectableIconButton(
                        context: context,
                        iconPath: IconString.previewTwo,
                        isSelected: controller.selectedView.value == 1,
                        onTap: () {
                          controller.selectedView.value = 1;
                          if (onGridView != null) onGridView!();
                        },
                        size: isMobile ? 32.0 : 38.0,
                      ),
                      _selectableIconButton(
                        context: context,
                        iconPath: IconString.previewThree,
                        isSelected: controller.selectedView.value == 2,
                        onTap: () {
                          controller.selectedView.value = 2;
                          if (onGridModernView != null) onGridModernView!();
                        },
                        size: isMobile ? 32.0 : 38.0,
                      ),
                    ],
                  ),
                ),

                SizedBox(width: AppSizes.padding(context) * (isMobile ? 0.5 : 1.0)),

                if (!isMobile)
                  AddButton(
                    text: "Add Car",
                    height: buttonHeight,
                    width: 120,
                    onTap: (){},
                  ),
              ],
            );
          }),
        ],
      ),
    );
  }


  /// SELECTABLE BUTTON
  Widget _selectableIconButton({
    required BuildContext context,
    required String iconPath,
    required bool isSelected,
    required VoidCallback onTap,
    double size = 38.0,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: size,
        height: size,
        margin: EdgeInsets.symmetric(horizontal: 1),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.textColor : Colors.white,
          borderRadius: BorderRadius.circular(AppSizes.borderRadius(context)),
        ),
        child: Center(
          child: Image.asset(
            iconPath,
            width: 16,
            height: 16,
            color: isSelected ? Colors.white : AppColors.blackColor,
          ),
        ),
      ),
    );
  }


  /// FILTER BUTTON
  Widget _headerButton({
    required BuildContext context,
    required String icon,
    required String text,
    VoidCallback? onTap,
  }) {
    bool isMobile = AppSizes.isMobile(context);

    return GestureDetector(
      onTap: onTap,
      child: Container(

        padding: isMobile
            ? const EdgeInsets.symmetric(horizontal: 10, vertical: 8)
            : EdgeInsets.symmetric(
          horizontal: AppSizes.padding(context),
          vertical: AppSizes.padding(context) * 0.6,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(
            AppSizes.borderRadius(context),
          ),
        ),
        child: Row(
          children: [
            Image.asset(icon, width: 14, height: 14, color: AppColors.secondTextColor),

            if (!isMobile) ...[
              const SizedBox(width: 9),
              Text(text, style: TTextTheme.btnTwo(context)),
            ],

            const SizedBox(width: 6),
            const Icon(Icons.keyboard_arrow_down, size: 16),
          ],
        ),
      ),
    );
  }


}
