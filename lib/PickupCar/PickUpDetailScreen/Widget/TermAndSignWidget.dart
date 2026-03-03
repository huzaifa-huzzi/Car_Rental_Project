import 'package:car_rental_project/Resources/Colors.dart';
import 'package:car_rental_project/Resources/TextString.dart';
import 'package:car_rental_project/Resources/TextTheme.dart';
import 'package:flutter/material.dart';

class TermsAndSignScreen extends StatelessWidget {
  const TermsAndSignScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isMobile = MediaQuery.of(context).size.width < 800;

    return Column(
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(color: AppColors.fieldsBackground, blurRadius: 10)
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
            ],
          ),
        ),
        const SizedBox(height: 120),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(color: AppColors.fieldsBackground, blurRadius: 15, offset: const Offset(0, 5))
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                decoration: BoxDecoration(
                  color: AppColors.secondaryColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.verified_user_outlined, color: Colors.blueGrey, size: 20),
                    const SizedBox(width: 10),
                    Text("Signature", style: TTextTheme.h6Style(context)),
                  ],
                ),
              ),
              const SizedBox(height: 25),
              _buildSignatureSection(context, isMobile),
            ],
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

   // Signature Section
  Widget _buildSignatureSection(BuildContext context, bool isMobile) {
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth < 768) {
        return Column(
          children: [
            _buildSignatureCard(context, "Signed by Owner", "Softsnip"),
            const SizedBox(height: 15),
            _buildSignatureCard(context, "Signed by Hirer", "Softsnip"),
          ],
        );
      }
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: _buildSignatureCard(context, "Signed by Owner", "Softsnip"),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: _buildSignatureCard(context, "Signed by Hirer", "Softsnip"),
          ),
        ],
      );
    });
  }
  Widget _buildSignatureCard(BuildContext context, String title, String name) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColors.primaryColor.withOpacity(0.1),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: TTextTheme.titleRadios(context)),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(name, style: TTextTheme.h2Style(context)),
                    const Divider(thickness: 1, color: AppColors.tertiaryTextColor),
                    Text("Full Name", style: TTextTheme.titleFullName(context)),
                  ],
                ),
              ),
              const SizedBox(width: 30),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(name, style: TTextTheme.h2Style(context).copyWith(fontStyle: FontStyle.italic)),
                    const Divider(thickness: 1, color: AppColors.tertiaryTextColor),
                    Text("Signature", style: TTextTheme.titleFullName(context)),
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
