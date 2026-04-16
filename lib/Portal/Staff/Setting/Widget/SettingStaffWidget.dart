import 'package:car_rental_project/Portal/Staff/Setting/SettingStaffController.dart';
import 'package:car_rental_project/Portal/Staff/Setting/Widget/ChangePasswordWidget.dart';
import 'package:car_rental_project/Portal/Staff/Setting/Widget/CompanuInfoWidget.dart';
import 'package:car_rental_project/Portal/Staff/Setting/Widget/PersonalInfoWidget.dart';
import 'package:car_rental_project/Resources/Colors.dart';
import 'package:car_rental_project/Resources/IconStrings.dart';
import 'package:car_rental_project/Resources/TextTheme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingStaffWidget extends StatelessWidget {
  const SettingStaffWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SettingStaffController());

    final List<Map<String, dynamic>> menuItems = [
      {'title': 'Personal Info', 'icon': IconString.PersonalInfoStaff},
      {'title': 'Company Info', 'icon': IconString.companyInfoIcon},
      {'title': 'Change Password', 'icon': IconString.changePasswordIcon},
    ];

    return LayoutBuilder(builder: (context, constraints) {
      double screenWidth = MediaQuery.of(context).size.width;
      bool isCollapsed = screenWidth < 800;

      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!isCollapsed)
            Container(
              width: 250,
              margin: const EdgeInsets.only(right: 20),
              child: Column(
                children: List.generate(menuItems.length, (index) {
                  return Obx(() => _buildWebTabItem(
                      context,
                      index,
                      menuItems[index],
                      controller
                  ));
                }),
              ),
            ),

          Expanded(
            child: Column(
              children: [
                if (isCollapsed)
                  _buildMobileDropdownHeader(context, menuItems, controller),

                const SizedBox(height: 10),
                Obx(() => _buildActiveContent(controller.selectedTabIndex.value)),
              ],
            ),
          ),
        ],
      );
    });
  }

  /// --------- Extra Widgets ///

   // Mobile Dropdown Header
  Widget _buildMobileDropdownHeader(BuildContext context, List<Map<String, dynamic>> items, SettingStaffController controller) {
    return LayoutBuilder(builder: (context, constraints) {
      return Obx(() => PopupMenuButton<int>(
        constraints: BoxConstraints(minWidth: constraints.maxWidth, maxWidth: constraints.maxWidth),
        offset: const Offset(0, 55),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        color: Colors.white,
        onOpened: () => controller.isDropdownOpen.value = true,
        onCanceled: () => controller.isDropdownOpen.value = false,
        onSelected: (index) => controller.changeTab(index),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                items[controller.selectedTabIndex.value]['title'],
                style: TTextTheme.bodySemiBold16(context),
              ),
              Icon(
                 Icons.menu,
                color: AppColors.textColor,
              ),
            ],
          ),
        ),
        itemBuilder: (context) => items.asMap().entries.map((entry) {
          int index = entry.key;
          bool isSelected = controller.selectedTabIndex.value == index;

          return PopupMenuItem<int>(
            value: index,
            padding: EdgeInsets.zero,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: isSelected ? AppColors.secondaryColor : Colors.transparent,
              ),
              child: Row(
                children: [
                  Image.asset(
                    entry.value['icon'],
                    width: 20,
                    height: 20,
                    color: isSelected ? AppColors.primaryColor : AppColors.quadrantalTextColor,
                  ),
                  const SizedBox(width: 12),
                  Text(
                    entry.value['title'],
                    style: isSelected ?  TTextTheme.hsettingsSelectedDesign(context) : TTextTheme.btnsettingsSelectedDesign(context)
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ));
    });
  }

   // Web Side Tabs
  Widget _buildWebTabItem(BuildContext context, int index, Map<String, dynamic> item, SettingStaffController controller) {
    bool isActive = controller.selectedTabIndex.value == index;
    return GestureDetector(
      onTap: () => controller.changeTab(index),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: isActive ? AppColors.secondaryColor : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Image.asset(
              item['icon'],
              width: 20,
              height: 20,
              color: isActive ? AppColors.primaryColor : AppColors.quadrantalTextColor,
            ),
            const SizedBox(width: 12),
            Text(
              item['title'],
              style: isActive ?  TTextTheme.hsettingsSelectedDesign(context) : TTextTheme.btnsettingsSelectedDesign(context)
            ),
          ],
        ),
      ),
    );
  }

   // Screens Calling
  Widget _buildActiveContent(int index) {
    switch (index) {
      case 0: return const PersonalInfoWidget();
      case 1: return const CompanyInfoWidget();
      case 2: return const ChangePasswordWidget();
      default: return const SizedBox.shrink();
    }
  }
}