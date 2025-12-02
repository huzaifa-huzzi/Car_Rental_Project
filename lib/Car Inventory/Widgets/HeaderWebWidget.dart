import 'package:car_rental_project/Car%20Inventory/Widgets/ButtonWidget.dart';
import 'package:car_rental_project/Resources/Colors.dart';
import 'package:car_rental_project/Resources/TextTheme.dart';
import 'package:flutter/material.dart';
import 'package:car_rental_project/Resources/AppSizes.dart';
import 'package:car_rental_project/Resources/IconStrings.dart';

class HeaderWebWidget extends StatelessWidget {
  final bool showBack;
  final bool showSmallTitle;
  final bool showAddButton;
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
    this.profileImageUrl = "https://i.pravatar.cc/300",
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
          ///  Titles
          Row(
            children: [
              if (showBack)
                GestureDetector(
                  onTap: onBackPressed,
                  child: Container(
                    width: AppSizes.buttonHeight(context),
                    height: AppSizes.buttonHeight(context),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        AppSizes.borderRadius(context),
                      ),
                      color: Colors.white,
                    ),
                    child:  Image.asset(IconString.backScreenIcon),
                  ),
                ),

              if (showBack)
                SizedBox(width: AppSizes.padding(context)),

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

          ///  Icons & Profile
          Row(
            children: [
              if (showAddButton)
                AddButton(
                  text: "Add Car",
                  height: AppSizes.buttonHeight(context),
                  width: AppSizes.buttonWidth(context),
                  onTap: onAddPressed ?? () {},
                ),

              if (showAddButton)
                SizedBox(width: AppSizes.padding(context) * 0.4), 

              _iconButton(IconString.searchIcon, onSearchPressed, context),
              SizedBox(width: AppSizes.padding(context) * 0.4),

              _iconButton(IconString.settingIcon, onSettingsPressed, context),
              SizedBox(width: AppSizes.padding(context) * 0.4),

              Stack(
                children: [
                  _iconButton(
                      IconString.notificationIcon,
                      onNotificationPressed,
                      context
                  ),
                  Positioned(
                    top: 12,
                    right: 9,
                    child: Container(
                      width: 8,
                      height: 8,
                      decoration:  BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.primaryColor,
                      ),
                    ),
                  )
                ],
              ),

              SizedBox(width: AppSizes.padding(context) * 1),

              /// Profile
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

   /// Universal Icons used in it
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
