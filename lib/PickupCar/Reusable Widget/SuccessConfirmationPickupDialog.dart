import 'package:car_rental_project/Resources/Colors.dart';
import 'package:car_rental_project/Resources/IconStrings.dart';
import 'package:car_rental_project/Resources/ImageString.dart';
import 'package:car_rental_project/Resources/TextTheme.dart';
import 'package:flutter/material.dart';

class SuccessConfirmationPickupDialog extends StatelessWidget {
  const SuccessConfirmationPickupDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        padding: const EdgeInsets.all(24),
        width: 450,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
             // header Icon
            Center(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Image.asset(
                  ImageString.successCheckPickupImage,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            const SizedBox(height: 16),

            // headings
            Text("Welcome", style: TTextTheme.h6Style(context)),
            Text(
              "confirm Rental Booking",
              style: TTextTheme.pSix(context),
            ),
            const SizedBox(height: 24),

            //  Social Media Buttons Row
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildShareButton(context, text: "Share", color: AppColors.primaryColor),
                  const SizedBox(width: 8),

                  _buildDownloadIcon(),

                  const SizedBox(width: 8),
                  _buildShareIcon(IconString.gmailIcon),
                  const SizedBox(width: 8),
                  _buildShareIcon(IconString.whatsappIcon),
                  const SizedBox(width: 8),
                  _buildShareIcon(IconString.faceBookIcon),
                  const SizedBox(width: 8),
                  _buildShareIcon(IconString.teleGramIcon),
                  const SizedBox(width: 8),
                  _buildShareIcon(IconString.messangerIcon),
                  const SizedBox(width: 8),
                  _buildMoreIcon(),
                ],
              ),
            ),
            const SizedBox(height: 24),

            //  Back To Home Button
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryColor,
                  elevation: 0,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                onPressed: () => Navigator.pop(context),
                child:  Text("Back To Home", style: TTextTheme.h9Style(context)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Download Widget Icon
  Widget _buildDownloadIcon() {
    return Container(
      padding:  EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.backgroundOfPickupsWidget,
        borderRadius: BorderRadius.circular(8),
      ),
      child:  Image.asset(
        IconString.downloadPickUpIcon,
      ),
    );
  }

  // More Icon Widget
  Widget _buildMoreIcon() {
    return Container(
      padding:  EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: AppColors.backgroundOfPickupsWidget,
        borderRadius: BorderRadius.circular(8),
      ),
      child:  Icon(Icons.more_horiz, color: AppColors.quadrantalTextColor, size: 20),
    );
  }

  // Share Icon Widget
  Widget _buildShareIcon(String iconPath) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: AppColors.backgroundOfPickupsWidget,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Image.asset(iconPath, width: 22, height: 22),
    );
  }

  // Share Button Widget
  Widget _buildShareButton(BuildContext context, {required String text, required Color color}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(text, style:TTextTheme.h8Style(context)),
    );
  }
}