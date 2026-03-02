import 'package:car_rental_project/PickupCar/PickupCarInventory.dart';
import 'package:car_rental_project/Resources/AppSizes.dart';
import 'package:car_rental_project/Resources/Colors.dart';
import 'package:car_rental_project/Resources/TextString.dart';
import 'package:car_rental_project/Resources/TextTheme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TermsAndSignScreen extends StatelessWidget {
  const TermsAndSignScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // final isWeb = AppSizes.isWeb(context); // Tab ke andar inhe use na karein toh behtar hai
    final bool isMobile = AppSizes.isMobile(context);
    double padding = 24.0;
    final controller = Get.find<PickupCarController>();

    // --- FIX: Scaffold aur SingleChildScrollView hata diye ---
    return Column(
      children: [
        // --- FIRST WHITE CONTAINER: TERMS CONTENT ---
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
                      Text(TextString.titleViewPickStepTwo, style: TTextTheme.h6Style(context)),
                      const SizedBox(height: 6),
                      Text(TextString.titleViewSubtitleStepTwo,
                          style: TTextTheme.titleThree(context)),

                      // --- Terms Sections ---
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
                      // ... Baki saare _buildHelperFunctions ...
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

        // --- SECOND WHITE CONTAINER: SIGNATURE SECTION ---
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
                  Row(
                    children: [
                      const Icon(Icons.verified_user_outlined, color: Colors.blueGrey),
                      const SizedBox(width: 10),
                      Text("Signature", style: TTextTheme.h6Style(context)),
                    ],
                  ),
                  const SizedBox(height: 20),
                  // --- Signature Section ---
                  _buildSignatureSection(context, isMobile),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
  /// ----------- Extra Widget -------- ///


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
          value: controller.isTermsAgreed2.value,
          onChanged: (value) => controller.isTermsAgreed2.value = value!,
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

  Widget _buildSignatureSection(BuildContext context, bool isMobile) {
    return LayoutBuilder(builder: (context, constraints) {
      if (isMobile) {
        return Column(
          children: [
            _buildSignatureBlock(context, "Pickup"), // Title pass kiya
            const SizedBox(height: 25),
            _buildSignatureBlock(context, "Dropoff", addTopPadding: true), // Dropoff ke liye extra top padding
          ],
        );
      }
      /// Web
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: _buildSignatureBlock(context, "Pickup")),
          const SizedBox(width: 30),
          Expanded(child: _buildSignatureBlock(context, "Dropoff", addTopPadding: true)),
        ],
      );
    });
  }

// Maine Pickup aur Dropoff ko ek hi function mein merge kar diya title aur padding parameter ke saath
  Widget _buildSignatureBlock(BuildContext context, String title, {bool addTopPadding = false}) {
    return Padding(
      padding: EdgeInsets.only(top: addTopPadding ? 50.0 : 0.0), // Dropoff ke liye padding
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!addTopPadding) // Sirf pickup ke liye title dikhayein
            Text(title, style: TTextTheme.dropdowninsideText(context)),
          if (!addTopPadding) const SizedBox(height: 15),

          // Yahan se `Container` aur `backgroundOfScreenColor` hata diya hai
          _buildSignatureCard(context, TextString.subtitleOwnerSignatureStepTwoDropOff, "Softsnip", isReadOnly: true, bgColor: Colors.white),
          const SizedBox(height: 15),
          _buildSignatureCard(context, TextString.subtitleHirerSignatureStepTwoDropOff, "Softsnip", isReadOnly: true, bgColor: Colors.white),
        ],
      ),
    );
  }


  Widget _buildSignatureCard(BuildContext context, String title, String name, {bool isReadOnly = false, required Color bgColor}) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColors.primaryColor.withOpacity(0.5),
          width: 0.6,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: TTextTheme.titleRadios(context)),
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(name, style:TTextTheme.h2Style(context) ),
                    const Divider(thickness: 1, color: AppColors.tertiaryTextColor),
                    Text(TextString.subtitleFullNameStepTwoDropOff , style: TTextTheme.titleFullName(context)),
                  ],
                ),
              ),
              const SizedBox(width: 25),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(name, style: TTextTheme.h2Style(context)),
                    const Divider(thickness: 1, color: AppColors.tertiaryTextColor),
                    Text(TextString.titleSignatureStepTwoDropOff , style: TTextTheme.titleFullName(context)),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

}
