import 'package:car_rental_project/Car%20Inventory/Car%20Directory/ReusableWidget/ButtonWidget.dart';
import 'package:car_rental_project/Resources/Colors.dart';
import 'package:car_rental_project/Resources/TextTheme.dart';
import 'package:flutter/material.dart';
import 'package:car_rental_project/Resources/AppSizes.dart';
import 'package:car_rental_project/Resources/IconStrings.dart'; // Ensure this file exists

class CarListItemWidget extends StatelessWidget {
  final String carImage;
  final String carName;
  final String carYear;
  final String transmission;
  final String capacity;
  final String price;
  final String status;
  final String registrationId;

  const CarListItemWidget({
    super.key,
    required this.carImage,
    required this.carName,
    required this.carYear,
    required this.transmission,
    required this.capacity,
    required this.price,
    required this.status,
    required this.registrationId,
  });

  @override
  Widget build(BuildContext context) {
    bool isWeb = AppSizes.isWeb(context);
    bool isSmallScreen = !isWeb;

    final cardPadding = AppSizes.padding(context);

    Color statusColor = AppColors.blackColor;
    Color statusBGColor = Colors.transparent;

    if (status == "Available") {
      statusBGColor = AppColors.availableBackgroundColor;
      statusColor = Colors.white;
    }

    // Main Item Container
    final Widget content = Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: AppSizes.horizontalPadding(context), vertical: AppSizes.verticalPadding(context) * 0.3),
      padding: EdgeInsets.all(cardPadding),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppSizes.borderRadius(context)),
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.05),
            offset: Offset(0, 2),
            blurRadius: 4,
          ),
        ],
      ),

      // *** HORIZONTAL SCROLL LOGIC APPLIED HERE ***
      child: isSmallScreen
          ? SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: SizedBox(
          width: MediaQuery.of(context).size.width < 800 ? 800 : null,
          child: _buildRowContent(context, isWeb, isSmallScreen, statusColor, statusBGColor),
        ),
      )
          : _buildRowContent(context, isWeb, isSmallScreen, statusColor, statusBGColor),
    );

    return content;
  }

  // --- New Helper Function to build the internal Row content ---
  Widget _buildRowContent(BuildContext context, bool isWeb, bool isSmallScreen, Color statusColor, Color statusBGColor) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // 1. CAR INFO (Image, Name, Status)
        _buildCarInfo(context, isWeb, carImage, carName, carYear, status, statusColor, statusBGColor, registrationId),

        // Flexible space between Car Info and Specs (Only on Large Screens)
        if (!isSmallScreen) Expanded(child: SizedBox()),

        // 2. CAR SPECIFICATIONS (Transmission, Capacity, Price)
        // Specs will be spaced out by SizedBox (padding) on small screens for scroll
        _buildCarSpecs(context, transmission, capacity, price),

        // 3. ACTIONS (View, Edit, Delete)
        // Add required spacing before actions on small screens for better scroll visibility
        SizedBox(width: AppSizes.padding(context) * (isSmallScreen ? 2 : 0)),
        _buildActions(context),
      ],
    );
  }


  // --- Helper Widgets (Skipping unchanged content for brevity, focusing on Actions) ---

  Widget _buildCarInfo(BuildContext context, bool isWeb, String image, String name, String year, String status, Color textColor, Color statusBGColor, String regId) {
    // ... (Content remains same as last version)
    final imageWidth = AppSizes.isWeb(context) ? 140.0 : 100.0;
    String adjustedImage = image.startsWith('assets/') ? image : 'assets/images/$image';

    return Row(
      children: [
        // Image
        Image.asset(
          adjustedImage,
          width: imageWidth,
          height: imageWidth * 0.65,
          fit: BoxFit.contain,
          errorBuilder: (context, error, stackTrace) {
            return Container(
              width: imageWidth,
              height: imageWidth * 0.65,
              color: Colors.grey[200],
              child: Center(child: Text("Car Img", style: TextStyle(fontSize: 10))),
            );
          },
        ),
        SizedBox(width: AppSizes.padding(context) * 0.75),

        // Text Info
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "$name $year",
              style: TTextTheme.titleOne(context),
            ),

            Text(
              "Martin",
              style: TTextTheme.titleOne(context)?.copyWith(fontWeight: FontWeight.bold, fontSize: AppSizes.isMobile(context) ? 16 : 18),
            ),

            if (status == "Available")
              Column(
                children: [
                  SizedBox(height: AppSizes.padding(context) * 0.2),

                  Container(
                    padding: EdgeInsets.symmetric(horizontal: AppSizes.padding(context) * 0.6, vertical: AppSizes.padding(context) * 0.2),
                    decoration: BoxDecoration(
                      color: statusBGColor,
                      borderRadius: BorderRadius.circular(AppSizes.borderRadius(context) * 0.5),
                    ),
                    child: Text(
                      status,
                      style: TTextTheme.smallX(context)?.copyWith(
                        color: textColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),

            SizedBox(height: AppSizes.padding(context) * 0.2),

            // Registration ID
            Text(
              "Registration | $regId",
              style: TTextTheme.smallX(context)?.copyWith(color: AppColors.secondTextColor),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildCarSpecs(BuildContext context, String transmission, String capacity, String price) {
    // ... (Content remains same as last version)
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(right: AppSizes.padding(context) * 1.5),
          child: _specDetailColumn(context, IconString.transmissionIcon, "Transmission", transmission),
        ),

        Padding(
          padding: EdgeInsets.only(right: AppSizes.padding(context) * 1.5),
          child: _specDetailColumn(context, IconString.capacityIcon, "Capacity", capacity),
        ),

        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Price", style: TTextTheme.smallX(context)?.copyWith(color: AppColors.secondTextColor)),
            SizedBox(height: AppSizes.padding(context) * 0.1),
            Text(price, style: TTextTheme.titleTwo(context)?.copyWith(color: AppColors.textColor, fontWeight: FontWeight.bold)),
          ],
        ),
      ],
    );
  }

  Widget _specDetailColumn(BuildContext context, String iconPath, String label, String value) {
    final iconSize = AppSizes.padding(context) * 1.0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Image.asset(
              iconPath,
              width: iconSize,
              height: iconSize,
              color: AppColors.secondTextColor,
            ),
            SizedBox(width: AppSizes.padding(context) * 0.2),
            Text(label, style: TTextTheme.smallX(context)?.copyWith(color: AppColors.secondTextColor)),
          ],
        ),
        SizedBox(height: AppSizes.padding(context) * 0.1),
        Text(
          value,
          style: TTextTheme.titleTwo(context)?.copyWith(color: AppColors.blackColor, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  // --- ACTIONS FIX ---
  Widget _buildActions(BuildContext context) {
    // Adjusted padding values to closely match the visual size of the buttons in the design
    final horizontalPadding = AppSizes.padding(context) * 0.4;
    final verticalPadding = AppSizes.padding(context) * 0.4;
    final space = SizedBox(width: AppSizes.padding(context) * 0.4);

    return Row(
      // Keep alignment right for the whole list item, but contents flow naturally
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        // 1. VIEW Button (Red/Primary) - Needs more width than the other buttons
        AddButton(
          text: "View",
          onTap: (){},
          height: 40,
          width: 90, // Fixed width
          borderRadius: AppSizes.borderRadius(context) * 0.8,
        ),

        // --- GAP between View and Edit/Delete Container ---
        SizedBox(width: AppSizes.padding(context) * 0.75),

        // 2. EDIT / DELETE Wrapper (AppColors.sideBoxesColor)
        Container(
          // Padding inside the grey box to wrap the two buttons
          padding: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: verticalPadding),
          decoration: BoxDecoration(
            color: AppColors.sideBoxesColor, // Light Grey Background
            borderRadius: BorderRadius.circular(AppSizes.borderRadius(context)),
          ),
          child: Row(
            children: [
              // EDIT Button (Icon + Text)
              _actionButton(context,  "Edit"),

              // Space between Edit and Delete
              SizedBox(width: AppSizes.padding(context) * 0.5),

              // DELETE Button (Icon + Text)
              _actionButton(context, "Delete"),
            ],
          ),
        ),
      ],
    );
  }

  // Custom Action Button (Edit/Delete) with Icon and Text
  Widget _actionButton(BuildContext context, String text) {
    return GestureDetector(
      // Add tap functionality here if needed
      onTap: (){},
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          SizedBox(width: AppSizes.padding(context) * 0.1),
          // Text
          Text(
            text,
            style: TTextTheme.smallX(context)?.copyWith(
              color: AppColors.blackColor, // Text color
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}