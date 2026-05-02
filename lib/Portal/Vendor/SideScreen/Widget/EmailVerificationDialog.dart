import 'package:car_rental_project/Resources/Colors.dart';
import 'package:flutter/material.dart';
import 'package:car_rental_project/Resources/TextTheme.dart';
import 'package:go_router/go_router.dart';

class EmailVerificationDialog extends StatelessWidget {
  const EmailVerificationDialog({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    bool isSmallMobile = screenWidth < 380;

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 10,
      backgroundColor: Colors.white,
      insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      child: Container(
        padding: const EdgeInsets.all(20),
        constraints: const BoxConstraints(maxWidth: 500),
        child: Stack(
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: AppColors.backgroundOfPickupsWidget,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(
                        Icons.report_gmailerrorred_rounded,
                        color: AppColors.primaryColor,
                        size: 28,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 4),
                          Text(
                            "Email not verified?",
                            style: TTextTheme.h6Style(context)
                          ),
                          const SizedBox(height: 6),
                          Text(
                            "Your trail period has completed Please verify your email.",
                            style: TTextTheme.bodyRegular16(context),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                Align(
                  alignment: Alignment.centerRight,
                  child: Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    alignment: WrapAlignment.end,
                    children: [
                      SizedBox(
                        height: 45,
                        width: isSmallMobile ? double.infinity : 145,
                        child: OutlinedButton(
                          onPressed: () {
                           Navigator.pop(context);
                          },
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(color:AppColors.primaryColor, width: 1.2),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          ),
                          child: Text(
                            "Verify Later",
                            style: TTextTheme.requireImagesText(context),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 45,
                        width: isSmallMobile ? double.infinity : 145,
                        child: ElevatedButton(
                          onPressed: () {
                            context.go('/twoStepVerificationOne');
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primaryColor,
                            elevation: 0,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          ),
                          child: Text(
                            "Verify Now",
                            style: TTextTheme.OwnerSelected(context),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Positioned(
              right: 0,
              top: 0,
              child: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: AppColors.sideBoxesColor,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.close, size: 18, color: AppColors.textColor),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}