import 'package:car_rental_project/Resources/AppSizes.dart';
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
    double containerSize = AppSizes.isMobile(context)
        ? 28
        : AppSizes.isTablet(context)
        ? 32
        : 36;

    double iconSize = AppSizes.isMobile(context)
        ? 16
        : AppSizes.isTablet(context)
        ? 18
        : 20;

    double logoSize = AppSizes.isMobile(context)
        ? 24
        : AppSizes.isTablet(context)
        ? 28
        : 32;

    double fontSize = AppSizes.isMobile(context)
        ? 15
        : AppSizes.isTablet(context)
        ? 16
        : 18;

    return  SizedBox(
      height: AppSizes.buttonHeight(context),
      child: Row(
        children: [

          SizedBox(width: AppSizes.padding(context)),

          // Logo + Text Centered
          Expanded(
            child: Align(
              alignment: Alignment.center,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    IconString.symbol,
                    width: logoSize,
                    height: logoSize,
                  ),
                  SizedBox(width: AppSizes.padding(context) / 2),
                  Text(
                    "Softsnip",
                    style: TTextTheme.h6Style(context).copyWith(
                      fontWeight: FontWeight.w600,
                      fontSize: fontSize,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Right side icons
          Row(
            children: [
              // Add
              GestureDetector(
                onTap: onAddPressed,
                child: Container(
                  width: containerSize,
                  height: containerSize,
                  margin: EdgeInsets.symmetric(horizontal: AppSizes.padding(context) / 4),
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor,
                    borderRadius: BorderRadius.circular(AppSizes.borderRadius(context)),
                  ),
                  child: Icon(
                    Icons.add,
                    color: Colors.white,
                    size: iconSize,
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
                      margin: EdgeInsets.symmetric(horizontal: AppSizes.padding(context) / 4),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(AppSizes.borderRadius(context)),
                      ),
                      child: Center(
                        child: Image.asset(
                          IconString.notificationIcon,
                          width: iconSize - 2,
                          height: iconSize - 2,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 7,
                      right: 8,
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
                margin: EdgeInsets.symmetric(horizontal: AppSizes.padding(context) / 4),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(AppSizes.borderRadius(context)),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(AppSizes.borderRadius(context)),
                  child: Image.network(
                    profileImageUrl,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(width: AppSizes.padding(context)),
            ],
          ),
        ],
      ),
    );

  }
}
