import 'package:car_rental_project/PickupCar/PickupCarInventory.dart';
import 'package:car_rental_project/PickupCar/ReusableWidgetOfPickup/AddButtonOfPickup.dart';
import 'package:car_rental_project/PickupCar/ReusableWidgetOfPickup/AddPickupButton.dart';
import 'package:car_rental_project/PickupCar/ReusableWidgetOfPickup/HeaderWebPickupWidget.dart';
import 'package:car_rental_project/PickupCar/ReusableWidgetOfPickup/SuccessConfirmationPickupDialog.dart';
import 'package:car_rental_project/Resources/AppSizes.dart';
import 'package:car_rental_project/Resources/Colors.dart';
import 'package:car_rental_project/Resources/TextString.dart';
import 'package:car_rental_project/Resources/TextTheme.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:signature/signature.dart';
import '../../../Resources/IconStrings.dart' show IconString;

class StepThreeWidget extends StatefulWidget {
  const StepThreeWidget({super.key});

  @override
  State<StepThreeWidget> createState() => _StepThreeWidgetState();
}

class _StepThreeWidgetState extends State<StepThreeWidget> {
  @override
  Widget build(BuildContext context) {
    final isWeb = AppSizes.isWeb(context);
    final bool isMobile = AppSizes.isMobile(context);
    double padding = 24.0;
    final controller = Get.find<PickupCarController>();

    return Scaffold(
      backgroundColor: AppColors.backgroundOfScreenColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),

            // Header of the Screen
            HeaderWebPickupWidget(
              mainTitle: 'Add Pickup Car',
              showBack: true,
              showSmallTitle: true,
              smallTitle: 'Pickup Car / Add Pickup Car',
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
                          // Header
                          Text(TextString.titleViewPickStepTwo, style: TTextTheme.h6Style(context)),
                          const SizedBox(height: 6),
                          Text(TextString.titleViewSubtitleStepTwo,
                              style: TTextTheme.titleThree(context)),
                          const SizedBox(height: 7),
                          _buildStepBadges(context),
                          const SizedBox(height: 25),
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
                          Padding(padding: const EdgeInsets.symmetric(horizontal: 10), child: _buildAgreementCheckbox(context,PickupCarController())),
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
                  child:Column(
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
              child:  _buttonSection(context, isMobile),
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
          "Welcome to our Soft Snip! These Terms and Conditions (\"Terms\") govern your access to and use of our website, platform, and services (\"Services\"). Please read them carefully. By using our Services, you agree to be bound by these Terms and our Privacy Policy (the \"Agreement\").\n\nIf you do not agree to these Terms, please do not use our Services.",
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
            "Acceptance of Term:",
            style: TTextTheme.hPickupStyle(context).copyWith(color: AppColors.primaryColor),
          ),
          const SizedBox(height: 10),
          Text(
            "By downloading, accessing, or using the [App Name] mobile application and services, you agree to comply with and be legally bound by these Terms and Conditions. If you do not agree, please do not use our services.",
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
            "Eligibility",
            style: TTextTheme.hPickupStyle(context),
          ),
          const SizedBox(height: 12),
          _buildEligibilityItem(context, "1: You must be at least 18/21/25 years old (depending on your policy and jurisdiction)."),
          _buildEligibilityItem(context, "2: You must possess a valid driver’s license."),
          _buildEligibilityItem(context, "3: You must provide valid identification and payment details."),
          _buildEligibilityItem(context, "4: You must not have any driving bans or legal restrictions."),
          _buildEligibilityItem(context, "5: You must possess a valid driver’s license."),
          _buildEligibilityItem(context, "6: You must provide valid identification and payment details."),
          _buildEligibilityItem(context, "7: You must not have any driving bans or legal restrictions."),
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
            "Account Registration",
            style: TTextTheme.hPickupStyle(context),
          ),
          const SizedBox(height: 12),
          _buildBulletItem(context, "1: Users must create an account with accurate and complete information."),
          _buildBulletItem(context, "2: You are responsible for maintaining the confidentiality of your account."),
          _buildBulletItem(context, "3: You agree to notify us immediately of unauthorized access."),
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
            "Booking and Rental Terms",
            style: TTextTheme.hPickupStyle(context),
          ),
          const SizedBox(height: 12),
          _buildBulletItem(context, "1: All rentals are subject to vehicle availability."),
          _buildBulletItem(context, "2: Booking confirmation is sent via email or in-app notification."),
          _buildBulletItem(context, "3: Rental duration begins and ends as stated in the booking confirmation."),
          _buildBulletItem(context, "4: Late returns may incur additional charges."),
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
          Text("Payment Terms", style: TTextTheme.hPickupStyle(context)),
          const SizedBox(height: 12),
          Text("Rental fees, taxes, and additional charges must be paid in full before vehicle release.", style: TTextTheme.titleThree(context)),
          const SizedBox(height: 8),
          Text("Security deposit may be required.", style: TTextTheme.titleThree(context)),
          const SizedBox(height: 8),
          Text("Additional charges may apply for:", style: TTextTheme.titleThree(context)),
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
          Text("Security Deposit", style: TTextTheme.hPickupStyle(context)),
          const SizedBox(height: 12),
          _buildBulletItem(context, "1: A refundable security deposit will be held during the rental period."),
          _buildBulletItem(context, "2: Refund timeline: [e.g., 5-14 business days after vehicle return]."),
          _buildBulletItem(context, "3: Deductions may apply for damages, fines, or contract violations."),
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
          Text("Vehicle Use Restrictions", style: TTextTheme.hPickupStyle(context)),
          const SizedBox(height: 12),
          _buildBulletItem(context, "1: Use the vehicle for illegal activities."),
          _buildBulletItem(context, "2: Allow unauthorized drivers to operate the vehicle."),
          _buildBulletItem(context, "3: Drive under the influence of alcohol or drugs."),
          _buildBulletItem(context, "4: Use the vehicle for racing, towing (unless permitted), or commercial purposes."),
          _buildBulletItem(context, "5: Drive outside permitted geographic areas."),
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
            "Insurance and Liability",
            style: TTextTheme.hPickupStyle(context),
          ),
          const SizedBox(height: 12),
          _buildBulletItem(context, "1: Vehicles are covered by basic insurance as required by law."),
          _buildBulletItem(context, "2: The renter is responsible for deductibles and damages not covered by insurance."),
          _buildBulletItem(context, "3: The renter must immediately report accidents or damage."),
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
            "Cancellations and Refunds",
            style: TTextTheme.hPickupStyle(context),
          ),
          const SizedBox(height: 12),
          _buildBulletItem(context, "1: Free cancellation up to [X hours] before pickup."),
          _buildBulletItem(context, "2: Late cancellations may incur fees."),
          _buildBulletItem(context, "3: No-shows may result in full booking charge."),
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
            "Privacy Policy",
            style: TTextTheme.hPickupStyle(context),
          ),
          const SizedBox(height: 12),
          Text(
            "Your personal data is handled according to our Privacy Policy. By using the app, you consent to our data practices.",
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
            "Intellectual Property",
            style: TTextTheme.hPickupStyle(context),
          ),
          const SizedBox(height: 12),
          Text(
            "All content, trademarks, logos, and software in the app are owned by [Company Name]. Unauthorized use is prohibited.",
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
            "Governing Law",
            style: TTextTheme.hPickupStyle(context),
          ),
          const SizedBox(height: 12),
          Text(
            "These Terms are governed by the laws of [Country/State]",
            style: TTextTheme.titleThree(context).copyWith(height: 1.5),
          ),
          Text(
            "Any disputes shall be resolved in the courts of [Jurisdiction].",
            style: TTextTheme.titleThree(context).copyWith(height: 1.5),
          ),
        ],
      ),
    );
  }
  // Agreement checkBox
  Widget _buildAgreementCheckbox(BuildContext context,PickupCarController controller) {
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
            "I agree to the Pickup Terms & Conditions*",
            style: TTextTheme.titleSmallRegister(context),
          ),
        ),
      ],
    ));
  }

   // Signature
  Widget _buildSignatureSection(BuildContext context, PickupCarController controller) {
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

          Text("Name*", style: TTextTheme.titleName(context)),
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
                borderSide: BorderSide(color: Colors.red),
              ),
            ),
          ),
          if (isDrawing && !isConfirmed)
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
          // Signature Pad Area
          DottedBorder(
            borderType: BorderType.RRect,
            radius: const Radius.circular(12),
            dashPattern: const [6, 3],
            color: AppColors.primaryColor,
            child: Container(
              height: 180, // Fixed height
              width: double.infinity,
              color: Colors.white,
              child: isConfirmed
                  ? Center(
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    controller.activeNameController.text,
                    style: _signatureTextStyle(),
                  ),
                ),
              )
                  : Stack(
                children: [
                  MediaQuery.of(context).size.width < 600
                      ? Scrollbar(
                    thumbVisibility: true,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: SizedBox(
                        height: 180,
                        width: 800,
                        child: Signature(
                          controller: controller.activeSigController,
                          backgroundColor: Colors.white,
                        ),
                      ),
                    ),
                  )
                      : SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: SizedBox(
                      height: 180,
                      width: 800,
                      child: Signature(
                        controller: controller.activeSigController,
                        backgroundColor: Colors.white,
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
              )
            ),
          )
        ],
      );
    });
  }
  Widget _buildSignaturePreviewSection(BuildContext context, PickupCarController controller) {
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
          Text("Preview", style: TTextTheme.h6Style(context)),
          const SizedBox(height: 4),
          Text("This is how your signature look on document", style: TTextTheme.titleThree(context)),
          const SizedBox(height: 20),

          DottedBorder(
            borderType: BorderType.RRect,
            radius: const Radius.circular(12),
            dashPattern: const [6, 3],
            color: AppColors.primaryColor,
            child: Container(
              width: double.infinity,
              height: 150,
              alignment: Alignment.center,
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                    controller.activeNameController.text,
                    style: _signatureTextStyle()
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
  Widget _buildSignatureHeader(BuildContext context, PickupCarController controller) {
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
              "Signature",
              style: TTextTheme.h13Style(context),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
        ],
      ),
    );
  }
  Widget _buildTogglesSection(BuildContext context, PickupCarController controller) {
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
           Text("Draw Your Signature here",
              style: TTextTheme.h1Style(context)),
          const SizedBox(height: 5),
          Container(width: 250, height: 1.5, color: AppColors.textColor),
        ],
      ),
    );
  }
  TextStyle _signatureTextStyle() {
    return const TextStyle(
        fontSize: 30,
        fontWeight: FontWeight.bold,
        fontStyle: FontStyle.italic,
        fontFamily: 'DancingScript'
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
                onTap: () {
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (BuildContext context) {
                      return const SuccessConfirmationPickupDialog();
                    },
                  );
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
                onTap: () {
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (BuildContext context) {
                      return const SuccessConfirmationPickupDialog();
                    },
                  );
                }
            ),
          ),

        ],
      );
    }
  }
}
