import 'package:car_rental_project/DroppOffCar/ReusableWidgetOfDropoff/HeaderWebDropOffWidget.dart';
import 'package:car_rental_project/Resources/AppSizes.dart';
import 'package:car_rental_project/Resources/Colors.dart';
import 'package:car_rental_project/Resources/TextString.dart';
import 'package:car_rental_project/Resources/TextTheme.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DropOffTandCDescription extends StatefulWidget {
  const DropOffTandCDescription({super.key});

  @override
  State<DropOffTandCDescription> createState() => _DropOffTandCDescriptionState();
}

class _DropOffTandCDescriptionState extends State<DropOffTandCDescription> {

  @override
  Widget build(BuildContext context) {
    final isWeb = AppSizes.isWeb(context);
    double padding = 24.0;


    return Scaffold(
      backgroundColor: AppColors.backgroundOfScreenColor,
      body: SingleChildScrollView(
        child: Column(
            children: [
              const SizedBox(height: 20),

              HeaderWebDropOffWidget(
                mainTitle: 'DropOff T&C',
                showBack: true,
                showSmallTitle: true,
                smallTitle: 'DropOff Car / DropOff T&C',
                showSearch: isWeb,
                showSettings: isWeb,
                showAddButton: true,
                showNotification: true,
                showProfile: true,
                onAddPressed: (){
                  context.push('/addDropOff', extra: {"hideMobileAppBar": true});
                },
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
                            _buildVersionHeader(context),
                            const SizedBox(height: 25),

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
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 30),
            ]
        ),
      ),
    );
  }
  /// ----------- Extra Widget ---------- ///
  // Version Control Container
  Widget _buildVersionHeader(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {

        return Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: AppColors.signaturePadColor,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.tertiaryTextColor.withOpacity(0.1)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                spacing: 10,
                runSpacing: 8,
                children: [
                  Text(
                    TextString.tandCTitle3,
                    style:TTextTheme.h6Style(context),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppColors.activeColor2,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child:  Text(
                        "Active",
                        style: TTextTheme.activeText(context)
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                TextString.tandCSubtitle3,
                style: TTextTheme.titleThree(context),
              ),
            ],
          ),
        );
      },
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

}

