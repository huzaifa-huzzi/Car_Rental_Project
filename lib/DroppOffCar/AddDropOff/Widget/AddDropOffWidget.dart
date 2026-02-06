import 'package:car_rental_project/DroppOffCar/DropOffController.dart';
import 'package:car_rental_project/DroppOffCar/ReusableWidgetOfDropoff/PrimaryBtnDropOff.dart';
import 'package:car_rental_project/Resources/Colors.dart';
import 'package:car_rental_project/Resources/IconStrings.dart';
import 'package:car_rental_project/Resources/ImageString.dart';
import 'package:car_rental_project/Resources/TextString.dart';
import 'package:car_rental_project/Resources/TextTheme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import '../../../Resources/AppSizes.dart' show AppSizes;


class AddDropOffWidget extends StatelessWidget {
  AddDropOffWidget({super.key});

  final DropOffController controller = Get.put(DropOffController());

  @override
  Widget build(BuildContext context) {

    return Obx(() {
      bool isTyping = controller.searchQuery.value.isNotEmpty;

      return Container(
        width: double.infinity,
        constraints: const BoxConstraints(minHeight: 220),
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //  Header
            Text(TextString.titleViewPickStepTwoDropOffAdd, style: TTextTheme.h5Style(context)),
            const SizedBox(height: 4),
            Text(
              TextString.titleViewSubtitleStepTwoDropOffAdd,
              style: TTextTheme.pTwo(context),
            ),

            const Padding(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: Divider(height: 1, color:AppColors.quadrantalTextColor),
            ),

            // SearchBar
            Row(
              children: [
                _buildCategorySelection(
                  context,
                  controller,
                  52,
                  true,
                ),
                const SizedBox(width: 12),

                Expanded(
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      final isMobile = AppSizes.isMobile(context);

                      return Container(
                        height: 52,
                        padding: const EdgeInsets.only(left: 16, right: 6),
                        decoration: BoxDecoration(
                          color: AppColors.backgroundOfPickupsWidget,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          children: [
                            if (!isMobile) ...[
                              Icon(Icons.search, size: 18, color: AppColors.secondTextColor),
                              const SizedBox(width: 10),
                            ],

                            Expanded(
                              child: TextField(
                                cursorColor: AppColors.blackColor,
                                controller: controller.searchController,
                                onChanged: controller.onSearchChanged,
                                style: TTextTheme.insidetextfieldWrittenText(context),
                                decoration: InputDecoration(
                                  hintText: "Search Pickup by customer",
                                  hintStyle: TTextTheme.textFieldWrittenText(context),
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.zero,
                                ),
                              ),
                            ),

                            GestureDetector(
                              onTap: controller.selectedSearchType2.call,
                              child: Container(
                                height: 40,
                                padding: EdgeInsets.symmetric(horizontal: isMobile ? 12 : 24),
                                decoration: BoxDecoration(
                                  color: AppColors.primaryColor,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                alignment: Alignment.center,
                                child: isMobile
                                    ? const Icon(Icons.search, color: Colors.white, size: 18)
                                    : Text("Search", style: TTextTheme.btnSearch(context)),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),

              ],
            ),

            // Result Showing Section
            if (isTyping) ...[
              const SizedBox(height: 30),

              LayoutBuilder(
                builder: (context, constraints) {
                  const double minContentWidth = 1100;
                  final bool enableScroll = constraints.maxWidth < minContentWidth;

                  return Scrollbar(
                    controller: controller.horizontalScrollController,
                    thumbVisibility: enableScroll,
                    child: SingleChildScrollView(
                      controller: controller.horizontalScrollController,
                      scrollDirection: Axis.horizontal,
                      physics: enableScroll
                          ? const AlwaysScrollableScrollPhysics()
                          : const ClampingScrollPhysics(),
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          minWidth: enableScroll ? minContentWidth : constraints.maxWidth,
                        ),
                        child: IntrinsicWidth(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 40.0, bottom: 35.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                ...List.generate(3, (index) {
                                  return Column(
                                    crossAxisAlignment: CrossAxisAlignment.stretch,
                                    children: [
                                      _buildResultItem(context, index, 3),
                                      Divider(
                                        height: 1.2,
                                        thickness: 1,
                                        color: AppColors.backgroundOfPickupsWidget,
                                      ),
                                    ],
                                  );
                                }),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ],
        ),
      );
    });
  }

  ///------ Extra Widgets ------------------///

  Widget _buildCategorySelection(
      BuildContext context,
      DropOffController controller,
      double height,
      bool showText,
      ) {
    final double screenWidth = MediaQuery.of(context).size.width;
    bool shouldShowText = screenWidth > 600 ? showText : false;
    double maxWidth = shouldShowText ? (screenWidth > 1100 ? 200 : 150) : 60;

    return Container(
      height: height,
      constraints: BoxConstraints(maxWidth: maxWidth),
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: AppColors.backgroundOfPickupsWidget,
        borderRadius: BorderRadius.circular(AppSizes.borderRadius(context)),
      ),
      child: Theme(
        data: Theme.of(context).copyWith(
          dividerColor: Colors.transparent,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.white)
              .copyWith(surface: Colors.white),
        ),
        child: PopupMenuButton<String>(
          offset: const Offset(0, 45),
          color: AppColors.backgroundOfPickupsWidget,
          elevation: 8,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          onSelected: (val) => controller.selectedSearchType.value = val,
          itemBuilder: (context) => [
            _buildPopupItem("Customer Name", IconString.nameIcon, context),
            _buildPopupItem("VIN Number", IconString.vinNumberIcon, context),
            _buildPopupItem("Registration", IconString.registrationIcon, context),
            _buildPopupItem("Car Name", IconString.carNameIcon, context, isLast: true),
          ],
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                _getIconPathForType(controller.selectedSearchType.value),
                width: 18,
                color: AppColors.quadrantalTextColor,
              ),
              if (shouldShowText) ...[
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
              const Icon(Icons.keyboard_arrow_down,
                  size: 16, color: AppColors.secondTextColor),
            ],
          ),
        ),
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
                Image.asset(icon, color: AppColors.quadrantalTextColor, width: 18),
                const SizedBox(width: 12),
                Text(text, style: TTextTheme.titleThree(context)),
              ],
            ),
          ),
          if (!isLast)
            Divider(height: 1, thickness: 0.5, color: AppColors.primaryColor),
        ],
      ),
    );
  }

  String _getIconPathForType(String type) {
    switch (type) {
      case "Customer Name":
        return IconString.nameIcon;
      case "VIN Number":
        return IconString.vinNumberIcon;
      case "Registration":
        return IconString.registrationIcon;
      case "Car Name":
        return IconString.carInventoryIcon;
      default:
        return IconString.nameIcon;
    }
  }

  Widget _buildResultItem(BuildContext context, int index, int total) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 6),
          child: Row(
            children: [
              const CircleAvatar(
                radius: 18,
                backgroundImage: AssetImage(ImageString.userImage),
              ),
              const SizedBox(width: 12),

              SizedBox(
                width: 300,
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(TextString.titleViewPickStepTwoDropOffTitle,
                      style: TTextTheme.pOne(context),),
                   Text(TextString.titleViewSubtitleStepTwoDropOffEmail,
                      style: TTextTheme.pFour(context)),
                ]),
              ),

              SizedBox(width: 170, child: _buildLabelValue(context,TextString.titleViewPickStepTwoDropOffVin, "JTNBA3HK003001234")),
              SizedBox(width: 160, child: _buildLabelValue(context,TextString.titleViewPickStepTwoDropOffTitleReg , "1234567890")),
              SizedBox(width: 200, child: _buildLabelValue(context,TextString.titleViewPickStepTwoDropOffTitleCarName , "Toyota Corolla (2017)")),

              PrimaryBthDropOff(
                text: "Select",
                onTap: () {
                  context.push('/addDropOffDetailTwo', extra: {"hideMobileAppBar": true});
                },
              ),
            ],
          ),
        ),
      ],
    );
  }


  Widget _buildLabelValue(BuildContext context, String label, String value) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(label, style: TTextTheme.pOne(context)),
      const SizedBox(height: 4),
      Text(value, style: TTextTheme.pFour(context)),
    ]);
  }
}

