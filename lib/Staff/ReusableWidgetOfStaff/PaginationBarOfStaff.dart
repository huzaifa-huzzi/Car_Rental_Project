import 'package:car_rental_project/Resources/Colors.dart';
import 'package:car_rental_project/Resources/TextTheme.dart';
import 'package:car_rental_project/Staff/StaffController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PaginationBarOfStaff extends StatelessWidget {
  final bool isMobile;
  final double tablePadding;

  final StaffController controller = Get.find<StaffController>();


  PaginationBarOfStaff({super.key, required this.isMobile, required this.tablePadding});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final alignment = isMobile ? MainAxisAlignment.start : MainAxisAlignment.spaceBetween;

      Widget rowContent = Row(
        mainAxisAlignment: alignment,
        children: [
          if (!isMobile) _resultsPerPageDropdown(context),
          _paginationControls(context),
        ],
      );

      if (isMobile) {
        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          child: rowContent,
        );
      } else {
        return rowContent;
      }
    });
  }



  ///  RESULTS PER PAGE DROPDOWN (Left side content for web only )
  Widget _resultsPerPageDropdown(BuildContext context) {

    String? selectedValue = controller.pageSize3.toString();

    return Row(
      children: [
        Text(
            "Results per page",
            style: TTextTheme.titleThree(context)
        ),
        const SizedBox(width: 8),
        Container(
          height: 36,
          padding: const EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(4),
            border: Border.all(color: AppColors.sideBoxesColor),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: selectedValue,
              isDense: true,
              icon: Icon(Icons.keyboard_arrow_down, color: AppColors.secondTextColor),
              style: TTextTheme.btnTwo(context),
              items: <String>['10', '20', '30', '40']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? newValue) {

              },
            ),
          ),
        ),
        const SizedBox(width: 16),
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


    final baseStyle = TTextTheme.btnTwo(context).copyWith(color: Colors.white);

    final bool isPrevDisabled = controller.currentPage3.value == 1;
    final bool isNextDisabled = controller.currentPage3.value >= controller.totalPages;


    bool isButtonDisabled = false;
    if (text == "Prev") {
      isButtonDisabled = isPrevDisabled;
    } else if (text == "Next") {

      isButtonDisabled = isNextDisabled;
    }


    final Color disabledColor = AppColors.secondTextColor.withOpacity(0.5);
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
      final bool isPrev = text == "Prev";

      return TextButton(
        onPressed: buttonAction,
        child: Container(
          height: size,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            color: isPrev
                ? AppColors.secondaryColor
                : Colors.white,
            borderRadius: BorderRadius.circular(4),
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
                  color: isPrev
                      ? AppColors.tertiaryTextColor
                      : (isButtonDisabled ? disabledColor : enabledColor),
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

      onTap: onTap,
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