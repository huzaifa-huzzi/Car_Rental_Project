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
  @override
  Widget build(BuildContext context) {
    final borderRadius = AppSizes.borderRadius(context);
    bool isHover = false;

    return StatefulBuilder(
      builder: (context, setState) {
        return MouseRegion(
          onEnter: (_) => setState(() => isHover = true),
          onExit: (_) => setState(() => isHover = false),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 180),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(borderRadius),
              border: isHover
                  ? Border.all(color: AppColors.primaryColor, width: 1)
                  : null,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                )
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(context),

                _buildCarImage(context),

                _buildResponsiveDetails(context),

                const SizedBox(height: 8),

                _buildActions(context),
              ],
            ),
          ),
        );
      },
    );
  }

  /// --------- Extra Widgets ----------- ///

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
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(name, style: TTextTheme.h6Style(context)),
                ),
                Text(model, style: TTextTheme.titleUpperHeading(context), overflow: TextOverflow.ellipsis),
              ],
            ),
          ),
          const SizedBox(width: 4),
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text("\$${price.split('/').first.trim()}", style: TTextTheme.titleOne(context)),
                Text("/${price.split('/').last.trim()}", style: TTextTheme.titleThree(context)),
              ],
            ),
          ),
        ],
      ),
    );
  }

   // car Image widget
  Widget _buildCarImage(BuildContext context) {
    String img = image.startsWith("assets/") ? image : "assets/images/$image";
    double screenWidth = MediaQuery.of(context).size.width;

    double h = screenWidth < 600 ? 90 : 110;

    return Container(
      width: double.infinity,
      height: h,
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Image.asset(
        img,
        fit: BoxFit.contain,
        filterQuality: FilterQuality.high,
      ),
    );
  }

  // Responsive details widget
  Widget _buildResponsiveDetails(BuildContext context) {
    final paddingH = AppSizes.padding(context) * (AppSizes.isMobile(context) ? 0.4 : 0.75);
    bool isMobile = AppSizes.isMobile(context);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: paddingH),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          isMobile
              ? Row(
            children: [
              _statusBadge(context),
              const SizedBox(width: 4),
              Expanded(child: _buildRegistrationBadge(context)),
            ],
          )
              : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _statusBadge(context),
              const SizedBox(height: 4),
              _buildRegistrationBadge(context),
            ],
          ),
          const SizedBox(height: 8),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            child: Row(
              children: [
                _specItem(context, IconString.transmissionIcon, transmission),
                const SizedBox(width: 8),
                _specItem(context, IconString.seatIcon, capacity),
                const SizedBox(width: 8),
                _specItem(context, IconString.gasPumpIcon, fuelType),
              ],
            ),
          ),
        ],
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

  // specItems widgets
  Widget _specItem(BuildContext context, String icon, String value) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(icon, width: 10, height: 10, color: AppColors.textColor),
        const SizedBox(width: 4),
        Text(value, style: TTextTheme.titleSmallTexts(context)),
      ],
    );
  }

   // Action button widget
  Widget _buildActions(BuildContext context) {
    final padding = AppSizes.padding(context) * (AppSizes.isMobile(context) ? 0.4 : 0.75);

    return Padding(
      padding: EdgeInsets.all(padding),
      child: LayoutBuilder(
          builder: (context, bConstraints) {
            double btnHeight = bConstraints.maxWidth < 150 ? 29 : 35;
            return Row(
              children: [
                Expanded(
                  child: AddButton(
                    text: 'View',
                    onTap: onView ?? () => context.push('/cardetails', extra: {"hideMobileAppBar": true}),
                    height: btnHeight,
                  ),
                ),
                const SizedBox(width: 6),
                Container(
                  height: btnHeight,
                  width: btnHeight,
                  decoration: BoxDecoration(
                    color: AppColors.backgroundOfScreenColor,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Icon(Icons.more_horiz, color: AppColors.blackColor, size: btnHeight * 0.5),
                ),
              ],
            );
          }
      ),
    );
  }
}