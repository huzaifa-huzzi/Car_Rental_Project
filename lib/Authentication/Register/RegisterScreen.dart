import 'package:car_rental_project/Authentication/LoginController.dart';
import 'package:car_rental_project/Authentication/ReusableWidgetOfLogin/PrimaryBtnOfLogin.dart';
import 'package:car_rental_project/Resources/Colors.dart';
import 'package:car_rental_project/Resources/IconStrings.dart';
import 'package:car_rental_project/Resources/TextString.dart';
import 'package:car_rental_project/Resources/TextTheme.dart';
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
          // Background Design
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
                  // Logo Section
                  if (!isMobile)
                    Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: const EdgeInsets.all(40.0),
                        child: _buildLogo(),
                      ),
                    ),
                  if (isMobile)
                    Padding(
                      padding: const EdgeInsets.only(top: 50),
                      child: _buildLogo(),
                    ),
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
                    child: Form(
                      key: controller.registerFormKey,
                      child: Column(
                        children: [
                          Text(TextString.registerLogin, style: TTextTheme.h11Style(context)),
                          const SizedBox(height: 8),
                          Text(TextString.registerSubtitle,
                              textAlign: TextAlign.center, style: TTextTheme.pSeven(context)),
                          const SizedBox(height: 25),

                          // Name Field
                          _buildLabel(TextString.registerName),
                          _buildTextField(
                            hint: "hasan",
                            textController: controller.nameRegisterController,
                            validator: controller.validateRegisterName,
                          ),
                          const SizedBox(height: 18),

                          // Company Field
                          _buildLabel(TextString.companyName),
                          _buildTextField(
                            hint: "SoftSnip",
                            textController: controller.companyNameController,
                            validator: controller.validateRegisterCompany,
                          ),
                          const SizedBox(height: 18),

                          _buildLabel(TextString.registerEmail),
                          _buildTextField(
                            hint: "sellostore@company.com",
                            textController: controller.emailRegisterController,
                            validator: controller.validateRegisterEmail,
                          ),
                          const SizedBox(height: 18),


                          _buildLabel(TextString.registerPassword),
                          Obx(() => _buildTextField(
                            hint: "5ellostore.",
                            isPassword: true,
                            textController: controller.passwordRegisterController,
                            obscureText: controller.obscureRegisterPassword.value,
                            onSuffixTap: controller.togglePasswordVisibility2,
                            validator: controller.validateRegisterPassword,
                          )),

                          const SizedBox(height: 25),

                          PrimaryBtnOfLogin(
                            text: "Register",
                            onTap: () {
                              controller.register(context);
                            },
                            width: double.infinity,
                            height: 50,
                            borderRadius: BorderRadius.circular(10),
                          ),

                          const SizedBox(height: 20),


                          Row(
                            children: [
                              Expanded(child: Divider(color: AppColors.quadrantalTextColor)),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 10),
                                child: Text(TextString.registerText, style: TTextTheme.loginDividerText(context)),
                              ),
                              Expanded(child: Divider(color: AppColors.quadrantalTextColor)),
                            ],
                          ),
                          const SizedBox(height: 20),


                          isMobile
                              ? Column(
                            children: [
                              GestureDetector(
                                onTap: () => context.go('/dashboard-admin'),
                                child: _buildSocialButton("Google", IconString.googleIcon),
                              ),
                              const SizedBox(height: 15),
                              GestureDetector(
                                onTap: () => context.go('/dashboard-staff'),
                                child: _buildSocialButton("Apple", IconString.appleIcon),
                              )
                            ],
                          )
                              : Row(
                            children: [
                              Expanded(
                                child: GestureDetector(
                                  onTap: () => context.go('/dashboard-admin'),
                                  child: _buildSocialButton("Google", IconString.googleIcon),
                                ),
                              ),
                              const SizedBox(width: 15),
                              Expanded(
                                child: GestureDetector(
                                  onTap: () => context.go("/dashboard-staff"),
                                  child: _buildSocialButton("Apple", IconString.appleIcon),
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 25),

                        ],
                      ),
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

  /// --------- Extra Widgets -------- ///
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
        padding: const EdgeInsets.only(bottom: 6),
        child: Text(text, style: TTextTheme.dropdowninsideText(context)),
      ),
    );
  }

  Widget _buildTextField({
    required String hint,
    TextEditingController? textController,
    bool isPassword = false,
    bool obscureText = false,
    VoidCallback? onSuffixTap,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: textController,
      obscureText: obscureText,
      validator: validator,
      cursorColor: AppColors.blackColor,
      style: TTextTheme.loginInsideTextField(context),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TTextTheme.loginInsideTextField(context),
        filled: true,
        fillColor: AppColors.secondaryColor,
        errorStyle: const TextStyle(color: AppColors.primaryColor, fontSize: 12),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
        focusedErrorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: AppColors.primaryColor)),
        errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: AppColors.primaryColor)),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        suffixIcon: isPassword ? IconButton(
            icon: Icon(obscureText ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                color: AppColors.quadrantalTextColor, size: 20),
            onPressed: onSuffixTap
        ) : null,
      ),
    );
  }

  Widget _buildSocialButton(String label, String icon) {
    return Container(
      width: double.infinity,
      height: 45,
      decoration: BoxDecoration(
          color: AppColors.backgroundOfScreenColor,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: AppColors.tertiaryTextColor)
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(icon),
          const SizedBox(width: 10),
          Text(label, style: TTextTheme.loginSocialIcons(context)),
        ],
      ),
    );
  }
}