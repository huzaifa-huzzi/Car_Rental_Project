import 'package:car_rental_project/Resources/IconStrings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:car_rental_project/Resources/Colors.dart';
import 'package:car_rental_project/Resources/TextTheme.dart';
import '../SideBarController.dart' show SideBarController;

class SidebarComponents {

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


  /// Menu item
  static Widget menuItem(
      BuildContext context,
      SideBarController controller, {
        required String iconPath,
        required String title,
        Widget? trailing,
        required Function(String) onTap,
        required GlobalKey<ScaffoldState> scaffoldKey,
      }) {
    return  InkWell(
      hoverColor: Colors.transparent,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      focusColor: Colors.transparent,

      onTap: () {
        controller.selectMenu(title);
        onTap(title);
        closeDrawerIfMobile(context, scaffoldKey);
      },
      child: Obx(() {
        bool active = controller.selected.value == title;
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
                color: active
                    ? AppColors.primaryColor
                    : AppColors.quadrantalTextColor,
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Text(
                  title,
                  overflow: TextOverflow.ellipsis,
                  style: (active
                      ? TTextTheme.btnSix(context)
                      : TTextTheme.btnOne(context)
                  ).copyWith(
                    color: active
                        ? AppColors.textColor
                        : AppColors.quadrantalTextColor,
                  ),
                ),
              ),
              if (trailing != null) trailing,
            ],
          ),
        );
      }),
    );

  }

  /// Expense menu item with sub-items
  static Widget expenseMenuItem(
      BuildContext context,
      SideBarController controller, {
        required Function(String) onTap,
        required GlobalKey<ScaffoldState> scaffoldKey,
      }) {
    return Obx(() {
      bool expanded = controller.isExpensesExpanded.value;
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            hoverColor: Colors.transparent,
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            focusColor: Colors.transparent,
            onTap: () {
              controller.toggleExpensesSub();
              onTap("Expenses");
              closeDrawerIfMobile(context, scaffoldKey);
            },
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              decoration: BoxDecoration(
                color: expanded ? AppColors.secondaryColor : null,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Image.asset(
                    IconString.expensesIcon,
                    width: 20,
                    height: 20,
                    color: expanded ? AppColors.primaryColor : AppColors.quadrantalTextColor,
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Text(
                      "Expenses",
                      style: (expanded
                          ? TTextTheme.btnSix(context)
                          : TTextTheme.btnOne(context)
                      ).copyWith(
                        color: expanded ? AppColors.textColor : AppColors.quadrantalTextColor,
                      ),
                    ),
                  ),
                  Icon(
                    expanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                    color: AppColors.quadrantalTextColor,
                    size: 20,
                  ),
                ],
              ),
            ),
          ),
          if (expanded) ...[
            expenseSubItem(context, controller, "1", onTap: onTap, scaffoldKey: scaffoldKey),
            expenseSubItem(context, controller, "2", onTap: onTap, scaffoldKey: scaffoldKey),
            expenseSubItem(context, controller, "3", onTap: onTap, scaffoldKey: scaffoldKey),
          ],
        ],
      );
    });
  }

  /// Expense sub-item
  static Widget expenseSubItem(
      BuildContext context,
      SideBarController controller,
      String title, {
        required Function(String) onTap,
        required GlobalKey<ScaffoldState> scaffoldKey,
      }) {
    return Padding(
      padding: const EdgeInsets.only(left: 54, bottom: 6),
      child: Obx(() {
        bool isActive = controller.subSelected.value == title;
        return InkWell(
          onTap: () {
            controller.selectSubItem("Expenses", title);
            onTap(title);
            closeDrawerIfMobile(context, scaffoldKey);
          },
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              title,
              style: (isActive
                  ? TTextTheme.btnSix(context)
                  : TTextTheme.btnOne(context)
              ).copyWith(
                  color: isActive ? AppColors.primaryColor : AppColors.secondTextColor),
            ),
          ),
        );
      }),
    );
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
      child: Text(
        number.toString(),
        textAlign: TextAlign.center,
        style: TTextTheme.pTwo(context).copyWith(
          color: AppColors.secondaryColor,
          fontSize: 10,
          height: 1.0,
        ),
      ),
    );
  }
}