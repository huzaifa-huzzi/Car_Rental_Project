

import 'package:car_rental_project/Portal/Admin/SidebarAdmin/SidebarController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:car_rental_project/Resources/Colors.dart';
import 'package:car_rental_project/Resources/TextTheme.dart';
import 'package:go_router/go_router.dart';

class SidebarComponentAdmin {

  /// Helper: Close drawer if mobile
  static void closeDrawerIfMobileAdmin(
      BuildContext context,
      GlobalKey<ScaffoldState> scaffoldKey,
      ) {
    if (scaffoldKey.currentState != null) {
      if (scaffoldKey.currentState!.isDrawerOpen) {
        Navigator.of(context).pop();
      }
    }
  }


  /// Menu item
  static Widget menuItemAdmin(
      BuildContext context,
      SideBarAdminController controller, {
        required String iconPath,
        required String title,
        Widget? trailing,
        bool? isSelected,
        required Function(String) onTap,
        required GlobalKey<ScaffoldState> scaffoldKey,
      }) {

    Widget buildItemContentAdmin(bool active) {
      return Container(
        margin: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        decoration: BoxDecoration(
          color: active ? AppColors.secondaryColor : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Image.asset(
              iconPath,
              width: 20,
              height: 20,
              color: active ? AppColors.primaryColor : AppColors.quadrantalTextColor,
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Text(
                title,
                overflow: TextOverflow.ellipsis,
                style: (active ? TTextTheme.btnSix(context) : TTextTheme.btnOne(context))
                    .copyWith(
                  color: active ? AppColors.textColor : AppColors.quadrantalTextColor,
                ),
              ),
            ),
            if (trailing != null) trailing,
          ],
        ),
      );
    }

    return InkWell(
      onTap: () {
        controller.selectMenu(title);
        onTap(title);
        closeDrawerIfMobileAdmin(context, scaffoldKey);
      },
      child: isSelected != null
          ? buildItemContentAdmin(isSelected)
          : Obx(() => buildItemContentAdmin(controller.selected.value == title)),
    );
  }

  /// Expandable Item
  static Widget expandableMenuItem(
      BuildContext context,
      SideBarAdminController controller, {
        required String iconPath,
        required String title,
        required String route,
        required List<Map<String, dynamic>> subItems,
        required GlobalKey<ScaffoldState> scaffoldKey,
        Map<String, dynamic>? extra,
      }) {
    return Obx(() {
      bool isExpanded = controller.expandedMenus[title] ?? false;
      bool isMainActive = controller.selected.value == title;

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () {
              controller.selectMenu(title);
              context.go(route, extra: extra);
              closeDrawerIfMobileAdmin(context, scaffoldKey);
            },
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              decoration: BoxDecoration(
                color: isMainActive ? AppColors.secondaryColor : Colors.transparent,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Image.asset(
                    iconPath,
                    width: 20,
                    height: 20,
                    color: isMainActive ? AppColors.primaryColor : AppColors.quadrantalTextColor,
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Text(
                      title,
                      style: (isMainActive ? TTextTheme.btnSix(context) : TTextTheme.btnOne(context)).copyWith(
                        color: isMainActive ? AppColors.textColor : AppColors.quadrantalTextColor,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => controller.toggleExpansion(title),
                    child: Icon(
                      isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                      color: AppColors.quadrantalTextColor,
                      size: 22,
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (isExpanded)
            ...subItems.map((sub) {
              return Padding(
                padding: const EdgeInsets.only(left: 28),
                child: IntrinsicHeight(
                  child: Row(
                    children: [
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(width: 1, color: AppColors.tertiaryTextColor.withOpacity(0.7)),
                          Container(
                            width: 6,
                            height: 6,
                            decoration: const BoxDecoration(color: AppColors.primaryColor, shape: BoxShape.circle),
                          ),
                        ],
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            controller.selectSubItem(title, sub['title']!);
                            context.go(sub['route']!, extra: sub['extra']);

                            closeDrawerIfMobileAdmin(context, scaffoldKey);
                          },
                          child: Container(
                            margin: const EdgeInsets.only(right: 14, top: 4, bottom: 4),
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                            decoration: BoxDecoration(
                              border: Border.all(color: AppColors.primaryColor),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              children: [
                                if (sub['icon'] != null)
                                  Image.asset(
                                    sub['icon'],
                                    width: 16,
                                    height: 16,
                                    color: AppColors.primaryColor,
                                  )
                                else
                                  const Icon(Icons.circle, size: 8, color: AppColors.primaryColor),
                                const SizedBox(width: 8),
                                Text(
                                  sub['title']!,
                                  style: TTextTheme.titleExpandableItem(context),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
        ],
      );
    });
  }

  /// Red dot with number
  static Widget redDotWithNumber(int number, BuildContext context) {
    return Container(
      width: 20,
      height: 20,
      alignment: Alignment.center,
      decoration: const BoxDecoration(
        color: AppColors.primaryColor,
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Text(
          number.toString(),
          textAlign: TextAlign.center,
          style: TTextTheme.pTwo(context).copyWith(
            color: AppColors.secondaryColor,
            fontSize: 10,
            height: 1.0,
          ),
        ),
      ),
    );
  }
}