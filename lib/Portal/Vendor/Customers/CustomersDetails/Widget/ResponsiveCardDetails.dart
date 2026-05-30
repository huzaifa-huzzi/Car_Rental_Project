import 'package:car_rental_project/Resources/Colors.dart';
import 'package:car_rental_project/Resources/IconStrings.dart';
import 'package:car_rental_project/Resources/TextString.dart';
import 'package:car_rental_project/Resources/TextTheme.dart';
import 'package:flutter/material.dart';

class ResponsiveCardDetails extends StatelessWidget {
  const ResponsiveCardDetails({super.key});

  static const List<Map<String, String>> cardsList = [
    {
      "label": "Card Number 01",
      "cardNumber": "•••• •••• •••• 4242",
      "cardHolderName": "Jong Ali",
      "cvc": "067",
      "expiryDate": "05/2029",
      "country": "Australia",
      "iconPath": IconString.visaIcon,
    },
    {
      "label": "Card Number 02",
      "cardNumber": "•••• •••• •••• 5555",
      "cardHolderName": "Softsnip",
      "cvc": "123",
      "expiryDate": "12/2030",
      "country": "United States",
      "iconPath": IconString.masterCardIcon,
    },
  ];

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
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(TextString.cardDetailsTitle, style: TTextTheme.titleSix(context)),

          const SizedBox(height: 20),

          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: cardsList.length,
            itemBuilder: (context, index) {
              final card = cardsList[index];
              final isLastItem = index == cardsList.length - 1;
              final String label = card['label'] ?? "Card Details";
              final String cardNumber = card['cardNumber'] ?? "";
              final String cardHolderName = card['cardHolderName'] ?? "";
              final String cvc = card['cvc'] ?? "";
              final String expiryDate = card['expiryDate'] ?? "";
              final String country = card['country'] ?? "";
              final String iconPath = card['iconPath'] ?? "";

              return Column(
                children: [
                  isMobile
                      ? _mobileRow(label, cardNumber, cardHolderName, cvc, expiryDate, country, iconPath, context)
                      : _webRow(cardNumber, cardHolderName, cvc, expiryDate, country, iconPath, context),
                  SizedBox(height: 20,),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  /// -------- Extra Widgets ----------///

  // WEB / TABLET VIEW
  Widget _webRow(String cardNumber, String holderName, String cvc, String expiry, String country, String iconPath, BuildContext context) {
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
                      cardNumber,
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
        _item("Card Holder Name", holderName, context: context, isMobile: false),
        _item("CVC or CVV", cvc, context: context, isMobile: false),
        _item("Expiry date", expiry, context: context, isMobile: false),
        _item("Country", country, context: context, isMobile: false),
      ],
    );
  }

  // MOBILE VIEW
  Widget _mobileRow(String label, String cardNumber, String holderName, String cvc, String expiry, String country, String iconPath, BuildContext context) {
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
                  cardNumber,
                  context: context,
                  expanded: false,
                  isMobile: true
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        _item("Card Holder Name", holderName, context: context, expanded: false, isMobile: true),
        const SizedBox(height: 12),
        _item("CVC or CVV", cvc, context: context, expanded: false, isMobile: true),
        const SizedBox(height: 12),
        _item("Expiry date", expiry, context: context, expanded: false, isMobile: true),
        const SizedBox(height: 12),
        _item("Country", country, context: context, expanded: false, isMobile: true),
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