import 'package:car_rental_project/Portal/Vendor/Car%20Inventory/Car%20Directory/CarInventoryController.dart';
import 'package:car_rental_project/Resources/AppSizes.dart';
import 'package:car_rental_project/Resources/Colors.dart';
import 'package:car_rental_project/Resources/TextTheme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomTextField extends StatefulWidget {
  final BuildContext parentContext;
  final String label;
  final TextEditingController textController;
  final String? prefix;
  final String? hint;
  final CarInventoryController invController;

  const CustomTextField({
    required this.parentContext,
    required this.label,
    required this.textController,
    required this.invController,
    this.prefix,
    this.hint,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final label = widget.label;
    final invController = widget.invController;
    final bool isFocused = _focusNode.hasFocus;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TTextTheme.titleTwo(context)),
        SizedBox(height: AppSizes.verticalPadding(context) * 0.3),
        if (label.contains("VIN") || label.contains("Registration"))
          Obx(() {
            String errorMsg = "";
            if (label.contains("VIN")) {
              errorMsg = invController.vinError.value;
            } else if (label.contains("Registration")) {
              errorMsg = invController.regError.value;
            }
            return _buildField(context, label, isFocused, errorMsg, invController);
          })
        else
          _buildField(context, label, isFocused, "", invController),
      ],
    );
  }

   /// ---------- Extra Widget
  // Field
  Widget _buildField(BuildContext context, String label, bool isFocused,
      String errorMsg, CarInventoryController invController) {
    bool hasError = errorMsg.isNotEmpty;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppSizes.borderRadius(context)),
            border: Border.all(
              color: hasError
                  ? AppColors.primaryColor
                  : (isFocused
                  ? AppColors.primaryColor.withOpacity(0.5)
                  : Colors.transparent),
              width: 1.5,
            ),
            boxShadow: isFocused && !hasError
                ? [
              BoxShadow(
                color: AppColors.fieldsBackground,
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ]
                : [],
          ),
          child: TextField(
            focusNode: _focusNode,
            controller: widget.textController,
            cursorColor: AppColors.blackColor,
            maxLength: label.contains("VIN")
                ? 17
                : (label.contains("Registration") ? 10 : null),
            textCapitalization:
            (label.contains("VIN") || label.contains("Registration"))
                ? TextCapitalization.characters
                : TextCapitalization.none,
            keyboardType: widget.prefix != null
                ? TextInputType.number
                : TextInputType.text,
            style: TTextTheme.insidetextfieldWrittenText(context),
            onChanged: (val) {
              if (label.contains("VIN")) invController.vinError.value = "";
              if (label.contains("Registration")) invController.regError.value = "";
            },
            decoration: InputDecoration(
              filled: true,
              fillColor: AppColors.secondaryColor,
              hintText: widget.hint ?? "Enter $label",
              hintStyle: TTextTheme.titleFour(context),
              prefixText: widget.prefix,
              counterText: "",
              border: OutlineInputBorder(
                borderRadius:
                BorderRadius.circular(AppSizes.borderRadius(context)),
                borderSide: BorderSide.none,
              ),
              contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            ),
          ),
        ),
        if (hasError)
          Padding(
            padding: const EdgeInsets.only(top: 4, left: 4),
            child: Text(errorMsg, style: TTextTheme.ErrorStyle(context)),
          ),
      ],
    );
  }
}