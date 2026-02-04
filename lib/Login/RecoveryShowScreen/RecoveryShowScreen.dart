import 'package:car_rental_project/Login/ReusableWidgetOfLogin/PrimaryBtnOfLogin.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';


class RecoveryShowScreenOne extends StatefulWidget {
  const RecoveryShowScreenOne({super.key});

  @override
  State<RecoveryShowScreenOne> createState() => _RecoveryShowScreenOneState();
}

class _RecoveryShowScreenOneState extends State<RecoveryShowScreenOne> {

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
                  _buildLogo(isMobile),
                  const SizedBox(height: 30),

                  // Main Card
                  Container(
                    constraints: const BoxConstraints(maxWidth: 450),
                    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 50),
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
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // 1. Red Circle Check Icon
                        Container(
                          padding: const EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: const Color(0xFFFF3B5C), width: 3),
                          ),
                          child: const Icon(
                            Icons.check_rounded,
                            color: Color(0xFFFF3B5C),
                            size: 50,
                          ),
                        ),
                        const SizedBox(height: 30),

                        // 2. Heading
                        const Text(
                          "Congratulation",
                          style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.black),
                        ),
                        const SizedBox(height: 10),

                        // 3. Subtitle (Isko aap yahan se asani se change kar sakte hain)
                        const Text(
                          "Successfully Recover Your Account",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(0xFF2D3748),
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 40),

                        // 4. Button (Using your custom primary button)
                        PrimaryBtnOfLogin(
                          text: "Back to Login",
                          onTap: () {
                            context.push('/login');
                          },
                          width: 180,
                          height: 48,
                          borderRadius: BorderRadius.circular(8),
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

  Widget _buildLogo(bool isMobile) {
    return Align(
      alignment: isMobile ? Alignment.center : Alignment.topLeft,
      child: Row(
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
      ),
    );
  }
}