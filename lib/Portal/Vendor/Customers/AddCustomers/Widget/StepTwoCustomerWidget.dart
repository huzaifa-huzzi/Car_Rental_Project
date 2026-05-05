import 'package:car_rental_project/Portal/Vendor/Customers/CustomersController.dart';
import 'package:car_rental_project/Portal/Vendor/Customers/ReusableWidgetOfCustomers/AddButtonOfCustomers.dart';
import 'package:car_rental_project/Portal/Vendor/Customers/ReusableWidgetOfCustomers/HeaderWebCustomersWidget.dart';
import 'package:car_rental_project/Resources/AppSizes.dart';
import 'package:car_rental_project/Resources/Colors.dart';
import 'package:car_rental_project/Resources/IconStrings.dart';
import 'package:car_rental_project/Resources/TextString.dart';
import 'package:car_rental_project/Resources/TextTheme.dart';
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(TextString.addCustomerTitle, style: TTextTheme.h7Style(context)),
                    SizedBox(height: AppSizes.verticalPadding(context) * 0.3),
                    Text(TextString.addCustomerSubtitle, style: TTextTheme.titleThree(context)),
                    SizedBox(height: spacing / 2),
                    Divider(thickness: 0.5, color: AppColors.quadrantalTextColor),

                    _buildStepBadges(context),
                    SizedBox(height: spacing),

                    // Input Credentials Box
                    _buildManualCredentialsBox(context),

                    SizedBox(height: spacing * 2),
                    _buttonSection(context, isMobile),

                  ],
                ),
              ),
            ),
            SizedBox(height: spacing),
          ],
        ),
      ),
    );
  }

   /// -------- Extra Widget ------///

   // Manual Credential Box
  Widget _buildManualCredentialsBox(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        children: [
          Image.asset(IconString.credentialsIcon, height: 48),
          const SizedBox(height: 16),
          Text("Create Employee Credentials Here", style: TTextTheme.h2Style(context)),
          Text("Here you can enter employee credentials manually", style: TTextTheme.bodyRegular16(context)),
          const SizedBox(height: 24),
          _buildManualInputField(
            context,
            label: "User Name",
            hint: "enter user name",
            controller: controller.userNameController,
            errorObs: controller.userNameError,
          ),

          const SizedBox(height: 16),

          _buildManualInputField(
            context,
            label: "Password",
            hint: "Enter Password",
            controller: controller.passwordController,
            isPassword: true,
            errorObs: controller.passwordError,
          ),
        ],
      ),
    );
  }

   // Fields
  Widget _buildManualInputField(
      BuildContext context, {
        required String label,
        required String hint,
        required TextEditingController controller,
        required RxnString errorObs,
        bool isPassword = false,
      }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TTextTheme.titleTwo(context)),
        const SizedBox(height: 8),
        Obx(() => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                color: AppColors.secondaryColor,
                borderRadius: BorderRadius.circular(8),
              ),
              child: TextField(
                cursorColor: AppColors.blackColor,
                controller: controller,
                obscureText: isPassword ? this.controller.isPasswordHidden.value : false,
                style: TTextTheme.otpSubtitleText(context),
                decoration: InputDecoration(
                  hintText: hint,
                  hintStyle: TTextTheme.bodyRegular16(context).copyWith(color: Colors.grey),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                  border: InputBorder.none,
                  suffixIcon: isPassword
                      ? GestureDetector(
                    onTap: () => this.controller.togglePasswordVisibility(),
                    child: Icon(
                      this.controller.isPasswordHidden.value ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                      color: AppColors.quadrantalTextColor,
                      size: 20,
                    ),
                  )
                      : null,
                ),
              ),
            ),
            if (errorObs.value != null)
              Padding(
                padding: const EdgeInsets.only(top: 6, left: 4),
                child: Text(
                  errorObs.value!,
                  style: TTextTheme.ErrorStyle(context),
                ),
              ),
          ],
        )),
      ],
    );
  }

  // Badges
  Widget _buildStepBadges(BuildContext context) {
    return Container(
      width: 220,
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Row(
        children: [
          _buildStepItem("1", "Step 1", false, context, isCurrent: true),
          _buildStepLine(true),
          _buildStepItem("2", "Step 2", true, context),
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

  //  BUTTONS
  Widget _buttonSection(BuildContext context, bool isMobile) {
    final double spacing = AppSizes.padding(context);
    final buttonWidth = isMobile ? double.infinity : 180.0;

    List<Widget> buttons = [
      SizedBox(
        width: buttonWidth,
        height: 45,
        child: OutlinedButton(
          onPressed: () => Navigator.pop(context),
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
        child: AddButtonOfCustomer(
          onTap: () async {
            if (controller.validateFields()) {
              showSavingDialog(context);
              try {
                await controller.saveCustomer(context);
              } catch (e) {
                print("Error while saving: $e");
              }
            }
          },
          text: "Save Credentials",
          isIconLeft: true,
        ),
      ),
    ];

    return isMobile
        ? Column(children: buttons)
        : Row(mainAxisAlignment: MainAxisAlignment.end, children: buttons);
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
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
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
                        SizedBox(height: 40, width: 40, child: Image.asset(IconString.searchingIcon)),
                        const SizedBox(width: 20),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(TextString.dialogCustomers1, style: TTextTheme.h2Style(context)),
                              const SizedBox(height: 4),
                              Text(TextString.dialogCustomers2, style: TTextTheme.bodyRegular16(context)),
                              const SizedBox(height: 25),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: LinearProgressIndicator(
                                  value: progress,
                                  minHeight: 6,
                                  backgroundColor: AppColors.backgroundOfPickupsWidget,
                                  valueColor: AlwaysStoppedAnimation<Color>(AppColors.primaryColor),
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
                        decoration: BoxDecoration(color: AppColors.emojiBackground, borderRadius: BorderRadius.circular(12)),
                        child: const Icon(Icons.check_circle_outline, color: AppColors.primaryColor),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(TextString.dialogCustomers3, style: TTextTheme.h2Style(context)),
                            const SizedBox(height: 8),
                            Text(TextString.dialogCustomers4, style: TTextTheme.bodyRegular16(context)),
                          ],
                        ),
                      ),
                      IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: AppColors.sideBoxesColor,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.close,
                            size: 16,
                            color: AppColors.blackColor,
                          ),
                        ),
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                      )
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