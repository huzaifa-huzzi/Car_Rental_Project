import 'package:car_rental_project/Portal/Vendor/Customers/CustomersController.dart';
import 'package:car_rental_project/Portal/Vendor/Customers/ReusableWidgetOfCustomers/HeaderWebCustomersWidget.dart';
import 'package:car_rental_project/Resources/AppSizes.dart';
import 'package:car_rental_project/Resources/Colors.dart';
import 'package:car_rental_project/Resources/IconStrings.dart';
import 'package:car_rental_project/Resources/TextString.dart';
import 'package:car_rental_project/Resources/TextTheme.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class StepTwoCustomerWidget extends StatelessWidget {
  StepTwoCustomerWidget({super.key});

  final controller = Get.put(CustomerController());

  @override
  Widget build(BuildContext context) {
    final isMobile = AppSizes.isMobile(context);
    final double spacing = AppSizes.padding(context);
    final isWeb = AppSizes.isWeb(context);

    return Scaffold(
      backgroundColor: AppColors.backgroundOfScreenColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            if (isWeb)
              HeaderWebCustomersWidget(
                mainTitle: 'Add Customer',
                showBack: true,
                showSmallTitle: true,
                smallTitle: 'Customers/Add Customer ',
                showSearch: true,
                showSettings: true,
                showAddButton: false,
                showNotification: true,
                showProfile: false,
              ),

            Center(
              child: Container(
                width: 800,
                margin: EdgeInsets.symmetric(
                  horizontal: AppSizes.padding(context),
                  vertical: spacing,
                ),
                padding: EdgeInsets.all(spacing),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(AppSizes.borderRadius(context)),
                ),
                child: Obx(() => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(TextString.addCustomerTitle, style: TTextTheme.h7Style(context)),
                    SizedBox(height: AppSizes.verticalPadding(context) * 0.3),
                    Text(TextString.addCustomerSubtitle, style: TTextTheme.titleThree(context)),
                    SizedBox(height: spacing / 2),
                    Divider(thickness: 0.5, color: AppColors.quadrantalTextColor),

                    _buildStepBadges(context),
                    SizedBox(height: spacing),
                    controller.isCredentialsGenerated.value
                        ? _buildSuccessCredentialsBox(context)
                        : _buildGenerateCredentialsBox(context),

                    SizedBox(height: spacing * 2),
                    _buttonSection(context, isMobile),
                    if (!controller.isCredentialsGenerated.value) ...[
                      SizedBox(height: spacing * 2),
                      _buildNoteSection(context),
                    ],
                  ],
                )),
              ),
            ),
            SizedBox(height: spacing),
          ],
        ),
      ),
    );
  }

  /// -------- Extra Widgets ----------- ///

  //  DOTTED BOX
  Widget _buildGenerateCredentialsBox(BuildContext context) {
    return DottedBorder(
      color: AppColors.primaryColor,
      strokeWidth: 1,
      dashPattern: const [6, 3],
      borderType: BorderType.RRect,
      radius: const Radius.circular(20),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
        decoration: BoxDecoration(
          color: AppColors.signaturePadColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          children: [
            Image.asset(IconString.credentialsIcon),
            const SizedBox(height: 20),
            Text(
              TextString.clickHereTogenerate,
              textAlign: TextAlign.center,
              style: TTextTheme.h1Style(context),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: 200,
              height: 45,
              child: ElevatedButton(
                onPressed: () => controller.generateCredentials(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryColor,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                child: Text("Generate Credentials", style: TTextTheme.h16Style(context)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  //  SUCCESS BOX
  Widget _buildSuccessCredentialsBox(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        children: [
          Image.asset(IconString.credentialsIcon),
          const SizedBox(height: 16),
          Text(TextString.credentialsGenerated,
              style: TTextTheme.hnotes(context)),
          Text(TextString.belowcredentialsGenerated,
              style: TTextTheme.bodyRegular16(context)),

          const SizedBox(height: 24),

          _buildReadOnlyField(context, "User Name", controller.userName.value),
          const SizedBox(height: 16),
          _buildReadOnlyField(
            context,
            "Password",
            controller.password.value,
            isPassword: true,
            isHidden: controller.isPasswordHidden.value,
            onVisibilityTap: () => controller.togglePasswordVisibility(),
          ),

          const SizedBox(height: 24),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () => controller.regeneratePassword(),
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: AppColors.primaryColor),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    padding: const EdgeInsets.symmetric(vertical: 15),
                  ),
                  child: Text("Regenerate Password", style: TTextTheme.btnRegenrate(context)),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {

                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryColor,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    padding: const EdgeInsets.symmetric(vertical: 15),
                  ),
                  child:  Text("Save", style: TTextTheme.btnSave(context)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Read Only Field
  Widget _buildReadOnlyField(BuildContext context, String label, String value,
      {bool isPassword = false, bool isHidden = true, VoidCallback? onVisibilityTap}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TTextTheme.titleTwo(context)),
        const SizedBox(height: 8),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
          decoration: BoxDecoration(
            color: AppColors.secondaryColor,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  (isPassword && isHidden) ? "•" * value.length : value,
                  style: TTextTheme.otpSubtitleText(context),
                ),
              ),
              if (isPassword)
                GestureDetector(
                  onTap: onVisibilityTap,
                  child: Icon(
                    isHidden ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                    color: AppColors.quadrantalTextColor,
                    size: 20,
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }

  // NOTE SECTION
  Widget _buildNoteSection(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(TextString.customerNoteStepTwo, style: TTextTheme.hnotes(context)),
          const SizedBox(height: 4),
          Text(
            TextString.customerNoteSubtitleStepTwo,
            style: TTextTheme.notesSubtitle(context),
          ),
        ],
      ),
    );
  }

  // STEP BADGES
  Widget _buildStepBadges(BuildContext context) {
    return Container(
      width: 220,
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Row(
        children: [
          _buildStepItem("1", "Step 1", true, context),
          _buildStepLine(true),
          _buildStepItem("2", "Step 2", false, context, isCurrent: true),
        ],
      ),
    );
  }
  Widget _buildStepItem(String stepNum, String label, bool isCompleted, BuildContext context, {bool isCurrent = false}) {
    return Column(
      children: [
        Container(
          width: 24,
          height: 24,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isCompleted ? AppColors.primaryColor : Colors.white,
            border: Border.all(color: AppColors.primaryColor, width: 1.5),
          ),
          child: Center(
            child: isCompleted
                ? const Icon(Icons.check, size: 14, color: Colors.white)
                : isCurrent
                ? Container(width: 8, height: 8, decoration: const BoxDecoration(color: AppColors.primaryColor, shape: BoxShape.circle))
                : null,
          ),
        ),
        const SizedBox(height: 6),
        Text(label, style: TTextTheme.stepsText(context).copyWith(color: isCompleted ? AppColors.primaryColor : AppColors.textColor)),
      ],
    );
  }
  Widget _buildStepLine(bool isActive) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: Container(height: 1.5, color: AppColors.primaryColor),
      ),
    );
  }

  // BOTTOM BUTTONS
  Widget _buttonSection(BuildContext context, bool isMobile) {
    final double spacing = AppSizes.padding(context);
    final buttonWidth = isMobile ? double.infinity : 180.0;
    List<Widget> buttons = [
      SizedBox(
        width: buttonWidth,
        height: 45,
        child: OutlinedButton(
          onPressed: () {},
          style: OutlinedButton.styleFrom(
            side: BorderSide(color: Colors.grey.shade300),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
          child: Text("Cancel", style: TextStyle(color: AppColors.textColor)),
        ),
      ),
      if (!isMobile) SizedBox(width: spacing),
      if (isMobile) SizedBox(height: spacing),
      SizedBox(
        width: buttonWidth,
        height: 45,
        child: ElevatedButton.icon(
    onPressed: () async {
    showSavingDialog(context);

    try {
    await controller.saveCustomer(context);
    } catch (e) {
    print("Error: $e");
    }
    },
          icon: const Icon(Icons.file_upload_outlined, color: Colors.white, size: 18),
          label: const Text("Save Customer", style: TextStyle(color: Colors.white)),
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primaryColor,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
        ),
      ),
    ];
    return isMobile ? Column(children: buttons) : Row(mainAxisAlignment: MainAxisAlignment.end, children: buttons);
  }


  // Dialogs
  void showSavingDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        double progress = 0.0;

        return StatefulBuilder(
          builder: (context, setState) {
            Future.delayed(Duration.zero, () async {
              while (progress < 1.0) {
                await Future.delayed(const Duration(milliseconds: 40));
                progress += 0.02;
                setState(() {});
              }
              Navigator.pop(context);
              showSuccessDialog(context);
            });

            double screenWidth = MediaQuery.of(context).size.width;

            return Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
              elevation: 10,
              backgroundColor: Colors.white,
              child: Container(
                width: screenWidth < 600 ? screenWidth * 0.9 : 450,
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 40,
                          width: 40,
                          child: Image.asset(IconString.searchingIcon),
                        ),
                        const SizedBox(width: 20),

                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                TextString.dialogCustomers1,
                                style: TTextTheme.h2Style(context),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                TextString.dialogCustomers2,
                                style: TTextTheme.bodyRegular16(context),
                              ),
                              const SizedBox(height: 25),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: LinearProgressIndicator(
                                  value: progress,
                                  minHeight: 6,
                                  backgroundColor: AppColors.backgroundOfPickupsWidget,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    AppColors.primaryColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
  void showSuccessDialog(BuildContext context) {
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
                                TextString.dialogCustomers3,
                                style: TTextTheme.h2Style(context)
                            ),
                            const SizedBox(height: 8),
                            Text(
                                TextString.dialogCustomers4,
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