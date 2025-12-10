import 'package:flutter/material.dart';
import 'package:car_rental_project/Resources/AppSizes.dart';
import 'package:car_rental_project/Resources/Colors.dart';
import 'package:car_rental_project/Resources/TextTheme.dart';
import 'package:car_rental_project/Resources/IconStrings.dart';
import 'package:car_rental_project/Car Inventory/Car Directory/ReusableWidget/ButtonWidget.dart';
import 'package:go_router/go_router.dart';

class CarGridItem extends StatelessWidget {
  final String image;
  final String name;
  final String model;
  final String transmission;
  final String capacity;
  final String price;
  final String status;
  final String regId;
  final String fuelType;
  final VoidCallback? onView;

  const CarGridItem({
    super.key,
    required this.image,
    required this.name,
    required this.model,
    required this.transmission,
    required this.capacity,
    required this.price,
    required this.status,
    required this.regId,
    required this.fuelType,
    this.onView,
  });

  @override
  Widget build(BuildContext context) {
    final borderRadius = AppSizes.borderRadius(context);
    final bool isMobile = AppSizes.isMobile(context);

    // Hover state
    bool isHover = false;

    return StatefulBuilder(
      builder: (context, setState) {
        return MouseRegion(
          onEnter: (_) {
            if (AppSizes.isWeb(context)) {
              setState(() => isHover = true);
            }
            if (AppSizes.isMobile(context)) {
              setState(() => isHover = true);
            }
            if (AppSizes.isTablet(context)) {
              setState(() => isHover = true);
            }
          },
          onExit: (_) {
            if (AppSizes.isWeb(context)) {
              setState(() => isHover = false);
            }
            if (AppSizes.isMobile(context)) {
              setState(() => isHover = false);
            }
            if (AppSizes.isTablet(context)) {
              setState(() => isHover = false);
            }
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 180),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(borderRadius),
              border: isHover
                  ? Border.all(color: AppColors.primaryColor, width: 2)
                  : null,
              boxShadow: const [
                BoxShadow(
                  color: Color.fromRGBO(0, 0, 0, 0.08),
                  offset: Offset(0, 1),
                  blurRadius: 4,
                ),
              ],
            ),

            child: LayoutBuilder(
              builder: (context, constraints) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildHeader(context),

                    Flexible(
                      flex: 2,
                      child: _buildCarImage(
                        context,
                        extraMobileHeight: isMobile ? 60 : 0,
                      ),
                    ),

                    _buildDetails(context),

                    _buildActions(context),
                  ],
                );
              },
            ),
          ),
        );
      },
    );
  }




  /// ----- Extra Widgets (Used in the above screen)  -----///

   // header widget
  Widget _buildHeader(BuildContext context) {
    final paddingH = AppSizes.padding(context) * (AppSizes.isMobile(context) ? 0.4 : 0.75);

    return Padding(
      padding: EdgeInsets.only(
        left: paddingH,
        right: paddingH,
        top: AppSizes.verticalPadding(context) * 0.75,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TTextTheme.h6Style(context),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
                const SizedBox(height: 2),
                Text(
                  model,
                  style: TTextTheme.titleUpperHeading(context),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              FittedBox(
                child: Text(
                  "\$${price.split('/').first.trim()}",
                  style: TTextTheme.titleOne(context),
                ),
              ),
              FittedBox(
                child: Text(
                  "/${price.split('/').last.trim()}",
                  style: TTextTheme.titleThree(context),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

   // buildCar Widget
  Widget _buildCarImage(BuildContext context, {double extraMobileHeight = 0}) {
    String img = image.startsWith("assets/") ? image : "assets/images/$image";
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final isMobile = AppSizes.isMobile(context);
    final isTablet = AppSizes.isTablet(context);

    int crossAxisCount = AppSizes.isWeb(context) ? 3 : isTablet ? 2 : 1;
    final cardWidth = screenWidth / crossAxisCount;

    double baseHeight = cardWidth * 0.6;

    if (isMobile) {
      baseHeight += extraMobileHeight;
    }

    double minHeight = screenHeight * (isMobile ? 0.35 : 0.25);
    double maxHeight = screenHeight * (isMobile ? 0.45 : 0.5);

    double imageHeight = baseHeight.clamp(minHeight, maxHeight);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Center(
        child: Image.asset(
          img,
          width: double.infinity,
          height: imageHeight,
          fit: BoxFit.contain,
        ),
      ),
    );
  }

  // status badge widget
  Widget _statusBadge(BuildContext context) {
    Color bg = Colors.transparent;
    Color txt = Colors.black;
    String s = status.toLowerCase();

    if (s == "available") {
      bg = AppColors.availableBackgroundColor;
      txt = Colors.white;
    } else if (s == "maintenance") {
      bg = AppColors.maintenanceBackgroundColor;
      txt = Colors.black;
    } else if (s == "unavailable") {
      bg = AppColors.sideBoxesColor;
      txt = AppColors.secondTextColor;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(8)),
      child: Text(
        status,
        style: TTextTheme.smallX(context)?.copyWith(color: txt),
      ),
    );
  }

   // RegistrationBadge widget
  Widget _buildRegistrationBadge(BuildContext context) {
    final double padH = AppSizes.isMobile(context) ? 6 : 8;
    final double padV = AppSizes.isMobile(context) ? 3 : 4;
    final double radius = AppSizes.isMobile(context) ? 4 : 6;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: padH, vertical: padV),
          decoration: BoxDecoration(
            color: AppColors.textColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(radius),
              bottomLeft: Radius.circular(radius),
            ),
          ),
          child: Text(
            "Registration",
            style: TTextTheme.titleeight(context),
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: padH, vertical: padV),
          decoration: BoxDecoration(
            color: AppColors.secondaryColor,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(radius),
              bottomRight: Radius.circular(radius),
            ),
          ),
          child: Text(
            regId,
            style: TTextTheme.titleseven(context),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

   // Build Detail widget
  Widget _buildDetails(BuildContext context) {
    final paddingH = AppSizes.padding(context) * (AppSizes.isMobile(context) ? 0.4 : 0.75);
    bool isMobile = AppSizes.isMobile(context);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: paddingH),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          isMobile
              ? Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 4.0, right: 8.0),
                child: _statusBadge(context),
              ),
              _buildRegistrationBadge(context),
            ],
          )
              : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _statusBadge(context),
              SizedBox(height: 8),
              _buildRegistrationBadge(context),
            ],
          ),
          SizedBox(height: isMobile ? 6 : 12),
          Wrap(
            spacing: isMobile ? 8 : 16,
            runSpacing: 8,
            children: [
              _specItem(context, IconString.transmissionIcon, transmission),
              _specItem(context, IconString.seatIcon, capacity),
              _specItem(context, IconString.gasPumpIcon, fuelType),
            ],
          ),
        ],
      ),
    );
  }

   // spec Items widget
  Widget _specItem(BuildContext context, String icon, String value) {
    final iconSize = AppSizes.isMobile(context) ? 16.0 : 20.0;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: iconSize,
          height: iconSize,
          decoration: BoxDecoration(
            color: AppColors.secondaryColor,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Center(
            child: Image.asset(
              icon,
              width: iconSize * 0.6,
              height: iconSize * 0.6,
              color: AppColors.textColor,
            ),
          ),
        ),
        const SizedBox(width: 4),
        Flexible(
          child: Text(
            value,
            style: TTextTheme.titleSmallTexts(context),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

   // Action Buttons widget
  Widget _buildActions(BuildContext context) {
    final padding = AppSizes.padding(context) * (AppSizes.isMobile(context) ? 0.5 : 0.75);
    final buttonHeight = AppSizes.isMobile(context) ? 40.0 : 45.0;

    return Padding(
      padding: EdgeInsets.all(padding),
      child: Row(
        children: [
          Expanded(
            child: AddButton(
              text: AppSizes.isMobile(context) ? 'View' : 'View Car',
              onTap: onView ?? () {
                context.push(
                  '/cardetails',
                  extra: {"hideMobileAppBar": true},
                );
              },
              height: buttonHeight,
            ),
          ),
          SizedBox(width: AppSizes.isMobile(context) ? 6 : 8),
          Container(
            height: buttonHeight,
            width: buttonHeight,
            decoration: BoxDecoration(
              color: AppColors.backgroundOfScreenColor,
              borderRadius: BorderRadius.circular(AppSizes.borderRadius(context) * 0.5),
            ),
            child: Icon(
              Icons.more_horiz,
              color: AppColors.blackColor,
              size: buttonHeight * 0.5,
            ),
          ),
        ],
      ),
    );
  }
}
