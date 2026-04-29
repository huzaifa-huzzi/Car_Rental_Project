import 'package:car_rental_project/Portal/Vendor/Staff/ReusableWidgetOfStaff/CustomButtonOfStaff.dart';
import 'package:car_rental_project/Portal/Vendor/Staff/ReusableWidgetOfStaff/PrimaryBtnStaff.dart';
import 'package:car_rental_project/Portal/Vendor/Staff/ReusableWidgetOfStaff/StaffSuccessDialog.dart';
import 'package:car_rental_project/Portal/Vendor/Staff/StaffController.dart';
import 'package:car_rental_project/Resources/IconStrings.dart';
import 'package:car_rental_project/Resources/TextString.dart';
import 'package:car_rental_project/Resources/TextTheme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:car_rental_project/Resources/AppSizes.dart';
import 'package:car_rental_project/Resources/Colors.dart';

class AddStaffScreenWidget extends StatelessWidget {
  const AddStaffScreenWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<StaffController>();

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(TextString.addStaffHeaderTitle, style: TTextTheme.h6Style(context)),
            ),
            const Divider(height: 1, thickness: 0.5, color: AppColors.quadrantalTextColor),

            // Staff Name Section
            _buildSection(context, icon: IconString.staffNameICon, title: TextString.addStaffName, subtitle: TextString.addStaffNameSubtitle,
                children: [
                  _buildTextField(TextString.addStaffNameFieldOne, "Write First Name...", controller.firstNameC, context),
                  _buildTextField(TextString.addStaffNameFieldTwo, "Write Last Name...", controller.lastNameC, context),
                ]),

            const Divider(height: 1, thickness: 0.5, color: AppColors.quadrantalTextColor),

            // Staff Details Section
            _buildSection(context, icon: IconString.staffContactIcon, title: TextString.addStaffContact, subtitle: TextString.addStaffContactSubtitle,
                children: [
                  _buildTextField(TextString.addStaffContactFieldOne, "Write Staff Email...", controller.emailC, context),
                  _buildTextField(TextString.addStaffContactFieldTwo, "Write Staff Number...", controller.phoneC, context),
                ]),

            const Divider(height: 1, thickness: 0.5, color: AppColors.quadrantalTextColor),

            // Staff Positions Section
            _buildSection(context, icon: IconString.staffDetailIcon, title: TextString.addStaffDetail, subtitle: TextString.addStaffDetailSubtitle,
                children: [
                  _buildTextField(TextString.addStaffDetailFieldOne, "Write Staff Role Name...", controller.positionC, context),
                  SizedBox(
                    width: 300,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(TextString.addStaffDetailFieldStatus, style: TTextTheme.staffUpsideField(context)),
                        const SizedBox(height: 8),
                        _statusDropdownBox(controller.statusItems, controller.selectedStatus, context),
                      ],
                    ),
                  ),
                ]),
            const Divider(height: 1, thickness: 0.5, color: AppColors.quadrantalTextColor),
            _buildSection(context, icon: IconString.staffAccessIcon, title: TextString.addStaffAccess, subtitle: TextString.addStaffAcessSubtitle,
                children: [
                  _buildAccessPermissions(controller, context),
                ]),

            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Builder(
                builder: (context) {
                  bool isStacked = AppSizes.isMobile(context) || AppSizes.isTablet(context);

                  return Flex(
                    direction: isStacked ? Axis.vertical : Axis.horizontal,
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: isStacked ? CrossAxisAlignment.stretch : CrossAxisAlignment.center,
                    children: [
                      CustomButtonOfStaff(
                        text: 'Cancel',
                        width: isStacked ? double.infinity : 120,
                        height: 45,
                        onTap: () => Navigator.pop(context),
                      ),

                      isStacked ? const SizedBox(height: 12) : const SizedBox(width: 16),
                      PrimaryBtnStaff(
                        text: "Sent Innovation",
                        width: isStacked ? double.infinity : 200,
                        height: 45,
                        onTap: () {
                          if (controller.validateStaffForm()) {
                            showDialog(
                              context: context,
                              builder: (context) => StaffSuccessDialog(),
                            );
                          } else {

                          }
                        },
                        icon: const Icon(Icons.arrow_forward, color: Colors.white, size: 18),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// ---------- Extra Widgets --------- ///

   // Section 
  Widget _buildSection(BuildContext context, {required String icon, required String title, required String subtitle, required List<Widget> children}) {
    bool isWeb = AppSizes.isWeb(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
      child: Flex(
        direction: isWeb ? Axis.horizontal : Axis.vertical,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: isWeb ? 250 : double.infinity,
            child: Row(
              children: [
                Image.asset(icon),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: TTextTheme.h7Style(context)),
                    Text(subtitle, style: TTextTheme.staffSubtitle(context)),
                  ],
                ),
              ],
            ),
          ),
          if (!isWeb) const SizedBox(height: 20),
          Expanded(flex: isWeb ? 1 : 0, child: Wrap(spacing: 30, runSpacing: 20, children: children)),
        ],
      ),
    );
  }

   // TextFields
  Widget _buildTextField(String label, String hint, TextEditingController controller, BuildContext context) {
    final staffController = Get.find<StaffController>();

    String errorKey = label.contains("First") ? "First Name" :
    label.contains("Last") ? "Last Name" :
    label.contains("Email") ? "Email" :
    label.contains("Number") ? "Phone" : "Position";

    return SizedBox(
      width: 300,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: TTextTheme.staffUpsideField(context)),
          const SizedBox(height: 8),
          Focus(
            onFocusChange: (hasFocus) {
              (context as Element).markNeedsBuild();
            },
            child: Builder(
              builder: (context) {
                final bool isFocused = Focus.of(context).hasFocus;

                return Obx(() {
                  bool hasError = staffController.textFieldErrors.containsKey(errorKey);

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: hasError ? AppColors.primaryColor : Colors.transparent,
                            width: 1,
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
                          cursorColor: AppColors.blackColor,
                          controller: controller,
                          style: TTextTheme.insidetextfieldWrittenText(context),
                          onChanged: (v) {
                            if (hasError) staffController.textFieldErrors.remove(errorKey);
                          },
                          onTapOutside: (event) {
                            FocusScope.of(context).unfocus();
                          },
                          decoration: InputDecoration(
                            hintText: hint,
                            filled: true,
                            fillColor: AppColors.secondaryColor,
                            hintStyle: TTextTheme.insidetextfieldWrittenText(context),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide.none,
                            ),
                            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                          ),
                        ),
                      ),
                      // Error Message
                      if (hasError)
                        Padding(
                          padding: const EdgeInsets.only(top: 4, left: 4),
                          child: Text(
                            staffController.textFieldErrors[errorKey]!,
                            style: TTextTheme.ErrorStyle(context),
                          ),
                        ),
                    ],
                  );
                });
              },
            ),
          ),
        ],
      ),
    );
  }

   // Status Dropdowns
  Widget _statusDropdownBox(List<String> items, RxString selectedRx, BuildContext context) {
    final controller = Get.find<StaffController>();

    return Obx(() {
      bool hasError = controller.statusError.value.isNotEmpty;

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          LayoutBuilder(
            builder: (context, constraints) {
              return PopupMenuButton<String>(
                offset: const Offset(0, 45),
                constraints: BoxConstraints(
                  minWidth: constraints.maxWidth,
                  maxWidth: constraints.maxWidth,
                ),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                color: AppColors.secondaryColor,
                tooltip: "Select Status",
                onSelected: (v) {
                  selectedRx.value = v;
                  controller.statusError.value = "";
                },
                itemBuilder: (context) {
                  return items.asMap().entries.map((entry) {
                    int index = entry.key;
                    String item = entry.value;

                    return PopupMenuItem<String>(
                      value: item,
                      padding: EdgeInsets.zero,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                            child: Container(
                              width: double.infinity,
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              decoration: BoxDecoration(
                                color: _getStatusBgColor(item),
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: AppColors.sideBoxesColor),
                              ),
                              child: Text(
                                item,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: _getStatusTextColor(item),
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                          if (index != items.length - 1)
                            Divider(
                              height: 1,
                              thickness: 0.5,
                              color: AppColors.quadrantalTextColor,
                            ),
                        ],
                      ),
                    );
                  }).toList();
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  height: 45,
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    color: AppColors.secondaryColor,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: hasError ? AppColors.primaryColor : Colors.transparent,
                      width: 1.5,
                    ),
                  ),
                  child: Row(
                    children: [
                      selectedRx.value.isEmpty
                          ? Text(
                        "Select Status",
                        style: TTextTheme.insidetextfieldWrittenText(context).copyWith(
                        ),
                      )
                          : Container(
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                        decoration: BoxDecoration(
                          color: _getStatusBgColor(selectedRx.value),
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(color: AppColors.sideBoxesColor),
                        ),
                        child: Text(
                          selectedRx.value,
                          style: TextStyle(
                            color: _getStatusTextColor(selectedRx.value),
                            fontSize: 12,
                          ),
                        ),
                      ),
                      const Spacer(),
                      const Icon(Icons.keyboard_arrow_down, size: 22, color: Colors.black54),
                    ],
                  ),
                ),
              );
            },
          ),
          if (hasError)
            Padding(
              padding: const EdgeInsets.only(top: 4, left: 4),
              child: Text(
                controller.statusError.value,
                style: TTextTheme.ErrorStyle(context),
              ),
            ),
        ],
      );
    });
  }
  Color _getStatusBgColor(String status) {
    switch (status) {
      case "Active": return AppColors.textColor;
      case "Awaiting": return AppColors.secondaryColor;
      case "InActive": return AppColors.secondaryColor;
      case "Suspended": return AppColors.iconsBackgroundColor;

      default: return Colors.grey.shade100;
    }
  }
  Color _getStatusTextColor(String status) {
    switch (status) {
      case "Active": return Colors.white;
      case "Awaiting": return AppColors.textColor;
      case "InActive": return AppColors.textColor;
      case "Suspended": return AppColors.primaryColor;
      default: return Colors.black;
    }
  }

   // Access Permission Section
  Widget _buildAccessPermissions(StaffController controller, BuildContext context) {
    List<String> options = ["Car Inventory", "Customers", "Pickup Car", "Dropoff Car"];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(TextString.addStaffAcessPermission, style: TTextTheme.staffUpsideField(context)),
        const SizedBox(height: 12),

        Obx(() {
          bool hasError = controller.permissionsError.value.isNotEmpty;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 10),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.white,
                  border: Border.all(
                    color: hasError ? AppColors.primaryColor : Colors.transparent,
                    width: 1.5,
                  ),
                ),
                child: Column(
                  children: options.map((opt) {
                    bool isSelected = controller.permissions.contains(opt);

                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12.0),
                      child: Row(
                        children: [
                          Checkbox(
                            value: isSelected,
                            activeColor: AppColors.primaryColor,
                            side: BorderSide(
                              color: isSelected
                                  ? AppColors.primaryColor
                                  : (hasError ? AppColors.primaryColor : AppColors.quadrantalTextColor),
                              width: 1.5,
                            ),
                            onChanged: (v) => controller.togglePermission(opt),
                          ),
                          const SizedBox(width: 8),
                          PrimaryBtnStaff(
                            text: opt,
                            onTap: () => controller.togglePermission(opt),
                            height: 35,
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ),
              if (hasError)
                Padding(
                  padding: const EdgeInsets.only(top: 6, left: 4),
                  child: Text(
                    controller.permissionsError.value,
                    style: TTextTheme.ErrorStyle(context),
                  ),
                ),
            ],
          );
        }),
      ],
    );
  }
}
