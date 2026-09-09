import 'package:car_rental_project/Portal/Vendor/Customers/CustomersController.dart';
import 'package:car_rental_project/Portal/Vendor/Customers/ReusableWidgetOfCustomers/AddButtonOfCustomers.dart';
import 'package:car_rental_project/Portal/Vendor/Customers/ReusableWidgetOfCustomers/CustomerPrimaryBtn.dart';
import 'package:car_rental_project/Portal/Vendor/Customers/ReusableWidgetOfCustomers/HeaderWebCustomersWidget.dart';
import 'package:car_rental_project/Resources/AppSizes.dart';
import 'package:car_rental_project/Resources/Colors.dart';
import 'package:car_rental_project/Resources/TextString.dart';
import 'package:car_rental_project/Resources/TextTheme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class SendInviteScreen extends StatelessWidget {
  SendInviteScreen({super.key});

  final controller = Get.put(CustomerController());

  @override
  Widget build(BuildContext context) {
    final horizontalPadding = AppSizes.horizontalPadding(context);
    final baseVerticalSpace = AppSizes.verticalPadding(context);
    final isMobile = AppSizes.isMobile(context);

    return Scaffold(
      backgroundColor: AppColors.backgroundOfScreenColor,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (AppSizes.isWeb(context)) ...[
                  HeaderWebCustomersWidget(
                    mainTitle: 'Invite Screen',
                    showBack: true,
                    smallTitle: 'Customer /Invite Customer',
                    showSmallTitle: true,
                    showProfile: true,
                    showNotification: true,
                    showSettings: true,
                    showSearch: true,
                  ),
                  const SizedBox(height: 16),
                ],
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(isMobile ? 16.0 : 24.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Form(
                    key: controller.inviteFormKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          TextString.customerInviteTitle,
                          style: TTextTheme.titleOne(context).copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          TextString.customerInviteSubtitle,
                          style: TTextTheme.titleTwo(context).copyWith(
                            color: AppColors.secondTextColor,
                            fontSize: 13,
                          ),
                        ),
                        const SizedBox(height: 16),
                        const Divider(thickness: 1, color: AppColors.secondaryColor),
                        const SizedBox(height: 24),

                        LayoutBuilder(
                          builder: (context, constraints) {
                            if (constraints.maxWidth > 800) {
                              return Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(child: _buildGivenNameField(context)),
                                  const SizedBox(width: 16),
                                  Expanded(child: _buildSurnameField(context)),
                                  const SizedBox(width: 16),
                                  Expanded(child: _buildEmailField(context)),
                                ],
                              );
                            } else {
                              return Column(
                                children: [
                                  _buildGivenNameField(context),
                                  const SizedBox(height: 16),
                                  _buildSurnameField(context),
                                  const SizedBox(height: 16),
                                  _buildEmailField(context),
                                ],
                              );
                            }
                          },
                        ),

                        const SizedBox(height: 40),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            CustomerPrimaryBtn(
                              text: 'Cancel',
                              width: 120,
                              height: 44,
                              textColor: AppColors.blackColor,
                              backgroundColor: Colors.white,
                              borderColor: AppColors.secondaryColor,
                              borderRadius: BorderRadius.circular(8),
                              onTap: () {
                                controller.clearInviteForm();
                                Navigator.pop(context);
                              },
                            ),
                            const SizedBox(width: 16),
                            AddButtonOfCustomer(
                              text: 'Send Invitation',
                              height: 44,
                              width: 170,
                              borderRadius: BorderRadius.circular(8),
                              icon: const Icon(
                                Icons.upload_sharp,
                                size: 18,
                                color: Colors.white,
                              ),
                              onTap: () {
                                controller.sendCustomerInvite(context);
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: baseVerticalSpace),
              ],
            ),
          ),
        ),
      ),
    );
  }

   /// ----------- Extra Widget -------------- ///

   // given Field Name
  Widget _buildGivenNameField(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(TextString.customerFieldName, style: TTextTheme.titleTwo(context)),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller.inviteGivenNameController,
          style: TTextTheme.titleTwo(context),
          validator: (val) => controller.validateRequired(val,TextString.customerFieldName ),
          decoration: _inputDecoration(context, hintText: TextString.customerFieldNameSubtitle),
        ),
      ],
    );
  }

   // Surname Field
  Widget _buildSurnameField(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(TextString.customerFieldNameTwo, style: TTextTheme.titleTwo(context)),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller.inviteSurnameController,
          style: TTextTheme.titleTwo(context),
          validator: (val) => controller.validateRequired(val,TextString.customerFieldNameTwo),
          decoration: _inputDecoration(context, hintText:TextString.customerFieldNameTwoSubtitle),
        ),
      ],
    );
  }

   // Email field
  Widget _buildEmailField(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(TextString.customerEmailAddressTitle, style: TTextTheme.titleTwo(context)),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller.inviteEmailController,
          keyboardType: TextInputType.emailAddress,
          style: TTextTheme.titleTwo(context),
          validator: (val) => controller.validateEmail(val),
          decoration: _inputDecoration(context, hintText:TextString.customerEmailAddressSubtitle),
        ),
      ],
    );
  }

   // Input Decorations
  InputDecoration _inputDecoration(BuildContext context, {required String hintText}) {
    return InputDecoration(
      hintText: hintText,
      hintStyle: TTextTheme.smallX(context).copyWith(color: AppColors.secondTextColor),
      fillColor: AppColors.secondaryColor,
      filled: true,
      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: AppColors.primaryColor, width: 1),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: AppColors.primaryColor, width: 1),
      ),
    );
  }
}
