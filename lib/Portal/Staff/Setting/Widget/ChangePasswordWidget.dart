import 'package:car_rental_project/Portal/Staff/Setting/ReusableWidget/PrimaryBtnOfStaffSettings.dart';
import 'package:car_rental_project/Portal/Staff/Setting/SettingStaffController.dart';
import 'package:car_rental_project/Resources/Colors.dart';
import 'package:car_rental_project/Resources/TextString.dart';
import 'package:car_rental_project/Resources/TextTheme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChangePasswordWidget extends StatelessWidget {
  const ChangePasswordWidget({super.key});

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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    TextString.changePasswordTitle,
                    style: TTextTheme.UploadText(context),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    TextString.changePasswordSubtitle,
                    style: TTextTheme.bodyRegular14Search(context),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 25),

            Container(
              padding: const EdgeInsets.all(32),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(TextString.changePasswordTitle, style: TTextTheme.hSettingsgeneral(context)),
                  Text(TextString.changePasswordSubtitle2, style: TTextTheme.loginDividerText(context)),
                  const SizedBox(height: 40),
                  _buildAnimatedField(context, TextString.passwordPersonal1, TextString.passwordPersonal1subtitle, controller),
                  const SizedBox(height: 20),
                  _buildAnimatedField(context, TextString.passwordPersonal2, TextString.passwordPersonal2subtitle, controller),
                  const SizedBox(height: 20),
                  _buildAnimatedField(context, TextString.passwordPersonal3,TextString.passwordPersonal3subtitle, controller),

                  const SizedBox(height: 30),

                  Align(
                    alignment: Alignment.centerRight,
                    child: PrimaryBtnOfStaffSettings(
                      text: "Update Password",
                      width: isMobile ? double.infinity : 200,
                      onTap: () {
                        showDeleteCompanyDialog(context);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

   /// ---------- Extra Widgets

   // Animated Field
  Widget _buildAnimatedField(BuildContext context, String label, String hint, SettingStaffController controller) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TTextTheme.tableRegular14black(context)),
        const SizedBox(height: 8),
        Obx(() => Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            boxShadow: controller.focusedField.value == label
                ? [BoxShadow(color: AppColors.fieldsBackground.withOpacity(0.06), blurRadius: 10, offset: const Offset(0, 4))]
                : [],
          ),
          child: TextFormField(
            cursorColor: AppColors.blackColor,
            onTap: () => controller.setFocus(label),
            onFieldSubmitted: (_) => controller.clearFocus(),
            onTapOutside: (_) => controller.clearFocus(),
            style: TTextTheme.titleinputTextField(context),
            decoration: InputDecoration(
              hintText: hint,
              filled: true,
              fillColor: Colors.white,
              hintStyle: TTextTheme.bodyRegular16(context),
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: AppColors.toolBackground)
              ),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: AppColors.toolBackground)
              ),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: AppColors.toolBackground)
              ),
            ),
          ),
        )),
      ],
    );
  }

   // Dialogs
  void showDeleteCompanyDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          elevation: 0,
          backgroundColor: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.all(20),
            width: 450,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Stack(
              children: [
                Positioned(
                  right: 0,
                  top: 0,
                  child: InkWell(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: AppColors.toolBackground,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.close, size: 16, color: AppColors.blackColor),
                    ),
                  ),
                ),

                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                            color: AppColors.emojiBackground,
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                               TextString.passwordDialog1title,
                                style: TTextTheme.h2Style(context),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                TextString.passwordDialog1subtitle,
                                style: TTextTheme.bodyRegular16(context),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        SizedBox(
                          width: 110,
                          height: 40,
                          child: OutlinedButton(
                            onPressed: () {
                              Navigator.pop(context);
                              showSuccessDeletedDialog(context);
                            },
                            style: OutlinedButton.styleFrom(
                              side: const BorderSide(color: AppColors.primaryColor),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                            ),
                            child:  Text(
                              "Save",
                              style: TTextTheme.bodyRegular14Primary(context),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        PrimaryBtnOfStaffSettings(
                          text: "Cancel",
                          width: 110,
                          height: 40,
                          onTap: () => Navigator.pop(context),
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
  void showSuccessDeletedDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          backgroundColor: Colors.white,
          child: Container(
            width: 480,
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 55,
                      width: 55,
                      decoration: BoxDecoration(
                        color: AppColors.emojiBackground,
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                        TextString.passwordDialog2title,
                            style: TTextTheme.h2Style(context),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            TextString.passwordDialog2subtitle,
                            style:  TTextTheme.bodyRegular16(context),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 10),
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(color: AppColors.toolBackground, shape: BoxShape.circle),
                        child: const Icon(Icons.close, size: 16, color: AppColors.blackColor),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}