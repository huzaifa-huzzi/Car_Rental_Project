import 'package:car_rental_project/Portal/Admin/Subscription/ReusableWidget/HeaderWebSubscriptionWidget.dart';
import 'package:car_rental_project/Portal/Admin/Subscription/ReusableWidget/PaginationBarOfSubscription.dart';
import 'package:car_rental_project/Portal/Admin/Subscription/SubscriptionController.dart';
import 'package:car_rental_project/Resources/AppSizes.dart';
import 'package:car_rental_project/Resources/Colors.dart';
import 'package:car_rental_project/Resources/IconStrings.dart';
import 'package:car_rental_project/Resources/TextString.dart';
import 'package:car_rental_project/Resources/TextTheme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

class SubscriptionInvoiceDetail extends StatelessWidget {
  const SubscriptionInvoiceDetail({super.key});

  @override
  Widget build(BuildContext context) {
    final horizontalPadding = AppSizes.horizontalPadding(context);
    final baseVerticalSpace = AppSizes.verticalPadding(context);
    final SubscriptionController controller = Get.put(SubscriptionController());

    final List<Map<String, dynamic>> paymentData = [
      {"invoiceId": "#1234", "date": "Dec 15, 2025", "period": "Dec 2025", "plan": "Monthly", "amount": "\$1,345.00", "method": "Pay to", "status": "Paid"},
      {"invoiceId": "#1234", "date": "Nov 15, 2025", "period": "Nov 2025", "plan": "Monthly", "amount": "\$1,345.00", "method": "Pay to", "status": "Paid"},
      {"invoiceId": "#1234", "date": "Oct 15, 2025", "period": "Oct 2025", "plan": "Monthly", "amount": "\$1,345.00", "method": "Pay to", "status": "Paid"},
      {"invoiceId": "#1234", "date": "Sep 15, 2025", "period": "Sep 2025", "plan": "Monthly", "amount": "\$1,345.00", "method": "Pay to", "status": "Paid"},
      {"invoiceId": "#1234", "date": "Aug 15, 2025", "period": "Aug 2025", "plan": "Monthly", "amount": "\$1,345.00", "method": "Pay to", "status": "Paid"},
    ];

    return Scaffold(
      backgroundColor: AppColors.backgroundOfScreenColor,
      body: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              if (AppSizes.isWeb(context))
                HeaderWebSubscriptionWidget(
                  mainTitle: 'Subscription',
                  showBack: true,
                  showProfile: true,
                  showNotification: true,
                  showSettings: true,
                  showSearch: true,
                ),

              const SizedBox(height: 30),
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.blackColor.withOpacity(0.02),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    )
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildPaymentHeader(context, controller),
                    const SizedBox(height: 24),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: SizedBox(
                        width: 1220,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildInvoiceTableHeader(context, controller),
                            const SizedBox(height: 8),
                            ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: paymentData.length,
                              itemBuilder: (context, index) {
                                return _buildInvoiceRow(context, paymentData[index], controller);
                              },
                            ),
                          ],
                        ),
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

              SizedBox(height: baseVerticalSpace * 1.25),
            ],
          ),
        ),
      ),
    );
  }


  /// --------- Extra Widgets --------- ///

  // Payment Header
  Widget _buildPaymentHeader(BuildContext context, SubscriptionController controller) {
    double screenWidth = MediaQuery.of(context).size.width;
    bool isMobileOrTablet = screenWidth < 1050;

    Widget leftSideInfo = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(TextString.SubscriptionTitle21, style: TTextTheme.h2Style(context)),
        const SizedBox(height: 4),
        Text(TextString.SubscriptionTitle22, style: TTextTheme.bodyRegular14(context)),
      ],
    );

    Widget rightSideFilterGroup = isMobileOrTablet
        ? Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildYearFieldForHeader(context, controller: controller, id: "payment_year_drop"),
        const SizedBox(height: 12),
        _buildHeaderSearchBar(context, controller, isMobile: true),
      ],
    )
        : Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildYearFieldForHeader(context, controller: controller, id: "payment_year_drop"),
        const SizedBox(width: 12),
        _buildHeaderSearchBar(context, controller, isMobile: false),
      ],
    );

    if (isMobileOrTablet) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          leftSideInfo,
          const SizedBox(height: 16),
          SizedBox(width: double.infinity, child: rightSideFilterGroup),
        ],
      );
    } else {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          leftSideInfo,
          const SizedBox(width: 20),
          rightSideFilterGroup,
        ],
      );
    }
  }

  // Header Serachbar
  Widget _buildHeaderSearchBar(BuildContext context, SubscriptionController controller, {required bool isMobile}) {
    return Container(
      width: isMobile ? double.infinity : 280,
      height: 42,
      decoration: BoxDecoration(
        color: AppColors.signaturePadColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Icon(Icons.search, size: 18, color: AppColors.quadrantalTextColor),
          ),
          Expanded(
            child: TextField(
              cursorColor: AppColors.blackColor,
              decoration: InputDecoration(
                hintText:TextString.SubscriptionTitle23 ,
                border: InputBorder.none,
                hintStyle: TTextTheme.SubscriptionSearch(context),
                isDense: true,
                contentPadding: const EdgeInsets.only(bottom: 2),
              ),
              style: TTextTheme.titleinputTextField(context),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: ElevatedButton(
              onPressed: () => controller.update(),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryColor,
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                padding: const EdgeInsets.symmetric(horizontal: 16),
              ),
              child: Text(TextString.SubscriptionTitle24, style: TTextTheme.medium12White(context)),
            ),
          ),
        ],
      ),
    );
  }

  // Custom Searchable Year
  Widget _buildYearFieldForHeader(
      BuildContext context, {
        required SubscriptionController controller,
        required String id,
      }) {
    final TextEditingController searchController = TextEditingController();
    double screenWidth = MediaQuery.of(context).size.width;
    bool isMobile = screenWidth < 1050;

    return Obx(() {
      bool isOpen = controller.openedDropdown2.value == id;
      String currentSelected = controller.selectedYear.value.isEmpty ? "2024" : controller.selectedYear.value;

      return LayoutBuilder(builder: (context, constraints) {
        return PopupMenuButton<String>(
          constraints: BoxConstraints(
            minWidth: isMobile ? (MediaQuery.of(context).size.width - 48) : 140,
            maxWidth: isMobile ? (MediaQuery.of(context).size.width - 48) : 140,
            maxHeight: 350,
          ),
          offset: const Offset(0, 46),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          color: Colors.white,
          onOpened: () {
            controller.openedDropdown2.value = id;
            searchController.text = controller.searchCarText.value;
          },
          onCanceled: () {
            controller.openedDropdown2.value = "";
            controller.searchCarText.value = "";
            searchController.clear();
          },
          onSelected: (val) {
            controller.selectedYear.value = val;
            controller.openedDropdown2.value = "";
            controller.searchCarText.value = "";
            searchController.clear();
          },
          child: Container(
            height: 42,
            width: isMobile ? double.infinity : 140,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: AppColors.signaturePadColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(currentSelected, style: TTextTheme.btncustomer(context)),
                Icon(isOpen ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down, size: 18, color: AppColors.quadrantalTextColor),
              ],
            ),
          ),
          itemBuilder: (context) {
            return [
              PopupMenuItem<String>(
                enabled: false,
                child: Obx(() {
                  final query = controller.searchCarText.value.toLowerCase();
                  final items = controller.yearsList
                      .where((year) => year.contains(query))
                      .toList();

                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        height: 38,
                        margin: const EdgeInsets.symmetric(vertical: 4),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: AppColors.primaryColor.withOpacity(0.4)),
                        ),
                        child: TextFormField(
                          controller: searchController,
                          cursorColor: AppColors.blackColor,
                          autofocus: true,
                          onChanged: (val) {
                            controller.searchCarText.value = val;
                          },
                          style: TTextTheme.titleinputTextField(context),
                          decoration: InputDecoration(
                            hintText: "Search Year",
                            hintStyle: TTextTheme.bodyRegular14Search(context),
                            prefixIcon: Icon(Icons.search, color: AppColors.primaryColor, size: 16),
                            filled: true,
                            fillColor: AppColors.backgroundOfScreenColor,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide.none,
                            ),
                            contentPadding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                          ),
                        ),
                      ),
                      const SizedBox(height: 6),
                      ConstrainedBox(
                        constraints: const BoxConstraints(maxHeight: 220),
                        child: items.isEmpty
                            ? const Padding(
                          padding: EdgeInsets.symmetric(vertical: 16),
                          child: Center(child: Text("No years found")),
                        )
                            : ListView.builder(
                          shrinkWrap: true,
                          itemCount: items.length,
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            final item = items[index];
                            bool isSelected = currentSelected == item;

                            return InkWell(
                              onTap: () {
                                Navigator.of(context).pop(item);
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 18,
                                      height: 18,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: isSelected ? AppColors.primaryColor : Colors.transparent,
                                        border: Border.all(color: AppColors.primaryColor, width: 1.5),
                                      ),
                                      child: isSelected
                                          ? const Center(child: Icon(Icons.done, color: Colors.white, size: 12))
                                          : null,
                                    ),
                                    const SizedBox(width: 10),
                                    Text(item, style: TTextTheme.medium14(context)),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  );
                }),
              ),
            ];
          },
        );
      });
    });
  }

  // Main Table Header
  Widget _buildInvoiceTableHeader(BuildContext context, SubscriptionController controller) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: AppColors.secondaryColor.withOpacity(0.5),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          _headerCell(TextString.SubscriptionTitle25, 140, context, controller),
          _headerCell(TextString.SubscriptionTitle26, 170, context, controller),
          _headerCell(TextString.SubscriptionTitle27, 160, context, controller),
          _headerCell(TextString.SubscriptionTitle28, 140, context, controller),
          _headerCell(TextString.SubscriptionTitle29, 150, context, controller),
          _headerCell(TextString.SubscriptionTitle30, 150, context, controller),
          _headerCell(TextString.SubscriptionTitle31, 140, context, controller),
          _headerCell(TextString.SubscriptionTitle32, 120, context, controller, canSort: false),
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

  // 3. Main Data Row Component
  Widget _buildInvoiceRow(BuildContext context, Map data, SubscriptionController controller) {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: BoxDecoration(
        color: AppColors.backgroundOfTableContainer,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.sideBoxesColor.withOpacity(0.4)),
      ),
      child: Row(
        children: [
          SizedBox(width: 140, child: Text(data["invoiceId"] ?? "-", style: TTextTheme.bodySemiBold14black(context))),
          SizedBox(width: 170, child: Text(data["date"] ?? "-", style: TTextTheme.tableRegular14black(context))),
          SizedBox(width: 160, child: Text(data["period"] ?? "-", style: TTextTheme.tableRegular14black(context))),
          SizedBox(width: 140, child: Text(data["plan"] ?? "-", style: TTextTheme.tableRegular14black(context))),
          SizedBox(width: 150, child: Text(data["amount"] ?? "-", style: TTextTheme.tableRegular14black(context))),
          SizedBox(
            width: 150,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(IconString.paytoIcon, color: AppColors.primaryColor, height: 16,width: 16,),
                const SizedBox(width: 4),
                Text(data["method"] ?? "-", style: TTextTheme.tableRegular14black(context)),
              ],
            ),
          ),
          SizedBox(
            width: 140,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                decoration: BoxDecoration(
                  color: AppColors.completedColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                child:  Text(
                  TextString.SubscriptionTitle33,
                  style: TTextTheme.btnWhiteColor(context),
                ),
              ),
            ),
          ),
          SizedBox(
            width: 120,
            child: Align(
              alignment: Alignment.centerLeft,
              child: OutlinedButton(
                onPressed: () {
                  context.go('/subscription/SubscriptionDetail');
                },
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: AppColors.primaryColor),
                  padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(IconString.viewIcon, width: 14, height: 14, color: AppColors.primaryColor),
                    const SizedBox(width: 4),
                    Text(TextString.SubscriptionTitle34, style: TTextTheme.viewBtnText(context)),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}