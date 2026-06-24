import 'dart:io';
import 'package:car_rental_project/Portal/Admin/Companies/ReusableWidget/PrimaryButtonOfComapnies.dart';
import 'package:car_rental_project/Portal/Admin/Subscription/SubscriptionController.dart';
import 'package:car_rental_project/Resources/AppSizes.dart';
import 'package:car_rental_project/Resources/Colors.dart';
import 'package:car_rental_project/Resources/IconStrings.dart';
import 'package:car_rental_project/Resources/TextTheme.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

class AddSubscriptionWidget extends StatelessWidget {
  AddSubscriptionWidget({super.key});

  final controller = Get.put(SubscriptionController());

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isWeb = AppSizes.isWeb(context);
        final isTablet = AppSizes.isTablet(context);
        final isMobile = AppSizes.isMobile(context);
        bool isSingleColumn = constraints.maxWidth < 900;
        bool isDesktopOrTablet = (isWeb || isTablet) && !isSingleColumn;

        return SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Container(
            constraints: const BoxConstraints(
              maxWidth: 1050,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSectionCard(
                  context,
                  title: "General Information",
                  subtitle: "Enter basic detail here",
                  child: isDesktopOrTablet
                      ? Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(child: _buildUploadField(context, "Logo", "Upload Image")),
                          const SizedBox(width: 16),
                          Expanded(child: _buildAnimatedField(context, "Company Name", "Enter company name", controller.companyName)),
                          const SizedBox(width: 16),
                          Expanded(
                            child: _buildDropdownWrapper(
                              context, "Account Status", "acc_status_sub_drop",
                              controller.accountStatus, ["Active", "Pending", "Suspended", "Inactive"], isMobile,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(child: _buildAnimatedField(context, "Phone Number", "Enter Phone Number", controller.phoneNumber)),
                          const SizedBox(width: 16),
                          Expanded(child: _buildAnimatedField(context, "Email Address", "Enter Email", controller.emailAddress)),
                          const SizedBox(width: 16),
                          Expanded(child: _buildAnimatedField(context, "Address", "Enter Address", controller.adressController)),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(child: _buildAnimatedField(context, "License Number", "Enter License Number", controller.licenseNumber)),
                          const SizedBox(width: 16),
                          Expanded(child: _buildAnimatedField(context, "Registration Date", "Enter Registration Date", controller.registrationDate)),
                          const SizedBox(width: 16),
                          Expanded(child: _buildAnimatedField(context, "Tax Number", "Enter Tax Number", controller.taxNumber)),
                        ],
                      ),
                    ],
                  )
                      : Column(
                    children: [
                      _buildUploadField(context, "Logo", "Upload Image"),
                      const SizedBox(height: 16),
                      _buildAnimatedField(context, "Company Name", "Enter company name", controller.companyName),
                      const SizedBox(height: 16),
                      _buildDropdownWrapper(context, "Account Status", "acc_status_sub_drop", controller.accountStatus, ["Active", "Pending", "Suspended", "Inactive"], isMobile),
                      const SizedBox(height: 16),
                      _buildAnimatedField(context, "Phone Number", "Enter Phone Number", controller.phoneNumber),
                      const SizedBox(height: 16),
                      _buildAnimatedField(context, "Email Address", "Enter Email", controller.emailAddress),
                      const SizedBox(height: 16),
                      _buildAnimatedField(context, "Address", "Enter Address", controller.adressController),
                      const SizedBox(height: 16),
                      _buildAnimatedField(context, "License Number", "Enter License Number", controller.licenseNumber),
                      const SizedBox(height: 16),
                      _buildAnimatedField(context, "Registration Date", "Enter Registration Date", controller.registrationDate),
                      const SizedBox(height: 16),
                      _buildAnimatedField(context, "Tax Number", "Enter Tax Number", controller.taxNumber),
                    ],
                  ),
                ),

                const SizedBox(height: 20),
                _buildSectionCard(
                  context,
                  title: "Subscription Information",
                  subtitle: "Enter company subscription here",
                  child: isDesktopOrTablet
                      ? Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(child: _buildDropdownWrapper(context, "Plan", "plan_sub_drop", controller.selectedPlan, ["Monthly", "Yearly"], isMobile)),
                          const SizedBox(width: 16),
                          Expanded(child: _buildAnimatedField(context, "Registered cars", "Enter number of cars", controller.totalCars)),
                          const SizedBox(width: 16),
                          Expanded(child: _buildAnimatedField(context, "Monthly Fee per Car", "\$1234", controller.availableCars)),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(child: _buildAnimatedField(context, "Yearly Fee Per Car", "\$23456", controller.underMaintenance)),
                          const SizedBox(width: 16),
                          Expanded(
                            child: CompositedTransformTarget(
                              link: controller.startDateLink,
                              child: _buildDateFields(context, "Start Date", controller.startDateController,
                                      () => controller.toggleCalendar(context, controller.startDateLink, controller.startDateController)),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: CompositedTransformTarget(
                              link: controller.endDateLink,
                              child: _buildDateFields(context, "End Date", controller.endDateController,
                                      () => controller.toggleCalendar(context, controller.endDateLink, controller.endDateController)),
                            ),
                          ),
                        ],
                      ),
                    ],
                  )
                      : Column(
                    children: [
                      _buildDropdownWrapper(context, "Plan", "plan_sub_drop", controller.selectedPlan, ["Monthly", "Yearly"], isMobile),
                      const SizedBox(height: 16),
                      _buildAnimatedField(context, "Registered cars", "Enter number of cars", controller.totalCars),
                      const SizedBox(height: 16),
                      _buildAnimatedField(context, "Monthly Fee per Car", "\$1234", controller.availableCars),
                      const SizedBox(height: 16),
                      _buildAnimatedField(context, "Yearly Fee Per Car", "\$23456", controller.underMaintenance),
                      const SizedBox(height: 16),
                      CompositedTransformTarget(
                        link: controller.startDateLink,
                        child: _buildDateFields(context, "Start Date", controller.startDateController,
                                () => controller.toggleCalendar(context, controller.startDateLink, controller.startDateController)),
                      ),
                      const SizedBox(height: 16),
                      CompositedTransformTarget(
                        link: controller.endDateLink,
                        child: _buildDateFields(context, "End Date", controller.endDateController,
                                () => controller.toggleCalendar(context, controller.endDateLink, controller.endDateController)),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),
                Align(
                  alignment: isSingleColumn ? Alignment.center : Alignment.centerRight,
                  child: PrimaryBtnOfCompanies(
                    text: "Submit",
                    width: isSingleColumn ? double.infinity : 160,
                    onTap: () {
                      showUpdateConfirmationDialog(context);
                    },
                  ),
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        );
      },
    );
  }


   /// ----------- Extra Widget ----------- ///


   // Build Section Card
  Widget _buildSectionCard(BuildContext context, {required String title, required String subtitle, required Widget child}) {
    return Container(
      width: double.infinity,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.toolBackground),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: TTextTheme.h2Style(context).copyWith(fontSize: 16, fontWeight: FontWeight.bold), softWrap: true),
                const SizedBox(height: 2),
                Text(subtitle, style: TTextTheme.bodyRegular14(context).copyWith(color: Colors.grey), softWrap: true),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: child,
          ),
        ],
      ),
    );
  }
  Widget _buildAnimatedField(BuildContext context, String label, String hint, TextEditingController textController) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TTextTheme.tableRegular14black(context).copyWith(fontSize: 13)),
        const SizedBox(height: 6),
        Obx(() => Container(
          height: 44,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: AppColors.toolBackground),
            boxShadow: controller.focusedField.value == label
                ? [BoxShadow(color: AppColors.fieldsBackground.withOpacity(0.04), blurRadius: 10, offset: const Offset(0, 4))]
                : [],
          ),
          child: TextFormField(
            cursorColor: AppColors.blackColor,
            controller: textController,
            onTap: () => controller.setFocus(label),
            onFieldSubmitted: (_) => controller.clearFocus(),
            style: TTextTheme.titleinputTextField(context).copyWith(fontSize: 13),
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: TTextTheme.bodyRegular14(context).copyWith(color: Colors.grey.shade400),
              fillColor: Colors.white,
              filled: true,
              contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: AppColors.toolBackground)),
              enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: AppColors.toolBackground)),
              focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: AppColors.toolBackground)),
            ),
          ),
        )),
      ],
    );
  }
  Widget _buildDropdownWrapper(BuildContext context, String label, String id, RxString selectedValue, List<String> items, bool isMobile) {
    return LayoutBuilder(
        builder: (context, constraints) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: TTextTheme.tableRegular14black(context).copyWith(fontSize: 13)),
              const SizedBox(height: 6),
              _buildCustomPopupMenuDropdown(
                context,
                id: id,
                selectedValue: selectedValue,
                items: items,
                isMobile: isMobile,
                width: constraints.maxWidth,
                height: 44,
                controller: controller,
              ),
            ],
          );
        }
    );
  }
  Widget _buildCustomPopupMenuDropdown(BuildContext context, {
    required String id,
    required RxString selectedValue,
    required List<String> items,
    required bool isMobile,
    required double width,
    required double height,
    required SubscriptionController controller,
  }) {
    return Obx(() {
      bool isOpen = controller.openedDropdown2.value == id;
      return PopupMenuButton<String>(
        constraints: BoxConstraints(minWidth: width, maxWidth: width),
        offset: const Offset(0, 48),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        color: Colors.white,
        elevation: 8,
        padding: EdgeInsets.zero,
        onOpened: () => controller.openedDropdown2.value = id,
        onCanceled: () => controller.openedDropdown2.value = "",
        onSelected: (val) {
          selectedValue.value = val;
          controller.openedDropdown2.value = "";
        },
        child: Container(
          height: height,
          width: width,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: AppColors.toolBackground),
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  selectedValue.value,
                  style: TTextTheme.bodyRegular12black(context),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Icon(isOpen ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down, size: 18, color: AppColors.quadrantalTextColor),
            ],
          ),
        ),
        itemBuilder: (context) => items.map((e) => PopupMenuItem<String>(
          value: e,
          height: 40,
          child: SizedBox(
            width: width,
            child: Text(e, style: TTextTheme.bodyRegular12black(context)),
          ),
        )).toList(),
      );
    });
  }

   // Field
  Widget _buildUploadField(BuildContext context, String title, String hint) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: TTextTheme.tableRegular14black(context)),
        const SizedBox(height: 6),
        Obx(() {
          if (controller.selectedImages2.isEmpty) {
            return InkWell(
              onTap: () => controller.pickImage2(),
              child: Container(
                height: 44,
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: AppColors.toolBackground),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Image.asset(IconString.uploadedImageAdmin2, height: 18, width: 18),
                    const SizedBox(width: 8),
                    Text(hint, style: TTextTheme.bodyRegular12(context).copyWith(color: AppColors.tertiaryTextColor)),
                  ],
                ),
              ),
            );
          } else {
            final image = controller.selectedImages2.first;
            return Stack(
              children: [
                Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
                  child: kIsWeb
                      ? Image.memory(image.bytes!, height: 44, fit: BoxFit.contain)
                      : Image.file(File(image.path!), height: 44, fit: BoxFit.contain),
                ),
                Positioned(
                  top: -10,
                  right: -10,
                  child: IconButton(
                    onPressed: () => controller.removeImage2(0),
                    icon: const Icon(Icons.cancel, size: 18, color: AppColors.primaryColor),
                  ),
                ),
              ],
            );
          }
        }),
      ],
    );
  }

   // Date Fields
  Widget _buildDateFields(BuildContext context, String label, TextEditingController textController, VoidCallback onTap) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TTextTheme.tableRegular14black(context)),
        const SizedBox(height: 6),
        GestureDetector(
          onTap: onTap,
          child: AbsorbPointer(
            child: Container(
              height: 44,
              child: TextFormField(
                cursorColor: AppColors.blackColor,
                controller: textController,
                style: const TextStyle(fontSize: 13),
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  suffixIcon: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Image.asset(IconString.calendarIcon, color: AppColors.quadrantalTextColor, height: 16, width: 16),
                  ),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: AppColors.toolBackground)),
                  enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: AppColors.toolBackground)),
                  focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: AppColors.toolBackground)),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

   // Dialogs
  Widget _buildSaveButton(BuildContext context) {
    return OutlinedButton(
      onPressed: () {
        Navigator.pop(context);
        showSuccessSubscriptionDialog(context);
      },
      style: OutlinedButton.styleFrom(
        side: const BorderSide(color: AppColors.primaryColor),
        padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      child: Text(
        "Save",
        style: TTextTheme.btnSavePrimary(context),
      ),
    );
  }
  Widget _buildCancelButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () => Navigator.pop(context),
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primaryColor,
        foregroundColor: Colors.white,
        elevation: 0,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      child:  Text("Cancel", style: TTextTheme.btnSave(context)),
    );
  }

  void showUpdateConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext dialogContext) {
        return Dialog(
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          child: LayoutBuilder(
            builder: (context, constraints) {
              double availableWidth = constraints.maxWidth;
              bool isUltraSmall = availableWidth < 350;

              return Container(
                width: availableWidth < 500 ? availableWidth * 0.95 : 480,
                padding: const EdgeInsets.all(24),
                child: Stack(
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: AppColors.emojiBackground,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Text("🤨", style: TextStyle(fontSize: 24)),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 4),
                                  Text(
                                    "Save Subscription",
                                    style: TTextTheme.h2Style(dialogContext).copyWith(fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(height: 6),
                                  Text(
                                    "Are you sure you want to Save subscription",
                                    style: TTextTheme.bodyRegular14(dialogContext).copyWith(color: AppColors.tertiaryTextColor),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 32),
                          ],
                        ),
                        const SizedBox(height: 30),
                        if (isUltraSmall)
                          Column(
                            children: [
                              _buildCancelButton(dialogContext),
                              const SizedBox(height: 10),
                              _buildSaveButton(dialogContext),
                            ],
                          )
                        else
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              _buildCancelButton(dialogContext),
                              const SizedBox(width: 12),
                              _buildSaveButton(dialogContext),
                            ],
                          ),
                      ],
                    ),
                    Positioned(
                      right: 0,
                      top: 0,
                      child: IconButton(
                        onPressed: () => Navigator.pop(dialogContext),
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                        icon: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: AppColors.sideBoxesColor.withOpacity(0.5),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.close, size: 14, color: AppColors.blackColor),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }
  void showSuccessSubscriptionDialog(BuildContext context) {
    final router = GoRouter.of(context);

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext dialogContext) {
        Future.delayed(const Duration(seconds: 2), () {
          if (dialogContext.mounted) {
            Navigator.pop(dialogContext);
            router.go('/subscription');
          }
        });

        return Dialog(
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          child: LayoutBuilder(
            builder: (context, constraints) {
              double availableWidth = constraints.maxWidth;

              return Container(
                width: availableWidth < 500 ? availableWidth * 0.95 : 460,
                padding: const EdgeInsets.all(24),
                child: Stack(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: AppColors.emojiBackground,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Text("👍", style: TextStyle(fontSize: 24)),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const SizedBox(height: 4),
                              Text(
                                "Subscription Saved Successfully",
                                style: TTextTheme.h2Style(dialogContext).copyWith(fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                "Congratulation! your Company subscription fees has successfully saved in the System",
                                style: TTextTheme.bodyRegular14(dialogContext).copyWith(color: AppColors.tertiaryTextColor),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 32),
                      ],
                    ),
                    Positioned(
                      right: 0,
                      top: 0,
                      child: IconButton(
                        onPressed: () {
                          Navigator.pop(dialogContext);
                          router.go('/subscription');
                        },
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                        icon: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: AppColors.sideBoxesColor.withOpacity(0.5),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.close, size: 14, color: AppColors.blackColor),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }
}