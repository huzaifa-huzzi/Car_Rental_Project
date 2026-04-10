import 'package:flutter/material.dart';
import 'package:car_rental_project/Resources/Colors.dart';
import 'package:car_rental_project/Resources/TextTheme.dart';
import 'package:car_rental_project/Resources/AppSizes.dart';

class CustomButtonDropOff extends StatelessWidget {
  final VoidCallback? onTap;
  final String text;
  final bool isLoading;
  final Color backgroundColor;
  final Color textColor;
  final Color borderColor;
  final Color iconColor;
  final String? iconPath;
  final double? height;
  final double? width;
  final BorderRadius? borderRadius;

  const CustomButtonDropOff({
    super.key,
    this.onTap,
    required this.text,
    this.isLoading = false,
    this.backgroundColor = Colors.white,
    this.textColor = AppColors.textColor,
    this.borderColor = AppColors.quadrantalTextColor,
    this.iconColor = AppColors.primaryColor,
    this.iconPath,
    this.height,
    this.width,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    final VoidCallback? effectiveOnTap = isLoading ? null : onTap;

    return GestureDetector(
      onTap: effectiveOnTap,
      child: Container(
        height: height ?? AppSizes.buttonHeight(context),
        width: width,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: borderRadius ?? BorderRadius.circular(AppSizes.borderRadius(context)),
          border: Border.all(color: borderColor, width: 1),
        ),
        child: isLoading
            ? Center(
          child: SizedBox(
            width: 20,
            height: 20,
            child: CircularProgressIndicator(
              color: textColor,
              strokeWidth: 2,
            ),
          ),
        )
            : Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (iconPath != null) ...[
              Image.asset(
                iconPath!,
                width: 18,
                height: 18,
                color:iconColor ,
                fit: BoxFit.contain,
              ),
              const SizedBox(width: 6),
            ],
            Text(
              text,
              style: TTextTheme.btnCancel(context).copyWith(color: textColor),
            ),
          ],
        ),
      ),
    );
  }
}