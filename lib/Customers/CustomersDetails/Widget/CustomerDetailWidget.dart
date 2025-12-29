import 'package:car_rental_project/Customers/CustomersController.dart';
import 'package:car_rental_project/Customers/CustomersDetails/Widget/ResponsiveCardDetails.dart';
import 'package:car_rental_project/Resources/IconStrings.dart';
import 'package:car_rental_project/Resources/ImageString.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../Resources/Colors.dart' show AppColors;

class CustomerDetailWidget extends StatelessWidget {
  const CustomerDetailWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final bool isMobile = screenWidth < 800;
    final double horizontalPadding = screenWidth > 1200 ? 40 : 20;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: 30),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
        children: [
          /// 1. HEADER SECTION (Mobile: Centered, Web: Row)
          _buildHeader(context, isMobile),
          const SizedBox(height: 35),

          /// 2. PERSONAL INFO SECTION (Responsive Wrap)
          _buildBorderedContainer(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Personal Info",
                  style: TextStyle(fontSize: 14, color: Colors.grey.shade400, fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 25),
                LayoutBuilder(
                  builder: (context, constraints) {
                    bool showGrid = screenWidth > 600;

                    return Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(child: _responsiveInfoItem(context, Icons.mail_outline, "Email", "Contact@SoftSnip.com.au")),
                            if (showGrid) ...[
                              const SizedBox(width: 20),
                              Expanded(child: _responsiveInfoItem(context, Icons.phone_outlined, "Contact Number", "+12 3456 7890")),
                              const SizedBox(width: 20),
                              Expanded(child: _responsiveInfoItem(context, Icons.location_on_outlined, "Address", "Toronto, California, 1234")),
                            ],
                          ],
                        ),

                        if (!showGrid) ...[
                          _responsiveInfoItem(context, Icons.phone_outlined, "Contact Number", "+12 3456 7890"),
                          _responsiveInfoItem(context, Icons.location_on_outlined, "Address", "Toronto, California, 1234"),
                        ],

                        const SizedBox(height: 20),

                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(child: _responsiveInfoItem(context, Icons.calendar_today_outlined, "Date of Birth", "12/03/2001")),
                            if (showGrid) ...[
                              const SizedBox(width: 20),
                              Expanded(child: _responsiveInfoItem(context, Icons.badge_outlined, "NID Number", "123 456 789")),
                              const SizedBox(width: 20),
                              const Spacer(),
                            ] else ...[
                            ],
                          ],
                        ),
                        if (!showGrid) _responsiveInfoItem(context, Icons.badge_outlined, "NID Number", "123 456 789"),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 35),

          /// 3. CUSTOMER NOTE
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSectionHeader("Customer Note"),
              const SizedBox(height: 12),
              Text(
                "Audi A8 is a luxurious and sophisticated sedan, ideal for both daily commutes and extended journeys. Renowned for its powerful performance and advanced technology features, the A8 provides a refined driving experience with exceptional comfort. Audi A8 is a luxurious and sophisticated sedan, ideal for both daily commutes and extended journeys.",
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey.shade700,
                  height: 1.6,
                  letterSpacing: 0.3,
                ),
              ),
            ],
          ),
          const SizedBox(height: 35),

          /// 4. LICENSE DETAILS
          _buildBorderedContainer(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "License Details",
                  style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey.shade400,
                      fontWeight: FontWeight.w500
                  ),
                ),
                const SizedBox(height: 25),

                LayoutBuilder(
                  builder: (context, constraints) {
                    bool isWideScreen = constraints.maxWidth > 900;

                    return Wrap(
                      spacing: isWideScreen ? (constraints.maxWidth / 10) : 42,
                      runSpacing: 30,
                      alignment: WrapAlignment.start,
                      children: [
                        _responsiveLicenseItem(context, Icons.person_outline, "License Name", "Carly Hevy"),
                        _responsiveLicenseItem(context, Icons.credit_card_outlined, "License Number", "1245985642"),
                        _responsiveLicenseItem(context, Icons.credit_card, "Card Number", "1243567434"),
                        _responsiveLicenseItem(context, Icons.calendar_today_outlined, "Expiry Date", "12/02/2035"),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),


          /// 5. CARD DETAILS
          ResponsiveCardDetails(),
          const SizedBox(height: 32),

          /// 6. DOCUMENTS SECTION
          _buildBorderedContainer(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Customer Documents",
                  style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey.shade400,
                      fontWeight: FontWeight.w500
                  ),
                ),
                const SizedBox(height: 25),

                Wrap(
                  spacing: 40,
                  runSpacing: 30,
                  children: [
                    _documentBox(context, "Gov ID", "HFC-052"),
                    _documentBox(context, "Passport", "Uploaded"),
                    _documentBox(context, "Driving License", "Uploaded"),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 50),
        ],
      ),
    );
  }

  /// --- UI COMPONENTS ---///

  Widget _buildHeader(BuildContext context, bool isMobile) {
    Widget profileImg = Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: AppColors.primaryColor, width: 1),
        image: const DecorationImage(
          image: AssetImage("assets/Images/Customers/CustomerUser.png"),
          fit: BoxFit.cover,
        ),
      ),
    );

    Widget details = Column(
      crossAxisAlignment: isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      children: [
        Text("Carlie Harvy", style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
        Text("Driver", style: TextStyle(fontSize: 14, color: Colors.grey.shade500)),
      ],
    );

    if (isMobile) {
      return Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              _headerActionBtn(IconString.editIcon, null, isDelete: false),
              const SizedBox(width: 10),
              _headerActionBtn(IconString.deleteIcon, null, isDelete: true),
            ],
          ),
          const SizedBox(height: 10),
          profileImg,
          const SizedBox(height: 15),
          details,
        ],
      );
    }

    return Row(
      children: [
        profileImg,
        const SizedBox(width: 20),
        Expanded(child: details),
        _headerActionBtn(IconString.editIcon, "Edit", isDelete: false),
        const SizedBox(width: 12),
        _headerActionBtn(IconString.deleteIcon, null, isDelete: true),
      ],
    );
  }


  Widget _documentBox(BuildContext context, String label, String status) {
    return SizedBox(
      width: 210,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: AppColors.secondaryColor,
            ),
            child:  Center(
              child: Image.asset(IconString.taxIcon),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(label, style: TextStyle(fontSize: 10, color: Colors.grey.shade500)),
                const SizedBox(height: 2),
                Row(
                  children: [
                    Flexible(
                      child: Text(
                        status,
                        style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.black),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(width: 6),
                    GestureDetector(
                      onTap: () {
                        final controller = Get.put(CustomerController());
                        controller.open(ImageString.registrationForm);
                      },
                      child: Image.asset(
                        IconString.uploadedIcon,
                        height: 16,
                        width: 16,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }



  /// --- COMMON HELPERS ---

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0), // Heading aur box ke beech gap
      child: Text(
        title,
        textAlign: TextAlign.start, // Isse heading hamesha left par rahegi
        style: TextStyle(
          fontSize: 15,
          color: Colors.grey.shade400,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.2,
        ),
      ),
    );
  }

  Widget _buildBorderedContainer({required Widget child, EdgeInsets? padding}) {
    return Container(
      width: double.infinity,
      padding: padding ?? const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFEEEEEE), width: 1.2),
      ),
      child: child,
    );
  }

  Widget _responsiveLicenseItem(BuildContext context, IconData icon, String label, String value) {
    final double screenWidth = MediaQuery.of(context).size.width;
    bool isMobile = screenWidth < 600;

    return Container(
      // Mobile par full width, Web/Tab par auto-width content ke hisab se
      width: isMobile ? double.infinity : null,
      constraints: BoxConstraints(minWidth: isMobile ? 0 : 160),
      child: IntrinsicWidth(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: const Color(0xFFF8F9FB),
                  borderRadius: BorderRadius.circular(10)
              ),
              child: Icon(icon, size: 18, color: Colors.black87),
            ),
            const SizedBox(width: 12),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(label, style: TextStyle(fontSize: 11, color: Colors.grey.shade400)),
                  const SizedBox(height: 2),
                  Text(
                    value,
                    style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.black),
                    softWrap: false,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }


  Widget _responsiveInfoItem(BuildContext context, IconData icon, String label, String value, {double? width}) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final bool isSmallMobile = screenWidth < 600;

    return Container(
      // Mobile par full width, Web/Tab par calculated width taaki alignment barabar rahe
      width: isSmallMobile ? double.infinity : width,
      margin: const EdgeInsets.only(bottom: 10),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: const Color(0xFFF8F9FB),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, size: 18, color: Colors.black87),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(label, style: TextStyle(fontSize: 11, color: Colors.grey.shade400)),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                    overflow: TextOverflow.ellipsis
                  ),
                  maxLines: 1,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }


  Widget _headerActionBtn(String iconPath, String? label, {required bool isDelete}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: label != null ? 14 : 10, vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        children: [
          Image.asset(
            iconPath,
            height: 20,
            width: 20,
          ),
          if (label != null) ...[
            const SizedBox(width: 8),
            Text(
              label,
              style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
            ),
          ],
        ],
      ),
    );
  }
}