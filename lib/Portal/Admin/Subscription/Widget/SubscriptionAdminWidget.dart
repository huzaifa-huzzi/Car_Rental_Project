import 'package:car_rental_project/Portal/Admin/Subscription/ReusableWidget/PaginationBarOfSubscription.dart';
import 'package:car_rental_project/Portal/Admin/Subscription/SubscriptionController.dart' show SubscriptionController;
import 'package:car_rental_project/Resources/Colors.dart';
import 'package:car_rental_project/Resources/IconStrings.dart';
import 'package:car_rental_project/Resources/TextTheme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

class SubscriptionAdminWidget extends StatelessWidget {
  const SubscriptionAdminWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final SubscriptionController controller = Get.put(SubscriptionController());

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LayoutBuilder(
          builder: (context, constraints) {
            double width = constraints.maxWidth;
            bool isMobileHeader = width < 750;

            Widget headerTexts = Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Subscription detail", style: TTextTheme.h2Style(context)),
                const SizedBox(height: 4),
                Text("Your subscription detail is given below", style: TTextTheme.bodyRegular14(context)),
              ],
            );
            Widget singleHeaderButton = OutlinedButton(
              onPressed: () {
                context.go('/subscription/subscriptionFee');
              },
              style: OutlinedButton.styleFrom(
                backgroundColor: Colors.transparent,
                side: const BorderSide(color: AppColors.primaryColor),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              ),
              child: Text("Change subscription fee", style: TTextTheme.bodyRegular14Primary(context)),
            );

            if (isMobileHeader) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  headerTexts,
                  const SizedBox(height: 16),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: singleHeaderButton,
                  ),
                ],
              );
            } else {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(child: headerTexts),
                  singleHeaderButton,
                ],
              );
            }
          },
        ),

        const SizedBox(height: 30),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildStatsGrid(context),
            const SizedBox(height: 40),
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.02),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("All Subscriptions", style: TTextTheme.h2Style(context)),
                  Text("List of all subscriptions", style: TTextTheme.bodyRegular14(context)),

                  const SizedBox(height: 25),
                  _buildFiltersAndTabsRow(context, controller),

                  const SizedBox(height: 25),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildTableHeader(context, controller),
                        const SizedBox(height: 10),
                        Obx(() => Column(
                          children: controller.filteredSubscriptions
                              .map((data) => _buildSubscriptionRow(context, data,controller))
                              .toList(),
                        )),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),
                  PaginationBarOfSubscription(
                    isMobile: MediaQuery.of(context).size.width < 600,
                    tablePadding: 0,
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }


   /// --------- Extra Widget ---------- ///
  //GRID COMPONENT
  Widget _buildStatsGrid(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      double totalWidth = constraints.maxWidth;

      if (totalWidth >= 850) {
        double fixedCardWidth = (totalWidth - (16 * 3)) / 4;
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(child: _statCard(context, "Total New Subscriptions", "12", "3 more subscriber added", fixedCardWidth)),
            const SizedBox(width: 16),
            Expanded(child: _statCard(context, "Total weekly Subscriptions", "5", "2 more subscriber added", fixedCardWidth)),
            const SizedBox(width: 16),
            Expanded(child: _statCard(context, "Total Monthly Subscriptions", "345", "3 more subscriber added", fixedCardWidth)),
            const SizedBox(width: 16),
            Expanded(child: _statCard(context, "Total Yearly Subscriptions", "10k", "3 more subscriber added", fixedCardWidth)),
          ],
        );
      } else if (totalWidth >= 480) {
        double tabletCardWidth = (totalWidth - 16) / 2;
        return Wrap(
          spacing: 16, runSpacing: 16,
          children: [
            _statCard(context, "Total New Subscriptions", "12", "3 more subscriber added", tabletCardWidth),
            _statCard(context, "Total weekly Subscriptions", "5", "2 more subscriber added", tabletCardWidth),
            _statCard(context, "Total Monthly Subscriptions", "345", "3 more subscriber added", tabletCardWidth),
            _statCard(context, "Total Yearly Subscriptions", "10k", "3 more subscriber added", tabletCardWidth),
          ],
        );
      } else {
        return Wrap(
          spacing: 16, runSpacing: 16,
          children: [
            _statCard(context, "Total New Subscriptions", "12", "3 more subscriber added", totalWidth),
            _statCard(context, "Total weekly Subscriptions", "5", "2 more subscriber added", totalWidth),
            _statCard(context, "Total Monthly Subscriptions", "345", "3 more subscriber added", totalWidth),
            _statCard(context, "Total Yearly Subscriptions", "10k", "3 more subscriber added", totalWidth),
          ],
        );
      }
    });
  }
  Widget _statCard(BuildContext context, String title, String value, String subText, double calculatedWidth) {
    bool isUltraSmall = calculatedWidth < 280;
    return Container(
      width: calculatedWidth,
      padding: EdgeInsets.all(isUltraSmall ? 10 : 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.sideBoxesColor.withOpacity(0.6), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              Container(
                height: isUltraSmall ? 28 : 36,
                width: isUltraSmall ? 28 : 36,
                decoration: BoxDecoration(
                  color: AppColors.signaturePadColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: Image.asset(IconString.subscritionGrid),
                ),
              ),
              SizedBox(width: isUltraSmall ? 6 : 10),
              Expanded(
                child: Text(
                  title,
                  style: TTextTheme.bodyRegular12(context).copyWith(color: AppColors.tertiaryTextColor),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),
          Text(
            value,
            style: TTextTheme.h2Style(context).copyWith(fontSize: isUltraSmall ? 20 : 26, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 2),
          Text(
            subText,
            style: TTextTheme.bodySecondRegular10(context).copyWith(color: AppColors.tertiaryTextColor.withOpacity(0.8)),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  // TABLE FILTER BAR COMPONENT
  Widget _buildFiltersAndTabsRow(BuildContext context, SubscriptionController controller) {
    double screenWidth = MediaQuery.of(context).size.width;
    bool isMobileOrTablet = screenWidth < 1050;

    Widget leftSideTabs = SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      child: Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(color: AppColors.signaturePadColor, borderRadius: BorderRadius.circular(8)),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: ["All", "Active", "Suspended", "Expired"].map((tab) {
            return Obx(() {
              bool isSelected = controller.selectedTab.value == tab;
              return GestureDetector(
                onTap: () => controller.changeTab(tab),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                  margin: const EdgeInsets.symmetric(horizontal: 2),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: isSelected ? AppColors.primaryColor : Colors.transparent,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(tab, style: isSelected ? TTextTheme.medium14White(context) : TTextTheme.tableRegular14(context)),
                ),
              );
            });
          }).toList(),
        ),
      ),
    );

    Widget rightSideFilterGroup = isMobileOrTablet
        ? Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildCustomPopupMenuDropdown(
          context, id: "sub_drop", selectedValue: controller.selectedCustomerValue,
          items: ["Customer Name", "Subscription Type", "Cars"],
          isMobile: true, width: 160, height: 42, controller: controller,
        ),
        const SizedBox(height: 12),
        _buildSearchBar(context, controller, isMobile: true),
      ],
    )
        : Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildCustomPopupMenuDropdown(
          context, id: "sub_drop", selectedValue: controller.selectedCustomerValue,
          items: ["Customer Name", "Subscription Type", "Cars"],
          isMobile: false, width: 160, height: 42, controller: controller,
        ),
        const SizedBox(width: 12),
        _buildSearchBar(context, controller, isMobile: false),
      ],
    );

    if (isMobileOrTablet) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(width: double.infinity, child: leftSideTabs),
          const SizedBox(height: 16),
          SizedBox(width: double.infinity, child: rightSideFilterGroup),
        ],
      );
    } else {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(child: Align(alignment: Alignment.centerLeft, child: leftSideTabs)),
          const SizedBox(width: 20),
          rightSideFilterGroup,
        ],
      );
    }
  }

  //  CUSTOM DROPDOWN COMPONENT
  Widget _buildCustomPopupMenuDropdown(BuildContext context, {
    required String id, required RxString selectedValue, required List<String> items,
    required bool isMobile, required double width, required double height,
    required SubscriptionController controller, void Function(String)? onChanged,
  }) {
    return Obx(() {
      bool isOpen = controller.openedDropdown2.value == id;
      return PopupMenuButton<String>(
        constraints: BoxConstraints(
          minWidth: isMobile ? (MediaQuery.of(context).size.width - 80) : width,
          maxWidth: isMobile ? (MediaQuery.of(context).size.width - 80) : width,
        ),
        offset: const Offset(0, 45),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        color: Colors.white,
        onOpened: () => controller.openedDropdown2.value = id,
        onCanceled: () => controller.openedDropdown2.value = "",
        onSelected: (val) {
          selectedValue.value = val;
          controller.openedDropdown2.value = "";
          if (onChanged != null) onChanged(val);
        },
        child: Container(
          height: height, width: isMobile ? double.infinity : width,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(color: AppColors.signaturePadColor, borderRadius: BorderRadius.circular(8)),
          child: Row(
            children: [
              Expanded(child: Text(selectedValue.value, style: TTextTheme.btncustomer(context), overflow: TextOverflow.ellipsis)),
              Icon(isOpen ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down, size: 18),
            ],
          ),
        ),
        itemBuilder: (context) => items.map((e) => PopupMenuItem<String>(
          value: e, child: Text(e, style: TTextTheme.bodyRegular14(context)),
        )).toList(),
      );
    });
  }
  Widget _buildSearchBar(BuildContext context, SubscriptionController controller, {required bool isMobile}) {
    return Container(
      width: isMobile ? double.infinity : 300, height: 42,
      decoration: BoxDecoration(color: AppColors.signaturePadColor, borderRadius: BorderRadius.circular(8)),
      child: Row(
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Icon(Icons.search, size: 18, color: AppColors.quadrantalTextColor),
          ),
          Expanded(
            child: TextField(
              cursorColor: AppColors.blackColor,
              controller: controller.searchController,
              decoration:  InputDecoration(
                hintText: "Search Subscription by name", border: InputBorder.none,
                hintStyle: TTextTheme.SubscriptionSearch(context),
                isDense: true, contentPadding: EdgeInsets.only(bottom: 2),
              ),
              style: TTextTheme.titleinputTextField(context)
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: ElevatedButton(
              onPressed: () => controller.update(),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryColor, foregroundColor: Colors.white,
                elevation: 0, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                padding: const EdgeInsets.symmetric(horizontal: 16),
              ),
              child:  Text("Search", style: TTextTheme.medium12White(context)),
            ),
          ),
        ],
      ),
    );
  }

  //  TABLE DATA ELEMENTS
  Widget _buildTableHeader(BuildContext context, SubscriptionController controller) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(color: AppColors.secondaryColor.withOpacity(0.5), borderRadius: BorderRadius.circular(8)),
      child: Row(
        children: [
          _headerCell("Company Name", 180, context, controller),
          _headerCell("Subscription Type", 160, context, controller),
          _headerCell("Cars", 100, context, controller),
          _headerCell("Charges", 130, context, controller),
          _headerCell("Next Billing Date", 160, context, controller),
          _headerCell("Status", 120, context, controller),
          _headerCell("Action", 100, context, controller, canSort: false),
        ],
      ),
    );
  }

  Widget _headerCell(
      String title,
      double width,
      BuildContext context,
      SubscriptionController controller,
      {bool canSort = true}
      ) {
    return SizedBox(
      width: width,
      child: InkWell(
        onTap: canSort ? () => controller.toggleSort(title) : null,
        borderRadius: BorderRadius.circular(4),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(
                child: Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TTextTheme.medium14tableHeading(context),
                ),
              ),
              if (canSort) ...[
                const SizedBox(width: 4),
                Obx(() {
                  bool isCurrent = controller.sortColumn.value == title;
                  int order = isCurrent ? controller.sortOrder.value : 0;

                  return SizedBox(
                    width: 12,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.keyboard_arrow_up,
                          size: 12,
                          color: order == 1 ? AppColors.primaryColor : AppColors.tertiaryTextColor,
                        ),
                        Transform.translate(
                          offset: const Offset(0, -4),
                          child: Icon(
                            Icons.keyboard_arrow_down,
                            size: 12,
                            color: order == 2 ? AppColors.primaryColor : AppColors.tertiaryTextColor,
                          ),
                        ),
                      ],
                    ),
                  );
                })
              ],
            ],
          ),
        ),
      ),
    );
  }

   // Subscription Row
  Widget _buildSubscriptionRow(BuildContext context, Map data,SubscriptionController controller) {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: BoxDecoration(
        color: AppColors.backgroundOfTableContainer, borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.sideBoxesColor.withOpacity(0.4)),
      ),
      child: Row(
        children: [
          SizedBox(width: 180, child: Row(children: [
            Image.asset(IconString.subscritionGrid, color: AppColors.primaryColor, height: 18,width: 18,),
            const SizedBox(width: 10),
            Text(data["companyName"] ?? "-", style: TTextTheme.bodySemiBold14black(context)),
          ])),
          SizedBox(width: 160, child: Text(data["type"] ?? "-", style: TTextTheme.tableRegular14black(context))),
          SizedBox(width: 100, child: Text("${data["cars"]}", style: TTextTheme.tableRegular14black(context))),
          SizedBox(width: 130, child: Text(data["charges"] ?? "-", style: TTextTheme.tableRegular14black(context))),
          SizedBox(width: 160, child: Text(data["nextBilling"] ?? "-", style: TTextTheme.tableRegular14black(context))),
          SizedBox(width: 120, child: _buildStatusChip(context,data["status"])),
          SizedBox(
            width: 100,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {
                    controller.accountStatus.value = data["status"] ?? "Active";
                    context.go('/subscription/SubscriptionDetail');
                  },
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Image.asset(
                      IconString.viewIcon,
                      height: 16,
                      width: 16,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                GestureDetector(
                  onTap: () {
                    context.go('/subscription/subscriptionInvoiceDetail');
                  },
                  child: Image.asset(
                    IconString.subcritionInvoice,
                    height: 16,
                    width: 16,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
  Widget _buildStatusChip(BuildContext context,String status) {
    Color bg = AppColors.tertiaryTextColor;
    if (status == "Active") bg = AppColors.completedColor;
    if (status == "Suspended") bg = Colors.red;
    if (status == "Expired") bg = AppColors.tableHeading;

    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(20)),
        child: Text(status, style: TTextTheme.medium14White(context)),
      ),
    );
  }
}

