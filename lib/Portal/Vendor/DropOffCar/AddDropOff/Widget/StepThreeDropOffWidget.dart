import 'package:car_rental_project/Portal/Vendor/DropOffCar/DropOffController.dart';
import 'package:car_rental_project/Portal/Vendor/DropOffCar/ReusableWidgetOfDropoff/DropOffSuccessDualog.dart';
import 'package:car_rental_project/Portal/Vendor/PickupCar/ReusableWidgetOfPickup/AddButtonOfPickup.dart';
import 'package:car_rental_project/Portal/Vendor/PickupCar/ReusableWidgetOfPickup/AddPickupButton.dart';
import 'package:car_rental_project/Portal/Vendor/PickupCar/ReusableWidgetOfPickup/HeaderWebPickupWidget.dart';
import 'package:car_rental_project/Resources/AppSizes.dart';
import 'package:car_rental_project/Resources/Colors.dart';
import 'package:car_rental_project/Resources/IconStrings.dart';
import 'package:car_rental_project/Resources/TextString.dart';
import 'package:car_rental_project/Resources/TextTheme.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:signature/signature.dart';

class StepThreeDropOffWidget extends StatefulWidget {
  const StepThreeDropOffWidget({super.key});

  @override
  State<StepThreeDropOffWidget> createState() => _StepThreeDropOffWidgetState();
}

class _StepThreeDropOffWidgetState extends State<StepThreeDropOffWidget> {
  @override
  Widget build(BuildContext context) {
    final isWeb = AppSizes.isWeb(context);
    final bool isMobile = AppSizes.isMobile(context);
    double padding = 24.0;
    final controller = Get.find<DropOffController>();

    return Scaffold(
      backgroundColor: AppColors.backgroundOfScreenColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),

            // Header of the Screen
            HeaderWebPickupWidget(
              mainTitle: 'Add DropOff Car',
              showBack: true,
              showSmallTitle: true,
              smallTitle: 'DropOff Car / DropOff Car details',
              showSearch: isWeb,
              showSettings: isWeb,
              showAddButton: false,
              showNotification: true,
              showProfile: true,
            ),

            Padding(
              padding: const EdgeInsets.all(20),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(padding),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Header title
                          Text(TextString.titleViewPickStepTwoDropOffAdd2, style: TTextTheme.h6Style(context)),
                          const SizedBox(height: 6),
                          Text(TextString.titleViewSubtitleStepTwoDropOffAdd3,
                              style: TTextTheme.titleThree(context)),
                          const SizedBox(height: 7),
                          // Step Badges
                          _buildStepBadges(context),
                          const SizedBox(height: 15),

                          _buildVersionHeader( context),
                          const SizedBox(height: 15),

                          // Terms Content
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: _buildTermsAndConditions(context),
                          ),
                          const SizedBox(height: 40),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: _buildAcceptanceOfTerm(context),
                          ),
                          const SizedBox(height: 20),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: _buildEligibility(context),
                          ),
                          const SizedBox(height: 20),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: _buildAccountRegistration(context),
                          ),
                          const SizedBox(height: 20),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: _buildBookingTerms(context),
                          ),
                          const SizedBox(height: 20),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: _buildPaymentTerms(context),
                          ),
                          const SizedBox(height: 20),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: _buildSecurityDeposit(context),
                          ),
                          const SizedBox(height: 20),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: _buildVehicleRestrictions(context),
                          ),
                          const SizedBox(height: 20),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: _buildInsuranceLiability(context),
                          ),
                          const SizedBox(height: 20),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: _buildCancellationsRefunds(context),
                          ),
                          const SizedBox(height: 20),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: _buildPrivacyPolicy(context),
                          ),
                          const SizedBox(height: 20),
                          Padding(padding: const EdgeInsets.symmetric(horizontal: 20), child: _buildIntellectualProperty(context)),
                          const SizedBox(height: 20),
                          Padding(padding: const EdgeInsets.symmetric(horizontal: 20), child: _buildGoverningLaw(context)),
                          const SizedBox(height: 25),
                          Padding(padding: const EdgeInsets.symmetric(horizontal: 10), child: _buildAgreementCheckbox(context, controller)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),

            // Signature Section
            Padding(
              padding: const EdgeInsets.all(20),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: EdgeInsets.all(padding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildSignatureSection(context, controller),
                    ],
                  ),
                ),
              ),
            ),

            // Preview Signature Section
            Obx(() => controller.isConfirmed.value
                ? Padding(
              padding: const EdgeInsets.all(20),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: EdgeInsets.all(padding),
                  child: _buildSignaturePreviewSection(context, controller),
                ),
              ),
            )
                : const SizedBox.shrink()
            ),

            /// Buttons
            Padding(
              padding: EdgeInsets.only(
                right: 20,
                left: isMobile ? 20 : 0,),
              child: _buttonSection(context, isMobile),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
  /// ----------- Extra Widget ---------- ///
  // Badges
  Widget _buildStepBadges(BuildContext context) {
    return Container(
      width: 280,
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildStepItem("1", "Step 1", false, context,isCurrent: true),
          _buildStepLine(true),
          _buildStepItem("2", "Step 2", false, context,isCurrent: true),
          _buildStepLine(true),
          _buildStepItem("3", "Step 3", true, context),
        ],
      ),
    );
  }
  Widget _buildStepItem(String stepNum, String label, bool isCompleted, BuildContext context, {bool isCurrent = false}) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 24,
          height: 24,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isCompleted ? AppColors.primaryColor : Colors.white,
            border: Border.all(color: AppColors.primaryColor, width: 1.5),
          ),
          child: Center(
            child: isCompleted
                ? const Icon(Icons.check, size: 14, color: Colors.white)
                : isCurrent
                ? Container(
              width: 8,
              height: 8,
              decoration: const BoxDecoration(
                color: AppColors.primaryColor,
                shape: BoxShape.circle,
              ),
            )
                : null,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          label,
          style: TTextTheme.stepsText(context).copyWith(
            color: isCompleted ? AppColors.primaryColor : AppColors.textColor,
          ),
        ),
      ],
    );
  }
  Widget _buildStepLine(bool isActive) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(top: 11.0),
        child: Container(
          height: 1.5,
          color: AppColors.primaryColor,
        ),
      ),
    );
  }


  // Terms & conditions
  Widget _buildTermsAndConditions(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          TextString.titleTermsStepTwo,
          style: TTextTheme.h6Style(context),
        ),
        const SizedBox(height: 15),
        Text(
          TextString.termsSubtitle,
          style: TTextTheme.titleAgreement(context).copyWith(height: 1.5),
          textAlign: TextAlign.justify,
        ),
      ],
    );
  }


  // Acceptance Of Terms
  Widget _buildAcceptanceOfTerm(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.tertiaryTextColor.withOpacity(0.3), width: 0.7),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            TextString.acceptanceOfTerms,
            style: TTextTheme.hPickupStyle(context).copyWith(color: AppColors.primaryColor),
          ),
          const SizedBox(height: 10),
          Text(
            TextString.acceptanceSubtitle,
            style: TTextTheme.titleThree(context).copyWith(height: 1.5),
          ),
        ],
      ),
    );
  }


  // Eligibility
  Widget _buildEligibility(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.tertiaryTextColor.withOpacity(0.3), width: 0.7),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            TextString.eligibilityTitle,
            style: TTextTheme.hPickupStyle(context),
          ),
          const SizedBox(height: 12),
          _buildEligibilityItem(context, TextString.eligibilityTitle1),
          _buildEligibilityItem(context, TextString.eligibilityTitle2),
          _buildEligibilityItem(context,TextString.eligibilityTitle3 ),
          _buildEligibilityItem(context,TextString.eligibilityTitle4 ),
          _buildEligibilityItem(context,TextString.eligibilityTitle5),
          _buildEligibilityItem(context, TextString.eligibilityTitle6),
          _buildEligibilityItem(context,TextString.eligibilityTitle7 ),
        ],
      ),
    );
  }
  Widget _buildEligibilityItem(BuildContext context, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        text,
        style: TTextTheme.titleThree(context).copyWith(height: 1.4),
      ),
    );
  }

  // Account Registration
  Widget _buildAccountRegistration(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.tertiaryTextColor.withOpacity(0.3), width: 0.7),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            TextString.accounting,
            style: TTextTheme.hPickupStyle(context),
          ),
          const SizedBox(height: 12),
          _buildBulletItem(context,TextString.accounting1 ),
          _buildBulletItem(context, TextString.accounting2),
          _buildBulletItem(context,TextString.accounting3),
        ],
      ),
    );
  }
  // Booking Items
  Widget _buildBookingTerms(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.tertiaryTextColor.withOpacity(0.3), width: 0.7),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            TextString.booking,
            style: TTextTheme.hPickupStyle(context),
          ),
          const SizedBox(height: 12),
          _buildBulletItem(context, TextString.booking1),
          _buildBulletItem(context, TextString.booking2),
          _buildBulletItem(context, TextString.booking3),
          _buildBulletItem(context,TextString.booking4),
        ],
      ),
    );
  }
  Widget _buildBulletItem(BuildContext context, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        text,
        style: TTextTheme.titleThree(context).copyWith(height: 1.4),
      ),
    );
  }

  // Payment Terms
  Widget _buildPaymentTerms(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.tertiaryTextColor.withOpacity(0.3), width: 0.7),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(TextString.payment, style: TTextTheme.hPickupStyle(context)),
          const SizedBox(height: 12),
          Text(TextString.payment1, style: TTextTheme.titleThree(context)),
          const SizedBox(height: 8),
          Text(TextString.payment2, style: TTextTheme.titleThree(context)),
          const SizedBox(height: 8),
          Text(TextString.payment3, style: TTextTheme.titleThree(context)),
          const SizedBox(height: 10),
          ...["Late return", "Fuel refill", "Toll fees", "Traffic violations", "Cleaning fees", "Damage repair"]
              .map((item) => Padding(
            padding: const EdgeInsets.only(left: 10, bottom: 4),
            child: Text("• $item", style: TTextTheme.titleThree(context)),
          )),
        ],
      ),
    );
  }
  // Security Deposit
  Widget _buildSecurityDeposit(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.tertiaryTextColor.withOpacity(0.3), width: 0.7),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(TextString.security, style: TTextTheme.hPickupStyle(context)),
          const SizedBox(height: 12),
          _buildBulletItem(context,TextString.security1),
          _buildBulletItem(context,TextString.security2),
          _buildBulletItem(context,TextString.security3 ),
        ],
      ),
    );
  }
  // Vehicles Restriction
  Widget _buildVehicleRestrictions(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.tertiaryTextColor.withOpacity(0.3), width: 0.7),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(TextString.vehicle, style: TTextTheme.hPickupStyle(context)),
          const SizedBox(height: 12),
          _buildBulletItem(context,TextString.vehicle1),
          _buildBulletItem(context, TextString.vehicle2),
          _buildBulletItem(context, TextString.vehicle3),
          _buildBulletItem(context, TextString.vehicle4),
          _buildBulletItem(context, TextString.vehicle5),
        ],
      ),
    );
  }

  // Insurance Liability
  Widget _buildInsuranceLiability(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.tertiaryTextColor.withOpacity(0.3), width: 0.7),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            TextString.insurance,
            style: TTextTheme.hPickupStyle(context),
          ),
          const SizedBox(height: 12),
          _buildBulletItem(context,TextString.insurance1 ),
          _buildBulletItem(context, TextString.insurance2),
          _buildBulletItem(context, TextString.insurance3),
        ],
      ),
    );
  }
  // Cancellation Returns
  Widget _buildCancellationsRefunds(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.tertiaryTextColor.withOpacity(0.3), width: 0.7),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            TextString.cancellation,
            style: TTextTheme.hPickupStyle(context),
          ),
          const SizedBox(height: 12),
          _buildBulletItem(context, TextString.cancellation1),
          _buildBulletItem(context,TextString.cancellation2),
          _buildBulletItem(context, TextString.cancellation3),
        ],
      ),
    );
  }
  // Build privacy policy
  Widget _buildPrivacyPolicy(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.tertiaryTextColor.withOpacity(0.3), width: 0.7),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            TextString.privacy,
            style: TTextTheme.hPickupStyle(context),
          ),
          const SizedBox(height: 12),
          Text(
            TextString.privacy1,
            style: TTextTheme.titleThree(context).copyWith(height: 1.5),
          ),
        ],
      ),
    );
  }
  // Intellectual property
  Widget _buildIntellectualProperty(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.tertiaryTextColor.withOpacity(0.3), width: 0.7),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            TextString.intellactual,
            style: TTextTheme.hPickupStyle(context),
          ),
          const SizedBox(height: 12),
          Text(
            TextString.intellactual1,
            style: TTextTheme.titleThree(context).copyWith(height: 1.5),
          ),
        ],
      ),
    );
  }
  // Governing Law
  Widget _buildGoverningLaw(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.tertiaryTextColor.withOpacity(0.3), width: 0.7),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            TextString.law,
            style: TTextTheme.hPickupStyle(context),
          ),
          const SizedBox(height: 12),
          Text(
            TextString.law1,
            style: TTextTheme.titleThree(context).copyWith(height: 1.5),
          ),
          Text(
            TextString.law2,
            style: TTextTheme.titleThree(context).copyWith(height: 1.5),
          ),
        ],
      ),
    );
  }
  // Agreement checkBox
  Widget _buildAgreementCheckbox(BuildContext context,DropOffController controller) {
    return Obx(() => Row(
      children: [
        Checkbox(
          value: controller.isTermsAgreed.value,
          onChanged: (value) => controller.isTermsAgreed.value = value!,
          activeColor: AppColors.primaryColor,
          side: const BorderSide(color: AppColors.primaryColor, width: 1.5),
        ),
        Expanded(
          child: Text(
            TextString.agreementText,
            style: TTextTheme.titleSmallRegister(context),
          ),
        ),
      ],
    ));
  }

  // Signature
  Widget _buildSignatureSection(BuildContext context, DropOffController controller) {
    return Obx(() {
      final isDrawing = controller.isDrawingStarted.value;
      final isConfirmed = controller.isConfirmed.value;

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSignatureHeader(context, controller),
          const SizedBox(height: 20),
          _buildTogglesSection(context, controller),
          const SizedBox(height: 20),

          Text(TextString.Name, style: TTextTheme.titleName(context)),
          const SizedBox(height: 8),
          TextFormField(
            cursorColor: AppColors.blackColor,
            controller: controller.activeNameController,
            style: TTextTheme.titleinputTextField(context),
            decoration: InputDecoration(
              hintText: "Enter your name",
              hintStyle: TTextTheme.titleName(context),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: AppColors.quadrantalTextColor),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color : AppColors.quadrantalTextColor, width: 1),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: AppColors.primaryColor),
              ),
            ),
          ),
            Padding(
              padding: const EdgeInsets.only(top: 15),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  bool useColumn = constraints.maxWidth < 280;

                  return Flex(
                    direction: useColumn ? Axis.vertical : Axis.horizontal,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      OutlinedButton(
                        onPressed: () => controller.clearSignature(),
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(color: AppColors.quadrantalTextColor, width: 1.5),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                        ),
                        child: Text(
                          "Clear",
                          style: TTextTheme.titleClear(context),
                        ),
                      ),
                      useColumn
                          ? const SizedBox(height: 10)
                          : const SizedBox(width: 10),

                      ElevatedButton(
                        onPressed: () => controller.confirmCurrentSignature(),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.textColor,
                          minimumSize: const Size(120, 45),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Text(
                          "Confirm",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),

          const SizedBox(height: 20),
          Builder(
            builder: (context) {
              final boxHeight = _signatureBoxHeight(context);
              return DottedBorder(
                borderType: BorderType.RRect,
                radius: const Radius.circular(12),
                dashPattern: const [6, 3],
                color: AppColors.primaryColor,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    height: boxHeight,
                    width: double.infinity,
                    color: Colors.white,
                    alignment: Alignment.center,
                    child: isConfirmed
                        ? LayoutBuilder(
                      builder: (context, constraints) {
                        final w = constraints.maxWidth.clamp(1.0, double.infinity);
                        final h = constraints.maxHeight.clamp(1.0, double.infinity);
                        return SizedBox(
                          width: w,
                          height: h,
                          child: FittedBox(
                            fit: BoxFit.contain,
                            alignment: Alignment.center,
                            child: Text(
                              controller.activeNameController.text,
                              style: _signatureTextStyle(),
                              maxLines: 1,
                            ),
                          ),
                        );
                      },
                    )
                        : Stack(
                      children: [
                        Positioned.fill(
                          child: FittedBox(
                            fit: BoxFit.contain,
                            alignment: Alignment.center,
                            child: SizedBox(
                              width: 400,
                              height: 150,
                              child: Signature(
                                controller: controller.activeSigController,
                                backgroundColor: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        if (!isDrawing)
                          Positioned.fill(
                            child: Center(
                              child: _buildEmptyPadPlaceholder(),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      );
    });
  }
  Widget _buildSignaturePreviewSection(BuildContext context, DropOffController controller) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.tertiaryTextColor.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(TextString.preview, style: TTextTheme.h6Style(context)),
          const SizedBox(height: 4),
          Text(TextString.preview1, style: TTextTheme.titleThree(context)),
          const SizedBox(height: 20),

          Builder(
            builder: (context) {
              final previewHeight = AppSizes.isMobile(context) ? 120.0 : 150.0;
              return DottedBorder(
                borderType: BorderType.RRect,
                radius: const Radius.circular(12),
                dashPattern: const [6, 3],
                color: AppColors.primaryColor,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: SizedBox(
                    width: double.infinity,
                    height: previewHeight,
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        final w = constraints.maxWidth.clamp(1.0, double.infinity);
                        final h = constraints.maxHeight.clamp(1.0, double.infinity);
                        return SizedBox(
                          width: w,
                          height: h,
                          child: FittedBox(
                            fit: BoxFit.contain,
                            alignment: Alignment.center,
                            child: Text(
                              controller.activeNameController.text,
                              style: _signatureTextStyle(),
                              maxLines: 1,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
  Widget _buildSignatureHeader(BuildContext context, DropOffController controller) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color:AppColors.secondaryColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Image.asset(IconString.signatureIcon),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              TextString.signature,
              style: TTextTheme.h13Style(context),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
        ],
      ),
    );
  }
  Widget _buildTogglesSection(BuildContext context, DropOffController controller) {
    return Obx(() {
      return Container(
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: AppColors.tertiaryTextColor),
        ),
        child: Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            _buildToggleOption(
              "Signed by owner",
              controller.isOwnerSigned.value,
                  () => controller.isOwnerSigned.value = true,
            ),
            _buildToggleOption(
              "Signed by hirer",
              !controller.isOwnerSigned.value,
                  () => controller.isOwnerSigned.value = false,
            ),
          ],
        ),
      );
    });
  }
  Widget _buildToggleOption(String text, bool isSelected, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primaryColor : Colors.transparent,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Text(text, style: isSelected ? TTextTheme.OwnerSelected(context) : TTextTheme.hirerSelected(context) ),
      ),
    );
  }
  Widget _buildEmptyPadPlaceholder() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(IconString.pickUpSignatureIcon),
          const SizedBox(height: 10),
          Text(TextString.drawSignature,
              style: TTextTheme.h1Style(context)),
          const SizedBox(height: 5),
          Container(width: 250, height: 1.5, color: AppColors.textColor),
        ],
      ),
    );
  }
  /// Responsive height for signature box (mobile / tablet / web)
  double _signatureBoxHeight(BuildContext context) {
    if (AppSizes.isWeb(context)) return 180;
    if (AppSizes.isTablet(context)) return 160;
    return 140;
  }
  TextStyle _signatureTextStyle() {
    return const TextStyle(
        fontSize: 30,
        fontWeight: FontWeight.bold,
        fontStyle: FontStyle.italic,
        fontFamily: 'DancingScript'
    );
  }

   // Version T&C
  Widget _buildVersionHeader(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        bool isMobile = constraints.maxWidth < 300;

        return Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: AppColors.signaturePadColor,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.tertiaryTextColor.withOpacity(0.1)),
          ),
          child: isMobile
              ? Column(
            key: const ValueKey('mobile_layout'),
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeaderText(context),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: _buildEditButton(context),
              ),
            ],
          )
              : Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(child: _buildHeaderText(context)),
              const SizedBox(width: 16),
              _buildEditButton(context),
            ],
          ),
        );
      },
    );
  }
  Widget _buildHeaderText(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          spacing: 10,
          runSpacing: 8,
          children: [
            Text(
              TextString.tandCTitle3,
              style: TTextTheme.h6Style(context),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: AppColors.activeColor2,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text("Active", style: TTextTheme.activeText(context)),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Text(
          TextString.tandCSubtitle3,
          style: TTextTheme.titleThree(context),
        ),
      ],
    );
  }
  Widget _buildEditButton(BuildContext context) {
    return AddButtonOfPickup(
      text: "Edit and Manage",
      onTap: () {
        context.go('/dropOffT&C', extra: {"hideMobileAppBar": true});
      },
      borderRadius: BorderRadius.circular(8),
    );
  }


  // Button Sections
  Widget _buttonSection(BuildContext context, bool isMobile) {
    const double webButtonWidth = 130.0;
    const double webButtonHeight = 45.0;
    final double spacing = AppSizes.padding(context);

    if (isMobile) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            height: webButtonHeight,
            child: AddPickUpButton(
              text: 'Cancel',
              backgroundColor: Colors.transparent,
              textColor: AppColors.textColor,
              borderColor: AppColors.quadrantalTextColor,
              onTap: () {
              },
            ),
          ),
          SizedBox(height: spacing),
          SizedBox(
            width: webButtonWidth,
            height: webButtonHeight,
            child: AddButtonOfPickup(
                text: "Confirm",
                onTap: () async {
                  showSavingDialog(context);
                }
            ),
          ),
        ],
      );
    } else {
      return Row(
        children: [
          Spacer(),
          SizedBox(
            width: webButtonWidth,
            height: webButtonHeight,
            child: AddPickUpButton(
              text: 'Cancel',
              backgroundColor: Colors.transparent,
              textColor: AppColors.textColor,
              borderColor: AppColors.quadrantalTextColor,
              onTap: () {
              },
            ),
          ),
          SizedBox(width: spacing),
          SizedBox(
            width: webButtonWidth,
            height: webButtonHeight,
            child: AddButtonOfPickup(
                text: "Confirm",
                onTap: () async{
                  showSavingDialog(context);
                }
            ),
          ),

        ],
      );
    }
  }

   // Dialogs
  void showSavingDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        double progress = 0.0;

        return StatefulBuilder(
          builder: (context, setState) {
            Future.delayed(Duration.zero, () async {
              while (progress < 1.0) {
                await Future.delayed(const Duration(milliseconds: 40));
                progress += 0.02;
                setState(() {});
              }
              Navigator.pop(context);
              showSuccessDialog(context);
            });

            double screenWidth = MediaQuery.of(context).size.width;

            return Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
              elevation: 10,
              backgroundColor: Colors.white,
              child: Container(
                width: screenWidth < 600 ? screenWidth * 0.9 : 450,
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 40,
                          width: 40,
                          child: Image.asset(IconString.searchingIcon),
                        ),
                        const SizedBox(width: 20),

                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                TextString.dialogDropoff1,
                                style: TTextTheme.h2Style(context),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                TextString.dialogDropoff2,
                                style: TTextTheme.bodyRegular16(context),
                              ),
                              const SizedBox(height: 25),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: LinearProgressIndicator(
                                  value: progress,
                                  minHeight: 6,
                                  backgroundColor: AppColors.backgroundOfPickupsWidget,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    AppColors.primaryColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
  void showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.white,
          insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Container(
            width: 450,
            padding: const EdgeInsets.all(24),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
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
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                TextString.dialogDropoff3,
                                style: TTextTheme.h2Style(context)
                            ),
                            const SizedBox(height: 8),
                            Text(
                                TextString.dialogDropoff4,
                                style: TTextTheme.bodyRegular16(context)
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: AppColors.sideBoxesColor,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(Icons.close, size: 16, color: AppColors.blackColor),
                        ),
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

