import 'package:car_rental_project/Authentication/LoginController.dart';
import 'package:car_rental_project/Authentication/ReusableWidgetOfLogin/PrimaryBtnOfLogin.dart';
import 'package:car_rental_project/Resources/Colors.dart';
import 'package:car_rental_project/Resources/TextTheme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

import '../../Resources/IconStrings.dart' show IconString;


class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
   final controller = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 600;

    return Scaffold(
      body: Stack(
        children: [
          //  Background
          Row(
            children: [
              Expanded(child: Container(color: AppColors.secondaryColor)),
              Expanded(child: Container(color: AppColors.backgroundOfPickupsWidget)),
            ],
          ),

          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(12),
              child: Column(
                children: [
                  //  Logo Logic
                  if (!isMobile)
                    Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: _buildLogo(),
                      ),
                    ),
                  if (isMobile) _buildLogo(),
                  if (isMobile) const SizedBox(height: 30),

                  // Forget Password Card
                  Container(
                    constraints: const BoxConstraints(maxWidth: 450),
                    padding: EdgeInsets.symmetric(
                      horizontal: size.width < 400 ? 15 : 30,
                      vertical: 40,
                    ),
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
                         Text(
                          "Forget Password",
                          style: TTextTheme.h11Style(context),
                        ),
                        const SizedBox(height: 10),
                         Text(
                          "No worries! Just enter your email and we'll send you a reset password link.",
                          textAlign: TextAlign.center,
                          style:TTextTheme.pSeven(context),
                        ),
                        const SizedBox(height: 40),

                        // Email Field
                        _buildLabel("Email"),
                        _buildTextField(
                          hint: "sellostore@company.com",
                         textController: controller.emailForgotController,
                        ),
                        const SizedBox(height: 30),

                        PrimaryBtnOfLogin(
                          text: "Send Verification Mail",
                          onTap:(){
                            context.push('/twoStepVerificationOne');
                          },
                          width: double.infinity,
                          height: 50,
                          borderRadius: BorderRadius.circular(10),
                         ),

                        const SizedBox(height: 25),

                        // Footer
                        Wrap(
                          alignment: WrapAlignment.center,
                          children: [
                            Text("Just remember? ", style: TTextTheme.titleSmallRemember(context)),
                            GestureDetector(
                              onTap: () {
                                context.push('/signUp');
                              },
                              child:  Text(
                                "Sign Up",
                                style: TTextTheme.titleSmallRegister(context)
                              ),
                            ),
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

  /// ---------- Extra Widgets -------- ///


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

  Widget _buildLabel(String text) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Text(text, style: TTextTheme.dropdowninsideText(context)),
      ),
    );
  }

  Widget _buildTextField({required String hint, TextEditingController? textController}) {
    return TextField(
      cursorColor: AppColors.blackColor,
      controller: textController,
      style: TTextTheme.loginInsideTextField(context),
      decoration: InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: AppColors.secondaryColor,
        hintStyle: TTextTheme.loginInsideTextField(context),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      ),
    );
  }
}
