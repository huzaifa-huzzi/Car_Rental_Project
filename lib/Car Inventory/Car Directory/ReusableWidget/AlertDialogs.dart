import 'package:car_rental_project/Resources/Colors.dart';
import 'package:car_rental_project/Resources/IconStrings.dart';
import 'package:car_rental_project/Resources/TextTheme.dart';
import 'package:flutter/material.dart';

enum DialogType { edit, delete }

class ResponsiveConfirmDialog extends StatelessWidget {
  final DialogType type;
  final VoidCallback onConfirm;
  final VoidCallback onCancel;

  const ResponsiveConfirmDialog({
    super.key,
    required this.type,
    required this.onConfirm,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    final bool isDelete = type == DialogType.delete;

    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          double maxWidth = constraints.maxWidth.clamp(200, 420);

          return ConstrainedBox(
            constraints: BoxConstraints(maxWidth: maxWidth),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  /// ICON
                  Container(
                    padding:  EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: isDelete
                          ? AppColors.iconsBackgroundColor
                          : AppColors.secondaryColor,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Image.asset(
                      isDelete ? IconString.deleteIcon : IconString.editIcon,
                      width: 20,
                      height: 20,
                      color: isDelete ? AppColors.primaryColor: AppColors.quadrantalTextColor,
                    ),
                  ),

                  const SizedBox(height: 12),

                  /// TITLE
                  Text(
                    isDelete ? "Delete" : "Edit",
                    style: TTextTheme.titleTwo(context)),


                  const SizedBox(height: 6),

                  /// MESSAGE
                  Text(
                    isDelete
                        ? "Are you sure want to delete?"
                        : "Are you sure want to Edit?",
                    textAlign: TextAlign.center,
                    style: TTextTheme.titleFour(context)),

                  const SizedBox(height: 20),

                  /// BUTTONS
                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: [
                      SizedBox(
                        width: maxWidth < 260 ? double.infinity : 120,
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
            SizedBox(
              width: maxWidth < 260 ? double.infinity : 120,
              child: ElevatedButton(
                onPressed: onConfirm,
                style: ElevatedButton.styleFrom(
                  backgroundColor: isDelete ? Colors.red : Colors.blue,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  "Confirm",
                  style: TTextTheme.btnConfirm(context).copyWith(
                    color: isDelete ? Colors.white : Colors.black,
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
