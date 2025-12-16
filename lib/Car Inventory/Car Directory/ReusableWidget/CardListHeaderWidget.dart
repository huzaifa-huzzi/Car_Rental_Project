import 'package:car_rental_project/Car%20Inventory/Car%20Directory/ReusableWidget/ButtonWidget.dart';
import 'package:car_rental_project/Car%20Inventory/Car%20Directory/CarInventoryController.dart';
import 'package:car_rental_project/Resources/Colors.dart';
import 'package:car_rental_project/Resources/TextTheme.dart';
import 'package:flutter/material.dart';
import 'package:car_rental_project/Resources/AppSizes.dart';
import 'package:car_rental_project/Resources/IconStrings.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

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
    bool isWeb = AppSizes.isWeb(context);

    final CarInventoryController controller = Get.put(CarInventoryController());

    final double screenWidth = MediaQuery.of(context).size.width;


    const double narrowThreshold = 350.0;
    const double veryNarrowThreshold = 280.0;
    const double tightSpacingThreshold = 380.0;
    const double filterTextHideThreshold = 450.0;
    const double overflowFixThreshold = 400.0;



    final double horizontalPadding = screenWidth < veryNarrowThreshold ? 4.0 : AppSizes.horizontalPadding(context);

    final double smallSpacing = screenWidth < veryNarrowThreshold ? 4.0 : AppSizes.padding(context) * 0.75;

    final double buttonHeight = isMobile
        ? 38.0
        : AppSizes.buttonHeight(context) * 0.8;

    final double searchBoxWidth = isMobile ? 140 : AppSizes.buttonWidth(context) * 1.5;


    final bool showFilterText = screenWidth >= filterTextHideThreshold && !isMobile;


    final double viewToggleSize = screenWidth < veryNarrowThreshold ? 28.0 : isMobile ? 32.0 : buttonHeight * 0.85;


    return Column(
      children: [
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(
            horizontal: horizontalPadding,
            vertical: AppSizes.verticalPadding(context),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Search Box
                    (isWeb)
                        ? SizedBox(
                      width: 260,
                      child: Container(
                        height: buttonHeight,
                        padding: EdgeInsets.symmetric(
                          horizontal: AppSizes.padding(context) * 0.5,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(
                            AppSizes.borderRadius(context),
                          ),
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
                                style: TTextTheme.titleTwo(context),
                                decoration: InputDecoration(
                                  isCollapsed: true,
                                  contentPadding: EdgeInsets.zero,
                                  hintText: screenWidth < 350
                                      ? "Search..."
                                      : "Search client name, car, etc...",
                                  hintStyle: TTextTheme.smallX(context),
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                        : Expanded(
                      child: Container(
                        height: buttonHeight,
                        padding: EdgeInsets.symmetric(
                          horizontal: AppSizes.padding(context) * 0.5,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(
                            AppSizes.borderRadius(context),
                          ),
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
                                  hintText: screenWidth < 350
                                      ? "Search..."
                                      : "Search client name, car, etc...",
                                  hintStyle: TTextTheme.smallX(context),
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),


                    SizedBox(width: smallSpacing),

                    // FILTER BUTTON
                    Obx(() {
                      return _headerButton(
                        context: context,
                        icon: IconString.filterIcon,
                        text: "Filter",
                        isOpen: controller.isFilterOpen.value,
                        showText: showFilterText,
                        onTap: () {
                          controller.toggleFilter();
                          if (onFilter != null) onFilter!();
                        },
                      );
                    }),
                  ],
                ),
              ),

              SizedBox(width: smallSpacing),

              Obx(() {
                final bool isUltraTight = screenWidth < tightSpacingThreshold;

                final double buttonGap = isUltraTight ? 1.0 : 4.0;

                final double addCarButtonSpacing = screenWidth < overflowFixThreshold ?
                AppSizes.padding(context) * 0.75 :
                AppSizes.padding(context) * 1.5;

                return Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                        vertical: isUltraTight ? 2.0 : AppSizes.padding(context) * 0.1,
                        horizontal: isUltraTight ? 4.0 : AppSizes.padding(context) * 0.2,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(
                          AppSizes.borderRadius(context),
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          _selectableIconButton(
                            context: context,
                            iconPath: IconString.previewOne,
                            isSelected: controller.selectedView.value == 0,
                            onTap: () => controller.selectedView.value = 0,
                            size: viewToggleSize,
                          ),

                          SizedBox(width: buttonGap),

                          _selectableIconButton(
                            context: context,
                            iconPath: IconString.previewTwo,
                            isSelected: controller.selectedView.value == 1,
                            onTap: () => controller.selectedView.value = 1,
                            size: viewToggleSize,
                          ),

                          SizedBox(width: buttonGap),

                          _selectableIconButton(
                            context: context,
                            iconPath: IconString.previewThree,
                            isSelected: controller.selectedView.value == 2,
                            onTap: () => controller.selectedView.value = 2,
                            size: viewToggleSize,
                          ),
                        ],
                      ),
                    ),

                    if (isWeb) ...[
                      SizedBox(width: addCarButtonSpacing),
                      AddButton(text: "Add Car", width: 120, onTap: () {
                        context.push(
                          '/addNewCar',
                          extra: {"hideMobileAppBar": true},
                        );
                      }),
                    ],
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

  // Filter container widget
  Widget _buildFilterContainer(BuildContext context) {
    final CarInventoryController controller = Get.put(CarInventoryController());
    const int totalItems = 9;
    final double width = MediaQuery.of(context).size.width;

    return LayoutBuilder(
      builder: (context, constraints) {

        const double narrowScreenMargin = 8.0;
        const double narrowScreenPadding = 10.0;
        const double narrowWrapSpacing = 8.0;

        double wrapSpacing = AppSizes.padding(context);
        double dynamicPadding = AppSizes.padding(context);
        double horizontalMargin = AppSizes.horizontalPadding(context);

        if (width < 350) {
          horizontalMargin = narrowScreenMargin;
          dynamicPadding = narrowScreenPadding;
          wrapSpacing = narrowWrapSpacing;
        } else if (AppSizes.isWeb(context)) {
          dynamicPadding = AppSizes.padding(context) * 1.5;
          horizontalMargin = AppSizes.horizontalPadding(context) * 1.5;
        }

        double containerPadding = dynamicPadding;

        int itemsPerRow;
        double itemWidth;

        if (width > 1500) {
          itemsPerRow = totalItems;
        } else if (width > 1100) {
          itemsPerRow = 9;
        } else if (width > 700) {
          itemsPerRow = 8;
        } else if (width > 450) {
          itemsPerRow = 3;
        } else {
          itemsPerRow = 1;
        }

        if (itemsPerRow == 1) {
          itemWidth = double.infinity;
        } else {
          double availableScreenWidth = width - (2 * horizontalMargin);
          double effectiveItemArea = availableScreenWidth - (2 * containerPadding);
          double totalSpacingInRow = (itemsPerRow - 1) * wrapSpacing;
          itemWidth = (effectiveItemArea - totalSpacingInRow) / itemsPerRow;
        }

        return Container(
          width: double.infinity,
          padding: EdgeInsets.all(containerPadding),
          margin: EdgeInsets.symmetric(
            horizontal: horizontalMargin,
            vertical: AppSizes.padding(context) * 0.5,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(AppSizes.borderRadius(context)),
          ),
          child: Wrap(
            spacing: wrapSpacing,
            runSpacing: AppSizes.padding(context) * 0.75,
            children: [
              /// BRAND
              _filterItem(
                "Car Brand",
                _dropdownBox(
                  ["BMW", "Aston", "Range Rover"],
                  controller.selectedBrand,
                  context,
                  placeholder: "Select",
                ),
                context,
                itemWidth: itemWidth,
              ),

              /// MODEL
              _filterItem(
                "Car Model",
                _dropdownBox(
                  ["Corolla", "Civic"],
                  controller.selectedModel,
                  context,
                  placeholder: "Select",
                ),
                context,
                itemWidth: itemWidth,
              ),

              /// YEAR
              _filterItem(
                "Car Year",
                _dropdownBox(
                  ["2025", "2024"],
                  controller.selectedYear,
                  context,
                  placeholder: "Select",
                ),
                context,
                itemWidth: itemWidth,
              ),

              /// BODY TYPE
              _filterItem(
                "Body Type",
                _dropdownBox(
                  ["Sedan", "SUV"],
                  controller.selectedBodyType,
                  context,
                  placeholder: "Select",
                ),
                context,
                itemWidth: itemWidth,
              ),

              /// STATUS
              _filterItem(
                "Car Status",
                _dropdownBox(
                  ["Available", "Unavailable"],
                  controller.selectedStatus,
                  context,
                  placeholder: "Select",
                ),
                context,
                itemWidth: itemWidth,
              ),

              /// TRANSMISSION
              _filterItem(
                "Transmission",
                _dropdownBox(
                  ["Auto", "Manual"],
                  controller.selectedTransmission,
                  context,
                  placeholder: "Select",
                ),
                context,
                itemWidth: itemWidth,
              ),

              /// FUEL
              _filterItem(
                "Fuel",
                _dropdownBox(
                  ["Petrol", "Hybrid"],
                  controller.selectedFuel,
                  context,
                  placeholder: "Select",
                ),
                context,
                itemWidth: itemWidth,
              ),

              /// ENGINE
              _filterItem(
                "Engine Size",
                _textFieldBox("2.5[L]", context),
                context,
                itemWidth: itemWidth,
              ),

              /// PRICE
              _filterItem(
                "Price (Under)",
                _textFieldBox(r"$ 1600 (W)", context),
                context,
                itemWidth: itemWidth,
              ),
            ],
          ),
        );
      },
    );
  }

  // filter Item
  Widget _filterItem(
      String title,
      Widget child,
      BuildContext context, {
        required double itemWidth,
      }) {
    return SizedBox(
      width: itemWidth == double.infinity ? null : itemWidth,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: TTextTheme.btnFour(context)),
          SizedBox(height: AppSizes.padding(context) * 0.3),
          child,
        ],
      ),
    );
  }

  // dropdown Box widget
  Widget _dropdownBox(
      List<String> items,
      RxString selectedRx,
      BuildContext context, {
        String placeholder = "Select",
      }) {
    return Obx(() {
      String? selectedValue = selectedRx.value.isEmpty
          ? null
          : selectedRx.value;

      return Container(
        height: 38,
        padding: EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          color: AppColors.secondaryColor,
          borderRadius: BorderRadius.circular(
            AppSizes.borderRadius(context) * 0.8,
          ),
        ),
        child: DropdownButton<String>(
          value: selectedValue,
          isExpanded: true,
          underline: SizedBox(),
          icon: Icon(Icons.keyboard_arrow_down, size: 20),
          dropdownColor: AppColors.secondaryColor,
          hint: Text(placeholder, style: TTextTheme.titleThree(context)),

          selectedItemBuilder: (context) {
            return items.map((item) {
              return Align(
                alignment: Alignment.centerLeft,
                child: Text(item, style: TTextTheme.titleTwo(context)),
              );
            }).toList();
          },

          items: List.generate(items.length, (index) {
            bool isLast = index == items.length - 1;

            return DropdownMenuItem(
              value: items[index],
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(items[index], style: TTextTheme.titleTwo(context)),
                  if (!isLast)
                    Padding(
                      padding: const EdgeInsets.only(top: 7),
                      child: Divider(
                        thickness: 0.4,
                        height: 4,
                        color: AppColors.quadrantalTextColor,
                      ),
                    ),
                ],
              ),
            );
          }),

          onChanged: (v) {
            if (v != null) {
              selectedRx.value = v;
            }
          },
        ),
      );
    });
  }

  // textField Widget
  Widget _textFieldBox(String label, BuildContext context) {
    return Container(
      width: double.infinity,
      height: 38,

      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          AppSizes.borderRadius(context) * 0.8,
        ),
        color: AppColors.secondaryColor,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: AppSizes.padding(context) * 0.5,
      ),

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
    final double iconPadding = size * 0.2;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: isSelected ? AppColors.textColor : Colors.transparent,
          borderRadius: BorderRadius.circular(
            AppSizes.borderRadius(context) * 0.7,
          ),
        ),
        child: Center(
          child: Image.asset(
            iconPath,
            width: size - iconPadding,
            height: size - iconPadding,
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
    required bool showText,
    VoidCallback? onTap,
  }) {
    bool isMobile = AppSizes.isMobile(context);

    final double horizontalPadding = showText ? AppSizes.padding(context) * 0.7 : 8.0;
    final double verticalPadding = AppSizes.padding(context) * 0.5;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: horizontalPadding,
          vertical: verticalPadding,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(AppSizes.borderRadius(context)),
          border: Border.all(
            color: isOpen ? AppColors.primaryColor : Colors.white,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              icon,
              width: AppSizes.padding(context) * 0.6,
              height: AppSizes.padding(context) * 0.6,
              color: isOpen
                  ? AppColors.primaryColor
                  : AppColors.secondTextColor,
            ),
            if (showText && !isMobile) ...[
              SizedBox(width: AppSizes.padding(context) * 0.4),
              Text(
                text,
                style: TTextTheme.btnTwo(context)?.copyWith(
                  color: isOpen
                      ? AppColors.primaryColor
                      : AppColors.secondTextColor,
                ),
              ),
            ],
            SizedBox(width: AppSizes.padding(context) * 0.3),
            Transform.rotate(
              angle: isOpen ? 3.14 : 0,
              child: Icon(
                Icons.keyboard_arrow_down,
                size: AppSizes.padding(context) * 0.65,
                color: isOpen
                    ? AppColors.primaryColor
                    : AppColors.secondTextColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}