import 'package:car_rental_project/Resources/AppSizes.dart';
import 'package:flutter/material.dart';
import 'package:car_rental_project/Resources/Colors.dart';
import 'package:car_rental_project/Resources/IconStrings.dart';
import 'package:car_rental_project/Resources/TextTheme.dart';


class MobileTopBar extends StatefulWidget {
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
  State<MobileTopBar> createState() => _MobileTopBarState();
}

class _MobileTopBarState extends State<MobileTopBar> with WidgetsBindingObserver {
  bool _isDrawerOpen = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }


  @override
  void didChangeMetrics() {
    super.didChangeMetrics();
    Future.delayed(Duration(milliseconds: 50), () {
      final isNowOpen = widget.scaffoldKey.currentState?.isDrawerOpen ?? false;
      if (_isDrawerOpen != isNowOpen) {
        setState(() {
          _isDrawerOpen = isNowOpen;
        });
      }
    });
  }

  /// Helper function
  Widget _buildMenuIconButton(BuildContext context, double containerSize, double iconSize) {

    final Color iconColor = _isDrawerOpen ? AppColors.primaryColor : AppColors.textColor;

    return GestureDetector(
      onTap: () {
        widget.scaffoldKey.currentState?.openDrawer();
      },
      child: Container(
        width: containerSize,
        height: containerSize,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Center(
          child: Icon(
            Icons.menu,
            color: iconColor,
            size: iconSize,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    const double narrowThreshold = 350;
    const double veryNarrowThreshold = 280;

    final double horizontalPadding = screenWidth < veryNarrowThreshold ? 6.0 : AppSizes.horizontalPadding(context);

    final double internalSpacing = screenWidth < veryNarrowThreshold ? 4.0 : 8.0;


    double containerSize;
    if (screenWidth < veryNarrowThreshold) {
      containerSize = 24;
    } else if (screenWidth < narrowThreshold) {
      containerSize = 28;
    } else {
      containerSize = AppSizes.isMobile(context) ? 28 : AppSizes.isTablet(context) ? 32 : 36;
    }


    double iconSize = containerSize * 0.65;


    double logoSize = containerSize * 1.0;


    double fontSize = screenWidth < veryNarrowThreshold ? 13 :
    screenWidth < narrowThreshold ? 15 : 16;


    return Padding(

      padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
      child: SizedBox(
        height: AppSizes.buttonHeight(context),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [

            _buildMenuIconButton(context, containerSize, iconSize),

            SizedBox(width: internalSpacing),

            /// 2. CENTER: Logo and Title
            Flexible(
              child: Center(
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset(
                        IconString.symbol,
                        width: logoSize,
                        height: logoSize,
                      ),
                      SizedBox(width: internalSpacing / 2),
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
            ),

            SizedBox(width: internalSpacing),

            /// 3. RIGHT SIDE ICONS
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                /// Add Button
                GestureDetector(
                  onTap: widget.onAddPressed,
                  child: Container(
                    width: containerSize,
                    height: containerSize,
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor,
                      borderRadius: BorderRadius.circular(AppSizes.borderRadius(context)),
                    ),
                    child: Icon(Icons.add, color: Colors.white, size: iconSize),
                  ),
                ),

                SizedBox(width: internalSpacing),

                /// Notification Icon
                GestureDetector(
                  onTap: widget.onNotificationPressed,
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Container(
                        width: containerSize,
                        height: containerSize,
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
                        top: 6,
                        right: 6,
                        child: Container(
                          width: 6,
                          height: 6,
                          decoration: BoxDecoration(
                            color: AppColors.primaryColor,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(width: internalSpacing),

                /// Profile Photo
                Container(
                  width: containerSize,
                  height: containerSize,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(AppSizes.borderRadius(context)),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(AppSizes.borderRadius(context)),
                    child: Image.network(
                      widget.profileImageUrl,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}