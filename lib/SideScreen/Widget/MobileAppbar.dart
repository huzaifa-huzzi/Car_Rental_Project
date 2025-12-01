import 'package:flutter/material.dart';
import 'package:car_rental_project/Resources/Colors.dart';
import 'package:car_rental_project/Resources/IconStrings.dart';
import 'package:car_rental_project/Resources/TextTheme.dart';

class MobileTopBar extends StatelessWidget {
  final VoidCallback? onAddPressed;
  final VoidCallback? onNotificationPressed;
  final String profileImageUrl;
  final GlobalKey<ScaffoldState> scaffoldKey;

  const MobileTopBar({
    super.key,
    this.onAddPressed,
    this.onNotificationPressed,
    required this.profileImageUrl,
    required this.scaffoldKey,
  });

  @override
  Widget build(BuildContext context) {
    double containerSize = 28;

    return SizedBox(
      height: 50,
      child: Row(
        children: [

          // Centered Logo + Text
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                IconString.symbol,
                width: 24,
                height: 24,
              ),
              const SizedBox(width: 4),
              Text(
                "Softsnip",
                style: TTextTheme.h6Style(context).copyWith(
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                ),
              ),
            ],
          ),

          // Spacer after logo
          const Spacer(),

          // Right-side buttons
          Row(
            children: [
              // Add
              GestureDetector(
                onTap: onAddPressed,
                child: Container(
                  width: containerSize,
                  height: containerSize,
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: const Icon(
                    Icons.add,
                    color: Colors.white,
                    size: 16,
                  ),
                ),
              ),

              // Notification
              GestureDetector(
                onTap: onNotificationPressed,
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      width: containerSize,
                      height: containerSize,
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Center(
                        child: Image.asset(
                          IconString.notificationIcon,
                          width: 14,
                          height: 14,
                        ),
                      ),
                    ),
                    Positioned(
                      top: -2, // badge slightly above icon
                      right: -2,
                      child: Container(
                        width: 6,
                        height: 6,
                        decoration: const BoxDecoration(
                          color: AppColors.primaryColor,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Profile picture
              Container(
                width: containerSize,
                height: containerSize,
                margin: const EdgeInsets.symmetric(horizontal: 4),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(6),
                  child: Image.network(
                    profileImageUrl,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

