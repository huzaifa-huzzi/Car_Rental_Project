import 'package:car_rental_project/Portal/Staff/Setting/ReusableWidget/PrimaryBtnOfStaffSettings.dart';
import 'package:car_rental_project/Portal/Staff/Setting/SettingStaffController.dart';
import 'package:car_rental_project/Resources/Colors.dart';
import 'package:car_rental_project/Resources/IconStrings.dart';
import 'package:car_rental_project/Resources/TextString.dart';
import 'package:car_rental_project/Resources/TextTheme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class PersonalInfoWidget extends StatelessWidget {
  const PersonalInfoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<SettingStaffController>();
    double screenWidth = MediaQuery.of(context).size.width;

    bool isMobile = screenWidth < 650;
    double containerWidth = screenWidth > 1200 ? 1000 : 800;

    return Center(
      child: Container(
        constraints: BoxConstraints(maxWidth: containerWidth),
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Obx(() => Wrap(
                spacing: 20,
                runSpacing: 15,
                alignment: WrapAlignment.spaceBetween,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        TextString.personalInfoTitle,
                        style: TTextTheme.UploadText(context),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        TextString.personalInfoSubtitle,
                        style: TTextTheme.bodyRegular14Search(context),
                      ),
                    ],
                  ),
                  if (controller.selectedSubTabIndex.value == 0)
                    controller.isEditing.value
                        ? Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        PrimaryBtnOfStaffSettings(
                          text: "Back",
                          width: 100,
                          onTap: () => controller.toggleEdit(false),
                        ),
                        const SizedBox(width: 10),
                        PrimaryBtnOfStaffSettings(
                          text: "Save Info",
                          width: 120,
                          onTap: () => controller.toggleEdit(false),
                        ),
                      ],
                    )
                        : PrimaryBtnOfStaffSettings(
                      text: "Edit Info",
                      width: isMobile ? 200 : 160,
                      onTap: () => controller.toggleEdit(true),
                      icon: Image.asset(IconString.SettingsEditIcon, color: Colors.white),
                      isIconLeft: true,
                    ),
                ],
              )),
            ),

            const SizedBox(height: 25),

            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: AppColors.signaturePadColor,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: AppColors.quadrantalTextColor, width: 0.4),
                ),
                child: Obx(() => Row(
                  children: [
                    _buildSubTab(context, "General", 0, controller),
                    const SizedBox(width: 8),
                    _buildSubTab(context, "Employment Details", 1, controller),
                  ],
                )),
              ),
            ),

            const SizedBox(height: 25),

            Obx(() => controller.selectedSubTabIndex.value == 0
                ? _buildGeneralInfoForm(context, controller)
                : _buildEmploymentInfoForm(context, controller)),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  /// ---------- Extra Widgets ---------///

   // General Form
  Widget _buildGeneralInfoForm(BuildContext context, SettingStaffController controller) {
    bool isMobile = MediaQuery.of(context).size.width < 650;

    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(TextString.generalPersonal, style: TTextTheme.hSettingsgeneral(context)),
          Text(TextString.generalPersonalSubtitle, style: TTextTheme.loginDividerText(context)),
          const SizedBox(height: 40),
          _buildResponsiveGridWithPickers(context, controller, isMobile),

          const SizedBox(height: 24),
          _buildAnimatedField(
              context, TextString.generalPersonal7, "123 Hay Street", controller,
              isFullWidth: true,
              isEnabled: controller.isEditing.value
          ),
        ],
      ),
    );
  }

  // Responsiveness Geids
  Widget _buildResponsiveGridWithPickers(BuildContext context, SettingStaffController controller, bool isMobile) {

    List<Widget> children = [
      _buildAnimatedField(context, TextString.generalPersonal1, "Jhon Doe", controller, isEnabled: controller.isEditing.value),
      _buildAnimatedField(context, TextString.generalPersonal2, "Doe Watson", controller, isEnabled: controller.isEditing.value),
      controller.isEditing.value
          ? _buildDateField(context, TextString.generalPersonal3, controller)
          : _buildAnimatedField(context, TextString.generalPersonal3, controller.dobTextController.text.isEmpty ? "15/04/1992" : controller.dobTextController.text, controller, isEnabled: false),
      controller.isEditing.value
          ? _buildDropdownWrapper(context, TextString.generalPersonal4, "gender_drop", controller.selectedGender, ["Male", "Female", "Others"], isMobile, controller)
          : _buildAnimatedField(
          context,
          TextString.generalPersonal4,
          controller.selectedGender.value ?? "Male",
          controller,
          isEnabled: false
      ),

      _buildAnimatedField(context, TextString.generalPersonal5, "jhon@gmail.com", controller, isEnabled: controller.isEditing.value),
      _buildAnimatedField(context, TextString.generalPersonal6, "+61 430 042 030", controller, isEnabled: controller.isEditing.value),
    ];

    if (isMobile) {
      return Column(
        children: children.expand((w) => [w, const SizedBox(height: 20)]).toList(),
      );
    } else {
      List<Widget> rows = [];
      for (int i = 0; i < children.length; i += 2) {
        rows.add(
          Row(
            children: [
              Expanded(child: children[i]),
              const SizedBox(width: 24),
              Expanded(child: i + 1 < children.length ? children[i+1] : const SizedBox()),
            ],
          ),
        );
        rows.add(const SizedBox(height: 20));
      }
      return Column(children: rows);
    }
  }

 // Calendar Picker Field
  Widget _buildDateField(BuildContext context, String label, SettingStaffController controller) {
    return CompositedTransformTarget(
      link: controller.dobLink,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: TTextTheme.tableRegular14black(context)),
          const SizedBox(height: 8),
          GestureDetector(
            onTap: () => controller.toggleCalendar(context, controller.dobLink, controller.dobTextController),
            child: AbsorbPointer(
              child: TextFormField(
                controller: controller.dobTextController,
                style: TTextTheme.titleinputTextField(context),
                decoration: InputDecoration(
                  hintText: "Select date of birth",
                  hintStyle: TTextTheme.bodyRegular16(context),
                  suffixIcon: Image.asset(IconString.calendarIcon, height: 20,width: 20, color: AppColors.quadrantalTextColor),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: AppColors.toolBackground)),
                  enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: AppColors.toolBackground)),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  //Employment Form
  Widget _buildEmploymentInfoForm(BuildContext context, SettingStaffController controller) {
    bool isMobile = MediaQuery.of(context).size.width < 650;

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(TextString.employmentPersonal, style: TTextTheme.hSettingsgeneral(context)),
          Text(TextString.employmentPersonalSubtitle, style: TTextTheme.loginDividerText(context)),
          const SizedBox(height: 30),
          _buildResponsiveGrid(context, controller, [
            [TextString.employmentPersonal1, "Jhon Doe"],
            [TextString.employmentPersonal2, "Rental Agent"],
            [TextString.employmentPersonal3, "Jaden Smith"],
            [TextString.employmentPersonal4, "15/04/2025"],
          ], isMobile, isEnabled: false),
          const SizedBox(height: 20),
          _buildAnimatedField(
              context, TextString.employmentPersonal5, "123 Hay Street", controller,
              isFullWidth: true,
              isEnabled: false
          ),
        ],
      ),
    );
  }

  // Responsive Grids
  Widget _buildResponsiveGrid(BuildContext context, SettingStaffController controller, List<List<String>> fields, bool isMobile, {bool isEnabled = true}) {
    List<Widget> rows = [];
    if (isMobile) {
      for (var field in fields) {
        rows.add(_buildAnimatedField(context, field[0], field[1], controller, isEnabled: isEnabled));
        rows.add(const SizedBox(height: 20));
      }
    } else {
      for (int i = 0; i < fields.length; i += 2) {
        rows.add(
          Row(
            children: [
              Expanded(child: _buildAnimatedField(context, fields[i][0], fields[i][1], controller, isEnabled: isEnabled)),
              const SizedBox(width: 24),
              if (i + 1 < fields.length)
                Expanded(child: _buildAnimatedField(context, fields[i + 1][0], fields[i + 1][1], controller, isEnabled: isEnabled))
              else
                const Expanded(child: SizedBox()),
            ],
          ),
        );
        rows.add(const SizedBox(height: 20));
      }
    }
    return Column(children: rows);
  }

  // Animated Fields
  Widget _buildAnimatedField(BuildContext context, String label, String hint,
      SettingStaffController controller,
      {bool isFullWidth = false, bool isEnabled = true}) {
    Widget field = TextFormField(
      enabled: isEnabled,
      cursorColor: AppColors.blackColor,
      initialValue: hint,
      onTap: isEnabled ? () => controller.setFocus(label) : null,
      onFieldSubmitted: (_) => controller.clearFocus(),
      onTapOutside: (_) => controller.clearFocus(),
      style: TTextTheme.titleinputTextField(context),
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        hintStyle: TTextTheme.bodyRegular16(context),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: AppColors.toolBackground)),
        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: AppColors.toolBackground)),
        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: AppColors.toolBackground)),
        disabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: AppColors.toolBackground)),
      ),
    );

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TTextTheme.tableRegular14black(context)),
        const SizedBox(height: 8),
        // AGAR Enabled hai to Obx chalaye (Shadow ke liye), warna simple Container
        isEnabled
            ? Obx(() => Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            boxShadow: controller.focusedField.value == label
                ? [BoxShadow(color: AppColors.fieldsBackground.withOpacity(0.06), blurRadius: 10, offset: const Offset(0, 4))]
                : [],
          ),
          child: field,
        ))
            : Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
          child: field,
        ),
      ],
    );
  }

   // Dropdown Wrapper
  Widget _buildDropdownWrapper(BuildContext context, String label, String id, RxString selectedValue, List<String> items, bool isMobile, SettingStaffController controller) {
    return LayoutBuilder(
        builder: (context, constraints) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: TTextTheme.tableRegular14black(context)),
              const SizedBox(height: 8),
              _buildCustomPopupMenuDropdown(
                context,
                id: id,
                selectedValue: selectedValue,
                items: items,
                isMobile: isMobile,
                width: constraints.maxWidth,
                height: 48,
                controller: controller,
              ),
            ],
          );
        }
    );
  }

  //  Custom Popup Menu Dropdown
  Widget _buildCustomPopupMenuDropdown(BuildContext context, {
    required String id,
    required RxString selectedValue,
    required List<String> items,
    required bool isMobile,
    required double width,
    required double height,
    required SettingStaffController controller,
    void Function(String)? onChanged,
  }) {
    return Obx(() {
      final openedDrop = controller.openedDropdown2?.value ?? "";
      bool isOpen = openedDrop == id;

      return PopupMenuButton<String>(
        constraints: BoxConstraints(minWidth: width, maxWidth: width),
        offset: const Offset(0, 52),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        color: Colors.white,
        elevation: 8,
        padding: EdgeInsets.zero,
        onOpened: () {
          if (controller.openedDropdown2 != null) {
            controller.openedDropdown2.value = id;
          }
        },
        onCanceled: () {
          if (controller.openedDropdown2 != null) {
            controller.openedDropdown2.value = "";
          }
        },
        onSelected: (val) {
          selectedValue.value = val;
          if (controller.openedDropdown2 != null) {
            controller.openedDropdown2.value = "";
          }
          if (onChanged != null) onChanged(val);
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
                  selectedValue.value ?? "Select",
                  style: TTextTheme.bodyRegular14(context),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Icon(
                isOpen ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                size: 20,
                color: AppColors.quadrantalTextColor,
              ),
            ],
          ),
        ),
        itemBuilder: (context) => items.map((e) => PopupMenuItem<String>(
          value: e,
          height: 45,
          child: SizedBox(
            width: width,
            child: Text(e, style: TTextTheme.bodyRegular14(context)),
          ),
        )).toList(),
      );
    });
  }
   // Sub tabs
  Widget _buildSubTab(BuildContext context, String title, int index, SettingStaffController controller) {
    bool isActive = controller.selectedSubTabIndex.value == index;
    return GestureDetector(
      onTap: () {
        controller.changeSubTab(index);
        controller.toggleEdit(false);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: isActive ? AppColors.primaryColor : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          title,
          style: isActive ? TTextTheme.bodyRegular14TabsSelected(context) : TTextTheme.bodyRegular14(context),
        ),
      ),
    );
  }
}