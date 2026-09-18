import 'package:car_rental_project/Portal/Vendor/Payment/ReusableWidget/HeaderWebPaymentWidget.dart';
import 'package:car_rental_project/Portal/Vendor/Payment/SubTabs/PaymentDetailTab/SelectedPaymentHistoryDetailView.dart';
import 'package:car_rental_project/Portal/Vendor/Payment/paymentController.dart';
import 'package:car_rental_project/Resources/AppSizes.dart';
import 'package:car_rental_project/Resources/Colors.dart';
import 'package:car_rental_project/Resources/ImageString.dart';
import 'package:car_rental_project/Resources/TextTheme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';



class PaymentDetailTab extends StatelessWidget {
  const PaymentDetailTab({super.key});

  @override
  Widget build(BuildContext context) {
    final PaymentController controller = Get.put(PaymentController());

    return Scaffold(
      backgroundColor: AppColors.backgroundOfScreenColor,
      body: Container(
        color: AppColors.backgroundOfScreenColor,
        width: double.infinity,
        height: double.infinity,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.symmetric(
            horizontal: AppSizes.horizontalPadding(context),
            vertical: 16.0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HeaderWebPaymentWidget(
                mainTitle: 'Payment History',
                showSmallTitle: true,
                smallTitle: 'Payment / Payment History',
                showNotification: true,
                showSettings: true,
                showBack: true,
                onBackPressed: () {
                  if (controller.isCustomerSelected.value) {
                    controller.isCustomerSelected.value = false;
                  } else {
                    final String currentPath = GoRouterState.of(context).uri.toString();
                    if (currentPath.startsWith('/payment/detail')) {
                      context.go('/payment');
                    } else {
                      context.pop();
                    }
                  }
                },
              ),
              const SizedBox(height: 20),
              Obx(() {
                if (!controller.isCustomerSelected.value) {
                  return _buildSearchCustomerCard(context, controller);
                } else {
                  return const SelectedPaymentHistoryDetailView();
                }
              }),
            ],
          ),
        ),
      ),
    );
  }

   /// ------------- Extra Widget --------------- ///

   // Search Customer Card
  Widget _buildSearchCustomerCard(BuildContext context, PaymentController controller) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(MediaQuery.of(context).size.width < 600 ? 16 : 24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Payment History",
            style: TTextTheme.h2Style(context).copyWith(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: AppColors.textColor,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            "Enter the specification to search the payment history",
            style: TTextTheme.h2StyleSubtitle(context).copyWith(
              color: AppColors.secondTextColor,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 16),
          Divider(color: AppColors.sideBoxesColor, height: 1),
          const SizedBox(height: 20),

          LayoutBuilder(builder: (context, constraints) {
            bool isMobile = constraints.maxWidth < 650;
            const double inputHeight = 48.0;

            if (isMobile) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildCustomerDropdown(
                    context,
                    controller,
                    "payment_search_category",
                    controller.selectedSearchCategory,
                    true,
                    inputHeight,
                  ),
                  const SizedBox(height: 12),
                  _buildSearchInputField(context, controller, inputHeight),
                ],
              );
            }

            return Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _buildCustomerDropdown(
                  context,
                  controller,
                  "payment_search_category",
                  controller.selectedSearchCategory,
                  false,
                  inputHeight,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildSearchInputField(context, controller, inputHeight),
                ),
              ],
            );
          }),

          Obx(() {
            if (controller.paymentHistorySearchResults.isEmpty) {
              return const SizedBox.shrink();
            }

            return Container(
              width: double.infinity,
              margin: const EdgeInsets.only(top: 20),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.backgroundOfPickupsWidget,
                borderRadius: BorderRadius.circular(16),
              ),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width > 900
                      ? MediaQuery.of(context).size.width - 320
                      : 800,
                  child: Column(
                    children: List.generate(
                      controller.paymentHistorySearchResults.length,
                          (index) {
                        final customer = controller.paymentHistorySearchResults[index];
                        return _buildCustomerSearchResultRow(context, controller, customer);
                      },
                    ),
                  ),
                ),
              ),
            );
          }),
        ],
      ),
    );
  }

   // Dropdown Widget
  Widget _buildCustomerDropdown(
      BuildContext context,
      PaymentController controller,
      String id,
      RxString selectedValue,
      bool isMobile,
      double height,
      ) {
    List<String> items = ["Customer", "Car Name", "Car Registration", "VIN Number"];

    return Obx(() {
      bool isOpen = controller.openedDropdown2.value == id;

      return PopupMenuButton<String>(
        constraints: BoxConstraints(
          minWidth: isMobile ? (MediaQuery.of(context).size.width - 48) : 180,
          maxWidth: isMobile ? (MediaQuery.of(context).size.width - 48) : 180,
        ),
        offset: const Offset(0, 50),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        color: Colors.white,
        elevation: 4,
        onOpened: () => controller.openedDropdown2.value = id,
        onCanceled: () => controller.openedDropdown2.value = "",
        onSelected: (val) {
          selectedValue.value = val;
          controller.openedDropdown2.value = "";
        },
        child: Container(
          height: height,
          width: isMobile ? double.infinity : 180,
          padding: const EdgeInsets.symmetric(horizontal: 14),
          decoration: BoxDecoration(
            color: AppColors.backgroundOfPickupsWidget,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              const Icon(
                Icons.person_outline,
                size: 18,
                color: AppColors.secondTextColor,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  selectedValue.value.isEmpty ? "Customer" : selectedValue.value,
                  style: TTextTheme.btncustomer(context).copyWith(
                    color: AppColors.textColor,
                    fontWeight: FontWeight.w500,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(width: 8),
              Icon(
                isOpen ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                size: 20,
                color: AppColors.secondTextColor,
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

  // Input Field
  Widget _buildSearchInputField(BuildContext context, PaymentController controller, double height) {
    return Obx(() {
      final category = controller.selectedSearchCategory.value.toLowerCase();

      return Container(
        height: height,
        decoration: BoxDecoration(
          color: AppColors.backgroundOfPickupsWidget,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            const SizedBox(width: 14),
            const Icon(Icons.search, color: AppColors.secondTextColor, size: 20),
            const SizedBox(width: 10),
            Expanded(
              child: TextField(
                cursorColor: AppColors.textColor,
                controller: controller.paymentHistorySearchController,
                onChanged: (val) => controller.performCustomerSearch(val),
                style: TTextTheme.h2Style(context).copyWith(fontSize: 14),
                decoration: InputDecoration(
                  hintText: "Search Payment History by $category",
                  hintStyle: TTextTheme.titleTwo(context).copyWith(
                    color: AppColors.secondTextColor.withValues(alpha: 0.7),
                    fontSize: 14,
                  ),
                  border: InputBorder.none,
                  isDense: true,
                  contentPadding: EdgeInsets.zero,
                ),
              ),
            ),
            const SizedBox(width: 8),
            SizedBox(
              height: height,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryColor,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(8),
                      bottomRight: Radius.circular(8),
                    ),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 28),
                  elevation: 0,
                ),
                onPressed: () => controller.performCustomerSearch(
                  controller.paymentHistorySearchController.text,
                ),
                child: Text(
                  "Search",
                  style: TTextTheme.titleTwo(context).copyWith(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }

   // Search Result
  Widget _buildCustomerSearchResultRow(
      BuildContext context, PaymentController controller, Map<String, dynamic> customer) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(16),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                ImageString.userImage,
                width: 20,
                height: 20,
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "${customer['customerName'] ?? 'John Smith'} (${customer['id'] ?? 'CUS-1234'})",
                    style: TTextTheme.h2Style(context).copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: AppColors.textColor,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    customer['email'] ?? 'john.smith@gmail.com',
                    style: TTextTheme.h2StyleSubtitle(context).copyWith(
                      color: AppColors.secondTextColor,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(width: 16),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.directions_car_outlined,
                size: 18,
                color: AppColors.secondTextColor,
              ),
              const SizedBox(width: 6),
              Text(
                customer['car'] ?? "Toyota Corolla 2022 Altis",
                style: TTextTheme.bodyRegular14(context).copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppColors.textColor,
                ),
              ),
            ],
          ),
          const SizedBox(width: 16),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Container(
              color: AppColors.secondaryColor,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                    color: AppColors.textColor,
                    child: Text(
                      "Reg",
                      style: TTextTheme.h10Style(context).copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    child: Text(
                      customer['registration'] ?? "Abc12345",
                      style: TTextTheme.stepsText(context).copyWith(
                        color: AppColors.textColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 16),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 12),
              elevation: 0,
            ),
            onPressed: () => controller.selectCustomerForHistory(customer),
            child: Text(
              "Select",
              style: TTextTheme.titleTwo(context).copyWith(
                color: Colors.white,
                fontSize: 13,
              ),
            ),
          ),
        ],
      ),
    );
  }
}