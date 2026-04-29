import 'package:car_rental_project/Portal/Vendor/PickupCar/PickupCarInventory.dart';
import 'package:car_rental_project/Portal/Vendor/PickupCar/ReusableWidgetOfPickup/AddButtonOfPickup.dart';
import 'package:car_rental_project/Portal/Vendor/PickupCar/ReusableWidgetOfPickup/PaginationBarOfPickup.dart';
import 'package:car_rental_project/Resources/AppSizes.dart';
import 'package:car_rental_project/Resources/Colors.dart';
import 'package:car_rental_project/Resources/IconStrings.dart';
import 'package:car_rental_project/Resources/TextString.dart';
import 'package:car_rental_project/Resources/TextTheme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

class PickupTandCWidget extends StatelessWidget {
  const PickupTandCWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<PickupCarController>();
    final bool isMobile = AppSizes.isMobile(context);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTopHeader(context),

          const SizedBox(height: 25),
          Align(
            alignment: Alignment.centerRight,
            child: _buildPremiumSearchBar(context),
          ),

          const SizedBox(height: 30),

          ScrollConfiguration(
            behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              child: SizedBox(
                width: isMobile ? 980 : 1000,
                child: Column(
                  children: [
                    _buildTableHeader(context),
                    const SizedBox(height: 15),
                    Obx(() => Column(
                      children: controller.termsList.asMap().entries.map((entry) {
                        return _buildDataCard(context, entry.value, entry.key, controller);
                      }).toList(),
                    )),
                  ],
                ),
              ),
            ),
          ),

          const SizedBox(height: 30),
          PaginationBarOfPickup(isMobile: isMobile, tablePadding: 0),
        ],
      ),
    );
  }
  /// --------- Extra Widgets ------ ///
  //  Search Bar Widget
  Widget _buildPremiumSearchBar(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final bool isMobile = screenWidth < 600;

    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        height: 44,
        width: isMobile ? (screenWidth * 0.88) : 350,
        decoration: BoxDecoration(
          color: AppColors.signaturePadColor,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color:AppColors.tertiaryTextColor.withOpacity(0.7)),
        ),
        child: Row(
          children: [
            const SizedBox(width: 12),
            const Icon(Icons.search_rounded, size: 20, color: AppColors.secondTextColor),
            const SizedBox(width: 8),

            Expanded(
              child: TextField(
                cursorColor: AppColors.blackColor,
                textAlignVertical: TextAlignVertical.center,
                style: TTextTheme.smallX2(context),
                decoration: InputDecoration(
                  hintText: isMobile ? "Search..." : "Search by version number...",
                  hintStyle: TTextTheme.smallX(context),
                  border: InputBorder.none,
                  isDense: true,
                  contentPadding: EdgeInsets.all(8),
                ),
              ),
            ),

            GestureDetector(
              onTap: () {
              },
              child: Container(
                height: 36,
                margin: const EdgeInsets.only(right: 4),
                width: isMobile ? 40 : 90,
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
      ),
    );
  }

  // Title header Section
  Widget _buildTopHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(TextString.tandCTitle, style: TTextTheme.h6Style(context)),
              const SizedBox(height: 4),
              Text(TextString.tandCSubtitle, style: TTextTheme.titleThree(context)),
            ],
          ),
        ),
        AddButtonOfPickup(
          text: "Add Pick up T&C",
          onTap: () {
            context.go('/AddpickupT&C', extra: {"hideMobileAppBar": true});
          },
        ),
      ],
    );
  }

   // Table Header
  Widget _buildTableHeader(BuildContext context) {
    final controller = Get.find<PickupCarController>();
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      decoration: BoxDecoration(
        color: AppColors.secondaryColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          _headerText("Version", 3, context, controller),
          _headerText("Date", 3, context, controller),
          _headerText("Time", 3, context, controller),
          _headerText("Status", 3, context, controller),
          _headerText("Action", 4, context, controller),
        ],
      ),
    );
  }
  //header Text
  Widget _headerText(String title, int flex, BuildContext context,PickupCarController controller) {
    bool isAction = title.toLowerCase() == "action";

    return Expanded(
      flex: flex,
      child: InkWell(
        onTap: isAction ? null : () => controller.togglePickupSort(title),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(title, style: TTextTheme.versionHeaderText(context)),
            const SizedBox(width: 4),

            if (!isAction)
              Obx(() {
                bool isCurrent = controller.pickupSortColumn.value == title;
                int order = isCurrent ? controller.pickupSortOrder.value : 0;

                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ClipRect(
                      child: Align(
                        alignment: Alignment.topCenter,
                        heightFactor: 0.5,
                        child: Image.asset(
                          IconString.sortIcon,
                          height: 14,
                          color: order == 1 ? AppColors.primaryColor : AppColors.textColor,
                        ),
                      ),
                    ),
                    const SizedBox(height: 1),
                    ClipRect(
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        heightFactor: 0.5,
                        child: Image.asset(
                          IconString.sortIcon,
                          height: 14,
                          color: order == 2 ? AppColors.primaryColor : AppColors.textColor,
                        ),
                      ),
                    ),
                  ],
                );
              }),
          ],
        ),
      ),
    );
  }
   // Data Cards
  Widget _buildDataCard(BuildContext context, Map<String, String> item, int index, PickupCarController controller) {
    bool isActive = item['status'] == 'Active';
    final LayerLink rowLink = controller.getLayerLink(item['version']!);
    final OverlayPortalController portalController = OverlayPortalController();

    return CompositedTransformTarget(
      link: rowLink,
      child: OverlayPortal(
        controller: portalController,
        overlayChildBuilder: (context) {
          return CompositedTransformFollower(
            link: rowLink,
            targetAnchor: Alignment.bottomRight,
            followerAnchor: Alignment.topRight,
            offset: const Offset(0, -20),
            child: Align(
              alignment: Alignment.topRight,
              child: _buildActivatedNotification(item['version']!,context),
            ),
          );
        },
        child: Obx(() {
          if (controller.activeLoadingIndex.value == index) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (!portalController.isShowing) portalController.show();
            });
          } else {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (portalController.isShowing) portalController.hide();
            });
          }

          return Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
            decoration: BoxDecoration(
              color: AppColors.signaturePadColor,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.tertiaryTextColor.withOpacity(0.4)),
            ),
            child: Row(
              children: [
                Expanded(flex: 3, child: Text(item['version']!, style: TTextTheme.versionText(context))),
                Expanded(flex: 3, child: Text(item['date']!, style: TTextTheme.subVersionText(context))),
                Expanded(flex: 3, child: Text(item['time']!, style: TTextTheme.subVersionText(context))),
                Expanded(flex: 3, child: _statusBadge(isActive, context)),
                Expanded(
                  flex: 4,
                  child: Row(
                    children: [
                      _viewButton(context),
                      if (!isActive) ...[
                        const SizedBox(width: 12),
                        AddButtonOfPickup(
                          text: "Enable",
                          width: 100,
                          height: 35,
                          onTap: () => controller.activateVersion(index),
                          icon: Image.asset(IconString.enableIcon),
                        ),
                      ]
                    ],
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
   // Notification
  Widget _buildActivatedNotification(String version,BuildContext context) {
    return Material(
      elevation: 8,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        width: 320,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: AppColors.fieldsBackground,
              blurRadius: 10,
              offset: const Offset(0, 4),
            )
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "$version has Activated",
                    style: TTextTheme.titleSmallRegister(context),
                  ),
                  const SizedBox(height: 4),
                   Text(
                    TextString.tandCVersion,
                    style: TTextTheme.titleThree(context),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 10),
            Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: AppColors.tertiaryTextColor,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.close,
                  size: 14,
                  color: AppColors.textColor,
                ),
              ),
          ],
        ),
      ),
    );
  }

  // View button
  Widget _viewButton(BuildContext context) {
    return InkWell(
      onTap: (){
        context.go('/pickupT&Cdescription', extra: {"hideMobileAppBar": true},);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: AppColors.primaryColor),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(IconString.viewIcon, color: AppColors.primaryColor),
            const SizedBox(width: 4),
            Text("View", style: TTextTheme.viewBtnText(context)),
          ],
        ),
      ),
    );
  }

   // Badges
  Widget _statusBadge(bool active,BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        decoration: BoxDecoration(
          color: active ? AppColors.activeColor2 : AppColors.quadrantalTextColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(active ? "Active" : "Inactive",
          style: TTextTheme.activeText(context),
        ),
      ),
    );
  }
}