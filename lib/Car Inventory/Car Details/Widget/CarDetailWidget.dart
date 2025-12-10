import 'package:car_rental_project/Resources/Colors.dart';
import 'package:car_rental_project/Resources/ImageString.dart';
import 'package:car_rental_project/Resources/TextTheme.dart';
import 'package:flutter/material.dart';
import 'package:car_rental_project/Resources/AppSizes.dart';
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
    ImageString.corollaPicTwo,
  ];

  final List<Map<String, dynamic>> specifications = const [
    {
      'title': 'Transmission',
      'value': 'Automatic',
      'icon': IconString.transmissionIcon
    },
    {'title': 'Capacity', 'value': '4 Seats', 'icon': IconString.seatIcon},
    {
      'title': 'Range',
      'value': '400 miles on a full tank',
      'icon': IconString.rangeIcon
    },
    {
      'title': 'Fuel',
      'value': 'Petrol',
      'icon': IconString.gasPumpIcon
    },
    {'title': 'Top Speed', 'value': '120 mph', 'icon': IconString.speedIcon},
    {
      'title': 'Color',
      'value': 'Silver',
      'icon': IconString.colorIcon
    },
    {
      'title': 'Acceleration',
      'value': '8.0 seconds(0-60mph)',
      'icon': IconString.accelerationIcon
    },
    {'title': 'Model Year', 'value': '2017', 'icon': IconString.modelYearIcon},
    {'title': 'Car Values', 'value': '35000\$Aud', 'icon': IconString.carValueIcon},
    {'title': 'Mileage', 'value': '43000(Km)', 'icon': IconString.milageIcon},
    {'title': 'Engine Size', 'value': '2.5(L)', 'icon': IconString.engineSizeIcon},
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
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
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
    final double thumbnailSize = 100;

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
      // MOBILE LAYOUT FIXES
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Sedan", style: TTextTheme.titleSix(context)),

          SizedBox(height: 4),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Toyota Corolla 2024",
                  style: TTextTheme.h1Style(context)),

              Row(
                children: [
                  _buildIconButton(context, Icons.edit),
                  SizedBox(width: 8),
                  _buildIconButton(context, Icons.delete_outline),
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
            child: Text("Available",
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

              Text("/Weekly",
                  style: TTextTheme.titleFour(context)),
            ],
          ),


          SizedBox(height: 15.0),

          // About Section
          Text("About",
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

    // WEB LAYOUT (Unchanged)
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
                  Text("Sedan", style: TTextTheme.titleSix(context)),
                  SizedBox(height: 4),
                  Text("Toyota Corolla 2024",
                      style: TTextTheme.h1Style(context)),
                ],
              ),
            ),
            Row(
              children: [
                _buildIconButton(
                  context,
                  Icons.edit,
                  label: "Edit",
                  onTap: () {},
                ),
                SizedBox(width: 8),
                _buildIconButton(context, Icons.delete_outline),
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
          child: Text("Available",
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

            Text("/Weekly",
                style: TTextTheme.titleFour(context)),
          ],
        ),

        SizedBox(height: spacing * 1.5),
        Text("About",
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
    final isMobile = AppSizes.isMobile(context);

    final int crossAxisCount = isMobile ? 3 : 5;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Specifications",
          style: TTextTheme.titleSix(context),
        ),
        SizedBox(height: spacing),

        GridView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: specifications.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: 10,
            mainAxisSpacing: 16,
            childAspectRatio: isMobile ? 3 : 4.2,
          ),
          itemBuilder: (_, i) {
            return _buildSpecTile(
              context,
              specifications[i]['icon'] as String,
              specifications[i]['title'] as String,
              specifications[i]['value'] as String,
              isMobile: isMobile,
            );
          },
        ),
      ],
    );
  }


//  Specification Tile for Mobile UI
  Widget _buildSpecTile(
      BuildContext context, String icon, String title, String value, {required bool isMobile}) {
    if (isMobile) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 26,
            width: 26,
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

          SizedBox(width: 9),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style:  TTextTheme.titleseven(context),
                ),
                SizedBox(height: 1),
                Text(
                  value,
                  style: TTextTheme.pThree(context),
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
          height: 38,
          width: 38,
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

        SizedBox(width: 14),

        // TITLE + VALUE
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style:  TTextTheme.titleseven(context),
            ),
            SizedBox(height: 3),
            Text(
              value,
              style: TTextTheme.pThree(context),
            ),
          ],
        ),
      ],
    );
  }


//  Documents Section for Mobile
  Widget _buildCarDocumentsSection(BuildContext context) {
    final spacing = AppSizes.padding(context);
    final isMobile = AppSizes.isMobile(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Car document",
          style: TTextTheme.titleSix(context),
        ),
        SizedBox(height: spacing),

        GridView.count(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          crossAxisCount: isMobile ? 3 : 3,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          childAspectRatio: isMobile ? 0.97 : 4.8,
          children: [
            _buildDocumentTile(
              context,
              "Registration",
              "1HFC-052",
              true,
              isMobile: isMobile,
            ),
            _buildDocumentTile(
              context,
              "Tax Token",
              "Uploaded",
              true,
              isMobile: isMobile,
            ),
            _buildDocumentTile(
              context,
              "Incoherence Paper",
              "Uploaded",
              true,
              isMobile: isMobile,
            ),
          ],
        ),
      ],
    );
  }



//  Document Tile for Mobile UI
  Widget _buildDocumentTile(
      BuildContext context,
      String title,
      String status,
      bool uploaded,
      {required bool isMobile}
      ) {
    String iconPath;

    if (title.toLowerCase().contains("tax") || title.toLowerCase().contains("paper")) {
      iconPath = IconString.taxIcon;
    } else {
      iconPath = IconString.registrationIcon;
    }

    if (isMobile) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 26,
            width: 26,
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: AppColors.secondaryColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Image.asset(
                iconPath,
                height: 18,
                width: 18,
              ),
            ),
          ),
          SizedBox(height: 8),

          Text(
            title,
            textAlign: TextAlign.center,
            style: TTextTheme.pThree(context),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: 4),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                status,
                style: TTextTheme.titleseven(context),
              ),
              SizedBox(width: 2,),

              Image.asset(
                IconString.verifiedIcon,
                height: 18,
                width: 18,
              ),
              SizedBox(width: 3,),
              Image.asset(
                IconString.uploadedIcon,
                height: 18,
                width: 18,
              ),
            ],
          ),
        ],
      );
    }

    // WEB LAYOUT (Unchanged)
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // ICON BOX
        Container(
          height: 40,
          width: 40,
          decoration: BoxDecoration(
            color: AppColors.secondaryColor,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Center(
            child: Image.asset(
              iconPath,
              height: 22,
              width: 22,
            ),
          ),
        ),
        SizedBox(width: 14),
        // TITLE + STATUS
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
                title,
                style: TTextTheme.pThree(context)),
            SizedBox(height: 4),
            Row(
              children: [
                Text(
                  status,
                  style:  TTextTheme.titleseven(context),
                ),
                SizedBox(width: 6),
                Image.asset(
                  IconString.verifiedIcon,
                  height: 22,
                  width: 22,
                ),
              ],
            ),
          ],
        ),
        SizedBox(width: 4),
        Image.asset(
          IconString.uploadedIcon,
          height: 22,
          width: 22,
        ),
      ],
    );
  }


// --- Icon Button (Used for Edit/Delete) ---
  Widget _buildIconButton(
      BuildContext context,
      IconData icon, {
        VoidCallback? onTap,
        String? label,
      }) {
    return Padding(
      padding: const EdgeInsets.only(left: 4.0),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: label != null ? 12 : 10,
            vertical: 8,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(AppSizes.borderRadius(context) * 0.5),
            border: Border.all(color: AppColors.quadrantalTextColor, width: 0.5),
          ),

          child: Row(
            children: [
              Icon(icon, size: 18, color: AppColors.textColor),

              if (label != null) ...[
                SizedBox(width: 6),
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