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
  @override
  Widget build(BuildContext context) {
    final bool isMobile = AppSizes.isMobile(context);
    final bool isTablet = AppSizes.isTablet(context);
    final bool isWeb = AppSizes.isWeb(context);
    final controller = Get.find<CarInventoryController>();

    final double screenWidth = MediaQuery.of(context).size.width;
    final bool isSmallMobile = screenWidth <= 300;

    const double minimumRowWidth = 720.0;
    const double filterTextHideThreshold = 450.0;
    const double tightSpacingThreshold = 380.0;

    final double horizontalPadding =
    screenWidth < 280 ? 4.0 : AppSizes.horizontalPadding(context);

    final double smallSpacing =
    screenWidth < 280 ? 4.0 : AppSizes.padding(context) * 0.75;

    final double buttonHeight =
    isMobile ? 38.0 : AppSizes.buttonHeight(context) * 0.8;

    final bool showFilterText =
        screenWidth >= filterTextHideThreshold && !isMobile;

    final double viewToggleSize =
    isSmallMobile ? 28.0 : isMobile ? 32.0 : buttonHeight * 0.85;


    Widget searchBar({required bool compact}) {
      return Container(
        height: buttonHeight,
        padding: EdgeInsets.symmetric(horizontal: AppSizes.padding(context) * 0.5),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(AppSizes.borderRadius(context)),
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
                style: compact ? TTextTheme.titleTwo(context).copyWith(fontSize: 10) : TTextTheme.titleTwo(context),
                decoration: InputDecoration(
                  isCollapsed: true,
                  contentPadding: EdgeInsets.zero,
                  hintText: isMobile || isTablet
                      ? "Search..."
                      : "Search client name, car, etc",
                  hintStyle: TTextTheme.smallX(context),
                  border: InputBorder.none,
                ),
              ),
            ),
          ],
        ),
      );
    }

    Widget filterButton = Obx(() {
      return _headerButton(
        context: context,
        icon: IconString.filterIcon,
        text: "Filter",
        isOpen: controller.isFilterOpen.value,
        showText: showFilterText,
        onTap: controller.toggleFilter,
      );
    });

    Widget viewToggle = Obx(() {
      final bool isUltraTight = screenWidth < tightSpacingThreshold;
      final double gap = isUltraTight ? 1.0 : 4.0;

      return Container(
        padding: EdgeInsets.symmetric(
          vertical: isUltraTight ? 2 : 2,
          horizontal: isUltraTight ? 4 : 6,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(AppSizes.borderRadius(context)),
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
            SizedBox(width: gap),
            _selectableIconButton(
              context: context,
              iconPath: IconString.previewTwo,
              isSelected: controller.selectedView.value == 1,
              onTap: () => controller.selectedView.value = 1,
              size: viewToggleSize,
            ),
            SizedBox(width: gap),
            _selectableIconButton(
              context: context,
              iconPath: IconString.previewThree,
              isSelected: controller.selectedView.value == 2,
              onTap: () => controller.selectedView.value = 2,
              size: viewToggleSize,
            ),
          ],
        ),
      );
    });

    Widget addCarButton = AddButton(
      text: "Add Car",
      width: 120,
      height: 40,
      onTap: () {
        context.push('/addNewCar', extra: {"hideMobileAppBar": true});
      },
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        LayoutBuilder(
          builder: (context, constraints) {
            final double maxWidth = constraints.maxWidth;


            if (maxWidth >= minimumRowWidth) {
              return Container(
                padding: EdgeInsets.symmetric(
                  horizontal: horizontalPadding,
                  vertical: AppSizes.verticalPadding(context),
                ),
                child: Row(
                  children: [
                    // LEFT SIDE
                    Row(
                      children: [
                        SizedBox(width: 220, child: searchBar(compact: false)),
                        SizedBox(width: smallSpacing),
                        filterButton,
                      ],
                    ),
                    const Spacer(),
                    // RIGHT SIDE
                    Row(
                      children: [
                        viewToggle,
                        if (isWeb) ...[const SizedBox(width: 16), addCarButton],
                      ],
                    ),
                  ],
                ),
              );
            }

            //  MOBILE / TABLET widget
            final bool forceScroll = maxWidth < 200;

            Widget content = Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // LEFT SIDE
                Flexible(
                  flex: 3,
                  child: SizedBox(
                    width: maxWidth < 260 ? 140 : 200,
                    child: searchBar(compact: true),
                  ),
                ),
                SizedBox(width: smallSpacing),
                filterButton,
                const Spacer(),
                // RIGHT SIDE
                viewToggle,
                if (isWeb) ...[const SizedBox(width: 12), addCarButton],
              ],
            );

            // SCROLL SAFETY
            if (forceScroll) {
              return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(children: [content]),
              );
            }

            return content;
          },
        ),

        Obx(() {
          return controller.isFilterOpen.value
              ? _buildFilterContainer(context)
              : const SizedBox.shrink();
        }),
      ],
    );
  }


  /// ----------Extra Widgets (used in the above code)----------///

  // Filter container widget
  Widget _buildFilterContainer(BuildContext context) {
    final CarInventoryController controller = Get.put(CarInventoryController());
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.symmetric(
          horizontal: AppSizes.horizontalPadding(context),
          vertical: AppSizes.padding(context) * 0.5,
        ),
        padding: EdgeInsets.all(AppSizes.padding(context)),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(AppSizes.borderRadius(context)),
        ),
        child: Wrap(
          spacing: 16,
          runSpacing: 16,
          crossAxisAlignment: WrapCrossAlignment.start,
          children: [
            _filterItem("Car Brand", _dropdownBox(["BMW", "Aston", "Range Rover"], controller.selectedBrand, context), context),
            _filterItem("Car Model", _dropdownBox(["Corolla", "Civic"], controller.selectedModel, context), context),
            _filterItem("Car Year", _dropdownBox(["2025", "2024"], controller.selectedYear, context), context),
            _filterItem("Body Type", _dropdownBox(["Sedan", "SUV"], controller.selectedBodyType, context), context),
            _filterItem("Car Status", _dropdownBox(["Available", "Unavailable"], controller.selectedStatus, context), context),
            _filterItem("Transmission", _dropdownBox(["Auto", "Manual"], controller.selectedTransmission, context), context),
            _filterItem("Fuel", _dropdownBox(["Petrol", "Hybrid"], controller.selectedFuel, context), context),
            _filterItem("Engine Size", _textFieldBox("2.5[L]", context), context),
            _filterItem("Price (Under)", _textFieldBox(r"$ 1600 (W)", context), context),
          ],
        ),
      ),
    );
  }

 // filter Item Widget
  Widget _filterItem(String title, Widget child, BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double itemWidth = screenWidth < 500 ? (screenWidth - 60) / 2 : 140;

    return SizedBox(
      width: screenWidth < 500 ? itemWidth : 130,
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



  // dropdown Box widget
  Widget _dropdownBox(
      List<String> items,
      RxString selectedRx,
      BuildContext context, {
        String placeholder = "Select",
      }) {
    return Obx(() {
      return PopupMenuButton<String>(
        offset: const Offset(0, 40),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        color: AppColors.secondaryColor,
        elevation: 4,
        tooltip: '',
        child: Container(
          height: 38,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: AppColors.secondaryColor,
            borderRadius: BorderRadius.circular(AppSizes.borderRadius(context) * 0.8),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  selectedRx.value.isEmpty ? placeholder : selectedRx.value,
                  style: selectedRx.value.isEmpty
                      ? TTextTheme.btnOne(context)
                      : TTextTheme.dropdowninsideText(context),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const Icon(Icons.keyboard_arrow_down, size: 22, color: Colors.black),
            ],
          ),
        ),
        onSelected: (v) => selectedRx.value = v,
        itemBuilder: (context) {
          return items.asMap().entries.map((entry) {
            int index = entry.key;
            String value = entry.value;
            bool isLast = index == items.length - 1;

            return PopupMenuItem<String>(
              value: value,
              padding: EdgeInsets.zero,
              height: 45,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    child: Text(
                      value,
                      style: TTextTheme.dropdowninsideText(context),
                    ),
                  ),
                  if (!isLast)
                    Divider(
                      height: 1,
                      thickness: 0.5,
                      color: AppColors.quadrantalTextColor,
                      indent: 0,
                      endIndent: 0,
                    ),
                ],
              ),
            );
          }).toList();
        },
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
          cursorColor: AppColors.blackColor,
          style: TTextTheme.insidetextfieldWrittenText(context),
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