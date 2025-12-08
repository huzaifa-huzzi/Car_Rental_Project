import 'package:flutter/material.dart';
import 'package:car_rental_project/Resources/Colors.dart';
import 'package:car_rental_project/Resources/TextTheme.dart';
import 'package:car_rental_project/Resources/AppSizes.dart';

class CustomPrimaryButton extends StatelessWidget {
  final VoidCallback? onTap;
  final String text;
  final bool isLoading;
  final Color backgroundColor;
  final Color textColor;
  final Color borderColor;

  const CustomPrimaryButton({
    super.key,
    this.onTap,
    required this.text,
    this.isLoading = false,
    this.backgroundColor = Colors.white,
    this.textColor = AppColors.textColor,
    this.borderColor = AppColors.quadrantalTextColor,
  });

  @override
  Widget build(BuildContext context) {
    final VoidCallback? effectiveOnTap = isLoading ? null : onTap;

    final double buttonHeight = AppSizes.buttonHeight(context);
    final double verticalPadding = AppSizes.isWeb(context)
        ? buttonHeight * 0.15  // web ke liye kam padding
        : buttonHeight * 0.35; // mobile/tablet
    final EdgeInsets buttonPadding = EdgeInsets.symmetric(
      vertical: verticalPadding,
      horizontal: AppSizes.padding(context) * 0.5,
    );

    return GestureDetector(
      onTap: effectiveOnTap,
      child: Container(
        padding: buttonPadding,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(AppSizes.borderRadius(context)),
          border: Border.all(
            color: borderColor,
            width: 1.0,
          ),
        ),
        alignment: Alignment.center,
        child: isLoading
            ? SizedBox(
          width: 20,
          height: 20,
          child: CircularProgressIndicator(
            color: textColor,
            strokeWidth: 2,
          ),
        )
            : Text(
          text,
          style: TTextTheme.btnCancel(context),
        ),
      ),
    );
  }

}
