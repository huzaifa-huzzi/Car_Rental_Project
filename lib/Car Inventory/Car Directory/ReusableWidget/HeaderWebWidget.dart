import 'package:car_rental_project/Resources/Colors.dart';
import 'package:car_rental_project/Resources/ImageString.dart';
import 'package:car_rental_project/Resources/TextTheme.dart';
import 'package:flutter/material.dart';
import 'package:car_rental_project/Resources/AppSizes.dart';
import 'package:car_rental_project/Resources/IconStrings.dart';
import 'package:go_router/go_router.dart';

class HeaderWebWidget extends StatelessWidget {
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

  const HeaderWebWidget({
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
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: AppSizes.verticalPadding(context),
        horizontal: AppSizes.horizontalPadding(context),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          /// LEFT SIDE (Back + Titles)
          Row(
            children: [
              if (showBack)
                GestureDetector(
                  onTap: () {
                    final router = GoRouter.of(context);

                    if (router.canPop()) {
                      router.pop();
                    } else {
                      router.go('/carInventory');
                    }
                  },
                  child: Container(
                    width: AppSizes.buttonHeight(context) * 0.7,
                    height: AppSizes.buttonHeight(context) * 0.7,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        AppSizes.borderRadius(context) * 0.7,
                      ),
                      color: Colors.white,
                    ),
                    child: Center(
                      child: Image.asset(
                        IconString.backScreenIcon,
                        width: AppSizes.buttonHeight(context) * 0.45,
                        height: AppSizes.buttonHeight(context) * 0.45,
                      ),
                    ),
                  ),
                ),

              if (showBack) SizedBox(width: AppSizes.padding(context)),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (showSmallTitle)
                    Text(
                      smallTitle ?? "",
                      style: TTextTheme.titleUpperHeading(context),
                    ),
                  Text(
                    mainTitle,
                    style: TTextTheme.titleOne(context),
                  ),
                ],
              ),
            ],
          ),

          /// RIGHT SIDE (Conditional Icons)
          Row(
            children: [
              if (showAddButton)
                Container(
                  height: AppSizes.buttonHeight(context) * 0.5,
                  width: AppSizes.buttonHeight(context) * 0.5,
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor,
                    borderRadius: BorderRadius.circular(AppSizes.borderRadius(context) * 0.5),
                  ),
                  child: Center(
                    child: Icon(
                      Icons.add,
                      size: AppSizes.buttonHeight(context) * 0.4,
                      color: Colors.white,
                    ),
                  ),
                ),




              if (showAddButton)
                SizedBox(width: AppSizes.padding(context) * 0.4),

              /// Search Icon
              if (showSearch)
                Row(
                  children: [
                    _iconButton(
                      IconString.searchIcon,
                      onSearchPressed,
                      context,
                    ),
                    SizedBox(width: AppSizes.padding(context) * 0.4),
                  ],
                ),

              /// Settings Icon
              if (showSettings)
                Row(
                  children: [
                    _iconButton(
                      IconString.settingIcon,
                      onSettingsPressed,
                      context,
                    ),
                    SizedBox(width: AppSizes.padding(context) * 0.4),
                  ],
                ),

              /// Notification Icon
              if (showNotification)
                Row(
                  children: [
                    Stack(
                      clipBehavior: Clip.none,
                      children: [
                        _iconButton(
                          IconString.notificationIcon,
                          onNotificationPressed,
                          context,
                        ),
                        Positioned(
                          top: AppSizes.isMobile(context) ? 0 : 12,
                          right: AppSizes.isMobile(context) ? 0 : 9,
                          child: Container(
                            width: 8,
                            height: 8,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.primaryColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(width: AppSizes.padding(context)),
                  ],
                ),


              /// Profile
              if (showProfile)
                Row(
                  children: [
                    CircleAvatar(
                      radius: AppSizes.buttonHeight(context) * 0.4,
                      backgroundImage: AssetImage(profileImageUrl),
                    ),
                    SizedBox(width: AppSizes.padding(context) / 2),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Abram Schleiter",
                          style: TTextTheme.titleTwo(context),
                        ),
                        Text(
                          "Admin",
                          style: TTextTheme.titleFour(context),
                        ),
                      ],
                    ),
                  ],
                ),
            ],
          )
        ],
      ),
    );
  }

  /// UNIVERSAL ICON BUTTON
  Widget _iconButton(
      String iconPath,
      VoidCallback? onTap,
      BuildContext context,
      ) {
    bool isMobile = AppSizes.isMobile(context);
    bool isTablet = AppSizes.isTablet(context);

    double containerSize = isMobile
        ? AppSizes.buttonHeight(context) * 0.5
        : isTablet
        ? AppSizes.buttonHeight(context) * 0.6
        : AppSizes.buttonHeight(context) * 0.7;

    double iconSize = isMobile
        ? 12
        : isTablet
        ? 14
        : 16;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: containerSize,
        height: containerSize,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(
            AppSizes.borderRadius(context) * 0.8,
          ),
        ),
        child: Center(
          child: Image.asset(
            iconPath,
            width: iconSize,
            height: iconSize,
          ),
        ),
      ),
    );
  }
}
