import 'package:car_rental_project/Authentication/LoginController.dart';
import 'package:car_rental_project/Authentication/ReusableWidgetOfLogin/PrimaryBtnOfLogin.dart';
import 'package:car_rental_project/Resources/Colors.dart';
import 'package:car_rental_project/Resources/IconStrings.dart';
import 'package:car_rental_project/Resources/TextString.dart';
import 'package:car_rental_project/Resources/TextTheme.dart';
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
          // Background Colors
          Row(
            children: [
              Expanded(child: Container(color: AppColors.secondaryColor)),
              Expanded(child: Container(color: AppColors.backgroundOfPickupsWidget)),
            ],
          ),

          Center(
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
                  if (isMobile) _buildLogo(),
                  if (isMobile) const SizedBox(height: 30),

                  // Main Login Card
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
                    child: Form(
                      key: controller.loginFormKey,
                      child: Column(
                        children: [
                          Text(TextString.titleLogin, style: TTextTheme.h11Style(context)),
                          const SizedBox(height: 10),
                          Text(
                            TextString.loginSubtitle,
                            textAlign: TextAlign.center,
                            style: TTextTheme.pSeven(context),
                          ),
                          const SizedBox(height: 30),

                          // Email Field
                          _buildLabel(TextString.loginEmail),
                          _buildTextField(
                            hint: "sellostore@company.com",
                            textController: controller.emailController,
                            validator: controller.validateEmail,
                          ),
                          const SizedBox(height: 20),

                          // Password Field
                          _buildLabel(TextString.loginPassword),
                          Obx(() => _buildTextField(
                            hint: "Password",
                            isPassword: true,
                            textController: controller.passwordController,
                            obscureText: controller.obscurePassword.value,
                            onSuffixTap: controller.togglePasswordVisibility,
                            validator: controller.validatePassword,
                          )),

                          const SizedBox(height: 15),

                          // Remember Me & Forgot Password
                          LayoutBuilder(
                            builder: (context, constraints) {
                              if (constraints.maxWidth < 300) {
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

                          // Log In Button
                          PrimaryBtnOfLogin(
                            text: "Log In",
                            onTap: () {
                              controller.login(context);
                            },
                            width: double.infinity,
                            height: 50,
                            borderRadius: BorderRadius.circular(10),
                          ),

                          const SizedBox(height: 25),

                          // Divider
                          Row(
                            children: [
                              Expanded(child: Divider(color: AppColors.quadrantalTextColor)),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 10),
                                child: Text(
                                  TextString.loginText,
                                  style: TTextTheme.loginDividerText(context),
                                ),
                              ),
                              Expanded(child: Divider(color: AppColors.quadrantalTextColor)),
                            ],
                          ),

                          const SizedBox(height: 25),

                          // Social Buttons (Google/Apple)
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

                          const SizedBox(height: 30),

                          Wrap(
                            alignment: WrapAlignment.center,
                            crossAxisAlignment: WrapCrossAlignment.center,
                            children: [
                              Text(
                                TextString.loginFooterFirst,
                                style: TTextTheme.titleSmallRemember(context),
                              ),
                              GestureDetector(
                                onTap: () => context.go('/signUp'),
                                child: Text(
                                  TextString.loginFooterTwo,
                                  style: TTextTheme.titleSmallRegister(context),
                                ),
                              ),
                            ],
                          ),
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

  /// -------- Extra Widget --------- ///


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
            side: BorderSide(color: AppColors.quadrantalTextColor, width: 1.5),
            activeColor: AppColors.primaryColor,
            visualDensity: VisualDensity.compact,
          )),
        ),
        const SizedBox(width: 8),
         Text(TextString.loginRemember, style: TTextTheme.titleSmallRemember(context)),
      ],
    );
  }

  Widget _buildForgotPassword() {
    return TextButton(
      onPressed: () {
        context.go('/forgotPassword');
        },
      style: TextButton.styleFrom(
        padding: EdgeInsets.zero,
        minimumSize: const Size(0, 0),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      child:  Text(
        TextString.loginForgot,
        style: TTextTheme.forgotText(context),
      ),
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