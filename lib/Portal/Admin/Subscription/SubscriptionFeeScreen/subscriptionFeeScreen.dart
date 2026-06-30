import 'package:car_rental_project/Portal/Admin/Subscription/ReusableWidget/HeaderWebSubscriptionWidget.dart';
import 'package:car_rental_project/Portal/Admin/Subscription/ReusableWidget/PrimaryButtonOfSubscription.dart';
import 'package:car_rental_project/Portal/Admin/Subscription/SubscriptionController.dart';
import 'package:car_rental_project/Resources/AppSizes.dart';
import 'package:car_rental_project/Resources/Colors.dart';
import 'package:car_rental_project/Resources/TextString.dart';
import 'package:car_rental_project/Resources/TextTheme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

class SubscriptionFreeScreen extends StatelessWidget {
  const SubscriptionFreeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final horizontalPadding = AppSizes.horizontalPadding(context);
    final baseVerticalSpace = AppSizes.verticalPadding(context);
    final SubscriptionController controller = Get.put(SubscriptionController());

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
                  mainTitle: 'Subscription Fees',
                  showBack: true,
                  showProfile: true,
                  showNotification: true,
                  showSettings: true,
                  showSearch: true,
                ),

              const SizedBox(height: 30),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.01),
                      blurRadius: 15,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      TextString.SubscriptionTitle35,
                      style: TTextTheme.h2Style(context).copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      TextString.SubscriptionTitle36,
                      style: TTextTheme.bodyRegular16(context).copyWith(color: AppColors.tertiaryTextColor),
                    ),
                    const SizedBox(height: 30),
                    Text(
                      TextString.SubscriptionTitle37,
                      style: TTextTheme.bodyRegular14(context).copyWith(color: AppColors.blackColor),
                    ),
                    const SizedBox(height: 8),
                    _buildFeeInputField(
                      context,
                      controller: controller.monthlyFeeController,
                      hintText: "Enter fee",
                    ),

                    const SizedBox(height: 24),
                    Text(
                      TextString.SubscriptionTitle38,
                      style: TTextTheme.bodyRegular14(context).copyWith(color: AppColors.blackColor),
                    ),
                    const SizedBox(height: 8),
                    _buildFeeInputField(
                      context,
                      controller: controller.yearlyFeeController,
                      hintText: "Enter Fee",
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  PrimaryBtnOfSubscription(
                    text: TextString.SubscriptionTitle39,
                    onTap: () {
                      showUpdateConfirmationDialog(context);
                      controller.updateCarSubscriptionFees();
                    },
                    borderRadius: BorderRadius.circular(8),
                  ),
                ],
              ),

              SizedBox(height: baseVerticalSpace * 1.25),
            ],
          ),
        ),
      ),
    );
  }


   /// ---- Extra Widget ------///
  // Fee InputField
  Widget _buildFeeInputField(BuildContext context,{required TextEditingController controller, required String hintText}) {
    return Container(
      height: 48,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: TextField(
        cursorColor: AppColors.blackColor,
        controller: controller,
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        style: const TextStyle(fontSize: 14),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TTextTheme.bodyRegular16(context),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: AppColors.sideBoxesColor.withOpacity(0.8)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: AppColors.sideBoxesColor.withOpacity(0.8)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: AppColors.tertiaryTextColor, width:0.7),
          ),
        ),
      ),
    );
  }



   /// Dialogs
  Widget _buildSaveButton(BuildContext context) {
    return OutlinedButton(
      onPressed: () {
        Navigator.pop(context);
        showSuccessSubscriptionDialog(context);
      },
      style: OutlinedButton.styleFrom(
        side: const BorderSide(color: AppColors.primaryColor),
        padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      child: Text(
        "Save",
        style: TTextTheme.btnSavePrimary(context),
      ),
    );
  }
  Widget _buildCancelButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () => Navigator.pop(context),
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primaryColor,
        foregroundColor: Colors.white,
        elevation: 0,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      child:  Text("Cancel", style: TTextTheme.btnSave(context)),
    );
  }

  void showUpdateConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext dialogContext) {
        return Dialog(
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          child: LayoutBuilder(
            builder: (context, constraints) {
              double availableWidth = constraints.maxWidth;
              bool isUltraSmall = availableWidth < 350;

              return Container(
                width: availableWidth < 500 ? availableWidth * 0.95 : 480,
                padding: const EdgeInsets.all(24),
                child: Stack(
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
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
                              child: const Text("🤨", style: TextStyle(fontSize: 24)),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 4),
                                  Text(
                                    TextString.SubscriptionTitle40,
                                    style: TTextTheme.h2Style(dialogContext).copyWith(fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(height: 6),
                                  Text(
                                    TextString.SubscriptionTitle41 ,
                                    style: TTextTheme.bodyRegular14(dialogContext).copyWith(color: AppColors.tertiaryTextColor),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 32),
                          ],
                        ),
                        const SizedBox(height: 30),
                        if (isUltraSmall)
                          Column(
                            children: [
                              _buildCancelButton(dialogContext),
                              const SizedBox(height: 10),
                              _buildSaveButton(dialogContext),
                            ],
                          )
                        else
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              _buildCancelButton(dialogContext),
                              const SizedBox(width: 12),
                              _buildSaveButton(dialogContext),
                            ],
                          ),
                      ],
                    ),
                    Positioned(
                      right: 0,
                      top: 0,
                      child: IconButton(
                        onPressed: () => Navigator.pop(dialogContext),
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                        icon: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: AppColors.sideBoxesColor.withOpacity(0.5),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.close, size: 14, color: AppColors.blackColor),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }
  void showSuccessSubscriptionDialog(BuildContext context) {
    final router = GoRouter.of(context);

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext dialogContext) {
        Future.delayed(const Duration(seconds: 2), () {
          if (dialogContext.mounted) {
            Navigator.pop(dialogContext);
            router.go('/subscription');
          }
        });

        return Dialog(
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          child: LayoutBuilder(
            builder: (context, constraints) {
              double availableWidth = constraints.maxWidth;

              return Container(
                width: availableWidth < 500 ? availableWidth * 0.95 : 460,
                padding: const EdgeInsets.all(24),
                child: Stack(
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
                          child: const Text("👍", style: TextStyle(fontSize: 24)),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const SizedBox(height: 4),
                              Text(
                               TextString.SubscriptionTitle42,
                                style: TTextTheme.h2Style(dialogContext).copyWith(fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                TextString.SubscriptionTitle43,
                                style: TTextTheme.bodyRegular14(dialogContext).copyWith(color: AppColors.tertiaryTextColor),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 32),
                      ],
                    ),
                    Positioned(
                      right: 0,
                      top: 0,
                      child: IconButton(
                        onPressed: () {
                          Navigator.pop(dialogContext);
                          router.go('/subscription');
                        },
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                        icon: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: AppColors.sideBoxesColor.withOpacity(0.5),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.close, size: 14, color: AppColors.blackColor),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }
}