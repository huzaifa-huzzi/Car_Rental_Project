import 'package:car_rental_project/Car%20Inventory/Car%20Directory/CarInventoryController.dart';
import 'package:car_rental_project/Car%20Inventory/Car%20Directory/ReusableWidget/AlertDialogs.dart';
import 'package:car_rental_project/Resources/Colors.dart';
import 'package:car_rental_project/Resources/ImageString.dart';
import 'package:car_rental_project/Resources/TextTheme.dart';
import 'package:flutter/material.dart';
import 'package:car_rental_project/Resources/AppSizes.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import '../../../Resources/IconStrings.dart' show IconString;
import '../../../Resources/TextString.dart' show TextString;


class CarDetailBodyWidget extends StatefulWidget {
  const CarDetailBodyWidget({super.key});

  @override
  State<CarDetailBodyWidget> createState() => _CarDetailBodyWidgetState();
}

class _CarDetailBodyWidgetState extends State<CarDetailBodyWidget> {
  int _selectedIndex = 0;

  final List<String> carImages = const [
    ImageString.corollaPicone,
    ImageString.corollaPicFour,
    ImageString.corollaPicThree,
  ];

  final List<Map<String, dynamic>> specifications = const [
    {'title': 'Vin Number', 'value': 'JTNBA3HK003001234', 'icon': IconString.vinNumberIcon},
    {'title': 'Registration', 'value': '1234567890', 'icon': IconString.registrationIcon},
    {'title': 'Transmission', 'value': 'Automatic', 'icon': IconString.transmissionIcon},
    {'title': 'Capacity', 'value': '4 Seats', 'icon': IconString.capacityIcon},
    {'title': 'Model Year', 'value': '2017', 'icon': IconString.modelYearIcon},
    {'title': 'Engine Size', 'value': '2.5(L)', 'icon': IconString.engineSizeIcon},
    {'title': 'Car Values', 'value': '35000\$Aud', 'icon': IconString.carValueIcon},
    {'title': 'Mileage', 'value': '43000(Km)', 'icon': IconString.milageIcon},
    {'title': 'Fuel', 'value': 'Petrol', 'icon': IconString.gasPumpIcon},
  ];

  @override
  Widget build(BuildContext context) {
    final isMobile = AppSizes.isMobile(context);
    final isWeb = AppSizes.isWeb(context);

    return isWeb
        ? _buildWebLayout(context, isMobile)
        : _buildMobileLayout(context, isMobile);
  }


// Main Card Wrapper
  Widget _buildCardWrapper(
      {required Widget child, required BuildContext context}) {
    final double spacing = AppSizes.padding(context);
    final double borderRadius = AppSizes.borderRadius(context);

    return Container(
      padding: EdgeInsets.fromLTRB(spacing * 1.5, spacing * 1.5, spacing * 1.5, 0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(borderRadius),
        boxShadow: [

        ],
      ),
      child: child,
    );
  }

  ///----- Extra Widgets ------ ///


// --- Web Layout
  Widget _buildWebLayout(BuildContext context, bool isMobile) {
    final double spacing = AppSizes.padding(context);

    return _buildCardWrapper(
      context: context,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 4,
                child: _buildMainCarImage(context),
              ),
              SizedBox(width: spacing),
              Expanded(
                flex: 1,
                child: _buildImageThumbnailList(context),
              ),
            ],
          ),

          SizedBox(height: spacing * 1.5),
          _buildCarDetailsSection(context, isMobile),
          SizedBox(height: spacing * 1.5),
          _buildSpecificationsSection(context),
          SizedBox(height: spacing * 1.5),
          _buildCarDocumentsSection(context),
        ],
      ),
    );
  }

//  Mobile Layout  Widget
  Widget _buildMobileLayout(BuildContext context, bool isMobile) {
    final double spacing = AppSizes.padding(context);

    return _buildCardWrapper(
      context: context,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildMainCarImage(context, isMobile: true),


          SizedBox(height: spacing * 1.5),

          _buildCarDetailsSection(context, isMobile),
          SizedBox(height: spacing * 1.5),
          _buildSpecificationsSection(context),
          SizedBox(height: spacing * 1.5),
          _buildCarDocumentsSection(context),
        ],
      ),
    );
  }


// Car Image Widget
  Widget _buildMainCarImage(BuildContext context, {bool isMobile = false}) {
    final double borderRadius = AppSizes.borderRadius(context);
    final double height = AppSizes.isWeb(context) ? 400 : 250;

    if (isMobile) {
      return Column(
        children: [
          Container(
            width: double.infinity,
            height: height,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(borderRadius),
              border: Border.all(
                color: AppColors.tertiaryTextColor,
                width: 0.5,
              ),
            ),
            child: PageView.builder(
              itemCount: carImages.length,
              controller: PageController(initialPage: _selectedIndex),
              onPageChanged: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.zero,
                  child: Image.asset(
                    carImages[index],
                    fit: BoxFit.contain,
                  ),
                );
              },
            ),
          ),
          SizedBox(height: 8),

          // Image Indicator Dots
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(carImages.length, (index) {
              return Container(
                width: 8.0,
                height: 8.0,
                margin: EdgeInsets.symmetric(horizontal: 4.0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _selectedIndex == index
                      ? AppColors.primaryColor
                      : AppColors.tertiaryTextColor.withOpacity(0.5),
                ),
              );
            }),
          ),
        ],
      );
    }
    //  Web layout
    else {
      String currentImagePath = carImages[_selectedIndex];

      return Container(
        width: double.infinity,
        height: height,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: AppColors.tertiaryTextColor,
            width: 0.5,
          ),
          borderRadius: BorderRadius.circular(borderRadius),
          image: DecorationImage(
            image: AssetImage(currentImagePath),
            fit: BoxFit.contain,
          ),
        ),
      );
    }
  }


//  Thumbnails (only for web)
  Widget _buildImageThumbnailList(BuildContext context,
      {bool isMobile = false}) {
    final double borderRadius = AppSizes.borderRadius(context);
    final double thumbnailSize = 123;

    if (isMobile) {
      return Container();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(carImages.length, (index) {
        return Padding(
          padding: EdgeInsets.only(bottom: AppSizes.padding(context) * 0.5),
          child: _buildThumbnailItem(
              context, index, borderRadius, thumbnailSize),
        );
      }),
    );
  }

  Widget _buildThumbnailItem(BuildContext context, int index,
      double borderRadius, double thumbnailSize) {
    String imagePath = carImages[index];
    bool isSelected = index == _selectedIndex;

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedIndex = index;
        });
      },
      child: Container(
        width: thumbnailSize,
        height: thumbnailSize,
        decoration: BoxDecoration(
          color: Colors.white,

          borderRadius: BorderRadius.circular(borderRadius),

          border: Border.all(
            color: isSelected ? AppColors.primaryColor : AppColors
                .tertiaryTextColor,
            width: 0.5,
          ),

          image: DecorationImage(
            image: AssetImage(imagePath),
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }

  //  Car Details Section Widget
  Widget _buildCarDetailsSection(BuildContext context, bool isMobile) {
    final spacing = AppSizes.padding(context);

    if (isMobile) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(TextString.carDetailTitle, style: TTextTheme.titleSix(context)),

          SizedBox(height: 4),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                 TextString.carDetailSubtitle,
                  style: TTextTheme.h1Style(context),
                  softWrap: true,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),

              Row(
                children: [
                  _buildIconButton(context, IconString.editIcon,onTap: (){
                    context.push('/editCar', extra: {"hideMobileAppBar": true});
                  }),
                  SizedBox(width: 8),
                  _buildIconButton(context, IconString.deleteIcon,onTap: (){
                      showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (_) =>
                            ResponsiveDeleteDialog(
                              onCancel: () {
                                context.pop();
                              },
                              onConfirm: () {
                                context.pop();
                              },
                            ),
                      );
                  }),
                ],
              ),
            ],
          ),

          Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: AppColors.availableBackgroundColor,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(TextString.carDetailStatus,
              style:TTextTheme.titleeight(context),
            ),
          ),


          SizedBox(height: 10.0),


          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("\$50",
                  style: TTextTheme.h5Style(context)),

              SizedBox(height: 3),

              Text(TextString.carDetailweekly,
                  style: TTextTheme.titleFour(context)),
            ],
          ),


          SizedBox(height: 15.0),

          // About Section
          Text(TextString.carDetailabout,
              style: TTextTheme.titleSix(context)),
          SizedBox(height: 6),

          Text(
            TextString.carDescriptionTitle,
            style: TTextTheme.pOne(context),
            maxLines: 5,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      );
    }

    // WEB LAYOUT
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(TextString.carDetailTitle, style: TTextTheme.titleSix(context)),
                  SizedBox(height: 4),
                  Text(TextString.carDetailSubtitle,
                      style: TTextTheme.h1Style(context)),
                ],
              ),
            ),
            Row(
              children: [
                _buildIconButton(
                  context,
                 IconString.editIcon,
                  label: "Edit",
                  onTap: () {
                    context.push('/editCar', extra: {"hideMobileAppBar": true});
                  },
                ),
                SizedBox(width: 8),
                _buildIconButton(context, IconString.deleteIcon,onTap: (){
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (_) =>
                        ResponsiveDeleteDialog(
                          onCancel: () {
                            context.pop();
                          },
                          onConfirm: () {
                            context.pop();
                          },
                        ),
                  );

                }),
              ],
            ),
          ],
        ),
        SizedBox(height: spacing/2),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: AppColors.availableBackgroundColor,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(TextString.carDetailStatus,
              style: TTextTheme.titleFour(context).copyWith(color: Colors.white, fontWeight: FontWeight.bold)),
        ),
        SizedBox(height: spacing),
        Row(
          children: [
            Text("\$50",
                style: TTextTheme.h5Style(context)),
          ],
        ),
        Column(
          children: [

            Text(TextString.carDetailweekly,
                style: TTextTheme.titleFour(context)),
          ],
        ),

        SizedBox(height: spacing * 1.5),
        Text(TextString.carDetailabout,
            style:TTextTheme.titleSix(context)),
        SizedBox(height: 6),
        Text(
          TextString.carDescriptionTitle,
          style: TTextTheme.pOne(context),
          maxLines: 5,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }


//  Specifications Widget
  Widget _buildSpecificationsSection(BuildContext context) {
    final spacing = AppSizes.padding(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          TextString.carDetailsSpecifications,
          style: TTextTheme.titleSix(context),
        ),
        SizedBox(height: spacing),

        LayoutBuilder(
          builder: (context, constraints) {
            final double totalWidth = constraints.maxWidth;
            final double horizontalSpacing = 10;

            double itemWidth;
            int columns;

            if (totalWidth >= 550) {
              columns = 4;
            } else if (totalWidth >= 350) {
              columns = 3;
            } else {
              columns = 2;
            }
            final double totalSpacing = horizontalSpacing * (columns - 1);
            itemWidth = (totalWidth - totalSpacing) / columns;

            final List<Widget> specWidgets = specifications.map((spec) {
              return SizedBox(
                width: itemWidth,
                child: _buildSpecTile(
                  context,
                  spec['icon'] as String,
                  spec['title'] as String,
                  spec['value'] as String,
                  isMobile: columns <= 3,
                ),
              );
            }).toList();

            return Wrap(
              spacing: horizontalSpacing,
              runSpacing: 20,
              children: specWidgets,
            );
          },
        ),
      ],
    );
  }


//  Specification Tile
  Widget _buildSpecTile(
      BuildContext context, String icon, String title, String value, {required bool isMobile}) {
    final double iconSize = isMobile ? 26 : 35;
    final double spacing = isMobile ? 9 : 14;
    final double textSpacing = isMobile ? 2 : 3;

    if (isMobile) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ICON BOX
          Container(
            height: iconSize,
            width: iconSize,
            decoration: BoxDecoration(
              color: AppColors.secondaryColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Image.asset(
                icon,
                height: 20,
                width: 20,
              ),
            ),
          ),

          SizedBox(width: spacing),

          // TITLE + VALUE
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TTextTheme.titleseven(context),
                  softWrap: true,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: textSpacing),
                Text(
                  value,
                  style: TTextTheme.pThree(context),
                  softWrap: true,
                  maxLines: null,
                ),
              ],
            ),
          ),
        ],
      );
    }

    // WEB LAYOUT
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ICON BOX
        Container(
          height: 36,
          width: 36,
          decoration: BoxDecoration(
            color: AppColors.secondaryColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: Image.asset(
              icon,
              height: 19,
              width: 19,
            ),
          ),
        ),

        SizedBox(width: 14),

        // TITLE + VALUE
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TTextTheme.titleseven(context),
                softWrap: true,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: 3),
              Text(
                value,
                style: TTextTheme.pThree(context),
              ),
            ],
          ),
        ),
      ],
    );
  }


//  Documents Section Widget
  Widget _buildCarDocumentsSection(BuildContext context) {
    final spacing = AppSizes.padding(context);
    final isMobile = AppSizes.isMobile(context);
    final tab = AppSizes.isTablet(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(TextString.carDetailsCarDocuments, style: TTextTheme.titleSix(context)),
        SizedBox(height: spacing),
        LayoutBuilder(
          builder: (context, constraints) {
            final double totalWidth = constraints.maxWidth;
            double gap = 6.0;

            double itemWidth;
            if (totalWidth < 600) {
              itemWidth = (totalWidth - gap) / 2;
            } else {
              itemWidth = (totalWidth - (gap * 3)) / 4;
            }

            return Wrap(
              spacing: gap,
              runSpacing: 12.0,
              children: [
                _buildSizedBoxTile(itemWidth, context, "Registration", "1234567890", isMobile, tab),
                _buildSizedBoxTile(itemWidth, context, "Tax Token", "Uploaded", isMobile, tab),
                _buildSizedBoxTile(itemWidth, context, "Incoherence Paper", "Uploaded", isMobile, tab),
                _buildSizedBoxTile(itemWidth, context, "Vin Number", "JTNBA3HK003001234", isMobile, tab),
              ],
            );
          },
        ),
      ],
    );
  }

   // Box Tile
  Widget _buildSizedBoxTile(double width, BuildContext context, String title, String status, bool isMobile, bool tab) {
    return SizedBox(
      width: width,
      child: _buildDocumentTile(
        context, title, status, true,
        isMobile: isMobile, tab: tab,
      ),
    );
  }

  // DocumnetTile Widget
  Widget _buildDocumentTile(
      BuildContext context,
      String title,
      String status,
      bool uploaded,
      {required bool isMobile, required bool tab}
      ) {

    String iconPath;
    String lowerTitle = title.toLowerCase();

    if (lowerTitle.contains("tax") || lowerTitle.contains("paper")) {
      iconPath = IconString.taxIcon;
    } else if (lowerTitle.contains("vin")) {
      iconPath = IconString.vinNumberIcon;
    } else {
      iconPath = IconString.registrationIcon;
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: isMobile
          ? Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 28,
            width: 28,
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: AppColors.secondaryColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Image.asset(iconPath, fit: BoxFit.contain),
          ),
          const SizedBox(height: 6),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TTextTheme.pThree(context),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                child: Text(
                  status,
                  style: TTextTheme.titleseven(context),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(width: 4),
              if (uploaded)
                GestureDetector(
                  onTap: () => Get.find<CarInventoryController>().open(ImageString.registrationForm),
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Image.asset(
                      IconString.uploadedIcon,
                      height: 14,
                      width: 14,
                      color: Colors.white,
                    ),
                  ),
                ),
            ],
          ),
        ],
      )
          : Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: tab ? 32 : 38,
            width: tab ? 32 : 38,
            decoration: BoxDecoration(
              color: AppColors.secondaryColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Image.asset(iconPath, height: 18, width: 18),
            ),
          ),
          const SizedBox(width: 6),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  style: TTextTheme.pThree(context),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Row(
                  children: [
                    Flexible(
                      child: Text(
                        status,
                        style: TTextTheme.titleseven(context),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(width: 7),
                    if (uploaded)
                      GestureDetector(
                        onTap: () => Get.find<CarInventoryController>().open(ImageString.registrationForm),
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: AppColors.primaryColor,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Image.asset(
                            IconString.uploadedIcon,
                            height: 14,
                            width: 14,
                            color: Colors.white,
                          ),
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



// Icon Button (Used for Edit/Delete) Widget
  Widget _buildIconButton(
      BuildContext context,
      String iconPath, {
        VoidCallback? onTap,
        String? label,
      }) {
    final bool isVeryNarrow =
        AppSizes.isMobile(context) &&
            MediaQuery.of(context).size.width < 350;

    final double horizontalPadding = (label != null || isVeryNarrow) ? 8 : 6;
    final double verticalPadding = isVeryNarrow ? 6 : 8;
    final double iconSize = isVeryNarrow ? 16 : 18;

    return Padding(
      padding: const EdgeInsets.only(left: 4.0),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(7),
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: horizontalPadding,
            vertical: verticalPadding,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(7),
            border: Border.all(
              color: AppColors.tertiaryTextColor,
              width: 1,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                iconPath,
                width: iconSize,
                height: iconSize,
                color: AppColors.secondTextColor,
              ),

              if (label != null) ...[
                const SizedBox(width: 4),
                Text(
                  label,
                  style: TTextTheme.btnFive(context),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

}