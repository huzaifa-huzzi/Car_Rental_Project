import 'package:car_rental_project/Customers/CustomersController.dart';
import 'package:car_rental_project/Customers/ReusableWidgetOfCustomers/AddButtonOfCustomers.dart';
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

    final double horizontalPadding = screenWidth < 280 ? 4.0 : AppSizes.horizontalPadding(context);
    final double smallSpacing = screenWidth < 280 ? 4.0 : AppSizes.padding(context) * 0.75;
    final double buttonHeight = 40.0;

    final bool showRedSearchButton = screenWidth > 550;
    final bool showCategoryText = screenWidth > 500;

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
              _buildCategorySelection(context, controller, buttonHeight, showCategoryText),

              const SizedBox(width: 8),

              Expanded(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(minWidth: 120, maxWidth: 450),
                  child: _searchBarWithButton(context, controller, buttonHeight, showRedSearchButton),
                ),
              ),

              SizedBox(width: smallSpacing /2 ),

              Obx(() => _headerButton(
                context: context,
                icon: IconString.filterIcon,
                text: "Filter",
                isOpen: controller.isFilterOpen.value,
                showText: screenWidth > 450,
                onTap: controller.toggleFilter,
              )),


              if (isWeb) ...[
                const Spacer(),
                AddButtonOfCustomer(
                  text: "Add Customers",
                  width: 135,
                  height: 40,
                  onTap: () => context.push('/addNewCustomer', extra: {"hideMobileAppBar": true}),
                ),
              ],
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
  // category Selection Widget
  Widget _buildCategorySelection(BuildContext context, CustomerController controller, double height, bool showText) {
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
              _buildPopupItem("Email", IconString.smsIcon, context),
              _buildPopupItem("Phone Number", IconString.callIcon, context),
              _buildPopupItem("License Detail", IconString.licesnseNo, context, isLast: true),
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
  Widget _searchBarWithButton(BuildContext context, CustomerController controller, double height, bool showButton) {
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
                hintText: screenWidth > 750 ? "Search Pickup by Customer Name" : "Search...",
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
  // Filter Panel Widget
  Widget _buildResponsiveFilterPanel(BuildContext context, bool isMobile, CustomerController controller) {
    return Align(
      alignment: isMobile ? Alignment.center : Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.symmetric(
          horizontal: AppSizes.horizontalPadding(context),
          vertical: 10,
        ),
        width: isMobile ? MediaQuery.of(context).size.width * 0.9 : null,
        padding: EdgeInsets.all(AppSizes.padding(context)),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(AppSizes.borderRadius(context)),
        ),
        child: isMobile
            ? Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _filterItem("Age", _textFieldBox("34", context), context),
            const SizedBox(height: 16),
            _filterItem("Phone Number", _textFieldBox("012 09786754", context), context),
            const SizedBox(height: 16),
            _filterItem("Address", _textFieldBox("404 super", context), context),
          ],
        )
            : Wrap(
          spacing: 10,
          runSpacing: 16,
          crossAxisAlignment: WrapCrossAlignment.start,
          children: [
            _filterItem("Age", _textFieldBox("34", context), context, customWidth: 100),
            _filterItem("Phone Number", _textFieldBox("012 0978754", context), context, customWidth: 150),
            _filterItem("Address", _textFieldBox("404 super", context), context, customWidth: 200),
          ],
        ),
      ),
    );
  }
  // filter Item Widget
  Widget _filterItem(String title, Widget child, BuildContext context, {double? customWidth}) {
    double screenWidth = MediaQuery.of(context).size.width;
    bool isMobile = screenWidth < 600;

    double calculatedWidth = isMobile ? (screenWidth * 0.8) : (customWidth ?? 130);

    return SizedBox(
      width: calculatedWidth,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: TTextTheme.btnFour(context), maxLines: 1, overflow: TextOverflow.ellipsis),
          const SizedBox(height: 6),
          child,
        ],
      ),
    );
  }
  // textfield Widget
  Widget _textFieldBox(String label, BuildContext context) {
    return Container(
      height: 38,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppSizes.borderRadius(context) * 0.8),
        color: AppColors.secondaryColor,
      ),
      padding: EdgeInsets.symmetric(horizontal: AppSizes.padding(context) * 0.5),
      child: Center(
        child: TextField(
          cursorColor: AppColors.blackColor,
          style: TTextTheme.titleTwo(context),
          decoration: InputDecoration(
            hintText: label,
            hintStyle: TTextTheme.titleTwo(context),
            border: InputBorder.none,
            isCollapsed: true,
          ),
        ),
      ),
    );
  }
  // headerButton Widget
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
            const SizedBox(width: 4),
            Icon(isOpen ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down, size: 18, color: isOpen ? AppColors.primaryColor : AppColors.secondTextColor),
          ],
        ),
      ),
    );
  }

  // PopMenuItem Widget
  PopupMenuItem<String> _buildPopupItem(
      String text,
      String icon,
      BuildContext context,
      {bool isLast = false}
      ) {
    return PopupMenuItem(
      value: text,
      padding: EdgeInsets.zero,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              children: [
                Image.asset(
                    icon,
                    color: AppColors.quadrantalTextColor
                ),
                const SizedBox(width: 12),
                Text(text, style: TTextTheme.titleThree(context)),
              ],
            ),
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

  String _getIconPathForType(String type) {
    switch (type) {
      case "Email":
        return IconString.smsIcon;
      case "Phone Number":
        return IconString.callIcon;
      case "License Detail":
        return IconString.licesnseNo;
      case "Customer Name":
        return IconString.nameIcon;
      default:
        return IconString.nameIcon;
    }
  }
}