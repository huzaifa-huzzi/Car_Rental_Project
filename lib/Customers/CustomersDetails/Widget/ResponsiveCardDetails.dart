import 'package:car_rental_project/Resources/IconStrings.dart';
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
        border: Border.all(color: const Color(0xffE5E7EB)),
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Card Details",
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: Color(0xFF374151))),

          const SizedBox(height: 20),

          _buildRow(isMobile, "Card Number 01"),

          if (isMobile) const Padding(
            padding: EdgeInsets.symmetric(vertical: 20),
            child: Divider(color: Color(0xffE5E7EB), thickness: 1),
          ) else const SizedBox(height: 22),

          _buildRow(isMobile, "Card Number 02"),
        ],
      ),
    );
  }

  /// -------- Extra Widgets (helper Widgets)----------///

  // Row Widget
  Widget _buildRow(bool isMobile, String label) {
    return isMobile ? _mobileRow(label) : _webRow();
  }

  //  WEB / TABLET VIEW Widget
  Widget _webRow() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _brand(),
        _item("Card Number", "41xxx xxxx xxxx 5609", isMobile: false),
        _item("Card Holder Name", "Jong Ali", isMobile: false),
        _item("Country", "Australia", isMobile: false),
        _item("Expiry date", "05/2029", isMobile: false),
        _item("CVC or CVV", "067", isMobile: false),
      ],
    );
  }

  //  MOBILE VIEW Widget
  Widget _mobileRow(String label) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Colors.black87)),
        const SizedBox(height: 12),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _brand(),
            Flexible(
              child: _item("Card Number", "41xxx xxxx xxxx 5609", expanded: false, isMobile: true),
            ),
          ],
        ),
        const SizedBox(height: 12),
        _item("Card Holder Name", "Jong Ali", expanded: false, isMobile: true),
        const SizedBox(height: 12),
        _item("Country", "Australia", expanded: false, isMobile: true),
        const SizedBox(height: 12),
        _item("Expiry date", "05/2029", expanded: false, isMobile: true),
        const SizedBox(height: 12),
        _item("CVC or CVV", "067", expanded: false, isMobile: true),
      ],
    );
  }

  //  Item Widget
  Widget _item(String title, String value, {bool expanded = true, required bool isMobile}) {
    bool hideLabel = isMobile && title == "Card Number";

    Widget content = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (!hideLabel) ...[
          Text(title,
              style: const TextStyle(fontSize: 12, color: Color(0xFF6B7280), fontWeight: FontWeight.w400)),
          const SizedBox(height: 4),
        ],
        Text(
          value,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Color(0xFF1F2937)),
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
        ),
      ],
    );

    if (expanded) {
      return Expanded(
          flex: 2,
          child: Padding(
            padding: const EdgeInsets.only(right: 8),
            child: content,
          )
      );
    }
    return content;
  }

  // brand Widget
  Widget _brand() {
    return Container(
      margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xffE5E7EB)),
        color: const Color(0xffF9FAFB),
      ),
      child: Image.asset(
        IconString.licenseIcon,
        height: 18,
        errorBuilder: (context, error, stackTrace) => const Icon(Icons.credit_card, size: 18, color: Colors.grey),
      ),
    );
  }

}