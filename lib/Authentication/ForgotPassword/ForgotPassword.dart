import 'package:car_rental_project/Authentication/LoginController.dart';
import 'package:car_rental_project/Authentication/ReusableWidgetOfLogin/PrimaryBtnOfLogin.dart';
import 'package:car_rental_project/Resources/Colors.dart';
import 'package:car_rental_project/Resources/IconStrings.dart';
import 'package:car_rental_project/Resources/TextString.dart';
import 'package:car_rental_project/Resources/TextTheme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';


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
                     child: Form(
                       key: controller.forgotFormKey,
                       child: Column(
                         children: [
                           Text(
                             TextString.forgotTitle,
                             style: TTextTheme.h11Style(context),
                           ),
                           const SizedBox(height: 10),
                           Text(
                             "No worries! Just enter your email and we'll send you a reset password link.",
                             textAlign: TextAlign.center,
                             style: TTextTheme.pSeven(context),
                           ),
                           const SizedBox(height: 40),

                           _buildLabel(TextString.forgotEmail),
                           _buildTextField(
                             hint: "sellostore@company.com",
                             textController: controller.emailForgotController,
                             validator: controller.validateForgotEmail,
                           ),
                           const SizedBox(height: 30),

                           PrimaryBtnOfLogin(
                             text: "Send Verification Mail",
                             onTap: () {
                               controller.sendResetLink(context);
                             },
                             width: double.infinity,
                             height: 50,
                             borderRadius: BorderRadius.circular(10),
                           ),

                           const SizedBox(height: 25),
                           Wrap(
                             alignment: WrapAlignment.center,
                             children: [
                               Text(
                                 TextString.forgotFirstFooter,
                                 style: TTextTheme.titleSmallRemember(context),
                               ),
                               GestureDetector(
                                 onTap: () {
                                   context.push('/signUp');
                                 },
                                 child: Text(
                                   TextString.forgotFooterTwo,
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
}
