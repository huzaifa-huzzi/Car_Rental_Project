import 'package:car_rental_project/Portal/Vendor/Staff/ReusableWidgetOfStaff/CustomButtonOfStaff.dart';
import 'package:car_rental_project/Portal/Vendor/Staff/ReusableWidgetOfStaff/PrimaryBtnStaff.dart';
import 'package:car_rental_project/Portal/Vendor/Staff/StaffController.dart';
import 'package:car_rental_project/Resources/IconStrings.dart';
import 'package:car_rental_project/Resources/TextString.dart';
import 'package:car_rental_project/Resources/TextTheme.dart';
import 'package:country_picker/country_picker.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:car_rental_project/Resources/AppSizes.dart';
import 'package:car_rental_project/Resources/Colors.dart';

class EditStaffScreenWidget extends StatelessWidget {
  const EditStaffScreenWidget({super.key});

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
              child: Text(TextString.addStaffHeaderTitleEdit, style: TTextTheme.h6Style(context)),
            ),
            const Divider(height: 1, thickness: 0.5, color: AppColors.quadrantalTextColor),

            // Staff Name
            _buildSection(context, icon: IconString.staffNameICon, title: TextString.addStaffNameEdit, subtitle: TextString.addStaffNameSubtitleEdit,
                children: [
                  _buildTextField(TextString.addStaffNameFieldOneEdit, "Write Staff Name...", controller.firstNameCEdit, context),
                  _buildTextField(TextString.addStaffNameFieldTwoEdit, "Write Staff Name...", controller.lastNameCEdit, context),
                ]),
            const Divider(height: 1, thickness: 0.5, color: AppColors.quadrantalTextColor),

            // Staff Details
            _buildSection(context,
                icon: IconString.staffContactIcon,
                title: TextString.addStaffContact,
                subtitle: TextString.addStaffContactSubtitle,
                children: [
                  LayoutBuilder(builder: (context, constraints) {
                    if (constraints.maxWidth > 600) {
                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: _buildTextField(TextString.addStaffContactFieldOne, "Write Staff Email...", controller.emailC, context),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: _buildPhoneField(context, "Write Staff Number ...."),
                          ),
                        ],
                      );
                    } else {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildTextField(TextString.addStaffContactFieldOne, "Write Staff Email...", controller.emailC, context),
                          const SizedBox(height: 16),
                          _buildPhoneField(context, "Contact Number ...."),
                        ],
                      );
                    }
                  }),
                ]),
            const Divider(height: 1, thickness: 0.5, color: AppColors.quadrantalTextColor),

            // Staff Positions
            _buildSection(context, icon: IconString.staffDetailIcon, title: TextString.addStaffDetailEdit, subtitle: TextString.addStaffDetailSubtitleEdit,
                children: [
                  _buildTextField(TextString.addStaffDetailFieldOneEdit, "Write Staff Role Name...", controller.positionCEdit, context),
                  SizedBox(
                    width: 300,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(TextString.addStaffDetailFieldStatusEdit, style: TTextTheme.staffUpsideField(context)),
                        const SizedBox(height: 8),
                        _statusDropdownBox(controller.statusItems, controller.selectedStatusEdit, context),
                      ],
                    ),
                  ),
                ]),
            const Divider(height: 1, thickness: 0.5, color: AppColors.quadrantalTextColor),

            // Staff Access
            _buildSection(context, icon: IconString.staffAccessIcon, title: TextString.addStaffAccessEdit, subtitle: TextString.addStaffAccessSubtitleEdit,
                children: [
                  _buildAccessPermissions(controller, context),
                ]),

            // Buttons
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
                        text: "Update Staff",
                        width: isStacked ? double.infinity : 200,
                        height: 45,
                        onTap: () => controller.submitDataEdit(context),
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

    /// ---------- Extra Widgets
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
                  bool hasError = staffController.textFieldErrorsEdit.containsKey(errorKey);
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: hasError ? AppColors.primaryColor : Colors.transparent,
                            width: 1.5,
                          ),
                          boxShadow: isFocused && !hasError
                              ? [BoxShadow(color: AppColors.fieldsBackground, blurRadius: 10, offset: const Offset(0, 4))]
                              : [],
                        ),
                        child: TextField(
                          cursorColor: AppColors.blackColor,
                          controller: controller,
                          style: TTextTheme.insidetextfieldWrittenText(context),
                          onChanged: (v) { if (hasError) staffController.textFieldErrorsEdit.remove(errorKey); },
                          onTapOutside: (event) => FocusScope.of(context).unfocus(),
                          decoration: InputDecoration(
                            hintText: hint,
                            filled: true,
                            fillColor: AppColors.secondaryColor,
                            hintStyle: TTextTheme.insidetextfieldWrittenText(context),
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide.none),
                            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                          ),
                        ),
                      ),
                      if (hasError)
                        Padding(
                          padding: const EdgeInsets.only(top: 4, left: 4),
                          child: Text(staffController.textFieldErrorsEdit[errorKey]!, style: TTextTheme.ErrorStyle(context)),
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

  // Status Dropdown
  Widget _statusDropdownBox(List<String> items, RxString selectedRx, BuildContext context) {
    final controller = Get.find<StaffController>();

    return Obx(() {
      bool hasError = controller.statusErrorEdit.value.isNotEmpty;
      String currentSelection = selectedRx.value;

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
                onSelected: (v) {
                  selectedRx.value = v;
                  controller.statusErrorEdit.value = "";
                },
                itemBuilder: (context) {
                  return items.map((String item) {
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
                          if (items.indexOf(item) != items.length - 1)
                            Divider(height: 1, thickness: 0.5, color: AppColors.quadrantalTextColor),
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
                      currentSelection.isEmpty
                          ? Text("Select Status", style: TTextTheme.insidetextfieldWrittenText(context))
                          : Container(
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                        decoration: BoxDecoration(
                          color: _getStatusBgColor(currentSelection),
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(color: AppColors.sideBoxesColor),
                        ),
                        child: Text(
                          currentSelection,
                          style: TextStyle(
                              color: _getStatusTextColor(currentSelection),
                              fontSize: 12
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
                  controller.statusErrorEdit.value,
                  style: TTextTheme.ErrorStyle(context)
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

  // Access Permission
  Widget _buildAccessPermissions(StaffController controller, BuildContext context) {
    List<String> options = ["Car Inventory", "Customers", "Pickup Car", "Dropoff Car"];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(TextString.addStaffAcessPermissionEdit, style: TTextTheme.staffUpsideField(context)),
        const SizedBox(height: 12),
        Obx(() {
          bool hasError = controller.permissionsErrorEdit.value.isNotEmpty;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: hasError ? AppColors.primaryColor : Colors.transparent, width: 1.5),
                ),
                child: Column(
                  children: options.map((opt) => Padding(
                    padding: const EdgeInsets.only(bottom: 12.0),
                    child: Row(
                      children: [
                        Checkbox(
                          value: controller.permissionsEdit.contains(opt),
                          activeColor: AppColors.primaryColor,
                          onChanged: (v) => controller.togglePermissionEdit(opt),
                        ),
                        const SizedBox(width: 8),
                        PrimaryBtnStaff(
                          text: opt,
                          onTap: () => controller.togglePermissionEdit(opt),
                          height: 35,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ],
                    ),
                  )).toList(),
                ),
              ),
              if (hasError)
                Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Text(controller.permissionsErrorEdit.value, style: TTextTheme.ErrorStyle(context)),
                ),
            ],
          );
        }),
      ],
    );
  }


   // Phone Fields
  Widget _buildPhoneField(BuildContext context, String label) {
    final controller = Get.find<StaffController>();
    final List<Country> countryList = CountryService().getAll();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(label, style: TTextTheme.titleTwo(context)),
        const SizedBox(height: 6),
        Obx(() => TextFormField(
          controller: controller.phoneControllerEdit,
          keyboardType: TextInputType.phone,
          style: TTextTheme.insidetextfieldWrittenText(context),
          cursorColor: AppColors.blackColor,
          decoration: InputDecoration(
            errorText: controller.textFieldErrorsEdit['Phone'],
            filled: true,
            fillColor: AppColors.secondaryColor,
            hintText: "Enter number",
            hintStyle: TTextTheme.titleTwo(context),
            prefixIcon: Padding(
              padding: const EdgeInsets.only(left: 4),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  DropdownButtonHideUnderline(
                    child: DropdownButton2<Country>(
                      isExpanded: false,
                      value: countryList.firstWhere(
                            (c) => c.name == controller.selectedCountryNameEdit.value,
                        orElse: () => countryList.firstWhere((c) => c.name == "Australia"),
                      ),
                      selectedItemBuilder: (context) {
                        return countryList.map((Country country) {
                          return Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const SizedBox(width: 8),
                              _buildCircleFlag(country.countryCode),
                              const SizedBox(width: 10),
                              Text("+${country.phoneCode}",
                                  style: TTextTheme.bodyRegular14(context)
                                      .copyWith(color: AppColors.blackColor)),
                            ],
                          );
                        }).toList();
                      },
                      items: countryList.map((Country country) {
                        return DropdownMenuItem<Country>(
                          value: country,
                          child: Row(
                            children: [
                              _buildCircleFlag(country.countryCode),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Text(country.name,
                                    style: const TextStyle(fontSize: 13),
                                    overflow: TextOverflow.ellipsis),
                              ),
                              Text("+${country.phoneCode}",
                                  style: TTextTheme.titleinputTextField(context)),
                            ],
                          ),
                        );
                      }).toList(),
                      onChanged: (Country? value) {
                        if (value != null) {
                          controller.selectedCountryNameEdit.value = value.name;
                          controller.selectedCode2.value = "+${value.phoneCode}";
                        }
                      },
                      buttonStyleData: const ButtonStyleData(
                        height: 48,
                        padding: EdgeInsets.symmetric(horizontal: 4),
                      ),
                      iconStyleData: const IconStyleData(
                        icon: Icon(Icons.keyboard_arrow_down_rounded,
                            size: 20, color: Colors.black54),
                      ),
                      dropdownStyleData: DropdownStyleData(
                        maxHeight: 350,
                        width: 250,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.white),
                        offset: const Offset(0, -5),
                      ),
                      dropdownSearchData: DropdownSearchData(
                        searchController: controller.searchController2,
                        searchInnerWidgetHeight: 50,
                        searchInnerWidget: _buildSearchField(
                            context, controller.searchController2),
                        searchMatchFn: (item, searchValue) {
                          return item.value!.name
                              .toLowerCase()
                              .contains(searchValue.toLowerCase()) ||
                              item.value!.phoneCode.contains(searchValue);
                        },
                      ),
                    ),
                  ),
                  Container(height: 24, width: 1, color: Colors.grey.withOpacity(0.3)),
                  const SizedBox(width: 8),
                ],
              ),
            ),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: AppColors.primaryColor, width: 1),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: AppColors.primaryColor, width: 1.5),
            ),
            errorStyle: const TextStyle(color: AppColors.primaryColor, fontSize: 12),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          ),
        )),
      ],
    );
  }
  Widget _buildSearchField(BuildContext context, TextEditingController searchController) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: TextFormField(
        cursorColor: AppColors.blackColor,
        controller: searchController,
        style: TTextTheme.textFieldWrittenText(context),
        decoration: InputDecoration(
          isDense: true,
          fillColor: AppColors.backgroundOfScreenColor,
          filled: true,
          hintText: 'Search',
          hintStyle: TTextTheme.titleTwo(context),
          prefixIcon: const Icon(Icons.search, size: 18, color: AppColors.primaryColor),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(color: AppColors.primaryColor),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(color: AppColors.primaryColor),
          ),
        ),
      ),
    );
  }
  Widget _buildCircleFlag(String code) {
    return Container(
      width: 24,
      height: 24,
      decoration: const BoxDecoration(shape: BoxShape.circle),
      child: ClipOval(
        child: Image.network(
          'https://flagcdn.com/w80/${code.toLowerCase()}.png',
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) => const Icon(Icons.flag, size: 14),
        ),
      ),
    );
  }

}