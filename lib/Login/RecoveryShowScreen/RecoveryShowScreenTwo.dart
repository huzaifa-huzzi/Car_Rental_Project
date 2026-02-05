import 'package:car_rental_project/Login/ReusableWidgetOfLogin/PrimaryBtnOfLogin.dart';
import 'package:car_rental_project/Resources/Colors.dart';
import 'package:car_rental_project/Resources/TextTheme.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';


class RecoveryShowScreenTwo extends StatefulWidget {
  const RecoveryShowScreenTwo({super.key});

  @override
  State<RecoveryShowScreenTwo> createState() => _RecoveryShowScreenTwoState();
}

class _RecoveryShowScreenTwoState extends State<RecoveryShowScreenTwo> {

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
                        //  Icon
                        Container(
                          padding: const EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: AppColors.primaryColor, width: 3),
                          ),
                          child: const Icon(
                            Icons.check_rounded,
                            color: AppColors.primaryColor,
                            size: 50,
                          ),
                        ),
                        const SizedBox(height: 30),

                        //  Heading
                         Text(
                          "Congratulation",
                          style: TTextTheme.h11Style(context),
                        ),
                        const SizedBox(height: 10),

                        //  Subtitle
                         Text(
                          "SuccessFully Created Your Account",
                          textAlign: TextAlign.center,
                          style: TTextTheme.h6Style(context)
                        ),
                        const SizedBox(height: 40),

                        //  Button
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

  /// ---------- Extra Widget ------- ///

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
          Text("SoftSnip", style:  TTextTheme.h6Style(context)),
        ],
      ),
    );
  }
}