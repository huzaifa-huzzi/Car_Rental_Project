import 'package:car_rental_project/Login/LoginController.dart';
import 'package:car_rental_project/Login/ReusableWidgetOfLogin/PrimaryBtnOfLogin.dart';
import 'package:car_rental_project/Resources/IconStrings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
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

          Align(
            alignment: const Alignment(0, -0.1), // Thora upar align kiya hai
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  // Logo Logic
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

                  // Register Card
                  Container(
                    constraints: const BoxConstraints(maxWidth: 450),
                    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 35),
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
                        const Text("Create an Account", style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 8),
                        const Text("Join now to streamline your experience from day one.",
                            textAlign: TextAlign.center, style: TextStyle(color: Colors.grey, fontSize: 13)),
                        const SizedBox(height: 25),

                        _buildLabel("Name"),
                        _buildTextField(hint: "hasan", textController: controller.nameRegisterController),
                        const SizedBox(height: 18),

                        _buildLabel("Email"),
                        _buildTextField(hint: "sellostore@company.com", textController: controller.emailRegisterController),
                        const SizedBox(height: 18),

                        _buildLabel("Password"),
                        Obx(() => _buildTextField(
                          hint: "***********",
                          isPassword: true,
                          textController: controller.passwordRegisterController,
                          obscureText: controller.obscureRegisterPassword.value,
                          onSuffixTap: controller.togglePasswordVisibility,
                        )),
                        const SizedBox(height: 18),

                        _buildLabel("Confirm Password"),
                        Obx(() => _buildTextField(
                          hint: "5ellostore.",
                          isPassword: true,
                          fillColor: const Color(0xFFE6F0FF), // Secondary Color Highlight
                          textController: controller.confirmRegisterPasswordController,
                          obscureText: controller.obscureConfirmPassword.value,
                          onSuffixTap: controller.toggleConfirmPasswordVisibility2,
                        )),

                        const SizedBox(height: 25),

                        // Register Button (Using your Reusable Widget)
                         PrimaryBtnOfLogin(
                          text:"Register",
                          onTap: (){
                            context.push('/twoStepVerificationTwo');
                          },
                          width: double.infinity,
                          height: 50,
                          borderRadius: BorderRadius.circular(10),
                        ),

                        const SizedBox(height: 20),
                        Row(
                          children: [
                            Expanded(child: Divider()),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              child: Text("Or Register With", style: TextStyle(color: Colors.grey, fontSize: 12)),
                            ),
                            Expanded(child: Divider()),
                          ],
                        ),
                        const SizedBox(height: 20),

                        // Social Button
                        isMobile
                            ? Column(
                          children: [
                            _buildSocialButton("Google", Icons.g_mobiledata),
                            const SizedBox(height: 15),
                            _buildSocialButton("Apple", Icons.apple),
                          ],
                        )
                            : Row(
                          children: [
                            Expanded(child: _buildSocialButton("Google", Icons.g_mobiledata)),
                            const SizedBox(width: 15),
                            Expanded(child: _buildSocialButton("Apple", Icons.apple)),
                          ],
                        ),

                        const SizedBox(height: 25),

                        // Footer
                        Wrap(
                          alignment: WrapAlignment.center,
                          children: [
                            const Text("Already Have An Account? ", style: TextStyle(color: Colors.grey, fontSize: 12)),
                            GestureDetector(
                              onTap: (){
                                context.push('/login');
                              },
                              child: const Text("Sign In.",
                                  style: TextStyle(color: Color(0xFFFF3B5C), fontWeight: FontWeight.bold, fontSize: 12)),
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

  // Same Helper Widgets
  Widget _buildLogo() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(IconString.symbol),
        const SizedBox(width: 10),
        const Text("SoftSnip", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
      ],
    );
  }

  Widget _buildLabel(String text) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 6),
        child: Text(text, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
      ),
    );
  }

  Widget _buildTextField({required String hint, required TextEditingController textController, bool isPassword = false, bool obscureText = false, VoidCallback? onSuffixTap, Color? fillColor}) {
    return TextField(
      controller: textController,
      obscureText: obscureText,
      decoration: InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: fillColor ?? const Color(0xFFEDF2F7),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        suffixIcon: isPassword ? IconButton(icon: Icon(obscureText ? Icons.visibility_off_outlined : Icons.visibility_outlined, size: 18), onPressed: onSuffixTap) : null,
      ),
    );
  }

  Widget _buildSocialButton(String label, IconData icon) {
    return Container(
      height: 45,
      decoration: BoxDecoration(color: const Color(0xFFF1F5F9), borderRadius: BorderRadius.circular(10)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 22),
          const SizedBox(width: 8),
          Text(label, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
        ],
      ),
    );
  }
}