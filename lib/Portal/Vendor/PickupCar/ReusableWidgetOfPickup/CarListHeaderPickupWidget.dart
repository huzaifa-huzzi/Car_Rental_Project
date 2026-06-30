import 'package:car_rental_project/Portal/Vendor/PickupCar/AddPickUp/Widget/CalendarManagingScreen.dart';
import 'package:car_rental_project/Portal/Vendor/PickupCar/PickupCarInventory.dart';
import 'package:car_rental_project/Portal/Vendor/PickupCar/ReusableWidgetOfPickup/AddButtonOfPickup.dart';
import 'package:car_rental_project/Portal/Vendor/PickupCar/ReusableWidgetOfPickup/AddPickupButton.dart';
import 'package:car_rental_project/Portal/Vendor/SystemUniversalController.dart';
import 'package:car_rental_project/Resources/Colors.dart';
import 'package:car_rental_project/Resources/TextTheme.dart';
import 'package:flutter/material.dart';
import 'package:car_rental_project/Resources/AppSizes.dart';
import 'package:car_rental_project/Resources/IconStrings.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

class CardListHeaderPickupWidget extends StatelessWidget {
  const CardListHeaderPickupWidget({super.key});
  static final TextEditingController startDateController = TextEditingController();
  static final TextEditingController endDateController = TextEditingController();

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

              /// Search Bar
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
                  onTap: () => context.go('/addpickup', extra: {"hideMobileAppBar": true}),
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

  // Category Selection Widget
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
                Image.asset(_getIconPathForType(controller.selectedSearchType.value), width: 18, color: AppColors.quadrantalTextColor,),
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
                const Icon(Icons.keyboard_arrow_down, size: 16, color: AppColors.secondTextColor,),
              ],
            ),
          ),
        ),
      );
    });
  }

  // Search Bar Widget
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
                contentPadding: const EdgeInsets.only(bottom: 18),
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
            Icon(isOpen ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down, size: 18, color: isOpen ? AppColors.primaryColor : AppColors.secondTextColor,),
          ],
        ),
      ),
    );
  }

  PopupMenuItem<String> _buildPopupItem(String text, String icon, BuildContext context, {bool isLast = false,}) {
    return PopupMenuItem(
      value: text,
      padding: EdgeInsets.zero,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              children: [
                Image.asset(icon, width: 18, height: 18, color: AppColors.quadrantalTextColor,),
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

  String _getIconPathForType(String type) {
    switch (type) {
      case "Customer Name": return IconString.nameIcon;
      case "VIN Number": return IconString.vinNumberIcon;
      case "Registration": return IconString.registrationIcon;
      case "Car Name": return IconString.carInventoryIcon;
      default: return IconString.nameIcon;
    }
  }

  // Filter Buttons Panels
  Widget _buildResponsiveFilterPanel(BuildContext context, bool isMobile, PickupCarController controller) {
    double screenWidth = MediaQuery.of(context).size.width;
    bool isMobileUI = screenWidth < 600;

    final SystemUniversalController systemCtrl = Get.find<SystemUniversalController>();

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
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _filterItem("Make", _dropdownBox([], controller.selectedMake, context, controller, id: "make", universalCtrl: systemCtrl), context),
            _filterItem("Model", _dropdownBox([], controller.selectedModel, context, controller, id: "model", universalCtrl: systemCtrl), context),
            _filterItem("Year", _buildYearField(context, "Year", controller.selectYear, id: "year", searchController:controller.yearSearchController), context),
            _filterItem("Status", _statusDropdownBox(statuses, controller.selectedStatus, context, id: "status"), context),
            _filterItem("Start Date", _buildDateFieldBox(context, startDateController, startDateLink), context),
            _filterItem("End Date", _buildDateFieldBox(context, endDateController, endDateLink), context),

            const SizedBox(height: 16),
            Align(
              alignment: Alignment.centerRight,
              child: _buildPickupResetButton(controller, isMobileUI),
            ),
          ],
        )
            : Wrap(
          spacing: 16,
          runSpacing: 16,
          crossAxisAlignment: WrapCrossAlignment.end,
          children: [
            _filterItem("Make", _dropdownBox([], controller.selectedMake, context, controller, id: "make", universalCtrl: systemCtrl), context),
            _filterItem("Model", _dropdownBox([], controller.selectedModel, context, controller, id: "model", universalCtrl: systemCtrl), context),
            _filterItem("Year", _buildYearField(context, "Year", controller.selectYear, id: "year", searchController:controller.yearSearchController), context),
            _filterItem("Status", _statusDropdownBox(statuses, controller.selectedStatus, context, id: "status"), context),
            _filterItem("Start Date", _buildDateFieldBox(context, startDateController, startDateLink), context),
            _filterItem("End Date", _buildDateFieldBox(context, endDateController, endDateLink), context),

            Padding(
              padding: const EdgeInsets.only(bottom: 2),
              child: _buildPickupResetButton(controller, isMobileUI),
            ),
          ],
        ),
      ),
    );
  }

  // Reset Button
  Widget _buildPickupResetButton(PickupCarController controller, bool isMobileUI) {
    return AddPickUpButton(
      text: "Reset",
      width: isMobileUI ? double.infinity : 100,
      height: 38,
      textColor: Colors.white,
      backgroundColor: AppColors.primaryColor,
      borderColor: AppColors.primaryColor,
      borderRadius: BorderRadius.circular(8),
      onTap: () {
        controller.selectedMake.value = "";
        controller.selectedStatus.value = "";
        controller.selectedModel.value = "";
        controller.selectYear.value = "";
        startDateController.clear();
        endDateController.clear();
        controller.openedDropdown3.value = "";
        removeCalendar();
      },
    );
  }

  Widget _filterItem(String title, Widget child, BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    bool isMobileUI = screenWidth < 600;

    return SizedBox(
      width: isMobileUI ? double.infinity : 180,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TTextTheme.btnFour(context),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 6),
          child,
        ],
      ),
    );
  }

  // Dropdown for Make and Model
  Widget _dropdownBox(
      List<String> items,
      RxString selected,
      BuildContext context,
      PickupCarController localController, {
        required String id,
        SystemUniversalController? universalCtrl,
      }) {
    return Obx(() {
      bool isOpen = universalCtrl != null
          ? universalCtrl.openedDropdownId.value == id
          : localController.openedDropdown2.value == id;

      List<String> finalItems = universalCtrl != null
          ? universalCtrl.getFilteredUniversalItems(id)
          : items;

      return LayoutBuilder(builder: (context, constraints) {
        return PopupMenuButton<String>(
          constraints: BoxConstraints(
            minWidth: constraints.maxWidth,
            maxWidth: constraints.maxWidth,
            maxHeight: 240,
          ),
          offset: const Offset(0, 48),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          color: Colors.white,
          elevation: 6,
          tooltip: '',
          onOpened: () {
            if (universalCtrl != null) {
              universalCtrl.openedDropdownId.value = id;
            } else {
              localController.openedDropdown2.value = id;
            }
          },
          onCanceled: () {
            if (universalCtrl != null) {
              universalCtrl.openedDropdownId.value = "";
              universalCtrl.searchCarText.value = "";
            } else {
              localController.openedDropdown2.value = "";
            }
          },
          onSelected: (value) {
            selected.value = value;

            if (universalCtrl != null) {
              universalCtrl.openedDropdownId.value = "";
              universalCtrl.searchCarText.value = "";
            } else {
              localController.openedDropdown2.value = "";
            }

            if (id == 'make') {
              localController.selectedModel.value = "";
            }
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            height: 37,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: AppColors.secondaryColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    selected.value.isEmpty ? "Select" : selected.value,
                    style: selected.value.isEmpty
                        ? const TextStyle(color: Colors.grey, fontSize: 14)
                        : const TextStyle(color: Colors.black87, fontSize: 14),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Icon(
                  isOpen ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                  color: Colors.grey.shade600,
                  size: 20,
                ),
              ],
            ),
          ),
          itemBuilder: (context) {
            return finalItems.map((value) {
              bool isSelected = selected.value == value;

              return PopupMenuItem<String>(
                value: value,
                height: 38,
                child: Row(
                  children: [
                    Container(
                      width: 18,
                      height: 18,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: isSelected ? AppColors.primaryColor : Colors.transparent,
                        border: Border.all(color: AppColors.primaryColor, width: 1.8),
                      ),
                      child: isSelected
                          ? const Center(child: Icon(Icons.done, color: Colors.white, size: 12))
                          : null,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        value,
                        style: TTextTheme.insidetextfieldWrittenText(context),
                      ),
                    ),
                  ],
                ),
              );
            }).toList();
          },
        );
      });
    });
  }

  // Status Dropdown Widget
  Widget _statusDropdownBox(List<String> items, RxString selectedRx, BuildContext context, {required String id}) {
    final controller = Get.find<PickupCarController>();

    return Obx(() {
      bool isOpen = controller.openedDropdown3.value == id;

      return LayoutBuilder(builder: (context, constraints) {
        double dropdownWidth = constraints.maxWidth == double.infinity ? 180 : constraints.maxWidth;

        return PopupMenuButton<String>(
          constraints: BoxConstraints(
            minWidth: dropdownWidth,
            maxWidth: dropdownWidth,
            maxHeight: 300,
          ),
          offset: const Offset(0, 42),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          color: Colors.white,
          onOpened: () => controller.openedDropdown3.value = id,
          onCanceled: () => controller.openedDropdown3.value = "",
          onSelected: (val) {
            selectedRx.value = val;
            controller.openedDropdown3.value = "";
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 10),
            height: 38,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              color: AppColors.secondaryColor,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: isOpen ? AppColors.primaryColor : Colors.transparent,
                width: 1.2,
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: selectedRx.value.isEmpty
                        ? Text("Select Status", style: TTextTheme.dropdowninsideText(context))
                        : _buildStatusChip(selectedRx.value, context),
                  ),
                ),
                Image.asset(
                  isOpen ? IconString.upsideDropdownIcon : IconString.dropdownIcon,
                  height: 14,
                ),
              ],
            ),
          ),
          itemBuilder: (BuildContext context) {
            return items.map((item) {
              bool isSelected = selectedRx.value == item;
              return PopupMenuItem<String>(
                value: item,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  children: [
                    Container(
                      width: 18,
                      height: 18,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: isSelected ? AppColors.primaryColor : Colors.transparent,
                        border: Border.all(color: AppColors.primaryColor, width: 2),
                      ),
                      child: isSelected
                          ? const Center(child: Icon(Icons.done, color: Colors.white, size: 12))
                          : null,
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        alignment: Alignment.centerLeft,
                        child: _buildStatusChip(item, context),
                      ),
                    ),
                  ],
                ),
              );
            }).toList();
          },
        );
      });
    });
  }

  Widget _buildStatusChip(String status, BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: _getStatusBgColor(status),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: AppColors.sideBoxesColor, width: 0.5),
      ),
      child: Text(
        status,
        style: TTextTheme.textFieldStatusTheme(context).copyWith(
          color: _getStatusTextColor(status),
          fontSize: 11,
        ),
      ),
    );
  }

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

  Widget _buildYearField(
      BuildContext context,
      String label,
      RxString selected,
      {required String id, required TextEditingController searchController}
      ) {
    final controller = Get.find<PickupCarController>();

    return Obx(() {
      bool isOpen = controller.openedDropdown2.value == id;

      return LayoutBuilder(builder: (context, constraints) {
        double width = constraints.maxWidth == double.infinity ? 180 : constraints.maxWidth;

        return PopupMenuButton<String>(
          constraints: BoxConstraints(
            minWidth: width,
            maxWidth: width,
            maxHeight: 400,
          ),
          offset: const Offset(0, 42),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          color: Colors.white,
          onOpened: () {
            controller.openedDropdown2.value = id;
          },
          onCanceled: () {
            controller.openedDropdown2.value = "";
            controller.searchCarText.value = "";
            searchController.clear();
          },
          onSelected: (val) {
            selected.value = val;
            controller.openedDropdown2.value = "";
            controller.searchCarText.value = "";
            searchController.clear();
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 10),
            height: 38,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: AppColors.secondaryColor,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: isOpen ? AppColors.primaryColor : Colors.transparent,
                width: 1.2,
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    selected.value.isEmpty ? "Select" : selected.value,
                    style: TTextTheme.dropdowninsideText(context),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Image.asset(
                  isOpen ? IconString.upsideDropdownIcon : IconString.dropdownIcon,
                  height: 14,
                ),
              ],
            ),
          ),
          itemBuilder: (context) {
            return [
              PopupMenuItem<String>(
                enabled: false,
                child: Obx(() {
                  var items = controller.getFilteredItems(id);

                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        height: 36,
                        margin: const EdgeInsets.symmetric(vertical: 4),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: AppColors.primaryColor.withValues(alpha: 0.4)),
                        ),
                        child: TextFormField(
                          controller: searchController,
                          cursorColor: AppColors.blackColor,
                          autofocus: true,
                          onChanged: (val) {
                            controller.searchCarText.value = val;
                          },
                          style: TTextTheme.titleinputTextField(context),
                          decoration: InputDecoration(
                            hintText: "Search Year",
                            hintStyle: TTextTheme.bodyRegular14Search(context),
                            prefixIcon: Icon(Icons.search, color: AppColors.primaryColor, size: 16),
                            filled: true,
                            fillColor: AppColors.backgroundOfScreenColor,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide.none,
                            ),
                            contentPadding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      ConstrainedBox(
                        constraints: const BoxConstraints(maxHeight: 250),
                        child: items.isEmpty
                            ? const Padding(
                          padding: EdgeInsets.symmetric(vertical: 20),
                          child: Center(child: Text("No years found")),
                        )
                            : ListView.builder(
                          shrinkWrap: true,
                          itemCount: items.length,
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            final item = items[index];
                            bool isSelected = selected.value == item;

                            return InkWell(
                              onTap: () {
                                Navigator.of(context).pop(item);
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 18,
                                      height: 18,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: isSelected ? AppColors.primaryColor : Colors.transparent,
                                        border: Border.all(color: AppColors.primaryColor, width: 2),
                                      ),
                                      child: isSelected
                                          ? const Center(child: Icon(Icons.done, color: Colors.white, size: 12))
                                          : null,
                                    ),
                                    const SizedBox(width: 10),
                                    Text(item, style: TTextTheme.medium14(context)),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  );
                }),
              ),
            ];
          },
        );
      });
    });
  }

  // Date Field
  Widget _buildDateFieldBox(BuildContext context, TextEditingController targetController, LayerLink link) {
    return CompositedTransformTarget(
      link: link,
      child: Container(
        height: 38,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: AppColors.secondaryColor,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: targetController,
                readOnly: true,
                style: TTextTheme.titleTwo(context),
                onTap: () {
                  toggleCalendar(context, link, targetController, 180);
                },
                decoration: InputDecoration(
                  hintText: "Select Date",
                  hintStyle: TTextTheme.titleTwo(context).copyWith(color: Colors.grey),
                  border: InputBorder.none,
                  isDense: true,
                  contentPadding: EdgeInsets.zero,
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                toggleCalendar(context, link, targetController, 180);
              },
              child:  Image.asset(IconString.calendarIcon, height: 16,width: 16,),
            ),
          ],
        ),
      ),
    );
  }

  ///  Calendar Overlay Integration ---
  static final LayerLink startDateLink = LayerLink();
  static final LayerLink endDateLink = LayerLink();
  static OverlayEntry? calendarOverlay;

  void toggleCalendar(
      BuildContext context,
      LayerLink link,
      TextEditingController targetController,
      double width,
      ) {
    removeCalendar();

    calendarOverlay =
        _createCalendarOverlay(context, link, targetController, width);

    Overlay.of(context).insert(calendarOverlay!);
  }

  void removeCalendar() {
    calendarOverlay?.remove();
    calendarOverlay = null;
  }

  OverlayEntry _createCalendarOverlay(
      BuildContext context,
      LayerLink link,
      TextEditingController targetController,
      double fieldWidth,
      ) {
    final screenWidth = MediaQuery.of(context).size.width;

    final double popupWidth = fieldWidth.isInfinite
        ? screenWidth.clamp(250, 320)
        : fieldWidth.clamp(250, 380);

    return OverlayEntry(
      builder: (context) => Stack(
        children: [
          Positioned.fill(
            child: GestureDetector(
              onTap: removeCalendar,
              child: Container(color: Colors.transparent),
            ),
          ),

          CompositedTransformFollower(
            link: link,
            showWhenUnlinked: false,
            targetAnchor: Alignment.bottomLeft,
            followerAnchor: Alignment.topLeft,
            offset: const Offset(0, 6),
            child: Material(
              elevation: 12,
              borderRadius: BorderRadius.circular(12),
              clipBehavior: Clip.antiAlias,
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minWidth: 250,
                  maxWidth: popupWidth,
                ),
                child: CustomCalendarPopup(
                  width: popupWidth,
                  onCancel: removeCalendar,
                  onDateSelected: (date) {
                    final now = DateTime.now();
                    final today = DateTime(now.year, now.month, date.day);
                    if (date.isAfter(today)) {
                      return;
                    }
                    targetController.text = "${date.day}/${date.month}/${date.year}";
                    removeCalendar();
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}