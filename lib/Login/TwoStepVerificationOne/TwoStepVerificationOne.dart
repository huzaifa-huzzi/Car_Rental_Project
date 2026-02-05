import 'package:car_rental_project/Login/LoginController.dart' show LoginController;
import 'package:car_rental_project/Login/ReusableWidgetOfLogin/PrimaryBtnOfLogin.dart';
import 'package:car_rental_project/Resources/Colors.dart';
import 'package:car_rental_project/Resources/IconStrings.dart';
import 'package:car_rental_project/Resources/ImageString.dart';
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
  final controller = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 600;

    return Scaffold(
      body: Stack(
        children: [
          // Background Split
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
                  // Logo
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

                  // OTP Card
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

                        //  Headings
                         Text("Two Step Verification",
                            style: TTextTheme.h11Style(context)),
                        const SizedBox(height: 10),

                        RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            children: [
                              TextSpan(text: "Enter the verification code we sent to \n",style: TTextTheme.otpMainText(context)),
                              TextSpan(text: "sellostore@company.com ",
                                  style: TTextTheme.otpSubtitleText(context)),
                              TextSpan(
                                text: "Resend",
                                style: TTextTheme.titleSmallRegister(context)
                              ),
                              TextSpan(
                                text: " ${controller.secondsRemaining}S",
                                style: TTextTheme.otpResend(context),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 35),

                         Text("Type your 6 digit security code",
                            style: TTextTheme.otpSubtitleText2(context)),
                        const SizedBox(height: 20),

                        //  6-Digit OTP Boxes
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: List.generate(6, (index) => _buildOtpBox(index)),
                        ),
                        const SizedBox(height: 35),

                        //  Submit Button
                        PrimaryBtnOfLogin(
                          text:"Submit",
                          onTap:(){
                            context.push('/newPassword');
                          },
                          width: double.infinity,
                          height: 50,
                          borderRadius: BorderRadius.circular(8),
                        ),

                        const SizedBox(height: 30),

                        //  Footer
                        Wrap(
                          alignment: WrapAlignment.center,
                          children: [
                             Text("Didn't get the code? ", style:TTextTheme.titleSmallRemember(context)),
                             Text("Resend",
                                style: TTextTheme.titleSmallRegister(context)),
                             Text(" or ", style: TTextTheme.titleSmallRemember(context)),
                             Text("Edit",
                                style: TTextTheme.titleSmallRegister(context)),
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

  /// ---------- Extra Widgets ------ ///


  Widget _buildOtpBox(int index) {
    return SizedBox(
      width: 50,
      height: 55,
      child: TextField(
        cursorColor: AppColors.blackColor,
        controller: controller.otpControllers2[index],
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        inputFormatters: [LengthLimitingTextInputFormatter(1), FilteringTextInputFormatter.digitsOnly],
        onChanged: (value) {
          if (value.isNotEmpty && index < 5) {
            FocusScope.of(context).nextFocus();
          } else if (value.isEmpty && index > 0) {
            FocusScope.of(context).previousFocus();
          }
        },
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color:AppColors.tertiaryTextColor),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: AppColors.primaryColor, width: 1.5),
          ),
        ),
        style: TTextTheme.btnEight(context),
      ),
    );
  }

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