import 'package:car_rental_project/Portal/Staff/Setting/ReusableWidget/PrimaryBtnOfStaffSettings.dart';
import 'package:car_rental_project/Portal/Staff/Setting/SettingStaffController.dart';
import 'package:car_rental_project/Resources/Colors.dart' show AppColors;
import 'package:car_rental_project/Resources/IconStrings.dart';
import 'package:car_rental_project/Resources/TextString.dart';
import 'package:car_rental_project/Resources/TextTheme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class CompanyInfoWidget extends StatelessWidget {
  const CompanyInfoWidget({super.key});

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
              child: Wrap(
                spacing: 20,
                runSpacing: 15,
                alignment: WrapAlignment.spaceBetween,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: AppColors.secondaryColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Image.asset(
                            IconString.companyProfileSettings,
                            width: 24,
                            color: AppColors.quadrantalTextColor
                        ),
                      ),
                      const SizedBox(width: 15),
                      Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                             TextString.CompanyProfileTitle,
                              style: TTextTheme.UploadText(context),
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              TextString.companyProfileSubtitle,
                              style: TTextTheme.bodyRegular14Search(context),
                              softWrap: true,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  PrimaryBtnOfStaffSettings(
                    text: "Edit Info",
                    width: isMobile ? 200 : 160,
                    onTap: () {},
                    icon: Image.asset(
                        IconString.SettingsEditIcon,
                        color: Colors.white,
                        width: 20
                    ),
                    isIconLeft: true,
                  ),
                ],
              ),
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
                    _buildSubTab(context, "Address", 1, controller),
                  ],
                )),
              ),
            ),

            const SizedBox(height: 25),

            Obx(() => controller.selectedSubTabIndex.value == 0
                ? _buildCompanyGeneralForm(context, controller)
                : _buildCompanyAddressForm(context, controller)),
          ],
        ),
      ),
    );
  }

  /// ------------ Extra Widgets ------

  // General Information
  Widget _buildCompanyGeneralForm(BuildContext context, SettingStaffController controller) {
    bool isMobile = MediaQuery.of(context).size.width < 650;
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(TextString.generalPersonal, style: TTextTheme.hSettingsgeneral(context)),
          Text(TextString.companyinfoSubtitle, style: TTextTheme.loginDividerText(context)),
          const SizedBox(height: 40),
          _buildResponsiveGrid(context, controller, [
            [TextString.companyPersonal1, "Soft Snip"],
            [TextString.companyPersonal2, "Reg-2024-2025"],
            [TextString.companyPersonal3, "softsnip@gmail.com"],
            [TextString.companyPersonal4, "1234567-8"],
            [TextString.companyPersonal5, "1234567-8"],
            [TextString.companyPersonal6, "1234567-8"],
          ], isMobile),
          const SizedBox(height: 24),
          _buildAnimatedField(context,TextString.companyPersonal7, "https://softsnip.au", controller, isFullWidth: true),
        ],
      ),
    );
  }

  // Address Section
  Widget _buildCompanyAddressForm(BuildContext context, SettingStaffController controller) {
    bool isMobile = MediaQuery.of(context).size.width < 650;
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(TextString.adressPersonal, style: TTextTheme.hSettingsgeneral(context)),
          Text(TextString.adressPersonalSubtitle, style: TTextTheme.loginDividerText(context)),
          const SizedBox(height: 40),
          _buildResponsiveGrid(context, controller, [
            [TextString.adressPersonal1, "Australia"],
            [TextString.adressPersonal2, "Western Australia"],
            [TextString.adressPersonal3, "Perth"],
            [TextString.adressPersonal4, "6000"],
            [TextString.adressPersonal5, "123 Hay Street"],
            [TextString.adressPersonal6, "https://softsnip.au"],
          ], isMobile),
        ],
      ),
    );
  }

  // Subtabs
  Widget _buildSubTab(BuildContext context, String title, int index, SettingStaffController controller) {
    bool isActive = controller.selectedSubTabIndex.value == index;
    return GestureDetector(
      onTap: () => controller.changeSubTab(index),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: isActive ? AppColors.primaryColor : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(title, style: isActive ? TTextTheme.bodyRegular14TabsSelected(context) : TTextTheme.bodyRegular14(context)),
      ),
    );
  }

   // Responsive Grids
  Widget _buildResponsiveGrid(BuildContext context, SettingStaffController controller, List<List<String>> fields, bool isMobile) {
    List<Widget> rows = [];
    for (int i = 0; i < fields.length; i += (isMobile ? 1 : 2)) {
      if (isMobile) {
        rows.add(_buildAnimatedField(context, fields[i][0], fields[i][1], controller));
      } else {
        rows.add(Row(children: [
          Expanded(child: _buildAnimatedField(context, fields[i][0], fields[i][1], controller)),
          const SizedBox(width: 24),
          if (i + 1 < fields.length) Expanded(child: _buildAnimatedField(context, fields[i + 1][0], fields[i + 1][1], controller)) else const Expanded(child: SizedBox()),
        ]));
      }
      rows.add(const SizedBox(height: 20));
    }
    return Column(children: rows);
  }

  // Fields
  Widget _buildAnimatedField(BuildContext context, String label, String hint, SettingStaffController controller, {bool isFullWidth = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TTextTheme.tableRegular14black(context)),
        const SizedBox(height: 8),
        TextFormField(
          initialValue: hint,
          style: TTextTheme.titleinputTextField(context),
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: AppColors.toolBackground)),
            enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: AppColors.toolBackground)),
            focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: AppColors.primaryColor)),
          ),
        ),
      ],
    );
  }
}