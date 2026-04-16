import 'dart:io';
import 'package:car_rental_project/Portal/Admin/Companies/CompaniesController.dart';
import 'package:car_rental_project/Resources/AppSizes.dart';
import 'package:car_rental_project/Resources/Colors.dart';
import 'package:car_rental_project/Resources/IconStrings.dart';
import 'package:car_rental_project/Resources/TextString.dart';
import 'package:car_rental_project/Resources/TextTheme.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class AddCompanyWidget extends StatelessWidget {
  AddCompanyWidget({super.key});

  final controller = Get.put(CompaniesAdminController());

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isWeb = AppSizes.isWeb(context);
        final isTablet = AppSizes.isTablet(context);
        final isMobile = AppSizes.isMobile(context);
        bool isSingleColumn = MediaQuery.of(context).size.width < 850;
        bool isDesktopOrTablet = isWeb || isTablet;

        return Column(
          children: [
            _buildSectionCard(
              context,
              title: TextString.AddcompanyTitle1,
              subtitle:TextString.AddcompanyTitle1Subtitle ,
              child: isDesktopOrTablet
                  ? Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: _buildAnimatedField(
                            context,
                            TextString.AddtotalCar,
                          TextString.AddtotalCarSubtitle,
                            controller.totalCars),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: _buildAnimatedField(
                            context,
                            TextString.AddavailableCar,
                            TextString.AddavailableCarSubtitle,
                            controller.availableCars),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: _buildAnimatedField(
                            context,
                            TextString.AddmaintenanceCar,
                            TextString.AddmaintenanceCarSubtitle,
                            controller.underMaintenance),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: _buildAnimatedField(
                            context,
                           TextString.AddStaffCar,
                          TextString.AddStaffCarSubtitle,
                            controller.totalStaff),
                      ),
                      const SizedBox(width: 20),
                      const Expanded(child: SizedBox()),
                      const SizedBox(width: 20),
                      const Expanded(child: SizedBox()),
                    ],
                  ),
                ],
              )
                  : Wrap(
                spacing: 20,
                runSpacing: 20,
                children: [
                  _buildAnimatedField(
                      context,
                      TextString.AddtotalCar,
                      TextString.AddtotalCarSubtitle,
                      controller.totalCars),
                  _buildAnimatedField(
                      context,
                      TextString.AddavailableCar,
                      TextString.AddavailableCarSubtitle,
                      controller.availableCars),
                  _buildAnimatedField(
                      context,
                      TextString.AddmaintenanceCar,
                      TextString.AddmaintenanceCarSubtitle,
                      controller.underMaintenance),
                  _buildAnimatedField(
                      context,
                      TextString.AddStaffCar,
                      TextString.AddStaffCarSubtitle,
                      controller.totalStaff),
                ],
              ),
            ),

            const SizedBox(height: 24),

            _buildSectionCard(
              context,
              title: TextString.AddcompanyTitle2,
              subtitle: TextString.AddcompanyTitle2Subtitle,
              child: isDesktopOrTablet
                  ? Column(
                children: [
                  Row(
                    children: [
                      Expanded(child: _buildUploadField(context,TextString.Addlogo, TextString.AdduploadImage)),
                      const SizedBox(width: 20),
                      Expanded(child: _buildAnimatedField(context,TextString.AddcompanyName, TextString.AddcompanyNameSubtitle, controller.companyName)),
                      const SizedBox(width: 20),
                      Expanded(
                        child: _buildDropdownWrapper(
                          context, "Account Status", "acc_status_drop",
                          controller.accountStatus, ["Active", "Pending", "Suspended", "Inactive"], isMobile,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(child: _buildAnimatedField(context, TextString.AddPhoneNumber, TextString.AddPhoneNumberSubtitle, controller.phoneNumber)),
                      const SizedBox(width: 20),
                      Expanded(child: _buildAnimatedField(context,TextString.addcompanyEmailAdress, TextString.addcompanyEmailAdressSubtitle, controller.emailAddress)),
                      const SizedBox(width: 20),
                      Expanded(child: _buildAnimatedField(context,TextString.addcompanyAdress,TextString.addcompanyAdressSubtitle , controller.adressController)),
                    ],
                  ),

                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(child: _buildAnimatedField(context, TextString.addcompanyLicense,TextString.addcompanyLicenseSubtitle , controller.licenseNumber)),
                      const SizedBox(width: 20),
                      Expanded(child: _buildAnimatedField(context, TextString.addcompanyregistration,TextString.addcompanyregistrationSubtitle, controller.registrationDate)),
                      const SizedBox(width: 20),
                      Expanded(child: _buildAnimatedField(context, TextString.addcompanyTaxNo,TextString.addcompanyTaxNoSubtitle, controller.taxNumber)),
                    ],
                  ),
                ],
              )
                  : Wrap(
                spacing: 20,
                runSpacing: 20,
                children: [
                  _buildUploadField(context, TextString.Addlogo, TextString.AdduploadImage),
                  _buildAnimatedField(context,TextString.AddcompanyName, TextString.AddcompanyNameSubtitle, controller.companyName),
                  _buildDropdownWrapper(context, "Account Status", "acc_status_drop", controller.accountStatus, ["Active", "Pending", "Suspended", "Inactive"], isMobile),
                  _buildAnimatedField(context, TextString.AddPhoneNumber, TextString.AddPhoneNumberSubtitle, controller.phoneNumber),
                  _buildAnimatedField(context, TextString.addcompanyEmailAdress, TextString.addcompanyEmailAdressSubtitle, controller.emailAddress),
                  _buildAnimatedField(context, TextString.addcompanyAdress,TextString.addcompanyAdressSubtitle, controller.adressController),
                  _buildAnimatedField(context, TextString.addcompanyLicense,TextString.addcompanyLicenseSubtitle, controller.licenseNumber),
                  _buildAnimatedField(context, TextString.addcompanyregistration,TextString.addcompanyregistrationSubtitle, controller.registrationDate),
                  _buildAnimatedField(context,  TextString.addcompanyTaxNo,TextString.addcompanyTaxNoSubtitle, controller.taxNumber),
                ],
              ),
            ),

            const SizedBox(height: 25),

            _buildSectionCard(
              context,
              title: TextString.socialLinks,
              subtitle: TextString.socialLinksSubtitle,
              child: isDesktopOrTablet
                  ? Column(
                children: [
                  Row(
                    children: [
                      Expanded(child: _buildSocialField(context, TextString.faceBook, TextString.addLinks, IconString.facebookAdminIcon, controller.facebookLink)),
                      const SizedBox(width: 20),
                      Expanded(child: _buildSocialField(context, TextString.twitter, TextString.addLinks, IconString.xAdminIcon, controller.twitterLink)),
                      const SizedBox(width: 20),
                      Expanded(child: _buildSocialField(context,TextString.instgram, TextString.addLinks,  IconString.instaAdminIcon, controller.instagramLink)),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(child: _buildSocialField(context,TextString.linkedIn, TextString.addLinks,  IconString.linkedinAdminIcon, controller.linkedinLink)),
                      const SizedBox(width: 20),
                      Expanded(child: _buildSocialField(context, TextString.youtube, TextString.addLinks, IconString.youtubeAdminIcon, controller.youtubeLink)),
                      const SizedBox(width: 20),
                      const Expanded(child: SizedBox()),
                    ],
                  ),
                ],
              )
                  : Wrap(
                spacing: 20,
                runSpacing: 20,
                children: [
                  _buildSocialField(context, TextString.faceBook, TextString.addLinks, IconString.facebookAdminIcon, controller.facebookLink),
                  _buildSocialField(context, TextString.twitter, TextString.addLinks, IconString.xAdminIcon, controller.twitterLink),
                  _buildSocialField(context, TextString.instgram, TextString.addLinks, IconString.instaAdminIcon, controller.instagramLink),
                  _buildSocialField(context, TextString.linkedIn, TextString.addLinks, IconString.linkedinAdminIcon, controller.linkedinLink),
                  _buildSocialField(context, TextString.youtube,TextString.addLinks, IconString.youtubeAdminIcon, controller.youtubeLink),
                ],
              ),
            ),

            const SizedBox(height: 24),



            _buildSectionCard(
              context,
              title: TextString.AddcompanyTitle3,
              subtitle: TextString.AddcompanyTitle3Subtitle,
              action: SizedBox(
                height: 40,
                width: 100,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor:AppColors.primaryColor,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    padding: EdgeInsets.zero,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(12),
                        bottomLeft: Radius.circular(12),
                      ),
                    ),
                  ),
                  child:  Text(
                    "Submit",
                    style: TTextTheme.btnWhiteColor(context),
                  ),
                ),
              ),
              child: Column(
                children: [
                  if (!isSingleColumn)
                    Row(
                      children: [
                        Expanded(child: _buildDropdownWrapper(context, TextString.plan, "plan_drop", controller.selectedPlan, ["Monthly", "Yearly"], false)),
                        const SizedBox(width: 20),
                        Expanded(child: _buildDropdownWrapper(context, TextString.planStatus, "status_drop", controller.selectedPlanStatus, ["Demo", "Subscribed", "Overdue", "Cancelled"], false)),
                        const SizedBox(width: 20),
                        Expanded(
                          child: CompositedTransformTarget(
                            link: controller.startDateLink,
                            child: _buildDateFields(context, TextString.startingDate, controller.startDateController,
                                    () => controller.toggleCalendar(context, controller.startDateLink, controller.startDateController)),
                          ),
                        ),
                      ],
                    )
                  else
                    Column(
                      children: [
                        _buildDropdownWrapper(context, TextString.plan, "plan_drop", controller.selectedPlan, ["Monthly", "Yearly"], true),
                        const SizedBox(height: 20),
                        _buildDropdownWrapper(context, TextString.planStatus, "status_drop", controller.selectedPlanStatus, ["Demo", "Subscribed", "Overdue", "Cancelled"], true),
                        const SizedBox(height: 20),
                        CompositedTransformTarget(
                          link: controller.startDateLink,
                          child: _buildDateFields(context, TextString.startingDate, controller.startDateController,
                                  () => controller.toggleCalendar(context, controller.startDateLink, controller.startDateController)),
                        ),
                      ],
                    ),

                  const SizedBox(height: 20),

                  if (!isSingleColumn)
                    Row(
                      children: [
                        Expanded(
                          child: CompositedTransformTarget(
                            link: controller.endDateLink,
                            child: _buildDateFields(context, TextString.endingDate, controller.endDateController,
                                    () => controller.toggleCalendar(context, controller.endDateLink, controller.endDateController)),
                          ),
                        ),
                        const SizedBox(width: 20),
                        const Expanded(child: SizedBox()),
                        const SizedBox(width: 20),
                        const Expanded(child: SizedBox()),
                      ],
                    )
                  else
                    CompositedTransformTarget(
                      link: controller.endDateLink,
                      child: _buildDateFields(context,TextString.endingDate, controller.endDateController,
                              () => controller.toggleCalendar(context, controller.endDateLink, controller.endDateController)),
                    ),
                ],
              ),
            ),

            const SizedBox(height: 240),

          ],
        );
      },
    );
  }

  /// ------------ Extra Widget -------- ///

   // Custom Dropdown
  Widget _buildCustomPopupMenuDropdown(BuildContext context, {
    required String id,
    required RxString selectedValue,
    required List<String> items,
    required bool isMobile,
    required double width,
    required double height,
    required CompaniesAdminController controller,
    void Function(String)? onChanged,
  }) {
    return Obx(() {
      bool isOpen = controller.openedDropdown2.value == id;
      return PopupMenuButton<String>(
        constraints: BoxConstraints(
          minWidth: width,
          maxWidth: width,
        ),
        offset: const Offset(0, 52),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        color: Colors.white,
        elevation: 8,
        padding: EdgeInsets.zero,
        onOpened: () => controller.openedDropdown2.value = id,
        onCanceled: () => controller.openedDropdown2.value = "",
        onSelected: (val) {
          selectedValue.value = val;
          controller.openedDropdown2.value = "";
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
                  selectedValue.value,
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
            child: Text(
              e,
              style: TTextTheme.bodyRegular14(context)
            ),
          ),
        )).toList(),
      );
    });
  }

   // Animated Field
  Widget _buildAnimatedField(BuildContext context, String label, String hint, TextEditingController textController) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TTextTheme.tableRegular14black(context)),
        const SizedBox(height: 8),
        Obx(() => Container(
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
            style: TTextTheme.titleinputTextField(context),
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: TTextTheme.bodyRegular16(context),
              fillColor: Colors.white,
              filled: true,
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: AppColors.toolBackground)),
              enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: AppColors.toolBackground)),
              focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: AppColors.toolBackground)),
            ),
          ),
        )),
      ],
    );
  }

   // DropdownWrapper
  Widget _buildDropdownWrapper(BuildContext context, String label, String id, RxString selectedValue, List<String> items, bool isMobile) {
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

   // upload Fields
  Widget _buildUploadField(BuildContext context, String title, String hint) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: TTextTheme.tableRegular14black(context)),
        const SizedBox(height: 12),

        Obx(() {
          if (controller.selectedImages2.isEmpty) {
            return InkWell(
              onTap: () => controller.pickImage2(),
              child: Container(
                height: 48,
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: AppColors.toolBackground),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Image.asset(IconString.uploadedImageAdmin2,),
                    const SizedBox(width: 10),
                    Text(hint, style: TTextTheme.bodyRegular16black(context)),
                  ],
                ),
              ),
            );
          }
          else {
            final image = controller.selectedImages2.first;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: kIsWeb
                          ? Image.memory(image.bytes!, height: 60, fit: BoxFit.contain)
                          : Image.file(File(image.path!), height: 60, fit: BoxFit.contain),
                    ),
                    Positioned(
                      top: -10,
                      right: -10,
                      child: IconButton(
                        onPressed: () => controller.removeImage2(0),
                        icon: const Icon(Icons.cancel, size: 20, color: AppColors.primaryColor),
                      ),
                    ),
                  ],
                ),
              ],
            );
          }
        }),
      ],
    );
  }
   // Section Card
  Widget _buildSectionCard(BuildContext context, {
    required String title,
    required String subtitle,
    required Widget child,
    Widget? action,
  }) {
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 24, left: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: TTextTheme.h2Style(context)),
                    Text(subtitle, style: TTextTheme.bodyRegular16(context)),
                  ],
                ),
              ),
              if (action != null) action,
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(24),
            child: child,
          ),
        ],
      ),
    );
  }

   // Social Fields
  Widget _buildSocialField(BuildContext context, String label, String hint, String assetPath, TextEditingController textController) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TTextTheme.tableRegular14black(context)),
        const SizedBox(height: 8),
        TextFormField(
          cursorColor: AppColors.blackColor,
          controller: textController,
          style: TTextTheme.titleinputTextField(context),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TTextTheme.bodyRegular16(context),
            fillColor: Colors.white,
            filled: true,
            prefixIcon: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Image.asset(assetPath, width: 20, height: 20),
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: AppColors.toolBackground)),
            enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: AppColors.toolBackground)),
            focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: AppColors.toolBackground)),
          ),
        ),
      ],
    );
  }
   // Date Fields
  Widget _buildDateFields(BuildContext context, String label, TextEditingController textController, VoidCallback onTap) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style:TTextTheme.tableRegular14black(context)),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: onTap,
          child: AbsorbPointer(
            child: TextFormField(
              cursorColor: AppColors.blackColor,
              controller: textController,
              style: const TextStyle(fontSize: 14),
              decoration: InputDecoration(
                fillColor: Colors.white,
                filled: true,
                suffixIcon: Image.asset(IconString.calendarIcon, color: AppColors.quadrantalTextColor),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: AppColors.toolBackground)),
                enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: AppColors.toolBackground)),
                focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: AppColors.toolBackground)),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
