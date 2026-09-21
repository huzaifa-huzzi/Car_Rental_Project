import 'package:car_rental_project/Portal/Vendor/Payment/ReusableWidget/HeaderWebPaymentWidget.dart';
import 'package:car_rental_project/Portal/Vendor/Payment/paymentController.dart';
import 'package:car_rental_project/Resources/Colors.dart';
import 'package:car_rental_project/Resources/TextString.dart';
import 'package:car_rental_project/Resources/TextTheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';



class PaymentDetail extends StatelessWidget {
  const PaymentDetail({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(PaymentController());
    final double screenWidth = MediaQuery.of(context).size.width;
    final bool isMobile = screenWidth < 600;
    final bool isTab = screenWidth >= 600 && screenWidth < 1024;
    final bool isWeb = kIsWeb || screenWidth >= 1024;

    return Scaffold(
      backgroundColor: AppColors.backgroundOfScreenColor,
      body: SafeArea(
        child: Column(
          children: [

            if(!isMobile)...[
              HeaderWebPaymentWidget(
              mainTitle: 'Payment',
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
                  Navigator.of(context).pop();
                }
              },
            ),],

            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.all(isMobile ? 12.0 : 20.0),
                child: Column(
                  children: [
                    _buildAddPaymentDetailsCard(context, controller, isMobile),
                    const SizedBox(height: 20),
                    _buildPaymentInstructionsCard(context, controller, isMobile),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

    /// ------------ Extra Widget ------------------ ///

  // Add Payment Detail Card
  Widget _buildAddPaymentDetailsCard(
      BuildContext context,
      PaymentController controller,
      bool isMobile,
      ) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(isMobile ? 16.0 : 24.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            TextString.addPaymentDetails,
            style: TTextTheme.h13Style(context).copyWith(
              fontWeight: FontWeight.bold,
              color: AppColors.textColor,
              fontSize: isMobile ? 18 : 22,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            TextString.belowAreTheInstructionHowToPay,
            style: TTextTheme.bodyRegular14(context).copyWith(
              color: AppColors.secondTextColor,
              fontSize: isMobile ? 12 : 14,
            ),
          ),
          const SizedBox(height: 20),
          Center(
            child: Obx(
                  () => Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: AppColors.secondaryColor,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Wrap(
                  alignment: WrapAlignment.center,
                  spacing: 6,
                  runSpacing: 6,
                  children: [
                    _buildTabButton(
                      context: context,
                      title: TextString.paymentByBankAccount,
                      isSelected: controller.selectedPaymentMethodTab.value == 0,
                      onTap: () => controller.switchPaymentMethodTab(0),
                      isMobile: isMobile,
                    ),
                    _buildTabButton(
                      context: context,
                      title: TextString.paymentByPayId,
                      isSelected: controller.selectedPaymentMethodTab.value == 1,
                      onTap: () => controller.switchPaymentMethodTab(1),
                      isMobile: isMobile,
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 24),
          Obx(() {
            if (controller.selectedPaymentMethodTab.value == 0) {
              return LayoutBuilder(
                builder: (context, constraints) {
                  if (constraints.maxWidth < 750) {
                    return Column(
                      children: [
                        _buildInputField(
                          context,
                          label: TextString.accountName,
                          hint: TextString.enterAccountName,
                          controller: controller.accountNameController,
                        ),
                        const SizedBox(height: 16),
                        _buildInputField(
                          context,
                          label: TextString.bsb,
                          hint: TextString.enterBsbNumber,
                          controller: controller.bsbController,
                        ),
                        const SizedBox(height: 16),
                        _buildInputField(
                          context,
                          label: TextString.accountNumber,
                          hint: TextString.enterAccountNumber,
                          controller: controller.accountNumberController,
                        ),
                      ],
                    );
                  }
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: _buildInputField(
                          context,
                          label: TextString.accountName,
                          hint: TextString.enterAccountName,
                          controller: controller.accountNameController,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: _buildInputField(
                          context,
                          label: TextString.bsb,
                          hint: TextString.enterBsbNumber,
                          controller: controller.bsbController,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: _buildInputField(
                          context,
                          label: TextString.accountNumber,
                          hint: TextString.enterAccountNumber,
                          controller: controller.accountNumberController,
                        ),
                      ),
                    ],
                  );
                },
              );
            } else {
              return _buildInputField(
                context,
                label: TextString.emailAddress,
                hint: TextString.enterEmailAddress,
                controller: controller.payIdController,
              );
            }
          }),
        ],
      ),
    );
  }

  // TAB BUTTON WIDGET
  Widget _buildTabButton({
    required BuildContext context,
    required String title,
    required bool isSelected,
    required VoidCallback onTap,
    required bool isMobile,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(24),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.symmetric(
          horizontal: isMobile ? 16 : 24,
          vertical: 10,
        ),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primaryColor : Colors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: isSelected
              ? []
              : [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.02),
              blurRadius: 4,
            ),
          ],
        ),
        child: Text(
          title,
          style: TTextTheme.pOne(context).copyWith(
            color: isSelected ? Colors.white : AppColors.secondTextColor,
            fontWeight: isSelected ? FontWeight.w500 : FontWeight.w500,
            fontSize: isMobile ? 12 : 14,
          ),
        ),
      ),
    );
  }

  // INPUT FIELD WIDGET
  Widget _buildInputField(
      BuildContext context, {
        required String label,
        required String hint,
        required TextEditingController controller,
      }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TTextTheme.pOne(context).copyWith(
            fontWeight: FontWeight.w600,
            color: AppColors.textColor,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          cursorColor: AppColors.textColor,
          controller: controller,
          style: TTextTheme.pOne(context),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TTextTheme.pFour(context).copyWith(
              color: AppColors.secondTextColor.withValues(alpha: 0.6),
            ),
            filled: true,
            fillColor: AppColors.secondaryColor,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 14,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(
                color: AppColors.sideBoxesColor,
                width: 1.2,
              ),
            ),
          ),
        ),
      ],
    );
  }

  // Payment Instructions
  Widget _buildPaymentInstructionsCard(
      BuildContext context,
      PaymentController controller,
      bool isMobile,
      ) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(isMobile ? 16.0 : 24.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      TextString.paymentInstruction,
                      style: TTextTheme.h13Style(context).copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppColors.textColor,
                        fontSize: isMobile ? 18 : 22,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      TextString.belowAreTheInstructionHowToPay,
                      style: TTextTheme.bodyRegular14(context).copyWith(
                        color: AppColors.secondTextColor,
                        fontSize: isMobile ? 12 : 14,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Obx(
                    () => SizedBox(
                  height: 36,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryColor,
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(horizontal: 22),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () {
                      if (controller.isEditingInstructions.value) {
                        showPausedConfirmationDialog(context,controller);
                      } else {
                        controller.startEditingInstructions();
                      }
                    },
                    child: Text(
                      controller.isEditingInstructions.value
                          ? TextString.save
                          : TextString.edit,
                      style: TTextTheme.btnSave(context).copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Obx(() {
            if (controller.isEditingInstructions.value) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    TextString.description,
                    style: TTextTheme.pOne(context).copyWith(
                      fontWeight: FontWeight.w600,
                      color: AppColors.textColor,
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    cursorColor: AppColors.textColor,
                    controller: controller.instructionDescriptionController,
                    maxLines: 5,
                    style: TTextTheme.pOne(context),
                    decoration: InputDecoration(
                      hintText: TextString.enterDescription,
                      hintStyle: TTextTheme.pFour(context).copyWith(
                        color: AppColors.secondTextColor.withValues(alpha: 0.6),
                      ),
                      filled: true,
                      fillColor: AppColors.secondaryColor,
                      contentPadding: const EdgeInsets.all(16),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide.none,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(
                          color: AppColors.sideBoxesColor,
                          width: 1.2,
                        ),
                      ),
                    ),
                  ),
                ],
              );
            } else {
              bool isBank = controller.selectedPaymentMethodTab.value == 0;
              List<String> activeInstructions = isBank
                  ? controller.bankInstructionsList
                  : controller.payIdInstructionsList;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: activeInstructions.map((step) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12.0),
                    child: Text(
                      step,
                      style: TTextTheme.pOne(context).copyWith(
                        fontWeight: FontWeight.w500,
                        color: AppColors.textColor,
                        fontSize: isMobile ? 13 : 15,
                        height: 1.4,
                      ),
                    ),
                  );
                }).toList(),
              );
            }
          }),
        ],
      ),
    );
  }

   /// Dialog
  void showPausedConfirmationDialog(BuildContext context, PaymentController controller) {
    final controller = PaymentController();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Container(
            width: 450,
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        color: AppColors.emojiBackground,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Center(child: Text("🤨", style: TextStyle(fontSize: 24))),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(TextString.paymentDetailDialogOne, style: TTextTheme.h2Style(context)),
                          const SizedBox(height: 8),
                          Text(
                            TextString.paymentDetailDialogTwo,
                            style: TTextTheme.bodyRegular16(context),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.close_rounded, size: 20),
                      padding: EdgeInsets.zero,
                    )
                  ],
                ),
                const SizedBox(height: 32),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          fixedSize: const Size.fromHeight(50),
                          side: BorderSide(color: AppColors.primaryColor),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          backgroundColor: Colors.white,
                        ),
                        onPressed: () {
                          Navigator.pop(context);

                          showPausedSuccessDialog(context);
                        },
                        child: Text(
                          "Save",
                          style: TTextTheme.medium14Primary(context),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          fixedSize: const Size.fromHeight(50),
                          backgroundColor: AppColors.primaryColor,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          elevation: 0,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          "Cancel",
                          style: TTextTheme.btnWhiteColor(context),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
  void showPausedSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.white,
          insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Container(
            width: 450,
            padding: const EdgeInsets.all(24),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
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
                            TextString.paymentDetailDialogThree,
                                style: TTextTheme.h2Style(context)
                            ),
                            const SizedBox(height: 8),
                            Text(
                                TextString.paymentDetailDialogFour,
                                style: TTextTheme.bodyRegular16(context)
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: AppColors.sideBoxesColor,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(Icons.close, size: 16, color: AppColors.blackColor),
                        ),
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}