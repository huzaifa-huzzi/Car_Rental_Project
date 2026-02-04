import 'package:car_rental_project/Login/LoginController.dart';
import 'package:car_rental_project/Login/ReusableWidgetOfLogin/PrimaryBtnOfLogin.dart';
import 'package:car_rental_project/Resources/Colors.dart';
import 'package:car_rental_project/Resources/IconStrings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
// import 'new_password_controller.dart';
// import 'primary_btn_widget.dart';

class NewPassword extends StatefulWidget {
  const NewPassword({super.key});

  @override
  State<NewPassword> createState() => _NewPasswordState();
}

class _NewPasswordState extends State<NewPassword> {
  final LoginController controller = Get.put(LoginController());

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
              Expanded(child: Container(color: const Color(0xFFF8FAFB))),
              Expanded(child: Container(color: const Color(0xFFFFF1F2))),
            ],
          ),

          // Main Content
          Align(
            alignment: const Alignment(0, -0.2), // Thora upar alignment
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
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

                  // Card
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
                        const Text("New Password",
                            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 10),
                        const Text(
                          "Please create a new password that you don't use on any other site.",
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.grey, fontSize: 13, height: 1.5),
                        ),
                        const SizedBox(height: 30),

                        // Password Field
                        _buildLabel("Password"),
                        Obx(() => _buildTextField(
                          hint: "***********",
                          isPassword: true,
                          obscureText: controller.obscurePassword.value,
                          textController: controller.newPasswordController,
                          onSuffixTap: controller.togglePassword,
                        )),
                        const SizedBox(height: 20),

                        // Confirm Password Field
                        _buildLabel("Confirm Password"),
                        Obx(() => _buildTextField(
                          hint: "5ellostore.",
                          isPassword: true,
                          obscureText: controller.obscureConfirmPassword.value,
                          textController: controller.newConfirmPasswordController,
                          onSuffixTap: controller.toggleConfirmPassword,
                          fillColor: AppColors.secondaryColor,
                        )),
                        const SizedBox(height: 30),

                        // Update Button
                       PrimaryBtnOfLogin(
                          text: "Confirm Password",
                          onTap:(){
                            context.push('/authSuccess');
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
                            const Text("Just Remember? ", style: TextStyle(color: Colors.grey, fontSize: 13)),
                            GestureDetector(
                              onTap: () => Get.back(),
                              child: const Text("Sign Up",
                                  style: TextStyle(color: Color(0xFFFF3B5C), fontWeight: FontWeight.bold, fontSize: 13)),
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

  /// --------- Extra Widgets ---------- ///

  // Helper Widgets (Same as Login)
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
        child: Text(text, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
      ),
    );
  }

  Widget _buildTextField({
    required String hint,
    required TextEditingController textController,
    bool isPassword = false,
    bool obscureText = false,
    VoidCallback? onSuffixTap,
    Color? fillColor,
  }) {
    return TextField(
      controller: textController,
      obscureText: obscureText,
      decoration: InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: fillColor ?? const Color(0xFFEDF2F7),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        suffixIcon: isPassword
            ? IconButton(
            icon: Icon(obscureText ? Icons.visibility_off_outlined : Icons.visibility_outlined, color: Colors.grey, size: 18),
            onPressed: onSuffixTap)
            : null,
      ),
    );
  }
}
