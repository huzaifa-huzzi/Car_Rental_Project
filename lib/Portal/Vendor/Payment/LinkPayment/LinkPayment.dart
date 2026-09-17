import 'package:car_rental_project/Portal/Vendor/Payment/ReusableWidget/HeaderWebPaymentWidget.dart';
import 'package:car_rental_project/Portal/Vendor/Payment/paymentController.dart';
import 'package:car_rental_project/Resources/Colors.dart';
import 'package:car_rental_project/Resources/ImageString.dart';
import 'package:car_rental_project/Resources/TextString.dart';
import 'package:car_rental_project/Resources/TextTheme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';


class LinkPaymentScreen extends StatelessWidget {
  final PaymentController controller = Get.find<PaymentController>();

  LinkPaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final bool isWeb = screenWidth > 900;
    final bool isTab = screenWidth > 600 && screenWidth <= 900;

    return Scaffold(
      backgroundColor: AppColors.backgroundOfScreenColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              HeaderWebPaymentWidget(
                mainTitle: 'Add Payment',
                showSmallTitle: true,
                smallTitle: 'Payment / Payment Detail',
                showProfile: isWeb || isTab,
                showNotification: true,
                showSettings: true,
                showBack: true,
                onBackPressed: () {
                  if (controller.isPaymentLinked.value) {
                    controller.isPaymentLinked.value = false;
                  } else {
                    context.pop();
                  }
                },
              ),
              const SizedBox(height: 24),
              Obx(() {
                return controller.isPaymentLinked.value
                    ? _buildFilledPaymentDetails(context)
                    : _buildSelectionView(context);
              }),
            ],
          ),
        ),
      ),
    );
  }

   /// ------------ Extra Widget ---------------- ///

  // SelectionView
  Widget _buildSelectionView(BuildContext context) {
    return GestureDetector(
      onTap: () => controller.isPickupDropdownOpen.value = false,
      behavior: HitTestBehavior.opaque,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: AppColors.sideBarBackgroundColor,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  TextString.linkTitleCarDetail,
                  style: TTextTheme.h2Style(context).copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  TextString.linkTitleCarDetailSubtitle,
                  style: TTextTheme.h2StyleSubtitle(context).copyWith(
                    color: AppColors.secondTextColor,
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: AppColors.sideBoxesColor.withValues(alpha: 0.5),
                      width: 1,
                    ),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.turn_left,
                            color: AppColors.primaryColor,
                            size: 22,
                          ),
                          const SizedBox(width: 8),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                TextString.linktitlePickup,
                                style: TTextTheme.h2Style(context).copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                TextString.linktitlePickupSubtitle,
                                style: TTextTheme.h2StyleSubtitle(context).copyWith(
                                  color: AppColors.secondTextColor,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                      const SizedBox(height: 18),

                      Obx(() {
                        final selected = controller.selectedPickup.value;
                        return SizedBox(
                          width: double.infinity,
                          height: 48,
                          child: ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primaryColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              elevation: 0,
                            ),
                            onPressed: () => controller.isPickupDropdownOpen.value =
                            !controller.isPickupDropdownOpen.value,
                            icon: const Icon(
                              Icons.near_me,
                              size: 16,
                              color: Colors.white,
                            ),
                            label: Text(
                              selected != null
                                  ? "${selected['title']}"
                                  : "Select The pickup",
                              style: TTextTheme.h8Style(context).copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        );
                      }),
                    ],
                  ),
                ),
                Obx(() {
                  if (!controller.isPickupDropdownOpen.value) {
                    return const SizedBox.shrink();
                  }

                  return Container(
                    margin: const EdgeInsets.only(top: 16),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppColors.backgroundOfPickupsWidget,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: TextField(
                            onChanged: (val) =>
                            controller.searchPickupText.value = val,
                            style: TTextTheme.h2Style(context),
                            decoration: InputDecoration(
                              hintText: "Search Car...",
                              hintStyle: TTextTheme.titleTwo(context).copyWith(
                                color: AppColors.blackColor,
                              ),
                              prefixIcon: const Icon(
                                Icons.search,
                                color: AppColors.secondTextColor,
                                size: 20,
                              ),
                              prefixIconConstraints: const BoxConstraints(
                                minWidth: 32,
                                minHeight: 20,
                              ),
                              border: InputBorder.none,
                              contentPadding:
                              const EdgeInsets.symmetric(vertical: 14),
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        Obx(() {
                          final list = controller.filteredPickups;
                          return ListView.separated(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: list.length,
                            separatorBuilder: (_, __) =>
                            const SizedBox(height: 10),
                            itemBuilder: (context, index) {
                              final item = list[index];
                              final String imagePath =
                                  item['image'] ?? ImageString.sedanCar;

                              return Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 12,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    children: [
                                      Image.asset(
                                        imagePath,
                                        width: 100,
                                        height: 50,
                                        fit: BoxFit.contain,
                                        errorBuilder: (_, __, ___) => Image.asset(
                                          ImageString.sedanCar,
                                          width: 75,
                                          height: 40,
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                      const SizedBox(width: 16),
                                      Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            item['subtitle'] ?? "Aston 2025",
                                            style: TTextTheme.h2StyleSubtitle(context).copyWith(
                                              color: AppColors.blackColor,
                                            ),
                                          ),
                                          Text(
                                            item['title'] ?? "Martin",
                                            style: TTextTheme.h2Style(context).copyWith(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(width: 24),
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 14,
                                          vertical: 8,
                                        ),
                                        decoration: BoxDecoration(
                                          color: AppColors.availableBackgroundColor,
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                        child: Text(
                                          item['status'] ?? "Available",
                                          style: TTextTheme.h10Style(context).copyWith(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 12),
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(8),
                                        child: Container(
                                          color: AppColors.secondaryColor,
                                          child: Row(
                                            children: [
                                              Container(
                                                padding: const EdgeInsets.symmetric(
                                                  horizontal: 12,
                                                  vertical: 8,
                                                ),
                                                color: AppColors.textColor,
                                                child: Text(
                                                 TextString.linktitleRegistration,
                                                  style: TTextTheme.h10Style(context).copyWith(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.symmetric(
                                                  horizontal: 12,
                                                  vertical: 8,
                                                ),
                                                child: Text(
                                                  item['registration'] ?? "1234567890",
                                                  style: TTextTheme.stepsText(context).copyWith(
                                                    color: AppColors.textColor,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 12),
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(8),
                                        child: Container(
                                          color: AppColors.secondaryColor,
                                          child: Row(
                                            children: [
                                              Container(
                                                padding: const EdgeInsets.symmetric(
                                                  horizontal: 12,
                                                  vertical: 8,
                                                ),
                                                color: AppColors.backgroundOfVin,
                                                child: Text(
                                                  TextString.linktitleVin,
                                                  style: TTextTheme.h10Style(context).copyWith(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.symmetric(
                                                  horizontal: 12,
                                                  vertical: 8,
                                                ),
                                                child: Text(
                                                  item['vin'] ?? "JTNBA3HK134567890",
                                                  style: TTextTheme.stepsText(context).copyWith(
                                                    color: AppColors.textColor,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 24),
                                      ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: AppColors.primaryColor,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(8),
                                          ),
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 24,
                                            vertical: 12,
                                          ),
                                          elevation: 0,
                                        ),
                                        onPressed: () =>
                                            controller.selectPickupItem(item),
                                        child: Text(
                                          "Select",
                                          style: TTextTheme.titleTwo(context).copyWith(
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        })
                      ],
                    ),
                  );
                }),
              ],
            ),
          ),
          const SizedBox(height: 24),
          Align(
            alignment: Alignment.centerRight,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryColor,
                padding: const EdgeInsets.symmetric(
                  horizontal: 28,
                  vertical: 14,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                elevation: 0,
              ),
              onPressed: controller.handleLinkPayment,
              child: Text(
                TextString.mainLinkPaymentTitle,
                style: TTextTheme.h8Style(context).copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  // Filled Payment Details
  Widget _buildFilledPaymentDetails(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LayoutBuilder(
          builder: (context, constraints) {
            bool isWide = constraints.maxWidth > 850;
            return isWide
                ? Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: _buildCarDetailCard(context, isWide)),
                const SizedBox(width: 20),
                Expanded(child: _buildCustomerDetailCard(context, isWide)),
              ],
            )
                : Column(
              children: [
                _buildCarDetailCard(context, isWide),
                const SizedBox(height: 20),
                _buildCustomerDetailCard(context, isWide),
              ],
            );
          },
        ),
        const SizedBox(height: 20),
        _buildRentalDetailsCard(context),
        const SizedBox(height: 24),
        LayoutBuilder(
          builder: (context, constraints) {
            bool isWeb = constraints.maxWidth > 600;
            return Align(
              alignment: isWeb ? Alignment.centerRight : Alignment.center,
              child: SizedBox(
                width: isWeb ? null : double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryColor,
                    padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    elevation: 0,
                  ),
                  onPressed: () {
                    _showApproveRequestDialog(context);
                    Get.snackbar("Success", "Payment linked successfully!");
                  },
                  child: Text(
                    TextString.mainLinkPaymentTitle,
                    style: TTextTheme.titleTwo(context).copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }

    // Car Detail Form
  Widget _buildCarDetailCard(BuildContext context, bool isWide) {
    return _buildCardWrapper(
      context: context,
      title: TextString.carDetailTitlepayment,
      subtitle: TextString.carDetailTitleSubtitle,
      child: Column(
        children: [
          _buildResponsiveRow(
            isWide: isWide,
            children: [
              _buildDisabledField(context, TextString.carField1, controller.carNameController),
              _buildDisabledField(context, TextString.carField2, controller.carTypeController),
            ],
          ),
          const SizedBox(height: 16),
          _buildResponsiveRow(
            isWide: isWide,
            children: [
              _buildDisabledField(context, TextString.carField2, controller.registrationController),
              _buildDisabledField(context, TextString.carField3, controller.transmissionController),
            ],
          ),
        ],
      ),
    );
  }

   // Customer Detail Form
  Widget _buildCustomerDetailCard(BuildContext context, bool isWide) {
    return _buildCardWrapper(
      context: context,
      title: TextString.customerDetail,
      subtitle: TextString.customerDetailSubtitle,
      child: Column(
        children: [
          _buildResponsiveRow(
            isWide: isWide,
            children: [
              _buildDisabledField(context, TextString.autoPaymentTitle2, controller.customerNameController),
              _buildDisabledField(context, TextString.field3, controller.phoneNumberController),
            ],
          ),
          const SizedBox(height: 16),
          _buildResponsiveRow(
            isWide: isWide,
            children: [
              _buildDisabledField(context, TextString.titleEmailStepTwo, controller.emailController ?? TextEditingController(text: "adam@gmail.com")),
              _buildDisabledField(context, TextString.licenseDetail, controller.licenseController ?? TextEditingController(text: "#12345667")),
            ],
          ),
        ],
      ),
    );
  }

   // Rental Details Form
  Widget _buildRentalDetailsCard(BuildContext context) {
    return _buildCardWrapper(
      context: context,
      title: TextString.autoRentalDetailTitle,
      subtitle: TextString.autoRentalDetailSubtitle,
      child: LayoutBuilder(
        builder: (context, constraints) {
          bool isDesktop = constraints.maxWidth > 900;
          bool isTablet = constraints.maxWidth > 600 && constraints.maxWidth <= 900;

          if (isDesktop) {
            return Column(
              children: [
                Row(
                  children: [
                    Expanded(child: _buildDisabledField(context, TextString.fromDate, controller.fromDateController)),
                    const SizedBox(width: 16),
                    Expanded(child: _buildDisabledField(context, TextString.toDate, controller.toDateController)),
                    const SizedBox(width: 16),
                    Expanded(child: _buildDisabledField(context, TextString.duration2, controller.durationController)),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(child: _buildDisabledField(context, TextString.rentalAmount, controller.paymentAmountController)),
                    const SizedBox(width: 16),
                    Expanded(
                      child: _buildCustomDropdown(
                        context,
                        'Overdue Day',
                        ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'],
                        controller.selectedOverdueDay ?? "Wednesday".obs,
                        id: 'overdue_day_drop',
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: _buildDisabledField(
                        context,
                        'Payment Type',
                        controller.paymentTypeController,
                      ),
                    ),
                  ],
                ),
              ],
            );
          } else if (isTablet) {
            return Column(
              children: [
                Row(
                  children: [
                    Expanded(child: _buildDisabledField(context, TextString.fromDate, controller.fromDateController)),
                    const SizedBox(width: 16),
                    Expanded(child: _buildDisabledField(context, TextString.toDate, controller.toDateController)),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(child: _buildDisabledField(context, TextString.duration2, controller.durationController)),
                    const SizedBox(width: 16),
                    Expanded(child: _buildDisabledField(context, TextString.rentalAmount, controller.paymentAmountController)),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: _buildCustomDropdown(
                        context,
                        'Overdue Day',
                        ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'],
                        controller.selectedOverdueDay ?? "Wednesday".obs,
                        id: 'overdue_day_drop',
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: _buildDisabledField(
                        context,
                        'Payment Type',
                        controller.paymentTypeController,
                      ),
                    ),
                  ],
                ),
              ],
            );
          } else {
            return Column(
              children: [
                _buildDisabledField(context, TextString.fromDate, controller.fromDateController),
                const SizedBox(height: 16),
                _buildDisabledField(context, TextString.toDate, controller.toDateController),
                const SizedBox(height: 16),
                _buildDisabledField(context, TextString.duration2, controller.durationController),
                const SizedBox(height: 16),
                _buildDisabledField(context, TextString.rentalAmount, controller.paymentAmountController),
                const SizedBox(height: 16),
                _buildCustomDropdown(
                  context,
                  'Overdue Day',
                  ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'],
                  controller.selectedOverdueDay ?? "Wednesday".obs,
                  id: 'overdue_day_drop',
                ),
                const SizedBox(height: 16),
                _buildDisabledField(
                  context,
                  'Payment Type',
                  controller.paymentTypeController,
                ),
              ],
            );
          }
        },
      ),
    );
  }

  // Customer Dropdown
  Widget _buildCustomDropdown(
      BuildContext context,
      String label,
      List<String> items,
      RxString selected, {
        required String id,
      }) {
    return Obx(() {
      bool isOpen = controller.openedDropdown2.value == id;
      String errorMsg = controller.dropdownErrors[id] ?? "";
      bool hasError = errorMsg.isNotEmpty;

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TTextTheme.h2StyleSubtitle(context).copyWith(
              color: AppColors.secondTextColor,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          LayoutBuilder(builder: (context, constraints) {
            return PopupMenuButton<String>(
              constraints: BoxConstraints(
                minWidth: constraints.maxWidth,
                maxWidth: constraints.maxWidth,
                maxHeight: 300,
              ),
              offset: const Offset(0, 48),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              color: Colors.white,
              elevation: 4,
              onOpened: () => controller.openedDropdown2.value = id,
              onCanceled: () => controller.openedDropdown2.value = "",
              onSelected: (val) {
                selected.value = val;
                if (controller.dropdownErrors.containsKey(id)) {
                  controller.dropdownErrors[id] = "";
                }
                controller.openedDropdown2.value = "";
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                height: 44,
                padding: const EdgeInsets.symmetric(horizontal: 14),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: hasError
                        ? AppColors.textColor
                        : AppColors.sideBoxesColor.withValues(alpha: 0.6),
                    width: 1,
                  ),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        selected.value.isEmpty ? "Select $label..." : selected.value,
                        style: TTextTheme.h2Style(context).copyWith(
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                          color: selected.value.isEmpty ? AppColors.tertiaryTextColor: Colors.black87,
                        ),
                      ),
                    ),
                    Icon(
                      isOpen ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                      color: AppColors.tertiaryTextColor,
                      size: 20,
                    ),
                  ],
                ),
              ),
              itemBuilder: (context) {
                return items.map((item) {
                  bool isSelected = selected.value == item;
                  return PopupMenuItem<String>(
                    value: item,
                    height: 40,
                    child: Text(
                      item,
                      style: TTextTheme.h2Style(context).copyWith(
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                        color:Colors.black87,
                      ),
                    ),
                  );
                }).toList();
              },
            );
          }),
          if (hasError)
            Padding(
              padding: const EdgeInsets.only(top: 6, left: 4),
              child: Text(
                errorMsg,
                style: TTextTheme.ErrorStyle(context),
              ),
            ),
        ],
      );
    });
  }

// Helpers
  Widget _buildResponsiveRow({required bool isWide, required List<Widget> children}) {
    if (isWide) {
      return Row(
        children: [
          Expanded(child: children[0]),
          const SizedBox(width: 16),
          Expanded(child: children[1]),
        ],
      );
    }
    return Column(
      children: [
        children[0],
        const SizedBox(height: 16),
        children[1],
      ],
    );
  }

  Widget _buildCardWrapper({
    required BuildContext context,
    required String title,
    required String subtitle,
    required Widget child,
  }) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(MediaQuery.of(context).size.width > 600 ? 24 : 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TTextTheme.h2Style(context).copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: TTextTheme.h2StyleSubtitle(context).copyWith(
              color: AppColors.secondTextColor,
              fontSize: 13,
            ),
          ),
          const SizedBox(height: 20),
          child,
        ],
      ),
    );
  }

  Widget _buildDisabledField(BuildContext context, String label, TextEditingController textController) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TTextTheme.h2StyleSubtitle(context).copyWith(
            color: AppColors.secondTextColor,
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          constraints: const BoxConstraints(minHeight: 44),
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: AppColors.sideBoxesColor.withValues(alpha: 0.6)),
          ),
          alignment: Alignment.centerLeft,
          child: TextFormField(
            controller: textController,
            readOnly: true,
            style: TTextTheme.h2Style(context).copyWith(
              fontSize: 13,
              fontWeight: FontWeight.w400,
              color: Colors.black87,
            ),
            decoration: const InputDecoration(
              isDense: true,
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(vertical: 8),
            ),
          ),
        ),
      ],
    );
  }

   /// Dialogs
  void _showApproveRequestDialog(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final bool isMobile = screenWidth < 600;

    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return Dialog(
          insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          backgroundColor: Colors.white,
          child: Container(
            constraints: const BoxConstraints(maxWidth: 480),
            padding: EdgeInsets.all(isMobile ? 16 : 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: const BoxDecoration(
                        color: AppColors.secondaryColor,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.close, size: 16, color: AppColors.blackColor),
                    ),
                  ),
                ),

                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: AppColors.emojiBackground,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      alignment: Alignment.center,
                      child: const Text('🤨', style: TextStyle(fontSize: 24)),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Mark Payment as linked ?",
                            style: TTextTheme.h13Style(context).copyWith(
                              fontWeight: FontWeight.bold,
                              color: AppColors.textColor,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            "Make Sure you want to mark payment as linked?This action confirm that Payment has linked with manual Payment",
                            style: TTextTheme.bodyRegular14(context).copyWith(
                              color: AppColors.secondTextColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 42,
                        child: OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            padding: EdgeInsets.zero,
                            side: const BorderSide(color: AppColors.primaryColor, width: 1.2),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                            _showSuccessDialog(context);
                          },
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text(
                              'Save',
                              style: TTextTheme.btnSavePrimary(context),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: SizedBox(
                        height: 42,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.zero,
                            backgroundColor: AppColors.primaryColor,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          onPressed: () => Navigator.of(context).pop(),
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text(
                              'Cancel',
                              style: TTextTheme.btnSave(context),
                            ),
                          ),
                        ),
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
  void _showSuccessDialog(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final bool isMobile = screenWidth < 600;

    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return Dialog(
          insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          backgroundColor: Colors.white,
          child: Container(
            constraints: const BoxConstraints(maxWidth: 440),
            padding: EdgeInsets.all(isMobile ? 16 : 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: const BoxDecoration(
                        color: AppColors.secondaryColor,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.close, size: 16, color: AppColors.blackColor),
                    ),
                  ),
                ),

                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: AppColors.emojiBackground,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      alignment: Alignment.center,
                      child: const Text('👍', style: TextStyle(fontSize: 24)),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Payment Marked as Linked Successfully!",
                            style: TTextTheme.h13Style(context).copyWith(
                              fontWeight: FontWeight.bold,
                              color: AppColors.textColor,
                              height: 1.2,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            "Congratulation! Payment has marked as linked in successfully in the System.",
                            style: TTextTheme.bodyRegular14(context).copyWith(
                              color: AppColors.secondTextColor,
                              height: 1.3,
                            ),
                          ),
                        ],
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