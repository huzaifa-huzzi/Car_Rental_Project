import 'package:car_rental_project/Login/LoginController.dart';
import 'package:car_rental_project/Login/ReusableWidgetOfLogin/PrimaryBtnOfLogin.dart';
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
          // 1. Background Split (Same as Login)
          Row(
            children: [
              Expanded(child: Container(color: const Color(0xFFF8FAFB))),
              Expanded(child: Container(color: const Color(0xFFFFF1F2))),
            ],
          ),

          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(12),
              child: Column(
                children: [
                  // 2. Logo Logic
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

                  // 3. Forget Password Card
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
                        const Text(
                          "Forget Password",
                          style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          "No worries! Just enter your email and we'll send you a reset password link.",
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.grey, fontSize: 14, height: 1.5),
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

                        // 5. Footer (Wrap for responsiveness)
                        Wrap(
                          alignment: WrapAlignment.center,
                          children: [
                            const Text("Just remember? ", style: TextStyle(color: Colors.grey, fontSize: 13)),
                            GestureDetector(
                              onTap: () => Get.back(),
                              child: const Text(
                                "Sign Up",
                                style: TextStyle(
                                  color: Color(0xFFFF3B5C),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13,
                                ),
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

  // Same Helper Widgets
  Widget _buildLogo() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(IconString.symbol),
        const SizedBox(width: 10),
        const Text("SoftSnip", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFF2D3748))),
      ],
    );
  }

  Widget _buildLabel(String text) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Text(text, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
      ),
    );
  }

  Widget _buildTextField({required String hint, TextEditingController? textController}) {
    return TextField(
      controller: textController,
      decoration: InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: const Color(0xFFEDF2F7),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      ),
    );
  }
}
