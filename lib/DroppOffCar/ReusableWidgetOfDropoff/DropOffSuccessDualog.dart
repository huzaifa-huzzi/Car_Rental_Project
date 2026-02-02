import 'package:car_rental_project/Resources/Colors.dart';
import 'package:car_rental_project/Resources/TextTheme.dart';
import 'package:flutter/material.dart';

class DropOffSuccessDialog extends StatelessWidget {
  const DropOffSuccessDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 32),
        width: 550,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                color: AppColors.primaryColor,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.check,
                color: Colors.white,
                size: 60,
              ),
            ),
            const SizedBox(height: 24),

            // SUCCESS Heading
            Text(
              "SUCCESS",
              style: TTextTheme.h6Style(context).copyWith(
                color: AppColors.primaryColor,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.2,
              ),
            ),
            const SizedBox(height: 16),

            //  Description
            Text(
              "Thank you.",
              textAlign: TextAlign.center,
              style: TTextTheme.h5Style(context),
            ),
            const SizedBox(height: 8),
            Text(
              "We are working hard to find the best service for you.\nShortly you will find a confirmation in your email.",
              textAlign: TextAlign.center,
              style: TTextTheme.pSix(context),
            ),
            const SizedBox(height: 40),

            //  Button
            SizedBox(
              width: double.infinity,
              height: 60,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryColor,
                  elevation: 0,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                onPressed: () => Navigator.pop(context),
                child: Text(
                  "Back To Home",
                  style: TTextTheme.h9Style(context),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}