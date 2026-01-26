import 'package:car_rental_project/Resources/Colors.dart';
import 'package:car_rental_project/Resources/IconStrings.dart';
import 'package:car_rental_project/Resources/TextTheme.dart';
import 'package:flutter/material.dart';

class ResponsiveDeletePickupDialog extends StatelessWidget {
  final VoidCallback onConfirm;
  final VoidCallback onCancel;

  const ResponsiveDeletePickupDialog({
    super.key,
    required this.onConfirm,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          double maxWidth = constraints.maxWidth.clamp(200, 350);

          return ConstrainedBox(
            constraints: BoxConstraints(maxWidth: maxWidth),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  /// DELETE ICON
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppColors.iconsBackgroundColor,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Image.asset(
                      IconString.deleteIcon,
                      width: 24,
                      height: 24,
                      color: AppColors.primaryColor,
                    ),
                  ),

                  const SizedBox(height: 16),

                  /// TITLE
                  Text(
                    "Delete",
                    style: TTextTheme.titleTwo(context),
                  ),

                  const SizedBox(height: 8),

                  /// MESSAGE
                  Text(
                    "Are you sure you want to delete?",
                    textAlign: TextAlign.center,
                    style: TTextTheme.titleFour(context),
                  ),

                  const SizedBox(height: 24),

                  /// BUTTONS (Cancel & Confirm)
                  Wrap(
                    spacing: 12,
                    runSpacing: 10,
                    alignment: WrapAlignment.center,
                    children: [
                      // Cancel Button
                      SizedBox(
                        width: maxWidth < 280 ? double.infinity : 120,
                        child: OutlinedButton(
                          onPressed: onCancel,
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            side: BorderSide(
                              color: AppColors.quadrantalTextColor,
                              width: 0.8,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: Text(
                            "Cancel",
                            style: TTextTheme.btnCancel(context),
                          ),
                        ),
                      ),

                      // Confirm Delete Button
                      SizedBox(
                        width: maxWidth < 280 ? double.infinity : 120,
                        child: ElevatedButton(
                          onPressed: onConfirm,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            elevation: 0,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: Text(
                            "Delete",
                            style: TTextTheme.btnConfirm(context).copyWith(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
