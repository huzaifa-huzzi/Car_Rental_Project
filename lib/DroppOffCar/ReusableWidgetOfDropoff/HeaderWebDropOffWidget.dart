import 'package:car_rental_project/Resources/Colors.dart';
import 'package:car_rental_project/Resources/ImageString.dart';
import 'package:car_rental_project/Resources/TextTheme.dart';
import 'package:flutter/material.dart';
import 'package:car_rental_project/Resources/AppSizes.dart';
import 'package:car_rental_project/Resources/IconStrings.dart';
import 'package:go_router/go_router.dart';

class HeaderWebDropOffWidget extends StatelessWidget {
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

  const HeaderWebDropOffWidget({
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
    final isMobile = AppSizes.isMobile(context);
    final isTablet = AppSizes.isTablet(context);
    final isWeb = AppSizes.isWeb(context);
    final bool isCompact = isMobile || isTablet;

    final double addButtonSize = isMobile
        ? 24.0
        : isTablet
        ? AppSizes.buttonHeight(context) * 0.6
        : AppSizes.buttonHeight(context) * 0.7;


    const double minHorizontalPadding = 12.0;
    const double minInternalSpacing = 8.0;

    final double actualHorizontalPadding = AppSizes.horizontalPadding(context);
    final double finalHorizontalPadding = actualHorizontalPadding > minHorizontalPadding
        ? actualHorizontalPadding
        : minHorizontalPadding;

    final double actualInternalSpacing = AppSizes.padding(context);
    final double finalInternalSpacing = actualInternalSpacing > minInternalSpacing
        ? actualInternalSpacing
        : minInternalSpacing;

    final double webIconSize = AppSizes.buttonHeight(context) * 0.7;
    final double tabletIconSize = AppSizes.buttonHeight(context) * 0.6;

    return Container(
      margin: EdgeInsets.only(
        bottom: isMobile ? 8 : 0,
      ),
      padding: EdgeInsets.symmetric(
        vertical: AppSizes.verticalPadding(context) * 0.5,
        horizontal: finalHorizontalPadding,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          /// LEFT SIDE (Back + Titles)
          Expanded(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (showBack)
                  GestureDetector(
                    onTap: () {
                      final router = GoRouter.of(context);

                      if (onBackPressed != null) {
                        onBackPressed!();
                      } else if (router.canPop()) {
                        router.pop();
                      } else {
                        router.go('/customers');
                      }
                    },
                    child: Container(
                      width: isMobile ? 30 : AppSizes.buttonHeight(context) * 0.7,
                      height: isMobile ? 30 : AppSizes.buttonHeight(context) * 0.7,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          AppSizes.borderRadius(context) * 0.7,
                        ),
                        color: Colors.white,
                      ),
                      child: Center(
                        child: Image.asset(
                          IconString.backScreenIcon,
                          width: isMobile ? 18 : AppSizes.buttonHeight(context) * 0.45,
                          height: isMobile ? 18 : AppSizes.buttonHeight(context) * 0.45,
                        ),
                      ),
                    ),
                  ),

                if (showBack) SizedBox(width: finalInternalSpacing),


                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (showSmallTitle)
                        Text(
                          smallTitle ?? "",
                          style: TTextTheme.titleUpperHeading(context),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),

                      Text(
                        mainTitle,
                        style: TTextTheme.titleOne(context),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),

                    ],
                  ),
                ),
              ],
            ),
          ),

          /// RIGHT SIDE
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [


              if (showAddButton)
                isCompact
                    ? GestureDetector(
                  onTap: onAddPressed,
                  child: Container(

                    width: addButtonSize,
                    height: addButtonSize,
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor,
                      borderRadius: BorderRadius.circular(
                        AppSizes.borderRadius(context) * 0.8,
                      ),
                    ),
                    child: Center(
                      child: Icon(
                        Icons.add,
                        size: isMobile ? 14.0 : 16.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                )
                    : GestureDetector(
                  onTap: onAddPressed,
                  child: Container(
                    height: 40.0,
                    padding: EdgeInsets.symmetric(horizontal: finalInternalSpacing),
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor,
                      borderRadius: BorderRadius.circular(
                        AppSizes.borderRadius(context) * 0.5,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        "Add Pickup Car",
                        style: TTextTheme.btnWhiteColor(context),
                      ),
                    ),
                  ),
                ),


              if (showAddButton && isCompact)
                SizedBox(width: finalInternalSpacing * 0.6),

              if (showAddButton && !isCompact)
                SizedBox(width: finalInternalSpacing),


              /// Search Icon
              if (showSearch)
                Row(
                  children: [
                    _iconButton(
                      IconString.searchIcon,
                      onSearchPressed,
                      context,
                    ),
                    SizedBox(width: finalInternalSpacing * 0.5),
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
                    SizedBox(width: finalInternalSpacing * 0.5),
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
                          top: isMobile ? 2 : (isTablet ? 8 : 11.5),
                          right: isMobile ? 2 : (isTablet ? 8 : 10),
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
                    SizedBox(width: finalInternalSpacing),
                  ],
                ),


              /// Profile
              if (showProfile)
                Row(
                  children: [
                    Container(
                      width: isMobile ? 24.0 : (isTablet ? tabletIconSize : webIconSize),
                      height: isMobile ? 24.0 : (isTablet ? tabletIconSize : webIconSize),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(isMobile ? 6.0 : AppSizes.borderRadius(context) * 0.8),
                        image: DecorationImage(
                          image: AssetImage(profileImageUrl),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),

                    if (isWeb)
                      Row(
                        children: [
                          SizedBox(width: finalInternalSpacing / 2),
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
        ? 24.0
        : isTablet
        ? AppSizes.buttonHeight(context) * 0.6
        : AppSizes.buttonHeight(context) * 0.7;


    double iconSize = isMobile
        ? 14.0
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