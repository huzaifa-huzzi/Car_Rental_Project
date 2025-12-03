import 'package:car_rental_project/Car Inventory/Car Directory/CarDirectoryController.dart';
import 'package:car_rental_project/Car%20Inventory/Car%20Directory/ReusableWidget/ButtonWidget.dart';
import 'package:car_rental_project/Resources/Colors.dart';
import 'package:car_rental_project/Resources/TextTheme.dart';
import 'package:flutter/material.dart';
import 'package:car_rental_project/Resources/AppSizes.dart';
import 'package:car_rental_project/Resources/IconStrings.dart';
import 'package:get/get.dart';

class CardListHeaderWidget extends StatelessWidget {
  final VoidCallback? onFilter;
  final VoidCallback? onListView;
  final VoidCallback? onGridView;
  final VoidCallback? onGridModernView;

  CardListHeaderWidget({
    super.key,
    this.onFilter,
    this.onListView,
    this.onGridView,
    this.onGridModernView,
  });

  @override
  Widget build(BuildContext context) {
    bool isMobile = AppSizes.isMobile(context);
    final CarInventoryController controller = Get.put(CarInventoryController());
    final double buttonHeight = isMobile ? 38.0 : AppSizes.buttonHeight(context) * 0.8;

    return Column(
      children: [
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(
            horizontal: AppSizes.horizontalPadding(context),
            vertical: AppSizes.verticalPadding(context),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  // Search Box
                  Container(
                    width: isMobile ? 140 : AppSizes.buttonWidth(context) * 1.5,
                    height: buttonHeight,
                    padding: EdgeInsets.symmetric(
                      horizontal: AppSizes.padding(context) * 0.5,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                      BorderRadius.circular(AppSizes.borderRadius(context)),
                    ),
                    child: Row(
                      children: [
                        Image.asset(
                          IconString.searchIcon,
                          color: AppColors.secondTextColor,
                          width: 18,
                          height: 18,
                        ),
                        SizedBox(width: AppSizes.padding(context) * 0.4),
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

                  SizedBox(width: AppSizes.padding(context) * 0.75),

                  // FILTER BUTTON
                  Obx(() {
                    return _headerButton(
                      context: context,
                      icon: IconString.filterIcon,
                      text: "Filter",
                      isOpen: controller.isFilterOpen.value,
                      onTap: () {
                        controller.toggleFilter();
                        if (onFilter != null) onFilter!();
                      },
                    );
                  }),
                ],
              ),

              // RIGHT SECTION
              Obx(() {
                return Row(
                  children: [
                    _selectableIconButton(
                      context: context,
                      iconPath: IconString.previewOne,
                      isSelected: controller.selectedView.value == 0,
                      onTap: () {
                        controller.selectedView.value = 0;
                        if (onListView != null) onListView!();
                      },
                      size: isMobile ? 32.0 : buttonHeight * 0.85,
                    ),
                    _selectableIconButton(
                      context: context,
                      iconPath: IconString.previewTwo,
                      isSelected: controller.selectedView.value == 1,
                      onTap: () {
                        controller.selectedView.value = 1;
                        if (onGridView != null) onGridView!();
                      },
                      size: isMobile ? 32.0 : buttonHeight * 0.85,
                    ),
                    _selectableIconButton(
                      context: context,
                      iconPath: IconString.previewThree,
                      isSelected: controller.selectedView.value == 2,
                      onTap: () {
                        controller.selectedView.value = 2;
                        if (onGridModernView != null) onGridModernView!();
                      },
                      size: isMobile ? 32.0 : buttonHeight * 0.85,
                    ),
                    SizedBox(width: AppSizes.padding(context) * 0.4),
                    AddButton(
                        text: "Add Car",
                        onTap: (){})
                  ],
                );
              }),
            ],
          ),
        ),

        // FILTER AREA
        Obx(() {
          return controller.isFilterOpen.value
              ? _buildFilterContainer(context)
              : SizedBox();
        }),
      ],
    );
  }

  /// ----------Extra Widgets (used in the above code)----------///

  // Filter container
  Widget _buildFilterContainer(BuildContext context) {
    const int totalItems = 9;

    return LayoutBuilder(
      builder: (context, constraints) {
        double width = constraints.maxWidth;
        double wrapSpacing = AppSizes.padding(context);


        double dynamicPadding = AppSizes.padding(context);
        double horizontalMargin = AppSizes.horizontalPadding(context);

        if (AppSizes.isWeb(context)) {
          dynamicPadding = AppSizes.padding(context) * 1.5;
          horizontalMargin = AppSizes.horizontalPadding(context) * 1.5;
        }

        double containerPadding = dynamicPadding;

        int itemsPerRow;

        if (width > 1500) {
          itemsPerRow = totalItems;
        } else if (width > 1100) {
          itemsPerRow = 4;
        } else if (width > 700) {
          itemsPerRow = 3;
        } else if(width > 450 ) {
          itemsPerRow = 2;
        } else{
          itemsPerRow = 1;
        }

        double availableScreenWidth = width - (2 * horizontalMargin);

        double effectiveItemArea = availableScreenWidth - (2 * containerPadding);

        double totalSpacingInRow = (itemsPerRow - 1) * wrapSpacing;

        double itemWidth = (effectiveItemArea - totalSpacingInRow) / itemsPerRow;

        return Container(
          width: double.infinity,
          padding: EdgeInsets.all(containerPadding),
          margin: EdgeInsets.symmetric(horizontal: horizontalMargin, vertical: AppSizes.padding(context) * 0.5),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(AppSizes.borderRadius(context)),
          ),
          child: Wrap(
            spacing: wrapSpacing,
            runSpacing: AppSizes.padding(context) * 0.75,
            children: [
              _filterItem(
                "Car Brand",
                _dropdownBox(["BMW","Aston","Range Rover"], context),
                context,
                itemWidth: itemWidth,
              ),

              _filterItem("Car Model", _staticDisplayBox(["Corolla", "Civic"],context), context, itemWidth: itemWidth),
              _filterItem("Car Year", _staticDisplayBox(["2025", "2024"],context), context, itemWidth: itemWidth),
              _filterItem("Body Type", _staticDisplayBox(["Sedan", "SUV"],context), context, itemWidth: itemWidth),
              _filterItem("Car Status", _staticDisplayBox(["Available", "unavailbale"],context), context, itemWidth: itemWidth),
              _filterItem("Transmission", _staticDisplayBox(["Auto", "Manual"],context), context, itemWidth: itemWidth),
              _filterItem("Fuel", _staticDisplayBox(["Petrol", "Hybrid"],context), context, itemWidth: itemWidth),
              _filterItem("Engine Size", _textFieldBox("2.5[L]", context), context, itemWidth: itemWidth),
              _filterItem("Price (Under)", _textFieldBox(r"$ 1600 (W)", context), context, itemWidth: itemWidth),
            ],
          ),
        );
      },
    );
  }
   // filter Item
  Widget _filterItem(String title, Widget child, BuildContext context, {required double itemWidth}) {
    return SizedBox(
      width: itemWidth,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TTextTheme.btnFour(context),
          ),
          SizedBox(height: AppSizes.padding(context) * 0.3), // Responsive spacing
          child,
        ],
      ),
    );
  }

   // dropdown Widget
  Widget _dropdownBox(List<String> items,BuildContext context ,{bool isFunctional = false}) {
    final CarInventoryController controller = Get.find<CarInventoryController>();

    return Obx(() {

      String? selectedValue = controller.selectedBrand.value.isEmpty
          ? null
          : controller.selectedBrand.value;

      final double leftPadding = AppSizes.padding(context) * 0.5;


      return Container(
        height: 38,
        decoration: BoxDecoration(
          color: AppColors.secondaryColor,
          borderRadius: BorderRadius.circular(AppSizes.borderRadius(context) * 0.8), // Responsive border radius
        ),
        padding: EdgeInsets.symmetric(horizontal: leftPadding),
        child: DropdownButton<String>(

          value: selectedValue,
          underline: const SizedBox(),
          isExpanded: true,
          icon: Icon(Icons.keyboard_arrow_down, size: AppSizes.padding(context) * 0.8, color: AppColors.blackColor), // Using padding for size estimate
          dropdownColor: AppColors.secondaryColor,
          style: TTextTheme.titleTwo(context),
          hint: Container(
            alignment: Alignment.centerLeft,
            child: Text(
              "Toyota",
              style:  TTextTheme.titleTwo(context),
            ),
          ),

          items: items.asMap().entries.map((entry) {
            final int index = entry.key;
            final String e = entry.value;
            final bool isLastItem = index == items.length - 1;

            return DropdownMenuItem<String>(
              value: e,
              child: SizedBox(
                width: double.infinity,
                height: 48,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 0, bottom: 0),
                      child: Text(
                        e,
                        style: const TextStyle(fontSize: 13, color: AppColors.blackColor),
                      ),
                    ),

                    if (!isLastItem)
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: AppSizes.padding(context) * 0.2, horizontal: 0),
                        child: const Divider(
                          color: AppColors.quadrantalTextColor,
                          height: 1,
                          thickness: 1,
                          indent: 0,
                          endIndent: 0,
                        ),
                      ),
                  ],
                ),
              ),
            );
          }).toList(),

          onChanged: (v) {
            if (v != null) {
              controller.selectedBrand.value = v;
            }
          },

          selectedItemBuilder: (BuildContext context) {
            return items.map<Widget>((String item) {
              return Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  item,
                  style:  TTextTheme.titleTwo(context),
                ),
              );
            }).toList();
          },
        ),
      );
    });
  }
      // static display widget
  Widget _staticDisplayBox(List<String> items,BuildContext context) {
    final String staticText = items.first;

    return Container(
      width: double.infinity,
      height: 38,
      decoration: BoxDecoration(
        color: AppColors.secondaryColor,
        borderRadius: BorderRadius.circular(AppSizes.borderRadius(context) * 0.8),
      ),
      padding: EdgeInsets.symmetric(horizontal: AppSizes.padding(context) * 0.5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            staticText,
            style:  TTextTheme.titleTwo(context),
          ),
          Icon(Icons.keyboard_arrow_down, size: AppSizes.padding(context) * 0.8, color: AppColors.blackColor),
        ],
      ),
    );
  }

    // textField Widget
  Widget _textFieldBox(String label, BuildContext context) {
    return Container(
      width: double.infinity,
      height: 38,

      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppSizes.borderRadius(context) * 0.8),
        color: AppColors.secondaryColor,
      ),
      padding: EdgeInsets.symmetric(horizontal: AppSizes.padding(context) * 0.5),

      child: Center(
        child: TextField(
          style: TextStyle(color: AppColors.blackColor, fontSize: 13),
          decoration: InputDecoration(
            hintText: label,
            hintStyle: TTextTheme.titleTwo(context),
            border: InputBorder.none,
            isCollapsed: true,
            contentPadding: EdgeInsets.zero,
          ),
        ),
      ),
    );
  }

     // SelectedIconButton Widget
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
        margin: EdgeInsets.symmetric(horizontal: AppSizes.padding(context) * 0.1),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.textColor : Colors.white,
          borderRadius: BorderRadius.circular(AppSizes.borderRadius(context)),
        ),
        child: Center(
          child: Image.asset(
            iconPath,
            width: AppSizes.padding(context) * 0.75,
            height: AppSizes.padding(context) * 0.75,
            color: isSelected ? Colors.white : AppColors.blackColor,
          ),
        ),
      ),
    );
  }

  // Filter Button Widget
  Widget _headerButton({
    required BuildContext context,
    required String icon,
    required String text,
    required bool isOpen,
    VoidCallback? onTap,
  }) {
    bool isMobile = AppSizes.isMobile(context);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: AppSizes.padding(context) * 0.7, vertical: AppSizes.padding(context) * 0.5),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(AppSizes.borderRadius(context)),
          border: Border.all(
            color: isOpen ? AppColors.primaryColor : Colors.white,
          ),
        ),
        child: Row(
          children: [
            Image.asset(
              icon,
              width: AppSizes.padding(context) * 0.6,
              height: AppSizes.padding(context) * 0.6,
              color: isOpen ? AppColors.primaryColor : AppColors.secondTextColor ,
            ),
            if (!isMobile) ...[
              SizedBox(width: AppSizes.padding(context) * 0.4),
              Text(
                  text,
                  style: TTextTheme.btnTwo(context)?.copyWith(
                    color: isOpen ? AppColors.primaryColor : AppColors.secondTextColor,
                  )
              ),
            ],
            SizedBox(width: AppSizes.padding(context) * 0.3),
            Transform.rotate(
              angle: isOpen ? 3.14 : 0,
              child: Icon(
                Icons.keyboard_arrow_down,
                size: AppSizes.padding(context) * 0.65,
                color: isOpen ? AppColors.primaryColor : AppColors.secondTextColor ,
              ),
            ),
          ],
        ),
      ),
    );
  }
}