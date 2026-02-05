import 'package:car_rental_project/Authentication/LoginController.dart';
import 'package:car_rental_project/Authentication/ReusableWidgetOfLogin/PrimaryBtnOfLogin.dart';
import 'package:car_rental_project/Resources/Colors.dart';
import 'package:car_rental_project/Resources/IconStrings.dart';
import 'package:car_rental_project/Resources/TextTheme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

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
          // Background
          Row(
            children: [
              Expanded(child: Container(color: AppColors.secondaryColor)),
              Expanded(child: Container(color: AppColors.backgroundOfPickupsWidget)),
            ],
          ),

          // Main Content
          Align(
            alignment: const Alignment(0, -0.2),
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
                         Text("New Password",
                            style:TTextTheme.h11Style(context)),
                        const SizedBox(height: 10),
                         Text(
                          "Please create a new password that you don't use on any other site.",
                          textAlign: TextAlign.center,
                          style:TTextTheme.pSeven(context),
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

                        //  Button
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
                             Text("Just Remember? ", style: TTextTheme.titleSmallRemember(context)),
                            GestureDetector(
                              onTap: (){
                                context.push('/signUp');
                              },
                              child:  Text("Sign Up",
                                  style: TTextTheme.titleSmallRegister(context)),
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
        child: Text(text, style:TTextTheme.dropdowninsideText(context)),
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
    return Material(
      elevation: 4,
      borderRadius: BorderRadius.circular(10),
      shadowColor: Colors.black.withOpacity(0.2),
      child: TextField(
        cursorColor: AppColors.blackColor,
        controller: textController,
        obscureText: obscureText,
        style: TTextTheme.loginInsideTextField(context),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TTextTheme.loginInsideTextField(context),
          filled: true,
          fillColor: fillColor ?? Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          suffixIcon: isPassword
              ? IconButton(
            icon: Icon(
              obscureText ? Icons.visibility_off_outlined : Icons.visibility_outlined,
              color: AppColors.quadrantalTextColor,
              size: 18,
            ),
            onPressed: onSuffixTap,
          )
              : null,
        ),
      ),
    );
  }
}
