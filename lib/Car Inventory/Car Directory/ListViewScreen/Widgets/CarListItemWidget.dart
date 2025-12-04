import 'package:flutter/material.dart';
import 'package:car_rental_project/Resources/AppSizes.dart';
import 'package:car_rental_project/Resources/Colors.dart';
import 'package:car_rental_project/Resources/TextTheme.dart';
import 'package:car_rental_project/Resources/IconStrings.dart';
import 'package:car_rental_project/Car Inventory/Car Directory/ReusableWidget/ButtonWidget.dart';

class CarListCard extends StatelessWidget {
  final String image;
  final String name;
  final String secondname;
  final String model;
  final String transmission;
  final String capacity;
  final String price;
  final String status;
  final String regId;
  final VoidCallback? onView;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  const CarListCard({
    super.key,
    required this.image,
    required this.name,
    required this.secondname,
    required this.model,
    required this.transmission,
    required this.capacity,
    required this.price,
    required this.status,
    required this.regId,
    this.onView,
    this.onEdit,
    this.onDelete,
  });

  Widget build(BuildContext context) {
    final cardPadding = AppSizes.padding(context);

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: AppSizes.horizontalPadding(context),
        vertical: AppSizes.verticalPadding(context) * 0.5,
      ),
      child: Stack(
        children: [
          // WHITE CARD
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(cardPadding * 0.9),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius:
              BorderRadius.circular(AppSizes.borderRadius(context)),
              boxShadow: const [
                BoxShadow(
                  color: Color.fromRGBO(0, 0, 0, 0.05),
                  offset: Offset(0, 2),
                  blurRadius: 4,
                ),
              ],
            ),
            child: _innerWhiteCard(context),
          ),
          Positioned(
            right: 0,
            top: 0,
            bottom: 0,
            child: _buildEditDelete(context),
          ),
        ],
      ),
    );
  }

  /// ------ Extra widgets

  // INNER CONTENT
  Widget _innerWhiteCard(BuildContext context) {
    return Row(
      children: [
        _buildCarImage(context),
        SizedBox(width: AppSizes.padding(context)),
        _buildCarDetails(context),
        SizedBox(width: AppSizes.padding(context)),
        _buildSpecs(context),
        SizedBox(width: AppSizes.padding(context)),
        AddButton(text: 'View', onTap: (){}),
      ],
    );
  }

  //  IMAGE
  Widget _buildCarImage(BuildContext context) {
    double width = AppSizes.isWeb(context) ? 140 : 100;

    String img = image.startsWith("assets/") ? image : "assets/images/$image";

    return ClipRRect(
      borderRadius:
      BorderRadius.circular(AppSizes.borderRadius(context) * 0.6),
      child: Image.asset(
        img,
        width: width,
        height: width * 0.65,
        fit: BoxFit.cover,
        errorBuilder: (c, e, s) => Container(
          width: width,
          height: width * 0.65,
          color: AppColors.quadrantalTextColor,
          child: Center(
              child: Text("Img", style: TTextTheme.titleTwo(context))),
        ),
      ),
    );
  }

  // DETAILS
  Widget _buildCarDetails(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _titleBlock(context),
        SizedBox(height: 6),
        _statusBadge(context),
        SizedBox(height: 6),

        Row(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: AppColors.textColor,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text("Registration", style: TTextTheme.titleeight(context)),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: AppColors.secondaryColor,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text("$regId", style: TTextTheme.titleseven(context)),
            ),
          ],
        ),
      ],
    );
  }

  // NAME + MODEL
  Widget _titleBlock(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text("$name", style: TTextTheme.titleSix(context)),
            SizedBox(width: 5),
            Text("$model", style: TTextTheme.titleSix(context)),
          ],
        ),
        Text(secondname, style: TTextTheme.h3Style(context)),
      ],
    );
  }

  // STATUS BADGE
  Widget _statusBadge(BuildContext context) {
    Color bg = Colors.transparent;
    Color txt = Colors.black;

    String s = status.toLowerCase();

    if (s == "available") {
      bg = AppColors.availableBackgroundColor;
      txt = Colors.white;
    } else if (s == "maintenance") {
      bg = AppColors.maintenanceBackgroundColor;
      txt = Colors.black;
    } else if (s == "unavailable") {
      bg = AppColors.sideBoxesColor;
      txt = AppColors.secondTextColor;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration:
      BoxDecoration(color: bg, borderRadius: BorderRadius.circular(8)),
      child: Text(
        status,
        style: TTextTheme.smallX(context)
            ?.copyWith(color: txt, fontWeight: FontWeight.bold),
      ),
    );
  }

  // SPECS widget
  Widget _buildSpecs(BuildContext context) {
    return Row(
      children: [
        _specBlock(context, IconString.transmissionIcon, "Transmission",
            transmission),
        SizedBox(width: AppSizes.padding(context) * 2),
        _specBlock(context, IconString.capacityIcon, "Capacity", capacity),
        SizedBox(width: AppSizes.padding(context) * 2),
        _priceBlock(context),
      ],
    );
  }

  Widget _specBlock(
      BuildContext context, String icon, String title, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 28,
          height: 28,
          decoration: BoxDecoration(
            color: AppColors.secondaryColor,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Center(
            child: Image.asset(
              icon,
              width: 16,
              height: 16,
              color: AppColors.blackColor,
            ),
          ),
        ),
        SizedBox(height: 6),
        Text(title, style: TTextTheme.titleFour(context)),
        SizedBox(height: 4),
        Text(value, style: TTextTheme.titleSmallTexts(context)),
      ],
    );
  }

  Widget _priceBlock(BuildContext context) {
    String amount = price.split(RegExp(r'\/'))[0].trim();
    String period = price.contains("/") ? "/" + price.split("/")[1].trim() : "";

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Price", style: TTextTheme.titleFour(context)),
        SizedBox(height: 4),
        RichText(
          text: TextSpan(
            children: [
              TextSpan(text: amount + " ", style: TTextTheme.h5Style(context)),
              TextSpan(text: period, style: TTextTheme.titleTwo(context)),
            ],
          ),
        ),
      ],
    );
  }

  //  Edit and delete widget
  Widget _buildEditDelete(BuildContext context) {
    return Container(
      height: 165,
      width: 170,
      decoration: BoxDecoration(
        color: AppColors.sideBoxesColor,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(AppSizes.borderRadius(context)),
          bottomRight: Radius.circular(AppSizes.borderRadius(context)),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _smallAction(context, "Edit", onEdit),
          SizedBox(width: 5),
          _smallAction(context, "Delete", onDelete),
        ],
      ),
    );
  }

  // SMALL BUTTON widget
  Widget _smallAction(BuildContext context, String text,
      VoidCallback? onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.08),
              blurRadius: 3,
              offset: Offset(0, 1),
            ),
          ],
        ),
        child: Row(
          children: [
            Text(
              text,
              style: TTextTheme.btnTwo(context),
            ),
          ],
        ),
      ),
    );
  }
}
