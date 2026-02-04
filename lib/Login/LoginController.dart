import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  // Register Screen
  final nameRegisterController = TextEditingController();
  final emailRegisterController = TextEditingController();
  final passwordRegisterController = TextEditingController();
  final confirmRegisterPasswordController = TextEditingController();
  var obscureRegisterPassword = true.obs;
  var obscureConfirmRegisterPassword = true.obs;

  void togglePasswordVisibility2() => obscureRegisterPassword.value = !obscureRegisterPassword.value;
  void toggleConfirmPasswordVisibility2() => obscureConfirmRegisterPassword.value = !obscureConfirmRegisterPassword.value;

   // Login Screen
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  var isLoading = false.obs;
  var obscurePassword = true.obs;
  var rememberMe = false.obs;

  void togglePasswordVisibility() {
    obscurePassword.value = !obscurePassword.value;
  }

  void toggleRememberMe(bool? value) {
    rememberMe.value = value ?? false;
  }

   // Forgot Password
  final emailForgotController = TextEditingController();

  // New Password
  final newPasswordController = TextEditingController();
  final newConfirmPasswordController = TextEditingController();
  var obscurePassword2 = true.obs;
  var obscureConfirmPassword = true.obs;

  void togglePassword() => obscurePassword.value = !obscurePassword.value;
  void toggleConfirmPassword() => obscureConfirmPassword.value = !obscureConfirmPassword.value;

  // Verification One Screen

  final List<TextEditingController> otpControllers = List.generate(6, (index) => TextEditingController());

  var secondsRemaining = 59.obs;

  // Verification two Screen

  final List<TextEditingController> otpControllers2 = List.generate(6, (index) => TextEditingController());

  var secondsRemaining2 = 59.obs;


  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    emailForgotController.dispose();
    newConfirmPasswordController.dispose();
    newPasswordController.dispose();
    nameRegisterController.dispose();
    emailRegisterController.dispose();
    passwordRegisterController.dispose();
    confirmRegisterPasswordController.dispose();
    super.onClose();
  }
}