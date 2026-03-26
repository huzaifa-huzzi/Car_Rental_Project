import 'package:car_rental_project/Resources/AppSizes.dart';
import 'package:car_rental_project/Resources/Colors.dart';
import 'package:car_rental_project/Resources/IconStrings.dart';
import 'package:car_rental_project/Resources/ImageString.dart';
import 'package:car_rental_project/Resources/TextTheme.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HeaderWebPaymentWidget extends StatelessWidget {
  final bool showBack;
  final bool showSmallTitle;
  final bool showAddButton;
  final bool showSearch;
  final bool showSettings;
  final bool showNotification;
  final bool showProfile;

  final String mainTitle;
  final String? smallTitle;

  final VoidCallback? onAddPressed;
  final VoidCallback? onBackPressed;
  final VoidCallback? onSearchPressed;
  final VoidCallback? onSettingsPressed;
  final VoidCallback? onNotificationPressed;

  final String profileImageUrl;

  const HeaderWebPaymentWidget({
    super.key,
    this.showBack = false,
    this.showSmallTitle = false,
    this.showAddButton = false,
    required this.mainTitle,
    this.smallTitle,
    this.onAddPressed,
    this.onBackPressed,
    this.onSearchPressed,
    this.onSettingsPressed,
    this.onNotificationPressed,
    this.profileImageUrl = ImageString.userImage,
    this.showSearch = false,
    this.showSettings = false,
    this.showNotification = false,
    this.showProfile = false,
  });

  @override
  Widget build(BuildContext context) {
    final bool isWeb = AppSizes.isWeb(context);

    return Container(
      color: AppColors.backgroundOfScreenColor,
      padding: EdgeInsets.symmetric(
        vertical: 15,
        horizontal: AppSizes.horizontalPadding(context),
      ),
      child: Row(
        children: [
          /// LEFT SIDE: Back Button + Titles
          if (showBack)
            Padding(
              padding: const EdgeInsets.only(right: 12),
              child: _whiteIconButton(IconString.backScreenIcon, () {
                if (onBackPressed != null) {
                  onBackPressed!();
                } else {
                  final String currentPath = GoRouterState.of(context).uri.toString();
                  if (currentPath.startsWith('/payment/detail')) {
                    context.go('/payment');
                  } else {
                    context.pop();
                  }
                }
              }),
            ),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  mainTitle,
                  style: TTextTheme.h1Style(context),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ],
            ),
          ),

          const Spacer(),

          /// RIGHT SIDE: Actions + Profile
          Row(
            children: [

              if (showSettings) ...[
                _whiteIconButton(IconString.settingIcon, onSettingsPressed),
                const SizedBox(width: 12),
              ],

              if (showNotification) ...[
                Stack(
                  children: [
                    _whiteIconButton(IconString.notificationIcon, onNotificationPressed),
                    Positioned(
                      top: 10,
                      right: 10,
                      child: Container(
                        width: 8,
                        height: 8,
                        decoration: const BoxDecoration(
                          color: AppColors.primaryColor,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 16),
              ],

              if (showProfile)
                Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      child: CircleAvatar(
                        radius: 22,
                        backgroundImage: AssetImage(profileImageUrl),
                      ),
                    ),
                    if (isWeb) ...[
                      const SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Alina Thompson",
                            style:  TTextTheme.bodyRegular12black(context),
                          ),
                          Text(
                            "User",
                            style: TTextTheme.medium14(context),
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
            ],
          ),
        ],
      ),
    );
  }

  /// Helper for the White Rounded Icon Buttons
  Widget _whiteIconButton(String iconPath, VoidCallback? onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Image.asset(iconPath, width: 20, height: 20),
      ),
    );
  }
}