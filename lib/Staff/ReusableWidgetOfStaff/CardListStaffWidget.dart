import 'package:car_rental_project/Resources/Colors.dart';
import 'package:car_rental_project/Resources/TextTheme.dart';
import 'package:car_rental_project/Staff/ReusableWidgetOfStaff/PrimaryBtnStaff.dart';
import 'package:car_rental_project/Staff/StaffController.dart';
import 'package:flutter/material.dart';
import 'package:car_rental_project/Resources/AppSizes.dart';
import 'package:car_rental_project/Resources/IconStrings.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

class CardListStaffWidget extends StatelessWidget {
  const CardListStaffWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double buttonHeight = 40.0;

    final bool showRedSearchButton = screenWidth > 600;
    final bool showCategoryText = screenWidth > 750;

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
              _buildCategorySelection(context, StaffController(), buttonHeight, showCategoryText),

              const SizedBox(width: 8),

              /// SearchBar
              Expanded(
                flex: 1,
                child: _searchBarWithButton(context, StaffController(), buttonHeight, showRedSearchButton),
              ),

              const SizedBox(width: 8),

              /// Add Button
              if (AppSizes.isWeb(context) && screenWidth > 1000) ...[
                const Spacer(),
                PrimaryBtnStaff(
                  text: "Add Staff",
                  width: 140,
                  height: 40,
                  onTap: (){
                    context.push('/addStaff', extra: {"hideMobileAppBar": true});
                  },
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }
  /// ------ Extra Widgets ---------///

  //  Category Selection Widget
  Widget _buildCategorySelection(BuildContext context, StaffController controller, double height, bool showText) {
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
            onSelected: (val) => controller.selectedSearchType2.value = val,
            itemBuilder: (context) => [
              _buildPopupItem("Staff Name", IconString.nameIcon, context),
              _buildPopupItem("Email", IconString.smsIcon, context),
            ],
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(_getIconPathForType(controller.selectedSearchType2.value), width: 18,color: AppColors.quadrantalTextColor,),
                if (showText) ...[
                  const SizedBox(width: 6),
                  Flexible(
                    child: Text(
                      controller.selectedSearchType2.value,
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
  Widget _searchBarWithButton(BuildContext context, StaffController controller, double height, bool showButton) {
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
                hintText: screenWidth > 750 ? "Search People by Mail" : "Search...",
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
      case "Email": return IconString.smsIcon;
      default: return IconString.nameIcon;
    }
  }


}