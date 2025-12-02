import 'package:flutter/material.dart';
import 'package:car_rental_project/Resources/Colors.dart';
import 'package:car_rental_project/Resources/TextTheme.dart';

class AddButton extends StatelessWidget {
  final String text;
  final double? height;
  final double? width;
  final VoidCallback onTap;
  final double borderRadius;

  const AddButton({
    super.key,
    required this.text,
    required this.onTap,
    this.height,
    this.width,
    this.borderRadius = 8,
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
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: Center(
          child: Text(
            text,
            style: TTextTheme.btnTwo(context).copyWith(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
