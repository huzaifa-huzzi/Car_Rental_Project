import 'package:car_rental_project/Resources/Colors.dart';
import 'package:car_rental_project/Resources/IconStrings.dart';
import 'package:car_rental_project/Resources/TextString.dart';
import 'package:car_rental_project/Resources/TextTheme.dart';
import 'package:flutter/material.dart';

class ResponsiveCardDetails extends StatelessWidget {
  const ResponsiveCardDetails({super.key});

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    bool isMobile = w <= 600;

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.tertiaryTextColor),
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(TextString.cardDetailsTitle, style: TTextTheme.titleSix(context)),

          const SizedBox(height: 20),

          _buildRow(isMobile, "Card Number 01", IconString.visaIcon, context),

          if (isMobile)
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: Divider(color: Colors.white, thickness: 1),
            )
          else
            const SizedBox(height: 22),

          _buildRow(isMobile, "Card Number 02", IconString.masterCardIcon, context),
        ],
      ),
    );
  }

  /// -------- Extra Widgets ----------///

  Widget _buildRow(bool isMobile, String label, String iconPath, BuildContext context) {
    return isMobile
        ? _mobileRow(label, iconPath, context)
        : _webRow(iconPath, context);
  }

  // WEB / TABLET VIEW
  Widget _webRow(String iconPath, BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 3,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(TextString.cardNumberDetail, style: TTextTheme.btnFour(context)),
              const SizedBox(height: 3),
              Row(
                children: [
                  _brand(iconPath),
                  Expanded(
                    child: Text(
                      TextString.cardNumberDetailScreen,
                      style: TTextTheme.titleSmallTexts(context),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(width: 8),
        _item("Card Holder Name", "Jong Ali", context: context, isMobile: false),
        _item("Country", "Australia", context: context, isMobile: false),
        _item("Expiry date", "05/2029", context: context, isMobile: false),
        _item("CVC or CVV", "067", context: context, isMobile: false),
      ],
    );
  }

  // MOBILE VIEW
  Widget _mobileRow(String label, String iconPath, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
            label,
            style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Colors.black87)
        ),
        const SizedBox(height: 12),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _brand(iconPath),
            Flexible(
              child: _item(
                  TextString.cardNumberDetail,
                  TextString.cardNumberDetailScreen,
                  context: context,
                  expanded: false,
                  isMobile: true
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        _item("Card Holder Name", "Jong Ali", context: context, expanded: false, isMobile: true),
        const SizedBox(height: 12),
        _item("Country", "Australia", context: context, expanded: false, isMobile: true),
        const SizedBox(height: 12),
        _item("Expiry date", "05/2029", context: context, expanded: false, isMobile: true),
        const SizedBox(height: 12),
        _item("CVC or CVV", "067", context: context, expanded: false, isMobile: true),
      ],
    );
  }

 // Item Widget
  Widget _item(String title, String value, {
    bool expanded = true,
    required BuildContext context,
    required bool isMobile,
  }) {
    bool hideLabel = isMobile && (title == "Card Number" || title == TextString.cardNumberDetail);

    Widget content = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (!hideLabel) ...[
          Text(title, style: TTextTheme.btnFour(context)),
          const SizedBox(height: 4),
        ],
        Text(
          value,
          style: TTextTheme.titleSmallTexts(context),
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
        ),
      ],
    );

    if (expanded) {
      return Expanded(
        flex: 2,
        child: Padding(padding: const EdgeInsets.only(right: 8), child: content),
      );
    }
    return content;
  }


  Widget _brand(String iconPath) {
    return Container(
      margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: AppColors.secondaryColor,
      ),
      child: Image.asset(
        iconPath,
        height: 18,
        errorBuilder: (context, error, stackTrace) => const Icon(Icons.credit_card, size: 18, color: Colors.grey),
      ),
    );
  }
}