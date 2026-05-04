import 'package:car_rental_project/Portal/Vendor/DropOffCar/ReusableWidgetOfDropoff/HeaderWebDropOffWidget.dart';
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
                  context.go('/addDropOff', extra: {"hideMobileAppBar": true});
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
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColors.tertiaryTextColor.withOpacity(0.3),
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
}