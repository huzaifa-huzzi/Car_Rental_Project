import 'package:car_rental_project/Portal/Admin/Comapnies/CompaniesController.dart';
import 'package:car_rental_project/Portal/Admin/Comapnies/ReusableWidget/PaginatioBarOfComapnies.dart';
import 'package:car_rental_project/Portal/Admin/Comapnies/ReusableWidget/PrimaryButtonOfComapnies.dart';
import 'package:car_rental_project/Resources/Colors.dart';
import 'package:car_rental_project/Resources/IconStrings.dart';
import 'package:car_rental_project/Resources/TextString.dart';
import 'package:car_rental_project/Resources/TextTheme.dart' show TTextTheme;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';



class CompaniesAdminWidget extends StatelessWidget {
  const CompaniesAdminWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final CompaniesAdminController controller = Get.find<CompaniesAdminController>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildStatsRow(context),

        const SizedBox(height: 50),

        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.03),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(child: _buildHeaderText(context)),
                  _buildAddPaymentButton(context, false),
                ],
              ),

              const SizedBox(height: 25),
              _buildTabsRow(context, controller),

              const SizedBox(height: 25),
              _buildFiltersRow(context, controller),

              const SizedBox(height: 20),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildTableHeader(context,controller),
                    const SizedBox(height: 8),
                    Obx(() => Column(
                      children: controller.filteredCompanies
                          .map((data) => _buildCompanyRow(context, data))
                          .toList(),
                    )),
                  ],
                ),
              ),

              const SizedBox(height: 20),
              PaginationBarOfCompanies(
                isMobile: MediaQuery.of(context).size.width < 600,
                tablePadding: 0,
              ),
            ],
          ),
        ),
      ],
    );
  }


   /// ----------- Extra Widgets ---------
  // Header Text
  Widget _buildHeaderText(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(TextString.companyTitle, style: TTextTheme.h2Style(context)),
        const SizedBox(height: 4),
        Text(TextString.companySubtitle, style: TTextTheme.bodyRegular14(context)),
      ],
    );
  }

   // Tabs
  Widget _buildTabsRow(BuildContext context, CompaniesAdminController controller) {
    return LayoutBuilder(builder: (context, constraints) {

      double width;

      if (constraints.maxWidth > 1400) {
        width = 850;
      } else if (constraints.maxWidth > 1000) {
        width = 800;
      } else if (constraints.maxWidth > 700) {
        width = 700;
      } else {
        width = constraints.maxWidth;
      }
      return Container(
        width: width,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: AppColors.signaturePadColor,
          borderRadius: BorderRadius.circular(8),
            border: Border.all(color: AppColors.sideBoxesColor.withOpacity(0.7))
        ),
        child: Row(
          children: [
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Obx(() {
                  var currentTabs =
                      controller.dynamicTabs[controller.selectedCategory.value] ?? [];

                  return Row(
                    children: currentTabs.map((tab) {
                      return _buildTabItem(
                        controller,
                        context,
                        tab["name"],
                        tab["count"],
                      );
                    }).toList(),
                  );
                }),
              ),
            ),

            const SizedBox(width: 10),
            _buildCustomPopupMenuDropdown(
              context,
              id: "main_filter",
              selectedValue: controller.selectedCategory,
              items: ["Email Status", "Account Status", "Plan Status"],
              isMobile: false,
              width: 160,
              height: 34,
              controller: controller,
              onChanged: (val) => controller.updateCategory(val),
            ),
          ],
        ),
      );
    });
  }
  Widget _buildTabItem(
      CompaniesAdminController controller,
      BuildContext context,
      String label,
      int count,
      ) {
    return Obx(() {
      bool isSelected = controller.selectedSubFilter.value == label;

      return GestureDetector(
        onTap: () => controller.changeTab(label),
        child: Container(
          margin: const EdgeInsets.only(right: 8),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.primaryColor : Colors.transparent,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                label,
                style:isSelected ? TTextTheme.bodyRegular14TabsSelected(context) : TTextTheme.bodyRegular14(context),
              ),

               SizedBox(width: 6),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: AppColors.quadrantalTextColor,width: 0.8),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  "$count",
                  style: TTextTheme.mediumCount(context)),
              ),
            ],
          ),
        ),
      );
    });
  }

  //  FILTERS ROW
  Widget _buildFiltersRow(BuildContext context, CompaniesAdminController controller) {
    return Align(
      alignment: Alignment.centerRight,
      child: Wrap(
        spacing: 12,
        runSpacing: 12,
        alignment: WrapAlignment.end,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          _buildCustomPopupMenuDropdown(
            context,
            id: "cust_drop",
            selectedValue: controller.selectedCustomerValue,
            items: ["Customer Name", "Invoice Id"],
            isMobile: MediaQuery.of(context).size.width < 600,
            width: 180,
            height: 42,
            controller: controller,
          ),
          _buildSearchBar(context),
        ],
      ),
    );
  }
  Widget _buildSearchBar(BuildContext context) {
    bool isMobile = MediaQuery.of(context).size.width < 600;
    return Container(
      width: isMobile ? double.infinity : 350,
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
            child:TextField(
              cursorColor: AppColors.blackColor,
              textAlignVertical: TextAlignVertical.center,
              style: TTextTheme.insidetextfieldWrittenText(context),
              decoration: InputDecoration(
                hintText: TextString.searchTextPayment,
                hintStyle: TTextTheme.smallX(context),
                border: InputBorder.none,
                isDense: true,
                contentPadding: EdgeInsets.only(bottom: 4),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryColor,
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
              ),
              child: Text(TextString.search, style: const TextStyle(fontSize: 12)),
            ),
          ),
        ],
      ),
    );
  }

   // Custom Dropdown
  Widget _buildCustomPopupMenuDropdown(BuildContext context, {
    required String id,
    required RxString selectedValue,
    required List<String> items,
    required bool isMobile,
    required double width,
    required double height,
    required CompaniesAdminController controller,
    void Function(String)? onChanged,
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
          height: height,
          width: isMobile ? double.infinity : width,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: (id == "email_status_drop" || id == "main_filter")
                ? Colors.white
                : AppColors.signaturePadColor,
            borderRadius: BorderRadius.circular(8),
            boxShadow: id == "email_status_drop" || id == "main_filter"
                ? [
              BoxShadow(
                color: AppColors.fieldsBackground.withOpacity(0.08),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ]
                : [],
          ),

          child: Row(
            children: [
              Expanded(
                child: Text(
                  selectedValue.value,
                  style: TTextTheme.btncustomer(context),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Icon(isOpen ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down, size: 18),
            ],
          ),
        ),
        itemBuilder: (context) => items.map((e) => PopupMenuItem<String>(
          value: e,
          child: Text(e, style: TTextTheme.bodyRegular14(context)),
        )).toList(),
      );
    });
  }

   // Table
  Widget _buildTableHeader(BuildContext context,CompaniesAdminController controller) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
      decoration: BoxDecoration(
        color: AppColors.secondaryColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          _headerCell(TextString.companyTable1, 200,context, controller,),
          _headerCell(TextString.companyTable2, 160,context, controller,),
          _headerCell(TextString.companyTable3, 200,context, controller,),
          _headerCell(TextString.companyTable4, 140,context, controller,),
          _headerCell(TextString.companyTable5, 140,context, controller,),
          _headerCell(TextString.companyTable6, 100,context, controller,),
          _headerCell(TextString.companyTable7, 120,context, controller,),
          _headerCell(TextString.companyTable8, 140,context, controller),
          _headerCell(TextString.companyTable9, 120,context, controller,),
          _headerCell(TextString.companyTable10, 100,context,controller,canSort: false),
        ],
      ),
    );
  }
  Widget _headerCell(
      String title,
      double width,
      BuildContext context,
      CompaniesAdminController controller,
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
                        Icon(Icons.keyboard_arrow_up,
                            size: 12,
                            color: order == 1 ? AppColors.primaryColor : AppColors.tertiaryTextColor),
                        Transform.translate(
                          offset: const Offset(0, -4),
                          child: Icon(Icons.keyboard_arrow_down,
                              size: 12,
                              color: order == 2 ? AppColors.primaryColor : AppColors.tertiaryTextColor),
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

  Widget _buildCompanyRow(BuildContext context, Map data) {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: BoxDecoration(
        color: AppColors.backgroundOfTableContainer,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.sideBoxesColor.withOpacity(0.7), width: 1),
      ),
      child: Row(
        children: [
          SizedBox(width: 200, child: Row(children: [
            Image.asset(IconString.companiesIconAdmin, color: AppColors.primaryColor),
            const SizedBox(width: 10),
            Text(data["companyName"] ?? "-", style: TTextTheme.bodySemiBold14black(context)),
          ])),
          _cell(data["ownerName"],context, 160),
          _cell(data["email"],context, 200),
          _statusCell(data["emailStatus"],context, 140),
          _statusCell(data["status"],context, 140),
          _cell(data["plan"],context, 100),
          _statusCell(data["planStatus"],context, 120),
          _cell(data["joiningDate"],context, 140),
          _cell("${data["activeCars"]}",context, 120),
          SizedBox(
            width: 100,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildActionButton(
                  iconPath: IconString.viewIcon,
                  iconColor: Colors.white,
                  bgColor: AppColors.primaryColor,
                  onTap: (){
                    context.push('/detailCompany');
                  }
                ),
                const SizedBox(width: 12),
                GestureDetector(
                  onTap: () => showSuspendCompanyDialog(context),
                  child: Icon(
                    Icons.block,
                    size: 20,
                    color: AppColors.blackColor,
                  ),
                ),
                const SizedBox(width: 12),
                _buildActionButton(
                  iconPath: IconString.deleteIcon,
                  iconColor: Colors.white,
                  bgColor:AppColors.primaryColor,
                  onTap: () {
                    showDeleteCompanyDialog(context);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  Widget _buildActionButton({
    String? iconPath,
    IconData? iconData,
    required Color iconColor,
    required Color bgColor,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(6),
        ),
        child: iconPath != null
            ? Image.asset(
          iconPath,
          height: 16,
          width: 16,
          color: iconColor,
        )
            : Icon(
          iconData,
          size: 16,
          color: iconColor,
        ),
      ),
    );
  }
  Widget _cell(String? text,BuildContext context ,double width, {bool isHeader = false}) {
    return SizedBox(width: width, child: Text(text ?? "-", style: TTextTheme.tableRegular14black(context)));
  }

  Widget _statusCell(String? status, BuildContext context, double width) {
    Color statusColor = AppColors.tertiaryTextColor;
    String s = status?.toLowerCase().trim() ?? "";

    if (s == "verified" || s == "active" || s == "subscribed") {
      statusColor = AppColors.completedColor;
    } else if (s == "not verified" || s == "overdue" || s == "suspended") {
      statusColor = AppColors.overdueColor;
    } else if (s == "pending") {
      statusColor = AppColors.pendingColor;
    } else if (s == "demo") {
      statusColor = AppColors.blackColor;
    } else if (s == "inactive" || s == "cancelled") {
      statusColor = AppColors.tertiaryTextColor;
    }

    return SizedBox(
        width: width,
        child: Text(
            status ?? "-",
            style: TTextTheme.tableRegular14(context).copyWith(
                color: statusColor,
                fontWeight: FontWeight.w600
            )
        )
    );
  }
  // Cards
  Widget _buildStatsRow(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      double width = constraints.maxWidth;
      int crossAxisCount = width > 800 ? 4 : (width > 550 ? 2 : 1);
      double childAspectRatio;
      if (width > 800) {
        childAspectRatio = 1.6;
      } else if (width > 550) {
        childAspectRatio = 2.0;
      } else {
        childAspectRatio = 2.0;
      }

      return GridView.count(
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        physics: const NeverScrollableScrollPhysics(),
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: childAspectRatio,
        children: [
          _statCard(context,TextString.companyCard1 , "35",TextString.companyCard1Subtitle , IconString.totalCompanies),
          _statCard(context,TextString.companyCard2 , "22",TextString.companyCard2Subtitle  , IconString.activeCompanies),
          _statCard(context,TextString.companyCard3 , "6",TextString.companyCard3subtitle  , IconString.suspendedCompanies),
          _statCard(context, TextString.companyCard4, "8",TextString.companyCard4subtitle , IconString.newCompanies),
        ],
      );
    });
  }
  Widget _statCard(BuildContext context, String title, String value, String sub, String icon) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              Container(
                  height: 32,
                  width: 32,
                  decoration: BoxDecoration(
                      color: AppColors.secondaryColor,
                      borderRadius: BorderRadius.circular(8)
                  ),
                  child: Image.asset(icon, height: 18)
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TTextTheme.bodyRegular12(context)
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(value, style: TTextTheme.h2Style(context)),
          const SizedBox(height: 2),
          Text(sub, style: TTextTheme.bodySecondRegular10(context)),
        ],
      ),
    );
  }

   // Add Button
  Widget _buildAddPaymentButton(BuildContext context, bool isFullWidth) {
    return PrimaryButtonOfCompanies(
      text: "Add Company",
      onTap: () =>  context.push('/addCompany'),
      width: isFullWidth ? double.infinity : 150,
      borderRadius: BorderRadius.circular(10),
    );
  }

   //  Delete Dialogs
  void showDeleteCompanyDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          elevation: 0,
          backgroundColor: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.all(20),
            width: 450,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Stack(
              children: [
                Positioned(
                  right: 0,
                  top: 0,
                  child: InkWell(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: AppColors.toolBackground,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.close, size: 16, color: AppColors.blackColor),
                    ),
                  ),
                ),

                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                            color: AppColors.emojiBackground,
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                               Text(
                                TextString.companyDeleteDialog1,
                                style: TTextTheme.h2Style(context),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                TextString.companyDeleteDialog1Subtitle,
                                style: TTextTheme.bodyRegular16(context),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        SizedBox(
                          width: 110,
                          height: 40,
                          child: OutlinedButton(
                            onPressed: () {
                              Navigator.pop(context);
                              showSuccessDeletedDialog(context);
                            },
                            style: OutlinedButton.styleFrom(
                              side: const BorderSide(color: AppColors.primaryColor),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                            ),
                            child:  Text(
                              "Save",
                              style: TTextTheme.bodyRegular14Primary(context),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        PrimaryButtonOfCompanies(
                          text: "Cancel",
                          width: 110,
                          height: 40,
                          onTap: () => Navigator.pop(context),
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
  void showSuccessDeletedDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          backgroundColor: Colors.white,
          child: Container(
            width: 480,
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 55,
                      width: 55,
                      decoration: BoxDecoration(
                        color: AppColors.emojiBackground,
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                           Text(
                            TextString.succesDialogtitle,
                            style: TTextTheme.h2Style(context),
                          ),
                          const SizedBox(height: 6),
                           Text(
                            TextString.succesDialogSubtitle,
                            style:  TTextTheme.bodyRegular16(context),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 10),
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(color: AppColors.toolBackground, shape: BoxShape.circle),
                        child: const Icon(Icons.close, size: 16, color: AppColors.blackColor),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
   // suspended Dialogs
  void showSuspendCompanyDialog(BuildContext context) {
    final TextEditingController reasonController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          backgroundColor: Colors.white,
          child: LayoutBuilder(builder: (context, constraints) {
            double dialogWidth = constraints.maxWidth;
            bool isSmall = dialogWidth < 280;

            return Container(
              padding: const EdgeInsets.all(24),
              width: 400,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.block, color: AppColors.primaryColor, size: 30),
                  const SizedBox(height: 16),
                  Text(TextString.suspendedTitle, style: TTextTheme.h2Style(context)),
                  const SizedBox(height: 24),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(TextString.reasoncompany, style: TTextTheme.tableMedium14(context)),
                      const SizedBox(height: 8),
                      TextField(
                        cursorColor: AppColors.blackColor,
                        controller: reasonController,
                        maxLines: 3,
                        style: TTextTheme.titleseven(context),
                        decoration: InputDecoration(
                          hintText: "Write here",
                          hintStyle: TTextTheme.titleseven(context),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(color: AppColors.quadrantalTextColor),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(color: AppColors.primaryColor),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),
                  isSmall
                      ? Column(
                    children: [
                      _buildCancelButton(context),
                      const SizedBox(height: 12),
                      _buildSuspendButton(context),
                    ],
                  )
                      : Row(
                    children: [
                      Expanded(child: _buildCancelButton(context)),
                      const SizedBox(width: 16),
                      Expanded(child: _buildSuspendButton(context)),
                    ],
                  ),
                ],
              ),
            );
          }),
        );
      },
    );
  }
  Widget _buildCancelButton(BuildContext context) {
    return SizedBox(
      height: 44,
      width: double.infinity,
      child: OutlinedButton(
        onPressed: () => Navigator.pop(context),
        style: OutlinedButton.styleFrom(
          side: const BorderSide(color: AppColors.primaryColor),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        child: Text("Cancel", style: TTextTheme.bodyRegular14Primary(context)),
      ),
    );
  }
  Widget _buildSuspendButton(BuildContext context) {
    return PrimaryButtonOfCompanies(
      text: "Suspend",
      height: 44,
      width: double.infinity,
      onTap: () {
        Navigator.pop(context);
       showSuspendedDeleteCompanyDialog(context);
      },
      borderRadius: BorderRadius.circular(8),
    );
  }
  void showSuspendedDeleteCompanyDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          elevation: 0,
          backgroundColor: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.all(20),
            width: 450,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Stack(
              children: [
                Positioned(
                  right: 0,
                  top: 0,
                  child: InkWell(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: AppColors.toolBackground,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.close, size: 16, color: AppColors.blackColor),
                    ),
                  ),
                ),

                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                            color: AppColors.emojiBackground,
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                TextString.suspendedTitle,
                                style: TTextTheme.h2Style(context),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                TextString.companyDeleteDialog1Subtitle,
                                style: TTextTheme.bodyRegular16(context),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        SizedBox(
                          width: 110,
                          height: 40,
                          child: OutlinedButton(
                            onPressed: () {
                              Navigator.pop(context);
                              showSuccessSuspendedDeletedDialog(context);
                            },
                            style: OutlinedButton.styleFrom(
                              side: const BorderSide(color: AppColors.primaryColor),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                            ),
                            child:  Text(
                              "Save",
                              style: TTextTheme.bodyRegular14Primary(context),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        PrimaryButtonOfCompanies(
                          text: "Cancel",
                          width: 110,
                          height: 40,
                          onTap: () => Navigator.pop(context),
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
  void showSuccessSuspendedDeletedDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          backgroundColor: Colors.white,
          child: Container(
            width: 480,
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 55,
                      width: 55,
                      decoration: BoxDecoration(
                        color: AppColors.emojiBackground,
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            TextString.suspendedTitle2,
                            style: TTextTheme.h2Style(context),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            TextString.suspendedTitle2Subtitle,
                            style:  TTextTheme.bodyRegular16(context),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 10),
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(color: AppColors.toolBackground, shape: BoxShape.circle),
                        child: const Icon(Icons.close, size: 16, color: AppColors.blackColor),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

}