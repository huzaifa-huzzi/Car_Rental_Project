import 'package:car_rental_project/Portal/Admin/SidebarAdmin/SidebarController.dart';
import 'package:car_rental_project/Portal/Staff/SidebarStaff/SidebarStaff.dart';
import 'package:car_rental_project/Portal/Staff/SidebarStaff/SidebarStaffController.dart';
import 'package:car_rental_project/Portal/Vendor/SideScreen/Widget/EmailVerificationDialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:car_rental_project/Resources/Colors.dart';
import 'package:car_rental_project/Resources/TextTheme.dart';
import 'package:go_router/go_router.dart';

class SidebarComponentStaff {

  /// Helper: Close drawer if mobile
  static void closeDrawerIfMobile(
      BuildContext context,
      GlobalKey<ScaffoldState> scaffoldKey,
      ) {
    if (scaffoldKey.currentState != null) {
      if (scaffoldKey.currentState!.isDrawerOpen) {
        Navigator.of(context).pop();
      }
    }
  }

  /// Email Verification
  static Widget emailNotVerifiedCard(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 14, vertical: 20),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.primaryColor, width: 1),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.backgroundOfPickupsWidget,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(
              Icons.report_gmailerrorred_rounded,
              color: AppColors.primaryColor,
              size: 24,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            "Email not verified?",
            style: TTextTheme.h6Style(context),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            height: 40,
            child: ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => const EmailVerificationDialog(),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                elevation: 0,
              ),
              child: Text(
                "Verify Now",
                style: TTextTheme.h16Style(context),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Menu item
  static Widget menuItemStaff(
      BuildContext context,
      SidebarStaffController controller, {
        required String iconPath,
        required String title,
        Widget? trailing,
        bool? isSelected,
        required Function(String) onTap,
        required GlobalKey<ScaffoldState> scaffoldKey,
      }) {

    Widget buildItemContent(bool active) {
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
        closeDrawerIfMobile(context, scaffoldKey);
      },
      child: isSelected != null
          ? buildItemContent(isSelected)
          : Obx(() => buildItemContent(controller.selected.value == title)),
    );
  }

  /// Expandable Item
  static Widget expandableMenuItem(
      BuildContext context,
      SidebarStaffController controller, {
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
      final String currentRoute = GoRouterState.of(context).uri.toString().toLowerCase();

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () {
              controller.selectMenu(title);
              context.go(route, extra: extra);
              closeDrawerIfMobile(context, scaffoldKey);
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
            Padding(
              padding: const EdgeInsets.only(left: 28),
              child: Column(
                children: subItems.map((sub) {
                  final String subRoute = (sub['route'] ?? '').toString().toLowerCase();
                  bool isSubSelected = subRoute.isNotEmpty && currentRoute.contains(subRoute);

                  return IntrinsicHeight(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        SizedBox(
                          width: 12,
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Container(
                                width: 1,
                                color: AppColors.tertiaryTextColor.withValues(alpha: 0.5),
                              ),
                              if (isSubSelected)
                                Container(
                                  width: 6,
                                  height: 6,
                                  decoration: const BoxDecoration(
                                    color: AppColors.primaryColor,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: InkWell(
                            borderRadius: BorderRadius.circular(8),
                            onTap: () {
                              controller.selectSubItem(title, sub['title']!);
                              context.go(sub['route']!, extra: sub['extra']);
                              closeDrawerIfMobile(context, scaffoldKey);
                            },
                            child: Container(
                              margin: const EdgeInsets.only(right: 14, top: 4, bottom: 4),
                              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                              decoration: BoxDecoration(
                                color: isSubSelected
                                    ? AppColors.backgroundOfScreenColor
                                    : Colors.transparent,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                sub['title']!,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: isSubSelected ? FontWeight.w500 : FontWeight.w400,
                                  color: isSubSelected
                                      ? AppColors.primaryColor
                                      : AppColors.quadrantalTextColor,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
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