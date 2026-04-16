import 'package:car_rental_project/Resources/AppSizes.dart';
import 'package:car_rental_project/Resources/Colors.dart';
import 'package:car_rental_project/Resources/IconStrings.dart';
import 'package:car_rental_project/Resources/TextTheme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';



class TabAppbarStaff extends StatefulWidget implements PreferredSizeWidget {
  final VoidCallback? onAddPressed;
  final VoidCallback? onNotificationPressed;
  final VoidCallback? onSearchPressed;
  final VoidCallback? onSettingsPressed;
  final String profileImageUrl;
  final GlobalKey<ScaffoldState> scaffoldKey;
  final bool isDashboard;

  const TabAppbarStaff({
    super.key,
    this.onAddPressed,
    this.onSearchPressed,
    this.onNotificationPressed,
    this.onSettingsPressed,
    required this.profileImageUrl,
    required this.scaffoldKey,
    this.isDashboard = false,
  });

  @override
  State<TabAppbarStaff> createState() => _TabAppbarStaffState();

  @override
  Size get preferredSize => Size.fromHeight(AppSizes.buttonHeight(Get.context!));
}

class _TabAppbarStaffState extends State<TabAppbarStaff> with WidgetsBindingObserver {
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
    Future.delayed(const Duration(milliseconds: 50), () {
      if (mounted) {
        final isNowOpen = widget.scaffoldKey.currentState?.isDrawerOpen ?? false;
        if (_isDrawerOpen != isNowOpen) {
          setState(() {
            _isDrawerOpen = isNowOpen;
          });
        }
      }
    });
  }

  Widget _buildIconButton({
    required Widget child,
    required double size,
    Color? bgColor,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: bgColor ?? Colors.white,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Center(child: child),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    const double minHorizontalPadding = 12.0;
    final double actualHorizontalPadding = AppSizes.horizontalPadding(context);
    final double finalHorizontalPadding = actualHorizontalPadding > minHorizontalPadding ? actualHorizontalPadding : minHorizontalPadding;
    final double finalInternalSpacing = AppSizes.padding(context) > 8.0 ? AppSizes.padding(context) : 8.0;

    double containerSize = AppSizes.isMobile(context) ? 28 : (AppSizes.isTablet(context) ? 32 : 36);
    double iconSize = AppSizes.isMobile(context) ? 16 : (AppSizes.isTablet(context) ? 18 : 20);
    double logoSize = AppSizes.isMobile(context) ? 24 : (AppSizes.isTablet(context) ? 28 : 32);
    double fontSize = AppSizes.isMobile(context) ? 15 : (AppSizes.isTablet(context) ? 16 : 18);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: finalHorizontalPadding),
      child: SizedBox(
        height: AppSizes.buttonHeight(context),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            /// 1. LEFT: Menu Icon
            _buildIconButton(
              size: containerSize,
              onTap: () => widget.scaffoldKey.currentState?.openDrawer(),
              child: Icon(
                Icons.menu,
                color: _isDrawerOpen ? AppColors.primaryColor : AppColors.textColor,
                size: iconSize,
              ),
            ),

            SizedBox(width: finalInternalSpacing),

            /// 2. CENTER: Logo and Title
            Flexible(
              child: Center(
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset(IconString.symbol, width: logoSize, height: logoSize),
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

            /// 3. RIGHT SIDE ICONS
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                /// Search or Add Button
                if (widget.isDashboard)
                  _buildIconButton(
                    size: containerSize,
                    onTap: widget.onSearchPressed,
                    child: Icon(Icons.search, color: AppColors.textColor, size: iconSize),
                  )
                else
                  _buildIconButton(
                    size: containerSize,
                    bgColor: AppColors.primaryColor,
                    onTap: widget.onAddPressed,
                    child: Icon(Icons.add, color: Colors.white, size: iconSize),
                  ),

                const SizedBox(width: 6),
                _buildIconButton(
                  size: containerSize,
                  onTap: widget.onSettingsPressed,
                  child: Image.asset(IconString.settingIcon, width: iconSize, height: iconSize),
                ),

                const SizedBox(width: 6),

                /// Notification Icon
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    _buildIconButton(
                      size: containerSize,
                      onTap: widget.onNotificationPressed,
                      child: Image.asset(IconString.notificationIcon, width: iconSize - 2, height: iconSize - 2),
                    ),
                    Positioned(
                      top: 8,
                      right: 7,
                      child: Container(
                        width: 6,
                        height: 6,
                        decoration: const BoxDecoration(color: AppColors.primaryColor, shape: BoxShape.circle),
                      ),
                    ),
                  ],
                ),

                const SizedBox(width: 6),

                /// Profile Photo
                _buildIconButton(
                  size: containerSize,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(AppSizes.borderRadius(context)),
                    child: Image.asset(widget.profileImageUrl, fit: BoxFit.cover),
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