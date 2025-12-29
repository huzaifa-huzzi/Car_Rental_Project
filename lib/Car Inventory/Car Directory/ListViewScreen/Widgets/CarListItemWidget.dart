import 'package:car_rental_project/Resources/TextString.dart';
import 'package:flutter/material.dart';
import 'package:car_rental_project/Resources/AppSizes.dart';
import 'package:car_rental_project/Resources/Colors.dart';
import 'package:car_rental_project/Resources/TextTheme.dart';
import 'package:car_rental_project/Resources/IconStrings.dart';
import 'package:car_rental_project/Car Inventory/Car Directory/ReusableWidget/ButtonWidget.dart';
import 'package:go_router/go_router.dart';

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
  final String regId2;
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
    required this.regId2,
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

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: AppSizes.horizontalPadding(context),
        vertical: AppSizes.verticalPadding(context) * 0.5,
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          double whiteWidth;

          if (AppSizes.isWeb(context)) {
            whiteWidth = 850;
          } else if (constraints.maxWidth > 600) {
            whiteWidth = constraints.maxWidth - 170;
          } else {
            whiteWidth = constraints.maxWidth;
          }

          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MouseRegion(
                onEnter: (_) => setState(() => isHover = true),
                onExit: (_) => setState(() => isHover = false),
                child: Container(
                  width: whiteWidth,
                  padding: EdgeInsets.all(cardPadding * 0.5),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(AppSizes.borderRadius(context)),
                      bottomLeft: Radius.circular(AppSizes.borderRadius(context)),
                    ),
                    border: Border.all(
                      color: isHover ? AppColors.primaryColor : Colors.transparent,
                      width: 0.5,
                    ),
                  ),
                  child: _innerWhiteCard(context),
                ),
              ),

              if (constraints.maxWidth > 600)
                _buildEditDelete(context)
              else
                const SizedBox.shrink(),
            ],
          );
        },
      ),
    );
  }

  /// --------- Extra Widgets --------- ///

  // White Card Widget
  Widget _innerWhiteCard(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildCarImageWithStatus(context),
        SizedBox(width: AppSizes.padding(context) * 0.8),

        Expanded(
          flex: 4,
          child: _buildCarDetails(context),
        ),

        Expanded(
          flex: 6,
          child: _buildSpecs(context),
        ),

        Padding(
          padding: EdgeInsets.only(left: AppSizes.padding(context) * 0.5),
          child: SizedBox(
            width: 85,
            height: 38,
            child: AddButton(
                text: 'View',
                onTap: widget.onView ?? () {
                  context.push('/cardetails', extra: {"hideMobileAppBar": true});
                }
            ),
          ),
        ),
      ],
    );
  }

   // Car Details Widget
  Widget _buildCarDetails(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          children: [
            Text(widget.name, style: TTextTheme.titleSix(context)),
            const SizedBox(width: 4),
            Text(widget.model, style: TTextTheme.titleSix(context)),
          ],
        ),
        const SizedBox(height: 2),
        Text(widget.secondname, style: TTextTheme.h3Style(context)),
        const SizedBox(height: 8),

        _scrollableIdRow(TextString.registration, widget.regId, AppColors.textColor, context),

        const SizedBox(height: 6),

        _scrollableIdRow(TextString.vin, widget.regId2, AppColors.backgroundOfVin, context),
      ],
    );
  }

  // Scrollable Widget for Specs
  Widget _scrollableIdRow(String label, String value, Color labelBg, BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: labelBg,
            borderRadius: const BorderRadius.only(topLeft: Radius.circular(6), bottomLeft: Radius.circular(6)),
          ),
          child: Text(label, style: TTextTheme.titleeight(context)),
        ),
        Flexible(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: AppColors.secondaryColor,
              borderRadius: const BorderRadius.only(topRight: Radius.circular(6), bottomRight: Radius.circular(6)),
            ),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Text(
                value,
                style: TTextTheme.titleseven(context),
                maxLines: 1,
              ),
            ),
          ),
        ),
      ],
    );
  }

   // Build Specs Widget
  Widget _buildSpecs(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _specBlock(context, IconString.transmissionIcon, "Transmission", widget.transmission),
        const SizedBox(width: 8),
        _specBlock(context, IconString.capacityIcon, "Seats", widget.capacity),
        const SizedBox(width: 8),
        _priceBlock(context),
      ],
    );
  }

  //  Car Image Widget
  Widget _buildCarImageWithStatus(BuildContext context) {
    double width = 140;
    String img = widget.image.startsWith("assets/") ? widget.image : "assets/images/${widget.image}";

    return Stack(
      clipBehavior: Clip.none,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(AppSizes.borderRadius(context) * 0.6),
          child: Image.asset(
            img,
            width: width,
            height: width * 0.60,
            fit: BoxFit.contain,
          ),
        ),
        Positioned(
          top: -20,
          left: 0,
          child: _statusBadge(context),
        ),
      ],
    );
  }

  //  Spec Block Widgets
  Widget _specBlock(BuildContext context, String icon, String title, String value) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: AppColors.secondaryColor,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
            child: Image.asset(icon, width: 20, height: 20, color: AppColors.blackColor),
          ),
        ),
        const SizedBox(height: 8),
        Text(title, style: TTextTheme.titleFour(context)),
        const SizedBox(height: 4),
        Text(value, style: TTextTheme.titleSmallTexts(context)),
      ],
    );
  }

  // 5. Price Block Widget
  Widget _priceBlock(BuildContext context) {
    String amount = widget.price.split(RegExp(r'\/'))[0].trim();
    String period = widget.price.contains("/") ? "/" + widget.price.split("/")[1].trim() : "";

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(TextString.price, style: TTextTheme.titleFour(context)),
        const SizedBox(height: 6),
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

  // 6. Status Badge Widget
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
      decoration: BoxDecoration(
        color: bg,
        borderRadius:BorderRadius.circular(6),
      ),
      child: Text(
        widget.status,
        style: TTextTheme.smallX(context)?.copyWith(color: txt,),
      ),
    );
  }

  //  Edit / Delete Widget
  Widget _buildEditDelete(BuildContext context) {

    final double boxWidth = AppSizes.isWeb(context)
        ? 155
        : AppSizes.isTablet(context) ? 160 : 150;

    final double boxHeight = AppSizes.isWeb(context)
        ? 146
        : AppSizes.isTablet(context) ? 120 : 115;


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
          const SizedBox(width: 8),
          _smallAction(context, "Delete", widget.onDelete),
        ],
      ),
    );
  }

  Widget _smallAction(BuildContext context, String text, VoidCallback? onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            )
          ],
        ),
        child: Text(text, style: TTextTheme.btnTwo(context)),
      ),
    );
  }
}