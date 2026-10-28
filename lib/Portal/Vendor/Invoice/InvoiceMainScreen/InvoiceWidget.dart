import 'package:car_rental_project/Portal/Vendor/Invoice/InvoiceController.dart';
import 'package:car_rental_project/Portal/Vendor/Invoice/ReusableWidget/PaginationBarOfInvoice.dart';
import 'package:car_rental_project/Resources/Colors.dart';
import 'package:car_rental_project/Resources/TextString.dart';
import 'package:car_rental_project/Resources/TextTheme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

import '../../../../Resources/IconStrings.dart' show IconString;



class InvoiceWidget extends StatefulWidget {
  const InvoiceWidget({super.key});

  @override
  State<InvoiceWidget> createState() => _InvoiceWidgetState();
}

class _InvoiceWidgetState extends State<InvoiceWidget> {
  final InvoiceController controller = Get.find<InvoiceController>();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              _buildTopAddInvoiceButton(context),
            ],
          ),
          const SizedBox(height: 16),
          _buildStatsGrid(context),
          const SizedBox(height: 30),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(MediaQuery.of(context).size.width < 600 ? 16 : 24),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeaderText(),
                const SizedBox(height: 25),
                _buildTabs(),
                const SizedBox(height: 20),
                _buildFiltersRow(),
                const SizedBox(height: 30),
                LayoutBuilder(
                  builder: (context, constraints) {
                    return Obx(() {
                      var currentList = controller.displayedInvoiceList;
                      return SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        physics: const BouncingScrollPhysics(),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildTableHeader(controller),
                            if (currentList.isEmpty)
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 12),
                                child: Text(
                                  TextString.noInvoicesFound,
                                  style: TTextTheme.bodyRegular14tertiary(context),
                                ),
                              )
                            else
                              ...currentList.map((data) {
                                return _buildInvoiceRow(data);
                              }),
                          ],
                        ),
                      );
                    });
                  },
                ),
                const SizedBox(height: 20),
                _buildPagination(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// --------------- Extra Widgets --------------///

   // Top Add Invoice Button
  Widget _buildTopAddInvoiceButton(BuildContext context) {
    bool isMobile = MediaQuery.of(context).size.width < 450;
    return ElevatedButton.icon(
      onPressed: () {
        context.go('/InvoiceAddDetail');
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primaryColor,
        foregroundColor: Colors.white,
        elevation: 0,
        padding: EdgeInsets.symmetric(horizontal: isMobile ? 16 : 20, vertical: 14),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      icon: const Icon(Icons.add, size: 18, color: Colors.white),
      label: Text(TextString.newInvoice, style: TTextTheme.searchText(context)),
    );
  }

   // Filter Row
  Widget _buildFiltersRow() {
    return LayoutBuilder(builder: (context, constraints) {
      double width = constraints.maxWidth;
      bool isMobile = width < 750;
      double fieldHeight = 42;

      return Align(
        alignment: isMobile ? Alignment.centerLeft : Alignment.centerRight,
        child: Wrap(
          spacing: 12,
          runSpacing: 12,
          alignment: isMobile ? WrapAlignment.start : WrapAlignment.end,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            _buildDateFilterBox(context, isMobile, fieldHeight),
            _buildCustomerDropdown(
              context,
              "cust_drop",
              controller.selectedCustomerValue,
              isMobile,
              fieldHeight,
            ),
            _buildSearchBar(context, isMobile, fieldHeight),
          ],
        ),
      );
    });
  }

   // Date Filter Row
  Widget _buildDateFilterBox(BuildContext context, bool isMobile, double height) {
    return CompositedTransformTarget(
      link: controller.dateFilterLink,
      child: InkWell(
        onTap: () {
          controller.toggleCalendar(
            context,
            controller.dateFilterLink,
            controller.dateTextController,
            isMobile ? MediaQuery.of(context).size.width * 0.9 : 320,
          );
        },
        borderRadius: BorderRadius.circular(8),
        child: Container(
          height: height,
          width: isMobile ? double.infinity : 200,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: AppColors.signaturePadColor,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              Icon(Icons.event, size: 18, color: AppColors.quadrantalTextColor),
              const SizedBox(width: 10),
              Expanded(
                child: Obx(() => Text(
                  controller.selectedDateRangeText.value.isEmpty
                      ? TextString.filterByWeek
                      : controller.selectedDateRangeText.value,
                  style: TTextTheme.btncustomer(context),
                  overflow: TextOverflow.ellipsis,
                )),
              ),
              Icon(Icons.keyboard_arrow_down, size: 18, color: AppColors.quadrantalTextColor),
            ],
          ),
        ),
      ),
    );
  }

   // Searchbar
  Widget _buildSearchBar(BuildContext context, bool isMobile, double height) {
    return Container(
      width: isMobile ? double.infinity : 300,
      height: height,
      decoration: BoxDecoration(
        color: AppColors.signaturePadColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Icon(Icons.search, size: 18, color: AppColors.quadrantalTextColor),
          ),
          Expanded(
            child: TextField(
              controller: controller.searchController,
              cursorColor: AppColors.blackColor,
              textAlignVertical: TextAlignVertical.center,
              style: TTextTheme.insidetextfieldWrittenText(context),
              onChanged: (_) => controller.baseInvoiceData.refresh(),
              decoration: InputDecoration(
                hintText: TextString.searchHint,
                hintStyle: TTextTheme.smallX(context),
                border: InputBorder.none,
                isDense: true,
                contentPadding: const EdgeInsets.only(bottom: 2),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(3.0),
            child: ElevatedButton(
              onPressed: () => controller.baseInvoiceData.refresh(),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryColor,
                foregroundColor: Colors.white,
                elevation: 0,
                padding: const EdgeInsets.symmetric(horizontal: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
              child: Text(TextString.searchButton, style: TTextTheme.searchText(context)),
            ),
          ),
        ],
      ),
    );
  }

   // Custom Dropdown
  Widget _buildCustomerDropdown(BuildContext context, String id, RxString selectedValue, bool isMobile, double height) {
    List<String> items = [TextString.customerNameFilter, TextString.registrationNoFilter, TextString.carNameFilter];

    return Obx(() {
      bool isOpen = controller.openedDropdown.value == id;

      return PopupMenuButton<String>(
        constraints: BoxConstraints(
          minWidth: isMobile ? (MediaQuery.of(context).size.width * 0.9) : 180,
          maxWidth: isMobile ? (MediaQuery.of(context).size.width * 0.9) : 180,
        ),
        offset: const Offset(0, 45),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        color: Colors.white,
        elevation: 4,
        onOpened: () => controller.openedDropdown.value = id,
        onCanceled: () => controller.openedDropdown.value = "",
        onSelected: (val) {
          selectedValue.value = val;
          controller.openedDropdown.value = "";
        },
        child: Container(
          height: height,
          width: isMobile ? double.infinity : 180,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: AppColors.signaturePadColor,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  selectedValue.value.isEmpty ? TextString.customerDefault : selectedValue.value,
                  style: TTextTheme.btncustomer(context),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(width: 8),
              Icon(
                isOpen ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                size: 20,
                color: AppColors.blackColor,
              ),
            ],
          ),
        ),
        itemBuilder: (context) => items.map((String item) {
          return PopupMenuItem<String>(
            value: item,
            padding: EdgeInsets.zero,
            height: 40,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Text(item, style: TTextTheme.bodyRegular14(context)),
            ),
          );
        }).toList(),
      );
    });
  }

   // Header Text
  Widget _buildHeaderText() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(TextString.allInvoicesTitle, style: TTextTheme.h2Style(context)),
        const SizedBox(height: 4),
        Text(TextString.allInvoicesSubtitle, style: TTextTheme.bodyRegular16(context)),
      ],
    );
  }

   // Stats Grid
  Widget _buildStatsGrid(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      double width = constraints.maxWidth;
      int crossAxisCount = width >= 1100 ? 3 : (width >= 700 ? 2 : 1);
      double spacing = 16;
      double totalSpacing = (crossAxisCount - 1) * spacing;
      double cardWidth = (width - totalSpacing) / crossAxisCount;

      return Wrap(
        spacing: spacing,
        runSpacing: spacing,
        children: [
          _statCard(context, cardWidth, TextString.totalRevenue, TextString.totalRevenueValue, IconString.paymentIconBlack),
          _statCard(context, cardWidth, TextString.pendingPayment, TextString.pendingPaymentValue, IconString.pendingPaymentIcon),
          _statCard(context, cardWidth, TextString.completedPayments, TextString.completedPaymentsValue, IconString.completedIcon),
        ],
      );
    });
  }

  Widget _statCard(BuildContext context, double width, String title, String value, String icon) {
    return Container(
      width: width,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 15,
            offset: const Offset(0, 5),
          )
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppColors.secondaryColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Image.asset(icon, height: 22, width: 22),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, maxLines: 1, overflow: TextOverflow.ellipsis, style: TTextTheme.bodyRegular12(context)),
                const SizedBox(height: 4),
                Text(value, maxLines: 1, overflow: TextOverflow.ellipsis, style: TTextTheme.h2Style(context)),
              ],
            ),
          ),
        ],
      ),
    );
  }

   // Tabs
  Widget _buildTabs() {
    List<String> tabs = [TextString.tabAll, TextString.tabPending, TextString.tabOverdue, TextString.tabCompleted];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      child: Container(
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: AppColors.signaturePadColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.sideBoxesColor.withValues(alpha: 0.7)),
        ),
        child: Obx(() => Row(
          children: tabs.map((tab) {
            bool isSelected = controller.selectedTab.value == tab;
            return GestureDetector(
              onTap: () => controller.changeTab(tab),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                  color: isSelected ? AppColors.primaryColor : Colors.transparent,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  tab,
                  style: isSelected
                      ? TTextTheme.medium14White(context)
                      : TTextTheme.bodyRegular14tertiary(context),
                ),
              ),
            );
          }).toList(),
        )),
      ),
    );
  }

  Widget _buildTableHeader(InvoiceController controller) {
    const double containerWidth = 1210;

    return Container(
      width: containerWidth,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.secondaryColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          SizedBox(width: 140, child: _headerCell(TextString.invNoHeader, controller)),
          SizedBox(width: 220, child: _headerCell(TextString.customerNameHeader, controller)),
          SizedBox(width: 280, child: _headerCell(TextString.carNameHeader, controller)),
          SizedBox(width: 150, child: _headerCell(TextString.dateHeader, controller)),
          SizedBox(width: 140, child: _headerCell(TextString.amountHeader, controller)),
          SizedBox(width: 140, child: _headerCell(TextString.statusHeader, controller, isCenter: true)),
          SizedBox(width: 110, child: _headerCell(TextString.actionHeader, controller, isCenter: true, canSort: false)),
        ],
      ),
    );
  }

  Widget _buildInvoiceRow(Map data) {
    String rawStatus = data["status"] ?? TextString.statusPending;
    const double containerWidth = 1210;

    return Container(
      width: containerWidth,
      margin: const EdgeInsets.only(top: 8),
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
      decoration: BoxDecoration(
        color: AppColors.backgroundOfTableContainer,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.sideBoxesColor.withValues(alpha: 0.7), width: 1),
      ),
      child: Row(
        children: [
          _cell(width: 140, child: Text(data["invNo"] ?? "", style: TTextTheme.bodySemiBold14black(context), overflow: TextOverflow.ellipsis)),
          _cell(width: 220, child: Text(data["customerName"] ?? "", style: TTextTheme.bodySemiBold14black(context), overflow: TextOverflow.ellipsis)),
          _cell(width: 280, child: Text(data["carName"] ?? "", style: TTextTheme.tableRegular14black(context), overflow: TextOverflow.ellipsis)),
          _cell(width: 150, child: Text(data["date"] ?? "", style: TTextTheme.tableRegular14black(context), overflow: TextOverflow.ellipsis)),
          _cell(width: 140, child: Text("\$${data["amount"] ?? ""}", style: TTextTheme.bodySemiBold16(context).copyWith(color: AppColors.primaryColor))),
          _cell(width: 140, child: Center(child: _buildStatusChip(rawStatus))),
          SizedBox(
            width: 110,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildActionIconButton(
                  iconPath: IconString.viewIcon,
                  onTap: () {
                    context.go('/InvoiceDetail');
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _headerCell(String title, InvoiceController controller, {bool isCenter = false, bool canSort = true}) {
    return InkWell(
      onTap: canSort ? () => controller.toggleSort(title) : null,
      borderRadius: BorderRadius.circular(4),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 4.0),
        child: Row(
          mainAxisAlignment: isCenter ? MainAxisAlignment.center : MainAxisAlignment.start,
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
                      Icon(Icons.keyboard_arrow_up, size: 12, color: order == 1 ? AppColors.primaryColor : AppColors.textColor),
                      Transform.translate(
                        offset: const Offset(0, -4),
                        child: Icon(Icons.keyboard_arrow_down, size: 12, color: order == 2 ? AppColors.primaryColor : AppColors.textColor),
                      ),
                    ],
                  ),
                );
              })
            ],
          ],
        ),
      ),
    );
  }

   // Action Button
  Widget _buildActionIconButton({required String iconPath, required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        width: 28,
        height: 28,
        padding: const EdgeInsets.all(5.0),
        decoration: BoxDecoration(
          color: AppColors.primaryColor,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.08),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Image.asset(iconPath, color: Colors.white, fit: BoxFit.contain),
      ),
    );
  }

  Widget _cell({required double width, required Widget child}) {
    return SizedBox(width: width, child: child);
  }

  Widget _buildStatusChip(String status) {
    Color backgroundColor;
    switch (status.toLowerCase()) {
      case 'overdue':
        backgroundColor = AppColors.overdueColor;
        break;
      case 'pending':
        backgroundColor = AppColors.pendingColor;
        break;
      case 'completed':
        backgroundColor = AppColors.completedColor;
        break;
      default:
        backgroundColor = AppColors.secondTextColor;
    }

    return Container(
      constraints: const BoxConstraints(minWidth: 85),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Text(
        status,
        textAlign: TextAlign.center,
        style: TTextTheme.bodySemiBold14White(context).copyWith(fontWeight: FontWeight.w400),
      ),
    );
  }

  Widget _buildPagination() {
    bool isMobile = MediaQuery.of(context).size.width < 800;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: PaginationBarOfInvoice(
        isMobile: isMobile,
        tablePadding: 240,
      ),
    );
  }
}