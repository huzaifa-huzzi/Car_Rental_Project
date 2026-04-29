import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

class LoginController extends GetxController {
  // Register Screen
  final nameRegisterController = TextEditingController();
  final companyNameController = TextEditingController();
  final emailRegisterController = TextEditingController();
  final passwordRegisterController = TextEditingController();
  var obscureRegisterPassword = true.obs;
  final loginFormKey = GlobalKey<FormState>();
  final registerFormKey = GlobalKey<FormState>();

  void togglePasswordVisibility2() => obscureRegisterPassword.value = !obscureRegisterPassword.value;
  String? validateRegisterName(String? value) {
    if (value == null || value.isEmpty) return "Full name is required";
    if (value.length < 3) return "Name must be at least 3 characters";
    return null;
  }

  String? validateRegisterCompany(String? value) {
    if (value == null || value.isEmpty) return "Company name is required";
    return null;
  }

  String? validateRegisterEmail(String? value) {
    if (value == null || value.isEmpty) return "Registration email is required";
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value)) return "Enter a valid email for registration";
    return null;
  }

  String? validateRegisterPassword(String? value) {
    if (value == null || value.isEmpty) return "Password is required";
    if (value.length < 8) return "Min 8 characters required";
    if (!value.contains(RegExp(r'[A-Z]'))) return "Add at least 1 uppercase letter";
    if (!value.contains(RegExp(r'[0-9]'))) return "Add at least 1 digit";
    if (!value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) return "Add 1 special character";

    return null;
  }
  void register(BuildContext context) {
    if (registerFormKey.currentState != null && registerFormKey.currentState!.validate()) {
      context.push('/authSuccess2');
    }
  }

   // Authentication Screen
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

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return "Email is required";
    }
    final emailRegex = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    if (!emailRegex.hasMatch(value)) {
      return "Enter a valid email (e.g. name@company.com)";
    }
    return null;
  }
  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return "Password is required";
    }
    if (value.length < 8) {
      return "Password must be at least 8 characters long";
    }

    if (!value.contains(RegExp(r'[A-Z]'))) {
      return "Password must contain at least one uppercase letter";
    }
    if (!value.contains(RegExp(r'[0-9]'))) {
      return "Password must contain at least one digit";
    }
    if (!value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      return "Password must contain at least one special character";
    }

    return null;
  }

  void login(BuildContext context) {
    if (loginFormKey.currentState != null && loginFormKey.currentState!.validate()) {
      context.go('/dashboard');
      /// TODO : Api Calling
    }
  }

   // Forgot Password
  final emailForgotController = TextEditingController();
  final GlobalKey<FormState> forgotFormKey = GlobalKey<FormState>();
  void resetForgotFields() {
    emailForgotController.clear();
  }
  String? validateForgotEmail(String? value) {
    if (value == null || value.isEmpty) return "Email is required to reset password";
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value)) return "Enter a valid email address";
    return null;
  }
  void sendResetLink(BuildContext context) {
    if (forgotFormKey.currentState != null && forgotFormKey.currentState!.validate()) {
      context.go('/newPassword');
    }
  }

  // New Password
  static final GlobalKey<FormState> newPasswordFormKey = GlobalKey<FormState>();

  final newPasswordController = TextEditingController();
  final newConfirmPasswordController = TextEditingController();

  var obscurePassword2 = true.obs;
  var obscureConfirmPassword = true.obs;

  void togglePassword() => obscurePassword2.value = !obscurePassword2.value;
  void toggleConfirmPassword() => obscureConfirmPassword.value = !obscureConfirmPassword.value;
  String? validateNewPassword(String? value) {
    if (value == null || value.isEmpty) return "Password is required";
    if (value.length < 8) return "Min 8 characters required";
    if (!value.contains(RegExp(r'[A-Z]'))) return "Add at least 1 uppercase letter";
    if (!value.contains(RegExp(r'[0-9]'))) return "Add at least 1 digit";
    if (!value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) return "Add 1 special character";

    return null;
  }
  String? validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return "Please confirm your password";
    }
    if (value != newPasswordController.text) {
      return "Passwords do not match!";
    }
    return null;
  }

  void resetPassword(BuildContext context) {
    if (newPasswordFormKey.currentState != null && newPasswordFormKey.currentState!.validate()) {
      context.go('/authSuccess');
    }
  }
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
    super.onClose();
  }
}