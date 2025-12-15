import 'package:flutter/material.dart';
import 'package:car_rental_project/Resources/Colors.dart';
import 'package:car_rental_project/Resources/TextTheme.dart';

class AddButton extends StatelessWidget {
  final String text;
  final double? height;
  final double? width;
  final VoidCallback onTap;
  final BorderRadius? borderRadius;
  final Widget? icon;
  final bool isIconLeft;

  const AddButton({
    super.key,
    required this.text,
    required this.onTap,
    this.height,
    this.width,
    this.borderRadius,
    this.icon,
    this.isIconLeft = true,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height,
        width: width,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: AppColors.primaryColor,
          borderRadius: borderRadius ?? BorderRadius.circular(8),
        ),
        child: Center(
          child: icon != null
              ? Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (isIconLeft) ...[
                SizedBox(
                  width: height != null ? height! * 0.5 : 20,
                  height: height != null ? height! * 0.5 : 20,
                  child: icon,
                ),
                const SizedBox(width: 8),
              ],
              Flexible(
                child: Text(
                  text,
                  style: TTextTheme.btnTwo(context)
                      .copyWith(color: Colors.white),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              if (!isIconLeft) ...[
                const SizedBox(width: 8),
                SizedBox(
                  width: height != null ? height! * 0.5 : 20,
                  height: height != null ? height! * 0.5 : 20,
                  child: icon,
                ),
              ],
            ],
          )
              : Text(
            text,
            style:
            TTextTheme.btnTwo(context).copyWith(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
