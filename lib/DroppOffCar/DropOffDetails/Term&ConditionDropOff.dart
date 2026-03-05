import 'package:car_rental_project/Resources/Colors.dart';
import 'package:car_rental_project/Resources/TextString.dart';
import 'package:car_rental_project/Resources/TextTheme.dart';
import 'package:flutter/material.dart';

class TermandConditionDropOff extends StatelessWidget {
  const TermandConditionDropOff({super.key});

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
          _buildEligibilityItem(context, TextString.eligibilityTitle3),
          _buildEligibilityItem(context, TextString.eligibilityTitle4),
          _buildEligibilityItem(context, TextString.eligibilityTitle5),
          _buildEligibilityItem(context, TextString.eligibilityTitle6),
          _buildEligibilityItem(context, TextString.eligibilityTitle7),
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
          _buildBulletItem(context, TextString.accounting1),
          _buildBulletItem(context, TextString.accounting2),
          _buildBulletItem(context, TextString.accounting3),
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
          _buildBulletItem(context, TextString.booking4),
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
          _buildBulletItem(context, TextString.security2),
          _buildBulletItem(context, TextString.security3),
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
          _buildBulletItem(context, TextString.vehicle1),
          _buildBulletItem(context,TextString.vehicle2),
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
          _buildBulletItem(context, TextString.insurance1),
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
          _buildBulletItem(context, TextString.cancellation2),
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
                    Text(TextString.subtitleFullName, style: TTextTheme.titleFullName(context)),
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
                    Text(TextString.signature, style: TTextTheme.titleFullName(context)),
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


