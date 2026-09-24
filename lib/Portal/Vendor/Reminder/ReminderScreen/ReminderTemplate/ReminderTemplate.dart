import 'package:car_rental_project/Portal/Vendor/Reminder/ReminderController.dart';
import 'package:car_rental_project/Portal/Vendor/Reminder/ReusableWidgetOfReminder/HeaderWebReminder.dart';
import 'package:car_rental_project/Portal/Vendor/Reminder/ReusableWidgetOfReminder/PrimaryBtnOfReminder.dart';
import 'package:car_rental_project/Resources/AppSizes.dart';
import 'package:car_rental_project/Resources/Colors.dart';
import 'package:car_rental_project/Resources/TextString.dart';
import 'package:car_rental_project/Resources/TextTheme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReminderTemplate extends StatelessWidget {
  const ReminderTemplate({super.key});

  @override
  Widget build(BuildContext context) {
    final ReminderController controller = Get.put(ReminderController());

    return Scaffold(
      backgroundColor: AppColors.backgroundOfScreenColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (AppSizes.isWeb(context)) ...[
                HeaderWebReminder(
                  mainTitle: 'Whatsapp',
                  showBack: false,
                  showSmallTitle: true,
                  smallTitle: "Whatsapp / Whatsapp Alerts",
                  showProfile: true,
                  showNotification: true,
                  showSettings: true,
                  showSearch: true,
                ),
                const SizedBox(height: 16),
              ],
              _buildTopActionBar(context, controller),
              const SizedBox(height: 20),
              _buildCreateTemplateCard(context, controller),
            ],
          ),
        ),
      ),
    );
  }

   /// --------------- Extra Widget ---------------- ///

  // Top Action Bar Component
  Widget _buildTopActionBar(BuildContext context, ReminderController controller) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 14.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.signaturePadColor, width: 1),
        boxShadow: [
          BoxShadow(
            color: AppColors.blackColor.withValues(alpha: 0.03),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          bool isMobile = constraints.maxWidth < 600;

          if (isMobile) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildAlertButtons(context, controller, isMobile: true),
                const SizedBox(height: 12),
                _buildProgressSection(context, isRightAligned: false),
              ],
            );
          }

          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildAlertButtons(context, controller, isMobile: false),
              _buildProgressSection(context, isRightAligned: true),
            ],
          );
        },
      ),
    );
  }

  // Progress Section
  Widget _buildProgressSection(BuildContext context, {bool isRightAligned = true}) {
    return Column(
      crossAxisAlignment: isRightAligned ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          TextString.reminderOne,
          style: TTextTheme.bodySemiBold14black(context),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 6),
        Container(
          height: 10,
          width: 170,
          decoration: BoxDecoration(
            color: AppColors.signaturePadColor,
            borderRadius: BorderRadius.circular(10),
          ),
          alignment: Alignment.centerLeft,
          child: FractionallySizedBox(
            widthFactor: 5 / 25,
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.primaryColor,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          TextString.reminderTwo,
          style: TTextTheme.bodyRegular12Gay10(context),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }

  // Alert Switcher Buttons
  Widget _buildAlertButtons(BuildContext context, ReminderController controller, {required bool isMobile}) {
    return Obx(() {
      bool isWhatsappSelected = controller.selectedAlertType.value == 'whatsapp';
      bool isSmsSelected = controller.selectedAlertType.value == 'sms';

      Widget buildPillButton({
        required String label,
        required bool isSelected,
        required VoidCallback onTap,
      }) {
        Widget buttonBody = GestureDetector(
          onTap: onTap,
          child: Container(
            height: 38,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: isSelected ? AppColors.primaryColor : Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: isSelected ? Colors.transparent : AppColors.primaryColor.withValues(alpha: 0.5),
                width: 1,
              ),
            ),
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                label,
                style: isSelected
                    ? TTextTheme.btnWhiteColor(context)
                    : TTextTheme.btnTwo(context).copyWith(color: AppColors.primaryColor),
              ),
            ),
          ),
        );

        return isMobile ? Expanded(child: buttonBody) : buttonBody;
      }

      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          buildPillButton(
            label: TextString.reminderThree,
            isSelected: isWhatsappSelected,
            onTap: () => controller.selectedAlertType.value = 'whatsapp',
          ),
          const SizedBox(width: 12),
          buildPillButton(
            label: TextString.reminderFour,
            isSelected: isSmsSelected,
            onTap: () => controller.selectedAlertType.value = 'sms',
          ),
        ],
      );
    });
  }

  // Main Card Widget
  Widget _buildCreateTemplateCard(BuildContext context, ReminderController controller) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.signaturePadColor, width: 1),
        boxShadow: [
          BoxShadow(
            color: AppColors.blackColor.withValues(alpha: 0.03),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            TextString.reminderTwelve,
            style: TTextTheme.PickupPayment(context).copyWith(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            TextString.reminderThirteen,
            style: TTextTheme.btncustomer(context),
          ),
          const SizedBox(height: 24),

          Text(
            TextString.reminder14,
            style: TTextTheme.CalendarSubtitle(context).copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          SizedBox(
            height: 44,
            child: TextField(
              cursorColor: AppColors.blackColor,
              controller: controller.titleController,
              style: TTextTheme.titleTwo(context),
              decoration: InputDecoration(
                hintText: TextString.reminder15,
                hintStyle: TTextTheme.bodyRegular16(context),
                contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                filled: true,
                fillColor: Colors.white,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: AppColors.quadrantalTextColor.withValues(alpha: 0.5)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: AppColors.primaryColor),
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Text(
            TextString.reminder16,
            style: TTextTheme.CalendarSubtitle(context).copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          TextField(
            cursorColor: AppColors.blackColor,
            controller: controller.descriptionController,
            maxLines: 4,
            style: TTextTheme.titleTwo(context),
            decoration: InputDecoration(
              hintText: TextString.reminder17,
              hintStyle: TTextTheme.bodyRegular16(context),
              contentPadding: const EdgeInsets.all(14),
              filled: true,
              fillColor: Colors.white,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: AppColors.quadrantalTextColor.withValues(alpha: 0.5)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: AppColors.primaryColor),
              ),
            ),
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              InkWell(
                onTap: () {
                  controller.titleController.clear();
                  controller.descriptionController.clear();
                  Get.back();
                },
                borderRadius: BorderRadius.circular(6),
                child: Container(
                  height: 38,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    color: AppColors.blackColor,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    TextString.reminder18,
                    style: TTextTheme.btnSave(context).copyWith(color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              PrimaryBtnReminder(
                text: TextString.reminder19,
                height: 38,
                width: 80,
                borderRadius: BorderRadius.circular(6),
                onTap: () => controller.addNewTemplate(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}