import 'package:car_rental_project/Authentication/LoginController.dart';
import 'package:car_rental_project/Authentication/ReusableWidgetOfLogin/PrimaryBtnOfLogin.dart';
import 'package:car_rental_project/Resources/Colors.dart';
import 'package:car_rental_project/Resources/IconStrings.dart';
import 'package:car_rental_project/Resources/ImageString.dart';
import 'package:car_rental_project/Resources/TextString.dart';
import 'package:car_rental_project/Resources/TextTheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

class TwoStepVerificationOne extends StatefulWidget {
  const TwoStepVerificationOne({super.key});

  @override
  State<TwoStepVerificationOne> createState() => _TwoStepVerificationOneState();
}

class _TwoStepVerificationOneState extends State<TwoStepVerificationOne> {
  final controller = Get.find<LoginController>();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 600;

    return Scaffold(
      body: Stack(
        children: [
          Row(
            children: [
              Expanded(child: Container(color: AppColors.secondaryColor)),
              Expanded(child: Container(color: AppColors.backgroundOfPickupsWidget)),
            ],
          ),
          Align(
            alignment: const Alignment(0, -0.1),
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  if (!isMobile)
                    Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: const EdgeInsets.all(40.0),
                        child: _buildLogo(),
                      ),
                    ),
                  if (isMobile) _buildLogo(),
                  if (isMobile) const SizedBox(height: 30),

                  Container(
                    constraints: const BoxConstraints(maxWidth: 450),
                    padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 40),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Image.asset(ImageString.smartPhoneImage),
                        const SizedBox(height: 25),
                        Text(TextString.twoStepLogin, style: TTextTheme.h11Style(context)),
                        const SizedBox(height: 10),

                        Obx(() => RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            children: [
                              TextSpan(text: "Enter the verification code we sent to \n", style: TTextTheme.otpMainText(context)),
                              TextSpan(text: TextString.twoStepName, style: TTextTheme.otpSubtitleText(context)),
                              TextSpan(text: " ${TextString.twoStepResend}", style: TTextTheme.titleSmallRegister(context)),
                              TextSpan(
                                text: " ${controller.secondsRemaining}S",
                                style: TTextTheme.otpResend(context),
                              ),
                            ],
                          ),
                        )),
                        const SizedBox(height: 35),
                        Text(TextString.twoStepSixDigit, style: TTextTheme.otpSubtitleText2(context)),
                        const SizedBox(height: 20),
                        Wrap(
                          alignment: WrapAlignment.center,
                          spacing: 8,
                          runSpacing: 8,
                          children: List.generate(6, (index) => _buildOtpBox(index)),
                        ),
                        Obx(() => controller.showOtpError.value
                            ? Padding(
                          padding: const EdgeInsets.only(top: 15),
                          child: Text(
                            "* Required: Please enter 6-digit code",
                            style: TextStyle(color: AppColors.primaryColor, fontSize: 12, fontWeight: FontWeight.w500),
                          ),
                        )
                            : const SizedBox.shrink()),

                        const SizedBox(height: 35),
                        Obx(() => PrimaryBtnOfLogin(
                          text: controller.isLoading.value ? "Verifying..." : "Submit",
                          onTap: () {
                            if (controller.validateOtp()) {
                              context.push('/newPassword');
                            }
                          },
                          width: double.infinity,
                          height: 50,
                          borderRadius: BorderRadius.circular(8),
                        )),

                        const SizedBox(height: 30),
                        Wrap(
                          alignment: WrapAlignment.center,
                          children: [
                            Text(TextString.twoStepFooterOne, style: TTextTheme.titleSmallRemember(context)),
                            Text(TextString.twoStepResend, style: TTextTheme.titleSmallRegister(context)),
                            Text(TextString.twoStepFooterTwo, style: TTextTheme.titleSmallRemember(context)),
                            Text(TextString.twoStepEdit, style: TTextTheme.titleSmallRegister(context)),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
  /// ----------- Extra Widget --------///

   // Otp
  Widget _buildOtpBox(int index) {
    final width = MediaQuery.of(context).size.width;
    final boxSize = width < 400 ? 42.0 : 50.0;

    return Obx(() {
      bool hasError = controller.showOtpError.value && controller.otpControllers2[index].text.isEmpty;

      return SizedBox(
        width: boxSize,
        height: boxSize + 5,
        child: TextField(
          cursorColor: AppColors.blackColor,
          controller: controller.otpControllers2[index],
          textAlign: TextAlign.center,
          keyboardType: TextInputType.number,
          inputFormatters: [
            LengthLimitingTextInputFormatter(1),
            FilteringTextInputFormatter.digitsOnly,
          ],
          onChanged: (value) {
            if (value.isNotEmpty) {
              controller.showOtpError.value = false;
            }

            if (value.isNotEmpty && index < 5) {
              FocusScope.of(context).nextFocus();
            } else if (value.isEmpty && index > 0) {
              FocusScope.of(context).previousFocus();
            }

            if (value.isNotEmpty && index == 5) {
              if (controller.validateOtp()) {
                context.go('/newPassword');
              }
            }
          },
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: hasError ? AppColors.primaryColor : AppColors.tertiaryTextColor,
                width: hasError ? 1.5 : 1.0,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: hasError ? AppColors.primaryColor : AppColors.primaryColor,
                width: 1.5,
              ),
            ),
          ),
          style: TTextTheme.btnEight(context),
        ),
      );
    });
  }

   // Logo
  Widget _buildLogo() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(IconString.symbol),
        const SizedBox(width: 10),
        Text("SoftSnip", style: TTextTheme.h6Style(context)),
      ],
    );
  }
}