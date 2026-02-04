import 'package:car_rental_project/Login/LoginController.dart';
import 'package:car_rental_project/Login/ReusableWidgetOfLogin/PrimaryBtnOfLogin.dart';
import 'package:car_rental_project/Resources/IconStrings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final LoginController controller = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 600;

    return Scaffold(
      body: Stack(
        children: [
          Row(
            children: [
              Expanded(child: Container(color: const Color(0xFFF8FAFB))),
              Expanded(child: Container(color: const Color(0xFFFFF1F2))),
            ],
          ),
          Center(
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
                    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 40),
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
                        const Text("Welcome Back", style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 10),
                        const Text("Enter your email and password to access your account.",
                            textAlign: TextAlign.center, style: TextStyle(color: Colors.grey, fontSize: 14)),
                        const SizedBox(height: 30),

                        _buildLabel("Email"),
                        _buildTextField(
                          hint: "sellostore@company.com",
                          textController: controller.emailController,
                        ),
                        const SizedBox(height: 20),

                        _buildLabel("Password"),
                        Obx(() => _buildTextField(
                          hint: "Password",
                          isPassword: true,
                          textController: controller.passwordController,
                          obscureText: controller.obscurePassword.value,
                          onSuffixTap: controller.togglePasswordVisibility,
                        )),

                        const SizedBox(height: 15),

                         // Remember Me /Forgot Password
                        LayoutBuilder(
                          builder: (context, constraints) {
                            if (constraints.maxWidth < 330) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _buildRememberMe(),
                                  const SizedBox(height: 5),
                                  _buildForgotPassword(),
                                ],
                              );
                            } else {
                              return Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  _buildRememberMe(),
                                  _buildForgotPassword(),
                                ],
                              );
                            }
                          },
                        ),

                        const SizedBox(height: 25),

                         // Login Button
                         PrimaryBtnOfLogin(
                          text:"Log In",
                          onTap: (){
                            context.push('/carInventory');
                          },
                          width: double.infinity,
                          height: 50,
                          borderRadius: BorderRadius.circular(10),
                         ),

                        const SizedBox(height: 25),
                        const Row(
                          children: [
                            Expanded(child: Divider()),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              child: Text("Or Login With", style: TextStyle(color: Colors.grey, fontSize: 12)),
                            ),
                            Expanded(child: Divider()),
                          ],
                        ),
                        const SizedBox(height: 25),

                           // Attachments Button
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

                        const SizedBox(height: 30),

                        Wrap(
                          alignment: WrapAlignment.center,
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: [
                            const Text(
                              "Don't Have An Account? ",
                              style: TextStyle(color: Colors.grey, fontSize: 13),
                            ),
                            GestureDetector(
                              onTap: () {
                                context.push('/signUp');
                              },
                              child: const Text(
                                "Register Now.",
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

  /// -------- Extra Widget --------- ///

  // Helper Widgets
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

  Widget _buildRememberMe() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: 24,
          width: 24,
          child: Obx(() => Checkbox(
            value: controller.rememberMe.value,
            onChanged: controller.toggleRememberMe,
            activeColor: const Color(0xFFFF3B5C),
            visualDensity: VisualDensity.compact,
          )),
        ),
        const SizedBox(width: 8),
        const Text("Remember Me", style: TextStyle(fontSize: 12, color: Colors.grey)),
      ],
    );
  }

  Widget _buildForgotPassword() {
    return TextButton(
      onPressed: () {
        context.push('/forgotPassword');
        },
      style: TextButton.styleFrom(
        padding: EdgeInsets.zero,
        minimumSize: const Size(0, 0),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      child: const Text(
        "Forgot Your Password?",
        style: TextStyle(
            color: Color(0xFFFF3B5C),
            fontSize: 12,
            fontWeight: FontWeight.bold
        ),
      ),
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

  Widget _buildTextField({required String hint, TextEditingController? textController, bool isPassword = false, bool obscureText = false, VoidCallback? onSuffixTap}) {
    return TextField(
      controller: textController,
      obscureText: obscureText,
      decoration: InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: const Color(0xFFEDF2F7),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        suffixIcon: isPassword ? IconButton(icon: Icon(obscureText
            ? Icons.visibility_off_outlined
            : Icons.visibility_outlined, size: 20), onPressed: onSuffixTap) : null,
      ),
    );
  }


  Widget _buildSocialButton(String label, IconData icon) {
    return Container(
      width: double.infinity,
      height: 45,
      decoration: BoxDecoration(
        color: const Color(0xFFF1F5F9),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 24, color: Colors.black87),
          const SizedBox(width: 10),
          Text(label, style: const TextStyle(fontWeight: FontWeight.w600, color: Color(0xFF4A5568))),
        ],
      ),
    );
  }
}
