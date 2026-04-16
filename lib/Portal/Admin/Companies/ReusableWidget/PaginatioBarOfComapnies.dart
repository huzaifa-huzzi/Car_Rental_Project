import 'package:car_rental_project/Portal/Admin/Companies/CompaniesController.dart';
import 'package:car_rental_project/Resources/Colors.dart';
import 'package:car_rental_project/Resources/TextTheme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PaginationBarOfCompanies extends StatelessWidget {
  final bool isMobile;
  final double tablePadding;

  final CompaniesAdminController controller = Get.find<CompaniesAdminController>();


  PaginationBarOfCompanies({super.key, required this.isMobile, required this.tablePadding});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final double screenWidth = MediaQuery.of(context).size.width;
      bool useSpaceBetween = screenWidth > 600;

      return Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: useSpaceBetween
            ? Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _resultsPerPageDropdown(context),
            _paginationControls(context),
          ],
        )
            : Wrap(
          alignment: WrapAlignment.start,
          crossAxisAlignment: WrapCrossAlignment.center,
          spacing: 20,
          runSpacing: 15,
          children: [
            _resultsPerPageDropdown(context),
            _paginationControls(context),
          ],
        ),
      );
    });
  }


  ///  RESULTS PER PAGE DROPDOWN
  Widget _resultsPerPageDropdown(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text("Results per page", style: TextStyle(fontSize: isMobile ? 12 : 14)),
        const SizedBox(width: 8),
        Container(
          height: 32,
          padding: const EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            border: Border.all(color: AppColors.tertiaryTextColor.withOpacity(0.7)),
          ),
          child: DropdownButtonHideUnderline(
            child: Obx(() => DropdownButton<int>(
              value: [5, 10, 20, 50].contains(controller.pageSize3.value)
                  ? controller.pageSize3.value
                  : 5,
              icon:  Icon(Icons.keyboard_arrow_down_outlined, size: 20),
              items: [5, 10, 20, 50].map((int value) {
                return DropdownMenuItem<int>(
                  value: value,
                  child: Text("$value", style: const TextStyle(fontSize: 12)),
                );
              }).toList(),
              onChanged: (int? newValue) {
                if (newValue != null) {
                  controller.pageSize3.value = newValue;
                }
              },
            )),
          ),
        ),
      ],
    );
  }


  /// ----------------- PAGINATION CONTROLS -----------------
  Widget _paginationControls(BuildContext context) {
    final double buttonSize = isMobile ? 32 : 36;

    Widget prevButton = _pageButton(context, "Prev", onTap: () {}, isText: true);
    Widget nextButton = _pageButton(context, "Next", onTap: () {}, isText: true);

    List<Widget> pageButtons = [];
    final int total = controller.totalPages;
    int maxDisplayPages = total > 4 ? 4 : total;

    for (int i = 1; i <= maxDisplayPages; i++) {
      pageButtons.add(_pageButton(
        context,
        i.toString(),
        isSelected: controller.currentPage3.value == i,
        onTap: () => controller.goToPage(i),
        size: buttonSize,
      ));
    }

    Widget paginationRow = Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        prevButton,
        const SizedBox(width: 4),
        ...pageButtons.map((w) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 2),
          child: w,
        )),
        const SizedBox(width: 4),
        nextButton,
      ],
    );

    if (isMobile) {
      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        child: paginationRow,
      );
    } else {
      return paginationRow;
    }

  }


  Widget _pageButton(BuildContext context, String text, {
    required VoidCallback onTap,
    bool isSelected = false,
    bool isText = false,
    double size = 36,
  }) {
    final baseStyle = TTextTheme.btnTwo(context);

    final bool isPrevDisabled = controller.currentPage3.value == 1;
    final bool isNextDisabled = controller.currentPage3.value >= controller.totalPages;

    bool isButtonDisabled = false;
    if (text == "Prev") {
      isButtonDisabled = isPrevDisabled;
    } else if (text == "Next") {
      isButtonDisabled = isNextDisabled;
    }

    final Color disabledColor = AppColors.secondTextColor.withOpacity(0.4);
    final Color enabledColor = AppColors.secondTextColor;

    final VoidCallback? buttonAction = isButtonDisabled ? null : () {
      if (text == "Prev") {
        controller.goToPreviousPage();
      } else if (text == "Next") {
        controller.goToNextPage();
      } else {
        onTap();
      }
    };

    if (isText) {
      return InkWell(
        onTap: buttonAction,
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        child: Container(
          height: size,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(4),
            border: Border.all(color: AppColors.sideBoxesColor),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (text == "Prev")
                Icon(
                  Icons.chevron_left,
                  size: 18,
                  color: isButtonDisabled ? disabledColor : enabledColor,
                ),
              Text(
                text,
                style: baseStyle.copyWith(
                  color: isButtonDisabled ? disabledColor : enabledColor,
                  fontWeight: FontWeight.normal,
                ),
              ),
              if (text == "Next")
                Icon(
                  Icons.chevron_right,
                  size: 18,
                  color: isButtonDisabled ? disabledColor : enabledColor,
                ),
            ],
          ),
        ),
      );
    }

    return GestureDetector(
      onTap: isButtonDisabled ? null : onTap,
      child: Container(
        width: size,
        height: size,
        margin: const EdgeInsets.symmetric(horizontal: 2),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primaryColor : Colors.white,
          borderRadius: BorderRadius.circular(4),
          border: isSelected ? null : Border.all(color: AppColors.sideBoxesColor),
        ),
        child: Center(
          child: Text(
              text,
              style: baseStyle.copyWith(
                  color: isSelected ? Colors.white : AppColors.secondTextColor,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal
              )
          ),
        ),
      ),
    );
  }
}