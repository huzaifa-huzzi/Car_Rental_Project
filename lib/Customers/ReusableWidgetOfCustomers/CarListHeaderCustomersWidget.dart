import 'package:car_rental_project/Car%20Inventory/Car%20Directory/ReusableWidget/ButtonWidget.dart';
import 'package:car_rental_project/Customers/CustomersController.dart';
import 'package:car_rental_project/Resources/Colors.dart';
import 'package:car_rental_project/Resources/TextTheme.dart';
import 'package:flutter/material.dart';
import 'package:car_rental_project/Resources/AppSizes.dart';
import 'package:car_rental_project/Resources/IconStrings.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

class CardListHeaderCustomerWidget extends StatelessWidget {
  const CardListHeaderCustomerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isMobile = AppSizes.isMobile(context);
    final bool isWeb = AppSizes.isWeb(context);
    final controller = Get.put(CustomerController());
    final double screenWidth = MediaQuery.of(context).size.width;

    // Responsive Logic
    final double horizontalPadding = screenWidth < 280 ? 4.0 : AppSizes.horizontalPadding(context);
    final double smallSpacing = screenWidth < 280 ? 4.0 : AppSizes.padding(context) * 0.75;
    final double buttonHeight = isMobile ? 38.0 : AppSizes.buttonHeight(context) * 0.8;

    final bool showFilterText = screenWidth > 450 && !isMobile;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: horizontalPadding,
            vertical: AppSizes.verticalPadding(context),
          ),
          child: Row(
            children: [
              Expanded(
                flex: isMobile ? 3 : 0,
                child: SizedBox(
                  width: isMobile ? null : 250,
                  child: _searchBar(context, buttonHeight, isMobile),
                ),
              ),
              SizedBox(width: smallSpacing),

              Obx(() => _headerButton(
                context: context,
                icon: IconString.filterIcon,
                text: "Filter",
                isOpen: controller.isFilterOpen.value,
                showText: showFilterText,
                onTap: controller.toggleFilter,
              )),

              const Spacer(),

              if (isWeb)
                AddButton(
                  text: "Add Customers",
                  width: 135,
                  height: 40,
                  onTap: () => context.push('/addNewCustomer', extra: {"hideMobileAppBar": true}),
                ),
            ],
          ),
        ),

        Obx(() {
          if (!controller.isFilterOpen.value) return const SizedBox.shrink();
          return _buildResponsiveFilterPanel(context, isMobile, controller);
        }),
      ],
    );
  }

  /// ------ Extra Widgets -------- ///

  Widget _buildResponsiveFilterPanel(BuildContext context, bool isMobile, CustomerController controller) {
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
        child: isMobile
            ? Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                Expanded(child: _filterItem("Customers", _textFieldBox("Jack", context), context)),
                const SizedBox(width: 16),
                Expanded(child: _filterItem("Customers Age", _dropdownBox(["34", "35", "36"], controller.selectAge, context), context)),
              ],
            ),
            const SizedBox(height: 16),

            SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              child: _filterItem("Customers Address", _textFieldBox("404 super", context), context),
            ),
            const SizedBox(height: 16),

            SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              child: _filterItem("Customers Phone", _textFieldBox("012 09786754", context), context),
            ),
          ],
        )
            : Wrap(
          spacing: 16,
          runSpacing: 16,
          crossAxisAlignment: WrapCrossAlignment.start,
          children: [
            _filterItem("Customers", _textFieldBox("Jack", context), context, customWidth: 130),
            _filterItem("Customers Age", _dropdownBox(["34", "35"], controller.selectAge, context), context, customWidth: 130),
            _filterItem("Customers Phone", _textFieldBox("012 09786754", context), context, customWidth: 130),
            _filterItem("Customers Address", _textFieldBox("404 super", context), context, customWidth: 130),
          ],
        ),
      ),
    );
  }

  // filter Item Widget
  Widget _filterItem(String title, Widget child, BuildContext context, {double? customWidth}) {
    double screenWidth = MediaQuery.of(context).size.width;
    double calculatedWidth = screenWidth < 500 ? (screenWidth - 60) / 2 : (customWidth ?? 130);

    return SizedBox(
      width: calculatedWidth,
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

  // TextField Widget
  Widget _textFieldBox(String label, BuildContext context) {
    return Container(
      width: double.infinity,
      height: 38,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppSizes.borderRadius(context) * 0.8),
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

  //  Dropdown Widget
  Widget _dropdownBox(
      List<String> items,
      RxString selectedRx,
      BuildContext context, {
        String placeholder = "Select",
      }) {
    return Obx(() {
      final double screenWidth = MediaQuery.of(context).size.width;
      final bool isMobile = screenWidth < 600;

      return PopupMenuButton<String>(
        offset: const Offset(0, 40),
        constraints: isMobile
            ? BoxConstraints(minWidth: screenWidth * 0.4)
            : null,
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
  // Searchbar Widget
  Widget _searchBar(BuildContext context, double height, bool isMobile) {
    return Container(
      height: height,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppSizes.borderRadius(context)),
      ),
      child: Row(
        children: [
          Image.asset(IconString.searchIcon, color: AppColors.secondTextColor, width: 16, height: 16),
          const SizedBox(width: 8),
          Expanded(
            child: TextField(
              style: TTextTheme.titleTwo(context).copyWith(fontSize: isMobile ? 12 : 14),
              decoration: InputDecoration(
                hintText: isMobile ? "Search..." : "Search client name, car, etc",
                hintStyle: TTextTheme.smallX(context),
                border: InputBorder.none,
                isCollapsed: true,
              ),
            ),
          ),
        ],
      ),
    );
  }


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