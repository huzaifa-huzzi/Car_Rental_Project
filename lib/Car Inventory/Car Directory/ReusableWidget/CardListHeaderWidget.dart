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
    final bool isMobile = AppSizes.isMobile(context);
    final bool isWeb = AppSizes.isWeb(context);
    final controller = Get.find<CarInventoryController>();
    final double buttonHeight = 40.0;
    final double viewToggleSize = isMobile ? 32.0 : 34.0;

    return LayoutBuilder(
      builder: (context, constraints) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: isMobile ? 8.0 : AppSizes.horizontalPadding(context),
                  vertical: AppSizes.verticalPadding(context),
                ),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minWidth: constraints.maxWidth - (isMobile ? 16 : (AppSizes.horizontalPadding(context) * 2)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          _buildCategorySelection(context, controller, buttonHeight, !isMobile),
                          SizedBox(width: isMobile ? 4 : 5),
                          SizedBox(
                            width: isMobile ? 140 : 270,
                            child: _searchBarWithButton(context, controller, buttonHeight, !isMobile),
                          ),
                          SizedBox(width: isMobile ? 4 : 5),
                          Obx(() => _headerButton(
                            context: context,
                            icon: IconString.filterIcon,
                            text: "Filter",
                            isOpen: controller.isFilterOpen.value,
                            showText: !isMobile,
                            onTap: controller.toggleFilter,
                          )),
                        ],
                      ),

                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(width: isMobile ? 2 : 4),
                          _viewToggleWidget(context, controller, viewToggleSize),
                          if (isWeb) ...[
                            const SizedBox(width: 12),
                            AddButton(
                              text: "Add Car",
                              width: 110,
                              height: 40,
                              onTap: () => context.push('/addNewCar', extra: {"hideMobileAppBar": true}),
                            ),
                          ],
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),

            Obx(() {
              return controller.isFilterOpen.value
                  ? _buildFilterContainer(context)
                  : const SizedBox.shrink();
            }),
          ],
        );
      },
    );
  }

  /// ------- Extra Widgets --------///

  // 1. Search Category Selection Widget
  Widget _buildCategorySelection(BuildContext context, CarInventoryController controller, double height, bool showText) {
    return Obx(() => Container(
      height: height,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: PopupMenuButton<String>(
        offset: const Offset(0, 45),
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        onSelected: (val) => controller.selectedSearchType.value = val,
        itemBuilder: (context) => [
          _buildCategoryPopupItem("VIN Number", IconString.vinNumberIcon, context),
          _buildCategoryPopupItem("Registration", IconString.registrationIcon, context),
          _buildCategoryPopupItem("Car Name", IconString.carInventoryIcon, context, isLast: true),
        ],
        child: Row(
          children: [
            Image.asset(
              _getIconPathForType(controller.selectedSearchType.value),
              width: 18, height: 18, color: AppColors.quadrantalTextColor,
            ),
            if (showText) ...[
              const SizedBox(width: 6),
              Text(controller.selectedSearchType.value, style: TTextTheme.titleThree(context)),
            ],
            const Icon(Icons.keyboard_arrow_down, size: 18, color: AppColors.secondTextColor),
          ],
        ),
      ),
    ));
  }

  // 2. Search Bar Widget
  Widget _searchBarWithButton(BuildContext context, CarInventoryController controller, double height, bool showButton) {
    final bool isWeb = AppSizes.isWeb(context);
    final bool isMobile = AppSizes.isMobile(context);

    String hintText = isWeb ? "Search Car By Vin Number" : (!isMobile ? "Search...." : "Search...");

    return Container(
      height: height,
      constraints: const BoxConstraints(minWidth: 100),
      padding: const EdgeInsets.only(left: 10),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
      child: Row(
        children: [
          const Icon(Icons.search, size: 18, color: AppColors.secondTextColor),
          const SizedBox(width: 8),
          Expanded(
            child: TextField(
              cursorColor: AppColors.blackColor,
              style: TTextTheme.titleTwo(context),
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: TTextTheme.smallX(context),
                border: InputBorder.none,
                isDense: true,
                contentPadding: const EdgeInsets.symmetric(vertical: 10),
              ),
            ),
          ),
          if (showButton && !isMobile)
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(color: AppColors.primaryColor, borderRadius: BorderRadius.circular(6)),
                alignment: Alignment.center,
                child: Text("Search", style: TTextTheme.btnSearch(context)),
              ),
            ),
        ],
      ),
    );
  }

  // PopUp for Category Item
  PopupMenuItem<String> _buildCategoryPopupItem(String text, String icon, BuildContext context, {bool isLast = false}) {
    return PopupMenuItem<String>(
      value: text,
      padding: EdgeInsets.zero,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              children: [
                Image.asset(icon, width: 18, color: AppColors.quadrantalTextColor),
                const SizedBox(width: 12),
                Text(text, style: TTextTheme.titleThree(context)),
              ],
            ),
          ),
          if (!isLast) Divider(height: 1, thickness: 0.5, color: AppColors.quadrantalTextColor),
        ],
      ),
    );
  }

  // Filter popMenuItem
  PopupMenuItem<String> _buildFilterPopupItem(String text, BuildContext context, {bool isLast = false}) {
    return PopupMenuItem<String>(
      value: text,
      padding: EdgeInsets.zero,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Text(
              text,
              style: TTextTheme.titleTwo(context)),
          ),
          if (!isLast)
            Divider(
              height: 1,
              thickness: 0.5,
              color: AppColors.quadrantalTextColor,
            ),
        ],
      ),
    );
  }

  // 5. Filter Dropdown Widget
  Widget _dropdownBox(List<String> items, RxString selectedRx, BuildContext context) {
    return Obx(() => PopupMenuButton<String>(
      offset: const Offset(0, 40),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      color: AppColors.secondaryColor,
      onSelected: (v) => selectedRx.value = v,
      itemBuilder: (BuildContext context) {
        return items.asMap().entries.map<PopupMenuEntry<String>>((entry) {
          return _buildFilterPopupItem(
              entry.value,
              context,
              isLast: entry.key == items.length - 1
          );
        }).toList();
      },
      child: Container(
        height: 38,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(color: AppColors.secondaryColor, borderRadius: BorderRadius.circular(8)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(child: Text(selectedRx.value.isEmpty ? "Select" : selectedRx.value, style: TTextTheme.dropdowninsideText(context), overflow: TextOverflow.ellipsis)),
            const Icon(Icons.keyboard_arrow_down, size: 22, color: Colors.black),
          ],
        ),
      ),
    ));
  }

  // filter Container Widget
  Widget _buildFilterContainer(BuildContext context) {
    final controller = Get.find<CarInventoryController>();
    return Container(
      margin: EdgeInsets.symmetric(horizontal: AppSizes.horizontalPadding(context), vertical: 8),
      padding: EdgeInsets.all(AppSizes.padding(context)),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
      child: Wrap(
        spacing: 16, runSpacing: 16,
        children: [
          _filterItem("Make", _dropdownBox(["BMW", "Aston", "Range Rover"], controller.selectedBrand, context), context),
          _filterItem("Model", _dropdownBox(["Corolla", "Civic"], controller.selectedModel, context), context),
          _filterItem("Year", _dropdownBox(["2025", "2024"], controller.selectedYear, context), context),
          _filterItem("Body Type", _dropdownBox(["Sedan", "SUV"], controller.selectedBodyType, context), context),
          _filterItem("Status", _dropdownBox(["Available", "Unavailable"], controller.selectedStatus, context), context),
          _filterItem("Transmission", _dropdownBox(["Auto", "Manual"], controller.selectedTransmission, context), context),
          _filterItem("Capacity", _textFieldBox("2 person", context), context),
          _filterItem("Fuel", _dropdownBox(["Petrol", "Hybrid"], controller.selectedFuel, context), context),
          _filterItem("Engine Size", _textFieldBox("2.5[L]", context), context),
          _filterItem("Price (Under)", _textFieldBox(r"$ 1600", context), context),
        ],
      ),
    );
  }

  // filter Item Widget
  Widget _filterItem(String title, Widget child, BuildContext context) {
    return SizedBox(width: 130, child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(title, style: TTextTheme.dropdowninsideText(context), maxLines: 1, overflow: TextOverflow.ellipsis),
      const SizedBox(height: 6),
      child,
    ]));
  }

  // textField widget
  Widget _textFieldBox(String label, BuildContext context) {
    return Container(
      height: 38, decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: AppColors.secondaryColor),
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Center(child: TextField(
        cursorColor: AppColors.blackColor,
          style: TTextTheme.titleTwo(context),
          decoration: InputDecoration(
              hintText: label,
              hintStyle: TTextTheme.titleTwo(context),
              border: InputBorder.none, isDense: true,
              contentPadding: EdgeInsets.zero)
      )),
    );
  }

  // headerButton Widget
  Widget _headerButton({required BuildContext context, required String icon, required String text, required bool isOpen, required bool showText, VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8), border: Border.all(color: isOpen ? AppColors.primaryColor : Colors.white)),
        child: Row(children: [
          Image.asset(icon, width: 16, color: isOpen ? AppColors.primaryColor : AppColors.secondTextColor),
          if (showText) ...[const SizedBox(width: 6), Text(text, style: TTextTheme.btnTwo(context)?.copyWith(color: isOpen ? AppColors.primaryColor : AppColors.secondTextColor))],
          const SizedBox(width: 4),
          Icon(isOpen ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down, size: 18, color: isOpen ? AppColors.primaryColor : AppColors.secondTextColor),
        ]),
      ),
    );
  }

  // viewToggle Widget
  Widget _viewToggleWidget(BuildContext context, CarInventoryController controller, double size) {
    return Obx(() => Container(
      padding: const EdgeInsets.all(0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _selectableIconButton(
                context: context,
                iconPath: IconString.previewOne,
                isSelected: controller.selectedView.value == 0,
                onTap: () => controller.selectedView.value = 0,
                size: size
            ),
            _selectableIconButton(
                context: context,
                iconPath: IconString.previewTwo,
                isSelected: controller.selectedView.value == 1,
                onTap: () => controller.selectedView.value = 1,
                size: size
            ),
            _selectableIconButton(
                context: context,
                iconPath: IconString.previewThree,
                isSelected: controller.selectedView.value == 2,
                onTap: () => controller.selectedView.value = 2,
                size: size
            ),
          ],
        ),
      ),
    ));
  }

  // selectable Icon Widget
  Widget _selectableIconButton({
    required BuildContext context,
    required String iconPath,
    required bool isSelected,
    required VoidCallback onTap,
    double size = 50.0,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: isSelected ? AppColors.textColor : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Image.asset(
            iconPath,
            width: size * 0.8,
            height: size * 0.8,
            color: isSelected ? Colors.white : AppColors.blackColor,
          ),
        ),
      ),
    );
  }

  // Icons Paths for the category
  String _getIconPathForType(String type) {
    switch (type) {
      case "VIN Number": return IconString.vinNumberIcon;
      case "Registration": return IconString.registrationIcon;
      case "Car Name": return IconString.carInventoryIcon;
      default: return IconString.carInventoryIcon;
    }
  }
}