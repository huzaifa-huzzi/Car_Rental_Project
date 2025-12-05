import 'package:flutter/material.dart';
import 'package:car_rental_project/Resources/AppSizes.dart';
import 'package:car_rental_project/Resources/Colors.dart';
import 'package:car_rental_project/Resources/TextTheme.dart';
import 'package:car_rental_project/Resources/IconStrings.dart';
import 'package:car_rental_project/Car Inventory/Car Directory/ReusableWidget/ButtonWidget.dart';

class CarListCard extends StatefulWidget {
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

  @override
  State<CarListCard> createState() => _CarListCardState();
}

class _CarListCardState extends State<CarListCard> {
  bool isHover = false;

  @override
  Widget build(BuildContext context) {
    final cardPadding = AppSizes.padding(context);

    return  Padding(
      padding: EdgeInsets.symmetric(
        horizontal: AppSizes.horizontalPadding(context),
        vertical: AppSizes.verticalPadding(context) * 0.5,
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          double whiteWidth;

          if (AppSizes.isWeb(context)) {
            whiteWidth = 800;
          } else if (constraints.maxWidth > 600) {
            whiteWidth = constraints.maxWidth - 170;
          } else {
            whiteWidth = constraints.maxWidth;
          }

          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MouseRegion(
                onEnter: (_) {
                  if (AppSizes.isWeb(context)) {
                    setState(() => isHover = true);
                  }
                  if (AppSizes.isMobile(context)) {
                    setState(() => isHover = true);
                  }
                  if (AppSizes.isTablet(context)) {
                    setState(() => isHover = true);
                  }
                },
                onExit: (_) {
                  if (AppSizes.isWeb(context)) {
                    setState(() => isHover = false);
                  }
                  if (AppSizes.isMobile(context)) {
                    setState(() => isHover = false);
                  }
                  if (AppSizes.isTablet(context)) {
                    setState(() => isHover = false);
                  }
                },
                child: Container(
                  width: whiteWidth,
                  padding: EdgeInsets.all(cardPadding * 0.8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(AppSizes.borderRadius(context)),
                      bottomLeft: Radius.circular(AppSizes.borderRadius(context)),
                      bottomRight: Radius.circular(AppSizes.borderRadius(context)),
                      topRight: Radius.circular(AppSizes.borderRadius(context)),
                    ),
                    border: Border.all(
                      color: isHover ? AppColors.primaryColor : Colors.transparent,
                      width: 2,
                    ),
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
              ),

              if (constraints.maxWidth > 600)
                _buildEditDelete(context)
              else
                SizedBox.shrink(),
            ],
          );
        },
      ),
    );

  }



 /// ---------- Extra Widgets


   // innerWhiteCard
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
   // carImage Widget
  Widget _buildCarImage(BuildContext context) {
    double width = AppSizes.isWeb(context) ? 140 : 100;

    String img = widget.image.startsWith("assets/")
        ? widget.image
        : "assets/images/${widget.image}";

    return ClipRRect(
      borderRadius:
      BorderRadius.circular(AppSizes.borderRadius(context) * 0.6),
      child: Image.asset(
        img,
        width: width,
        height: width * 0.65,
        fit: BoxFit.cover,
      ),
    );
  }
   // car details widget
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
              child: Text(widget.regId,
                  style: TTextTheme.titleseven(context)),
            ),
          ],
        ),
      ],
    );
  }

   // title block widget
  Widget _titleBlock(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(widget.name, style: TTextTheme.titleSix(context)),
            SizedBox(width: 5),
            Text(widget.model, style: TTextTheme.titleSix(context)),
          ],
        ),
        Text(widget.secondname, style: TTextTheme.h3Style(context)),
      ],
    );
  }
   // status badge widget
  Widget _statusBadge(BuildContext context) {
    Color bg = Colors.transparent;
    Color txt = Colors.black;

    String s = widget.status.toLowerCase();

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
      decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(8)),
      child: Text(
        widget.status,
        style: TTextTheme.smallX(context)
            ?.copyWith(color: txt, fontWeight: FontWeight.bold),
      ),
    );
  }

  // build specs widget
  Widget _buildSpecs(BuildContext context) {
    return Row(
      children: [
        _specBlock(context, IconString.transmissionIcon, "Transmission",
            widget.transmission),
        SizedBox(width: AppSizes.padding(context) * 2),
        _specBlock(context, IconString.capacityIcon, "Capacity",
            widget.capacity),
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
   // price block widget
  Widget _priceBlock(BuildContext context) {
    String amount = widget.price.split(RegExp(r'\/'))[0].trim();
    String period =
    widget.price.contains("/") ? "/" + widget.price.split("/")[1].trim() : "";

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Price", style: TTextTheme.titleFour(context)),
        SizedBox(height: 4),
        RichText(
          text: TextSpan(
            children: [
              TextSpan(text: "$amount ", style: TTextTheme.h5Style(context)),
              TextSpan(text: period, style: TTextTheme.titleTwo(context)),
            ],
          ),
        ),
      ],
    );
  }

  // edit /Delete widget
  Widget _buildEditDelete(BuildContext context) {
    final double boxWidth = AppSizes.isWeb(context)
        ? 170
        : AppSizes.isTablet(context)
        ? 150
        : 130;

    final double boxHeight = AppSizes.isWeb(context)
        ? 155
        : AppSizes.isTablet(context)
        ? 135
        : 115;

    return Container(
      height: boxHeight,
      width: boxWidth,
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
          _smallAction(context, "Edit", widget.onEdit),
          SizedBox(width: AppSizes.padding(context) * 0.4),
          _smallAction(context, "Delete", widget.onDelete),
        ],
      ),
    );
  }

  // small action widgets
  Widget _smallAction(BuildContext context, String text, VoidCallback? onTap) {
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
            Text(text, style: TTextTheme.btnTwo(context)),
          ],
        ),
      ),
    );
  }
}
