import 'package:car_rental_project/Resources/AppSizes.dart';
import 'package:flutter/material.dart';
import 'package:car_rental_project/Resources/Colors.dart';
import 'package:car_rental_project/Resources/IconStrings.dart';
import 'package:car_rental_project/Resources/TextTheme.dart';


class TabAppBar extends StatefulWidget {
  final VoidCallback? onAddPressed;
  final VoidCallback? onNotificationPressed;
  final String profileImageUrl;
  final GlobalKey<ScaffoldState> scaffoldKey;

  const TabAppBar({
    super.key,
    this.onAddPressed,
    this.onNotificationPressed,
    required this.profileImageUrl,
    required this.scaffoldKey,
  });

  @override
  State<TabAppBar> createState() => _TabAppBarState();
}

class _TabAppBarState extends State<TabAppBar> with WidgetsBindingObserver {
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

  /// Helper function to build the Menu Icon Container
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

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: finalHorizontalPadding),
      child: SizedBox(
        height: AppSizes.buttonHeight(context),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [

            _buildMenuIconButton(context, containerSize, iconSize),

            SizedBox(width: finalInternalSpacing),

            /// CENTER: Logo and Title
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
                      SizedBox(width: finalInternalSpacing / 2),
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

            SizedBox(width: finalInternalSpacing),

            /// RIGHT SIDE ICONS
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

                const SizedBox(width: 6),

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
                        right: 5,
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

                const SizedBox(width: 6),

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