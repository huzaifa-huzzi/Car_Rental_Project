import 'package:car_rental_project/Customers/CustomersController.dart';
import 'package:car_rental_project/Customers/CustomersDetails/Widget/ResponsiveCardDetails.dart';
import 'package:car_rental_project/Customers/ReusableWidgetOfCustomers/AlertDialogCustomers.dart';
import 'package:car_rental_project/Resources/IconStrings.dart';
import 'package:car_rental_project/Resources/ImageString.dart';
import 'package:car_rental_project/Resources/TextString.dart';
import 'package:car_rental_project/Resources/TextTheme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import '../../../Car Inventory/Car Directory/ReusableWidget/AlertDialogs.dart';
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
          ///  HEADER SECTION
          _buildHeader(context, isMobile),
          const SizedBox(height: 35),

          ///  PERSONAL INFO SECTION
          _buildBorderedContainer(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(TextString.personalTitle,
                  style: TTextTheme.titleSix(context),
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
                            Expanded(child: _responsiveInfoItem(context, IconString.smsIcon, "Email", "Contact@SoftSnip.com.au")),
                            if (showGrid) ...[
                              const SizedBox(width: 20),
                              Expanded(child: _responsiveInfoItem(context, IconString.callIcon, "Contact Number", "+12 3456 7890")),
                              const SizedBox(width: 20),
                              Expanded(child: _responsiveInfoItem(context, IconString.location, "Address", "Toronto, California, 1234")),
                            ],
                          ],
                        ),

                        if (!showGrid) ...[
                          _responsiveInfoItem(context, IconString.callIcon, "Contact Number", "+12 3456 7890"),
                          _responsiveInfoItem(context, IconString.location, "Address", "Toronto, California, 1234"),
                        ],

                        const SizedBox(height: 20),

                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(child: _responsiveInfoItem(context, IconString.birthIcon, "Date of Birth", "12/03/2001")),
                            if (showGrid) ...[
                              const SizedBox(width: 20),
                              Expanded(child: _responsiveInfoItem(context,IconString.nidIcon, "NID Number", "123 456 789")),
                              const SizedBox(width: 20),
                              const Spacer(),
                            ] else ...[
                            ],
                          ],
                        ),
                        if (!showGrid) _responsiveInfoItem(context, IconString.nidIcon, "NID Number", "123 456 789"),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 35),

          ///  CUSTOMER NOTE
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSectionHeader(TextString.customerNoteTitle,context),
              const SizedBox(height: 12),
              Text(
                TextString.customerNoteSubtitleDetail,
                textAlign: TextAlign.start,
                style: TTextTheme.pOne(context),
              ),
            ],
          ),
          const SizedBox(height: 35),

          ///  LICENSE DETAILS
          _buildBorderedContainer(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  TextString.licenseDetailScreen,
                  style:  TTextTheme.titleSix(context)),
                const SizedBox(height: 25),

                LayoutBuilder(
                  builder: (context, constraints) {
                    bool isWideScreen = constraints.maxWidth > 900;

                    return Wrap(
                      spacing: isWideScreen ? (constraints.maxWidth / 10) : 42,
                      runSpacing: 30,
                      alignment: WrapAlignment.start,
                      children: [
                        _responsiveLicenseItem(context, IconString.licenseName, "License Name", "Carly Hevy"),
                        _responsiveLicenseItem(context,IconString.licesnseNo, "License Number", "1245985642"),
                        _responsiveLicenseItem(context, IconString.licenseCard, "Card Number", "1243567434"),
                        _responsiveLicenseItem(context, IconString.expiryDate, "Expiry Date", "12/02/2035"),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),


          ///  CARD DETAILS
          ResponsiveCardDetails(),
          const SizedBox(height: 32),

          ///  DOCUMENTS SECTION
          _buildBorderedContainer(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  TextString.customerDocumentDetails,
                  style: TTextTheme.titleSix(context)),
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

  /// --- Extra Widgets  ---///

   // BuildHeader Widget
  Widget _buildHeader(BuildContext context, bool isMobile) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final bool showDeleteText = screenWidth > 1100;

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
        Text(TextString.name, style: TTextTheme.h1Style(context)),
        Text(TextString.jobTitle, style: TTextTheme.titleDriver(context)),
      ],
    );

    if (isMobile) {
      return Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              _headerActionBtn(
                  IconString.editIcon,
                  context, null,
                  isDelete: false,
                  onTap: (){
                    context.push(
                      '/editCustomers',
                      extra: {"hideMobileAppBar": true},
                    );
                  }),
              const SizedBox(width: 10),
              _headerActionBtn(
                  IconString.deleteIcon,
                  context, null,
                  isDelete: true,
                onTap: (){
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (_) =>
                        ResponsiveCustomerDialog(
                          onCancel: () {
                            context.pop();
                          },
                          onConfirm: () {
                            context.pop();
                          },
                        ),
                  );
                }
              ),
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
        _headerActionBtn(
            IconString.editIcon,
            context, "Edit",
            isDelete: false,
            onTap: (){
              context.push(
                '/editCustomers',
                extra: {"hideMobileAppBar": true},
              );
            },
        ),
        const SizedBox(width: 12),
        _headerActionBtn(
            IconString.deleteIcon,
            context,
            showDeleteText ? "Delete" : null,
            isDelete: true,
            onTap: (){
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (_) =>
                    ResponsiveCustomerDialog(
                      onCancel: () {
                        context.pop();
                      },
                      onConfirm: () {
                        context.pop();
                      },
                    ),
              );

            }
        ),
      ],
    );
  }

 // document Box Widget
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
                Text(label, style: TTextTheme.titleFour(context)),
                const SizedBox(height: 2),
                Row(
                  children: [
                    Flexible(
                      child: Text(
                        status,
                        style: TTextTheme.titleseven(context),
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


  // SectionHeaderWidget
  Widget _buildSectionHeader(String title,BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Text(
        title,
        textAlign: TextAlign.start,
        style: TTextTheme.titleSix(context)
      ),
    );
  }

   // borderContainer Widget
  Widget _buildBorderedContainer({required Widget child, EdgeInsets? padding}) {
    return Container(
      width: double.infinity,
      padding: padding ?? const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.tertiaryTextColor, width: 1.2),
      ),
      child: child,
    );
  }

   // responsiveLicenseItem Widget
  Widget _responsiveLicenseItem(BuildContext context, String iconPath, String label, String value) {
    final double screenWidth = MediaQuery.of(context).size.width;
    bool isMobile = screenWidth < 600;

    return Container(
      width: isMobile ? double.infinity : null,
      constraints: BoxConstraints(minWidth: isMobile ? 0 : 160),
      child: IntrinsicWidth(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: AppColors.secondaryColor,
                  borderRadius: BorderRadius.circular(10)
              ),
              child: Image.asset(iconPath, width: 18, height: 18),
            ),
            const SizedBox(width: 12),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(label, style: TTextTheme.titleFour(context)),
                  const SizedBox(height: 2),
                  Text(
                    value,
                    style: TTextTheme.titleseven(context),
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

   // responsiveInfoItem Widget
  Widget _responsiveInfoItem(BuildContext context, String iconPath, String label, String value, {double? width}) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final bool isSmallMobile = screenWidth < 600;

    return Container(
      width: isSmallMobile ? double.infinity : width,
      margin: const EdgeInsets.only(bottom: 10),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppColors.secondaryColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Image.asset(iconPath, width: 18, height: 18),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(label, style: TTextTheme.titleFour(context)),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: TTextTheme.titleseven(context),
                  maxLines: 1,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // headerAction Button Widget
  Widget _headerActionBtn(
      String iconPath,
      BuildContext context,
      String? label,
      {required bool isDelete, required VoidCallback onTap}
      ) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: label != null ? 14 : 10, vertical: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color:  AppColors.tertiaryTextColor,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
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
                style: TTextTheme.btnTwo(context)
              ),
            ],
          ],
        ),
      ),
    );
  }
}