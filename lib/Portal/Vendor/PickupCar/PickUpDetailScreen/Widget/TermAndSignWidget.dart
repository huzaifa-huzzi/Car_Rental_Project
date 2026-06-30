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
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColors.tertiaryTextColor.withValues(alpha: 0.3),
          width: 0.7,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            TextString.titleTermsStepTwo,
            style: TTextTheme.hPickupStyle(context),
          ),
          const SizedBox(height: 12),
          Text(
            TextString.termsSubtitle,
            style: TTextTheme.titleThree(context),
            textAlign: TextAlign.justify,
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
          color: AppColors.primaryColor.withValues(alpha: 0.1),
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
