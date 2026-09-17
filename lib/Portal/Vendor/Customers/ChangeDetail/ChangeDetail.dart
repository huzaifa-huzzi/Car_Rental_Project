import 'package:car_rental_project/Portal/Vendor/Customers/CustomersController.dart';
import 'package:car_rental_project/Portal/Vendor/Customers/ReusableWidgetOfCustomers/HeaderWebCustomersWidget.dart';
import 'package:car_rental_project/Resources/Colors.dart';
import 'package:car_rental_project/Resources/TextString.dart';
import 'package:car_rental_project/Resources/TextTheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class ChangeDetail extends StatelessWidget {
  const ChangeDetail({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CustomerController());
    final double screenWidth = MediaQuery.of(context).size.width;
    final bool isMobile = screenWidth < 600;
    final bool isWeb = kIsWeb || screenWidth >= 1024;

    return Scaffold(
      backgroundColor: AppColors.backgroundOfScreenColor,
      body: SafeArea(
        child: Column(
          children: [
            HeaderWebCustomersWidget(
              mainTitle: 'Change Detail',
              showBack: true,
              showSmallTitle: true,
              smallTitle: 'Customer / Change Details',
              showSearch: isWeb,
              showSettings: isWeb,
              showAddButton: false,
              showNotification: true,
              showProfile: true,
            ),
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.all(isMobile ? 12.0 : 20.0),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(isMobile ? 16.0 : 24.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.03),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Form(
                    key: controller.changeDetailFormKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          TextString.changeDetailTitle,
                          style: TTextTheme.h13Style(context).copyWith(
                            fontWeight: FontWeight.bold,
                            color: AppColors.textColor,
                            fontSize: isMobile ? 18 : 22,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          TextString.changeDetailSubtitle,
                          style: TTextTheme.bodyRegular14(context).copyWith(
                            color: AppColors.secondTextColor,
                            fontSize: isMobile ? 12 : 14,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Divider(
                          color: AppColors.sideBoxesColor.withValues(alpha: 0.5),
                          thickness: 1,
                        ),
                        const SizedBox(height: 20),
                        Text(
                          TextString.FieldOne,
                          style: TTextTheme.pOne(context).copyWith(
                            fontWeight: FontWeight.w600,
                            color: AppColors.textColor,
                          ),
                        ),
                        const SizedBox(height: 8),
                        TextFormField(
                          cursorColor: AppColors.textColor,
                          controller: controller.changeDetailTitleController,
                          style: TTextTheme.pOne(context),
                          validator: (value) =>
                              controller.validateRequired(value, TextString.FieldOne),
                          decoration: InputDecoration(
                            hintText: TextString.FieldOneSubtitle,
                            hintStyle: TTextTheme.pFour(context).copyWith(
                              color: AppColors.secondTextColor.withValues(alpha: 0.6),
                            ),
                            filled: true,
                            fillColor: AppColors.secondaryColor,
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 14,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide.none,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: const BorderSide(
                                color: AppColors.sideBoxesColor,
                                width: 1.2,
                              ),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: const BorderSide(color: AppColors.primaryColor, width: 1),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Text(
                         TextString.FieldTwo,
                          style: TTextTheme.pOne(context).copyWith(
                            fontWeight: FontWeight.w600,
                            color: AppColors.textColor,
                          ),
                        ),
                        const SizedBox(height: 8),
                        TextFormField(
                          cursorColor: AppColors.textColor,
                          controller: controller.changeDetailDescriptionController,
                          maxLines: 5,
                          style: TTextTheme.pOne(context),
                          validator: (value) =>
                              controller.validateRequired(value, TextString.FieldTwo),
                          decoration: InputDecoration(
                            hintText: TextString.FieldTwoSubtitle,
                            hintStyle: TTextTheme.pFour(context).copyWith(
                              color: AppColors.secondTextColor.withValues(alpha: 0.6),
                            ),
                            filled: true,
                            fillColor: AppColors.secondaryColor,
                            contentPadding: const EdgeInsets.all(16),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide.none,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: const BorderSide(
                                color: AppColors.sideBoxesColor,
                                width: 1.2,
                              ),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: const BorderSide(color: AppColors.primaryColor, width: 1),
                            ),
                          ),
                        ),
                        const SizedBox(height: 28),
                        Align(
                          alignment: Alignment.centerRight,
                          child: SizedBox(
                            width: isMobile ? double.infinity : 150,
                            height: 44,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.primaryColor,
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              onPressed: () {
                                controller.saveChangeDetails(context);
                              },
                              child: Text(
                                'Save details',
                                style: TTextTheme.btnSave(context).copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
