import 'package:car_rental_project/Login/LoginController.dart';
import 'package:car_rental_project/Login/ReusableWidgetOfLogin/PrimaryBtnOfLogin.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

class TwoStepVerificationTwo extends StatefulWidget {
  const TwoStepVerificationTwo({super.key});

  @override
  State<TwoStepVerificationTwo> createState() => _TwoStepVerificationTwoState();
}

class _TwoStepVerificationTwoState extends State<TwoStepVerificationTwo> {
  final controller = Get.put(LoginController());

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
            alignment: const Alignment(0, -0.1),
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
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

                  // OTP Card
                  Container(
                    constraints: const BoxConstraints(maxWidth: 450),
                    padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 40),
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
                        // 1. Mobile Icon (Screenshot wala red icon)
                        Container(
                          height: 80,
                          width: 50,
                          decoration: BoxDecoration(
                            color: const Color(0xFFFF3B5C),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Icon(Icons.phone_android, color: Colors.white, size: 35),
                        ),
                        const SizedBox(height: 25),

                        // 2. Headings
                        const Text("Two Step Verification",
                            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 10),

                        RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            style: const TextStyle(color: Colors.grey, fontSize: 13, height: 1.5),
                            children: [
                              const TextSpan(text: "Enter the verification code we sent to \n"),
                              const TextSpan(text: "sellostore@company.com ",
                                  style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black87)),
                              TextSpan(
                                text: "Resend",
                                style: const TextStyle(color: Color(0xFFFF3B5C), fontWeight: FontWeight.bold),
                              ),
                              TextSpan(
                                text: " ${controller.secondsRemaining}S",
                                style: const TextStyle(color: Color(0xFFFF3B5C)),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 35),

                        const Text("Type your 6 digit security code",
                            style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 20),

                        // 3. 6-Digit OTP Boxes
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: List.generate(6, (index) => _buildOtpBox(index)),
                        ),
                        const SizedBox(height: 35),

                        // 4. Submit Button
                       PrimaryBtnOfLogin(
                          text:"Submit",
                          onTap:(){
                            context.push('/authSuccess2');
                          },
                          width: double.infinity,
                          height: 50,
                          borderRadius: BorderRadius.circular(8),
                        ),

                        const SizedBox(height: 30),

                        // 5. Footer
                        Wrap(
                          alignment: WrapAlignment.center,
                          children: [
                            const Text("Didn't get the code? ", style: TextStyle(color: Colors.grey, fontSize: 12)),
                            const Text("Resend",
                                style: TextStyle(color: Color(0xFFFF3B5C), fontWeight: FontWeight.bold, fontSize: 12)),
                            const Text(" or ", style: TextStyle(color: Colors.grey, fontSize: 12)),
                            const Text("Edit",
                                style: TextStyle(color: Color(0xFFFF3B5C), fontWeight: FontWeight.bold, fontSize: 12)),
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

  // OTP Box with auto-focus logic
  Widget _buildOtpBox(int index) {
    return SizedBox(
      width: 50,
      height: 55,
      child: TextField(
        controller: controller.otpControllers[index],
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        inputFormatters: [LengthLimitingTextInputFormatter(1), FilteringTextInputFormatter.digitsOnly],
        onChanged: (value) {
          if (value.isNotEmpty && index < 5) {
            FocusScope.of(context).nextFocus();
          } else if (value.isEmpty && index > 0) {
            FocusScope.of(context).previousFocus();
          }
        },
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Color(0xFFFF3B5C), width: 1.5),
          ),
        ),
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildLogo() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: const BoxDecoration(color: Color(0xFFFF3B5C), shape: BoxShape.circle),
          child: const Icon(Icons.adjust, color: Colors.white, size: 20),
        ),
        const SizedBox(width: 10),
        const Text("SoftSnip", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
      ],
    );
  }
}