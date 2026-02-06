import 'package:car_rental_project/PickupCar/PickupCarInventory.dart';
import 'package:car_rental_project/PickupCar/ReusableWidgetOfPickup/AddButtonOfPickup.dart';
import 'package:car_rental_project/Resources/Colors.dart';
import 'package:car_rental_project/Resources/TextTheme.dart';
import 'package:flutter/material.dart';
import 'package:car_rental_project/Resources/AppSizes.dart';
import 'package:car_rental_project/Resources/IconStrings.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

class CardListHeaderPickupWidget extends StatelessWidget {
  const CardListHeaderPickupWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(PickupCarController());
    final double screenWidth = MediaQuery.of(context).size.width;
    final double buttonHeight = 40.0;

    final bool showRedSearchButton = screenWidth > 600;
    final bool showCategoryText = screenWidth > 750;
    final bool showFilterText = screenWidth > 600;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: AppSizes.horizontalPadding(context),
            vertical: AppSizes.verticalPadding(context),
          ),
          child: Row(
            children: [
              /// Category Selection
              _buildCategorySelection(context, controller, buttonHeight, showCategoryText),

              const SizedBox(width: 8),

              ///
              Expanded(
                flex: 1,
                child: _searchBarWithButton(context, controller, buttonHeight, showRedSearchButton),
              ),

              const SizedBox(width: 8),

              /// Filter Button
              Obx(() => _headerButton(
                context: context,
                icon: IconString.filterIcon,
                text: "Filter",
                isOpen: controller.isFilterOpen.value,
                showText: showFilterText,
                onTap: controller.toggleFilter,
              )),

              /// Add Button
              if (AppSizes.isWeb(context) && screenWidth > 1000) ...[
                const Spacer(),
                AddButtonOfPickup(
                  text: "Add Pickup car",
                  width: 140,
                  height: 40,
                  onTap: () => context.push('/addpickup', extra: {"hideMobileAppBar": true}),
                ),
              ],
            ],
          ),
        ),

        Obx(() {
          if (!controller.isFilterOpen.value) return const SizedBox.shrink();
          return _buildResponsiveFilterPanel(context, AppSizes.isMobile(context), controller);
        }),
      ],
    );
  }
   /// ------ Extra Widgets ---------///

  //  Category Selection Widget
  Widget _buildCategorySelection(BuildContext context, PickupCarController controller, double height, bool showText) {
    return Obx(() {
      final double screenWidth = MediaQuery.of(context).size.width;
      double maxWidth = showText ? (screenWidth > 1100 ? 200 : 150) : 50;

      return Container(
        height: height,
        constraints: BoxConstraints(maxWidth: maxWidth),
        padding: const EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(AppSizes.borderRadius(context)),
        ),
        child: Theme(
          data: Theme.of(context).copyWith(
            dividerColor: Colors.transparent,
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.white).copyWith(
              surface: Colors.white,
            ),
          ),
          child: PopupMenuButton<String>(
            offset: const Offset(0, 45),
            color: Colors.white,
            elevation: 8,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            onSelected: (val) => controller.selectedSearchType.value = val,
            itemBuilder: (context) => [
              _buildPopupItem("Customer Name", IconString.nameIcon, context),
              _buildPopupItem("VIN Number", IconString.vinNumberIcon, context),
              _buildPopupItem("Registration", IconString.registrationIcon, context),
              _buildPopupItem("Car Name", IconString.carInventoryIcon, context, isLast: true),
            ],
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(_getIconPathForType(controller.selectedSearchType.value), width: 18,color: AppColors.quadrantalTextColor,),
                if (showText) ...[
                  const SizedBox(width: 6),
                  Flexible(
                    child: Text(
                      controller.selectedSearchType.value,
                      style: TTextTheme.titleThree(context),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ),
                ],
                const Icon(Icons.keyboard_arrow_down, size: 16,color: AppColors.secondTextColor,),
              ],
            ),
          ),
        ),
      );
    });
  }

  //  Search Bar Widget
  Widget _searchBarWithButton(BuildContext context, PickupCarController controller, double height, bool showButton) {
    final double screenWidth = MediaQuery.of(context).size.width;

    return Container(
      height: height,
      padding: const EdgeInsets.only(left: 12, right: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppSizes.borderRadius(context)),
      ),
      child: Row(
        children: [
          if (showButton) ...[
            const Icon(Icons.search, size: 18, color: AppColors.secondTextColor),
            const SizedBox(width: 8),
          ],

          Expanded(
            child: TextField(
              cursorColor: AppColors.blackColor,
              textAlignVertical: TextAlignVertical.center,
              style: TTextTheme.titleTwo(context),
              decoration: InputDecoration(
                hintText: screenWidth > 750 ? "Search Pickup by Customer" : "Search...",
                hintStyle: TTextTheme.smallX(context),
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(bottom: 18),
              ),
            ),
          ),

          GestureDetector(
            onTap: () {},
            child: Container(
              height: 32,
              padding: EdgeInsets.symmetric(horizontal: showButton ? 16 : 0),
              width: showButton ? null : 32,
              decoration: BoxDecoration(
                color: AppColors.primaryColor,
                borderRadius: BorderRadius.circular(8),
              ),
              alignment: Alignment.center,
              child: showButton
                  ? Text("Search", style: TTextTheme.btnSearch(context))
                  : const Icon(Icons.search, color: Colors.white, size: 18),
            ),
          ),
        ],
      ),
    );
  }

  Widget _headerButton({required BuildContext context, required String icon, required String text, required bool isOpen, required bool showText, VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: isOpen ? AppColors.primaryColor : Colors.white),
        ),
        child: Row(
          children: [
            Image.asset(icon, width: 16, color: isOpen ? AppColors.primaryColor : AppColors.secondTextColor),
            if (showText) ...[
              const SizedBox(width: 6),
              Text(text, style: TTextTheme.btnTwo(context).copyWith(color: isOpen ? AppColors.primaryColor : AppColors.secondTextColor)),
            ],
            Icon(isOpen ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down, size: 18,color: isOpen?AppColors.primaryColor : AppColors.secondTextColor,),
          ],
        ),
      ),
    );
  }

  PopupMenuItem<String> _buildPopupItem(
      String text,
      String icon,
      BuildContext context, {
        bool isLast = false,
      }) {
    return PopupMenuItem(
      value: text,
      padding: EdgeInsets.zero,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              children: [
                Image.asset(icon, width: 18, height: 18,color: AppColors.quadrantalTextColor,),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    text,
                    style: TTextTheme.titleThree(context),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),

          if (!isLast)
            Divider(
              height: 1,
              thickness: 0.3,
              color: AppColors.quadrantalTextColor,
            ),
        ],
      ),
    );
  }

  // Icon Paths
  String _getIconPathForType(String type) {
    switch (type) {
      case "Customer Name": return IconString.nameIcon;
      case "VIN Number": return IconString.vinNumberIcon;
      case "Registration": return IconString.registrationIcon;
      case "Car Name": return IconString.carInventoryIcon;
      default: return IconString.nameIcon;
    }
  }

  // Filter Buttons Widgets
  Widget _buildResponsiveFilterPanel(BuildContext context, bool isMobile, PickupCarController controller) {
    double screenWidth = MediaQuery.of(context).size.width;
    bool isMobileUI = screenWidth < 600;

    final List<String> statuses = ["Completed", "Awaiting", "Processing", "Overdue"];

    return Align(
      alignment: isMobileUI ? Alignment.center : Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.symmetric(
          horizontal: AppSizes.horizontalPadding(context),
          vertical: 10,
        ),
        width: isMobileUI ? double.infinity : null,
        padding: EdgeInsets.all(AppSizes.padding(context)),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(AppSizes.borderRadius(context)),
        ),
        child: isMobileUI
            ? Column(
          children: [
            _filterItem("Make", _dropdownBox(controller.makes, controller.selectedMake, context), context),
            _filterItem("Model", _textFieldBox(controller.selectedModel.value, context), context),
            _filterItem("Year", _textFieldBox(controller.selectYear.value, context), context),
            _filterItem("Status", _statusDropdownBox(statuses, controller.selectedStatus, context), context),
            _filterItem("Start Date", _textFieldBox(controller.startDate.value, context), context),
            _filterItem("End Date", _textFieldBox(controller.endDate.value, context), context),
          ],
        )
            : Wrap(
          spacing: 16,
          runSpacing: 16,
          children: [
            _filterItem("Make", _dropdownBox(controller.makes, controller.selectedMake, context), context),
            _filterItem("Model", _textFieldBox(controller.selectedModel.value, context), context),
            _filterItem("Year", _textFieldBox(controller.selectYear.value, context), context),
            _filterItem("Status", _statusDropdownBox(statuses, controller.selectedStatus, context), context),
            _filterItem("Start Date", _textFieldBox(controller.startDate.value, context), context),
            _filterItem("End Date", _textFieldBox(controller.endDate.value, context), context),
          ],
        ),
      ),
    );
  }

// Filter Item Widget
  Widget _filterItem(String title, Widget child, BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    bool isMobileUI = screenWidth < 600;

    if (isMobileUI) {
      return SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: TTextTheme.btnFour(context)),
            const SizedBox(height: 6),
            child,
          ],
        ),
      );
    }

    return IntrinsicWidth(
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          minWidth: 100,
          maxWidth: 250,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TTextTheme.btnFour(context),
              maxLines: 1,
              softWrap: false,
              overflow: TextOverflow.visible,
            ),
            const SizedBox(height: 6),
            child,
          ],
        ),
      ),
    );
  }

//  Dropdown  for other Fields
  Widget _dropdownBox(List<String> items, RxString selectedRx, BuildContext context) {
    return Obx(() => PopupMenuButton<String>(
      offset: const Offset(0, 40),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      color: AppColors.secondaryColor,
      onSelected: (v) => selectedRx.value = v,
      itemBuilder: (BuildContext context) {
        List<PopupMenuEntry<String>> menuItems = [];
        for (int i = 0; i < items.length; i++) {
          menuItems.add(
            PopupMenuItem<String>(
              value: items[i],
              height: 35,
              child: Text(items[i], style: TTextTheme.dropdowninsideText(context)),
            ),
          );
          if (i < items.length - 1) {
            menuItems.add(
              PopupMenuDivider(height: 1),
            );
          }
        }
        return menuItems;
      },
      child: Container(
        height: 38,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
            color: AppColors.secondaryColor,
            borderRadius: BorderRadius.circular(8)
        ),
        child: Row(
          children: [
            Expanded(
                child: Text(
                    selectedRx.value.isEmpty ? "Select" : selectedRx.value,
                    style: TTextTheme.dropdowninsideText(context),
                    overflow: TextOverflow.ellipsis
                )
            ),
            const Icon(Icons.keyboard_arrow_down, size: 20, color: AppColors.secondTextColor),
          ],
        ),
      ),
    ));
  }

// Status Dropdown Widget
  Widget _statusDropdownBox(List<String> items, RxString selectedRx, BuildContext context) {
    return Obx(() => PopupMenuButton<String>(
      offset: const Offset(0, 45),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: AppColors.secondaryColor,
      elevation: 4,
      onSelected: (v) => selectedRx.value = v,
      itemBuilder: (BuildContext context) {
        List<PopupMenuEntry<String>> menuItems = [];

        for (int i = 0; i < items.length; i++) {
          menuItems.add(
            PopupMenuItem<String>(
              value: items[i],
              height: 45,
              child: Container(
                width: 120,
                padding: const EdgeInsets.symmetric(vertical: 8),
                decoration: BoxDecoration(
                  color: _getStatusBgColor(items[i]),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: AppColors.sideBoxesColor,
                    width: 1,
                  ),
                ),
                child: Text(
                  items[i],
                  textAlign: TextAlign.center,
                  style: TTextTheme.textFieldStatusTheme(context).copyWith(
                    color: _getStatusTextColor(items[i]),
                  ),
                ),
              ),
            ),
          );

          if (i < items.length - 1) {
            menuItems.add(
               PopupMenuDivider(   height: 0.3,
                thickness: 0.3,
                color: AppColors.quadrantalTextColor,),
            );
          }
        }
        return menuItems;
      },
      child: Container(
        height: 38,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
            color: AppColors.secondaryColor,
            borderRadius: BorderRadius.circular(8)
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: _getStatusBgColor(selectedRx.value),
                borderRadius: BorderRadius.circular(6),
                border: Border.all(
                  color: AppColors.sideBoxesColor,
                  width: 1,
                ),
              ),
              child: Text(
                selectedRx.value,
                style: TTextTheme.textFieldStatusTheme(context).copyWith(
                  color: _getStatusTextColor(selectedRx.value),
                ),
              ),
            ),
            const Spacer(),
            const Icon(Icons.keyboard_arrow_down, size: 20, color: AppColors.secondTextColor),
          ],
        ),
      ),
    ));
  }

  // Helper methods for colors for filter dropdowns
  Color _getStatusBgColor(String status) {
    switch (status) {
      case "Completed": return AppColors.textColor;
      case "Processing":
      case "Overdue": return AppColors.iconsBackgroundColor;
      case "Awaiting": return AppColors.secondaryColor;
      default: return Colors.grey.shade100;
    }
  }

  Color _getStatusTextColor(String status) {
    switch (status) {
      case "Completed": return Colors.white;
      case "Processing":
      case "Overdue": return AppColors.primaryColor;
      case "Awaiting": return AppColors.textColor;
      default: return Colors.black;
    }
  }

  // TextField Widget
  Widget _textFieldBox(String label, BuildContext context) {
    return Container(
      height: 38,
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: AppColors.secondaryColor,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: TextField(
        cursorColor: AppColors.blackColor,
        style: TTextTheme.titleTwo(context),
        decoration: InputDecoration(
          hintText: label,
          hintStyle: TTextTheme.titleTwo(context),
          border: InputBorder.none,
          isDense: true,
          contentPadding: EdgeInsets.zero,
        ),
      ),
    );
  }

}