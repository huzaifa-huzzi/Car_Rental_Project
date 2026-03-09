import 'package:car_rental_project/PickupCar/PickupCarInventory.dart';
import 'package:car_rental_project/PickupCar/ReusableWidgetOfPickup/AddButtonOfPickup.dart';
import 'package:car_rental_project/PickupCar/ReusableWidgetOfPickup/PaginationBarOfPickup.dart';
import 'package:car_rental_project/Resources/AppSizes.dart';
import 'package:car_rental_project/Resources/Colors.dart';
import 'package:car_rental_project/Resources/IconStrings.dart';
import 'package:car_rental_project/Resources/TextTheme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PickupTandCWidget extends StatelessWidget {
  const PickupTandCWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isMobile = AppSizes.isMobile(context);

    final List<Map<String, String>> data = [
      {'version': 'V5', 'date': '5/03/2026', 'time': '12:30pm', 'status': 'Active'},
      {'version': 'V4', 'date': '5/03/2026', 'time': '9:30am', 'status': 'Inactive'},
      {'version': 'V3', 'date': '4/03/2026', 'time': '5:30pm', 'status': 'Inactive'},
      {'version': 'V2', 'date': '4/03/2026', 'time': '4:30pm', 'status': 'Inactive'},
      {'version': 'V1', 'date': '3/03/2026', 'time': '4:30pm', 'status': 'Inactive'},
    ];


    final double minTableWidth = isMobile ? 980 : 1000;

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
          LayoutBuilder(
            builder: (context, constraints) {
              bool isSmallScreen = constraints.maxWidth < 420;

              if (isSmallScreen) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Pickup term and condition",
                            style: TTextTheme.h6Style(context), overflow: TextOverflow.ellipsis, maxLines: 1,),
                        Text("List of all versions of term and condition",
                            style: TTextTheme.titleThree(context), overflow: TextOverflow.ellipsis, maxLines: 1),
                      ],
                    ),
                    const SizedBox(height: 16),
                    AddButtonOfPickup(
                      width: 130,
                      text: "Add Pick up T&C",
                      onTap: () {},
                    ),
                  ],
                );
              } else {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Pickup term and condition",
                            style: TTextTheme.h6Style(context), overflow: TextOverflow.ellipsis, maxLines: 1),
                        Text("List of all versions of term and condition",
                        style: TTextTheme.titleThree(context), overflow: TextOverflow.ellipsis, maxLines: 1),
                      ],
                    ),
                    AddButtonOfPickup(
                      text: "Add Pick up T&C",
                      onTap: () {},
                    ),
                  ],
                );
              }
            },
          ),
          const SizedBox(height: 30),

          ScrollConfiguration(
            behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              child: SizedBox(
                width: minTableWidth,
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                      decoration: BoxDecoration(
                        color: AppColors.secondaryColor,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          _headerText("Version", 3,context,PickupCarController()),
                          _headerText("Date", 3,context,PickupCarController()),
                          _headerText("Time", 3,context,PickupCarController()),
                          _headerText("Status", 3,context,PickupCarController()),
                          _headerText("Action", 4,context,PickupCarController()),
                        ],
                      ),
                    ),
                    const SizedBox(height: 15),
                    ...data.map((item) => _buildDataCard(context, item)),
                  ],
                ),
              ),
            ),
          ),

          const SizedBox(height: 30),
          PaginationBarOfPickup(
            isMobile: isMobile,
            tablePadding: 0,
          ),
        ],
      ),
    );
  }

   /// --------- Extra Widgets ------ ///
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
  Widget _buildDataCard(BuildContext context, Map<String, String> item) {
    bool isActive = item['status'] == 'Active';

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
          Expanded(flex: 3, child: Text(item['version']!, style:TTextTheme.versionText(context))),
          Expanded(flex: 3, child: Text(item['date']!, style: TTextTheme.subVersionText(context))),
          Expanded(flex: 3, child: Text(item['time']!, style: TTextTheme.subVersionText(context))),
          Expanded(flex: 3, child: _statusBadge(isActive,context)),
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
                    onTap: () {

                    },
                    icon: Image.asset(IconString.enableIcon),
                  ),
                ]
              ],
            ),
          ),
        ],
      ),
    );
  }

  // View button
  Widget _viewButton(BuildContext context) {
    return Container(
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