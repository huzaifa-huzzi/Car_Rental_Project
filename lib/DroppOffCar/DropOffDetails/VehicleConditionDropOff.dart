import 'dart:io';
import 'package:car_rental_project/DroppOffCar/DropOffController.dart';
import 'package:car_rental_project/DroppOffCar/ReusableWidgetOfDropoff/PrimaryBtnDropOff.dart';
import 'package:car_rental_project/Resources/Colors.dart';
import 'package:car_rental_project/Resources/IconStrings.dart';
import 'package:car_rental_project/Resources/ImageString.dart';
import 'package:car_rental_project/Resources/TextString.dart';
import 'package:car_rental_project/Resources/TextTheme.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class VehicleConditionDropOff extends StatelessWidget {
  final dynamic controller;
  final bool isMobile;

  const VehicleConditionDropOff({
    super.key,
    required this.controller,
    required this.isMobile
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Container(
        padding: EdgeInsets.all(isMobile ? 15 : 30),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionHeader(context, TextString.titleDamageInspectionStepTwoDropOff, IconString.damageInspection),
            const SizedBox(height: 25),
            _buildDamageInspectionComparison(context, isMobile),
            const SizedBox(height: 20),
            _buildUploadPictureCard(context, isMobile),
            const SizedBox(height: 45),
          ],
        ),
      ),
    );
  }

  /// --------- Extra Widget ------- ///

  // Reusable Section
  Widget _buildSectionHeader(BuildContext context, String title, String icon) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.secondaryColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Image.asset(icon, width: 22, height: 22),
          const SizedBox(width: 12),
          Expanded(
            child: Text(title, style: TTextTheme.h6Style(context), overflow: TextOverflow.ellipsis,
              maxLines: 1,),
          ),
        ],
      ),
    );
  }
   // Damage Inspection
  Widget _buildDamageInspectionComparison(BuildContext context, bool isMobile) {
    return LayoutBuilder(builder: (context, constraints) {
      double columnWidth = isMobile ? constraints.maxWidth : (constraints.maxWidth - 40) / 2;

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flex(
            direction: isMobile ? Axis.vertical : Axis.horizontal,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ///  PICKUP DAMAGE
              SizedBox(
                width: columnWidth,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                        TextString.titleDamageInspectionStepTwoDropOffPickup,
                        style: TTextTheme.titleTwo(context)
                    ),
                    const SizedBox(height: 12),
                    _buildStaticLegendBox(context),
                    const SizedBox(height: 20),
                    _buildStaticCarDiagram(context, columnWidth - 30),
                  ],
                ),
              ),

              if (!isMobile) const SizedBox(width: 30) else const SizedBox(height: 20),

              /// DROPOFF DAMAGE
              Container(
                width: columnWidth,
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: AppColors.backgroundOfPickupsWidget,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(TextString.titleDamageInspectionStepTwoDropOff2, style: TTextTheme.titleTwo(context)),
                    const SizedBox(height: 12),
                    _buildInteractiveLegendBox(context),
                    const SizedBox(height: 20),
                    _buildInteractiveCarDiagram(context, columnWidth - 30),
                  ],
                ),
              ),
            ],
          ),
        ],
      );
    });
  }
  Widget _buildStaticLegendBox(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: AppColors.tertiaryTextColor.withOpacity(0.7)),
        borderRadius: BorderRadius.circular(8),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: controller.damageTypes2.map<Widget>((type) {
            return Padding(
              padding: const EdgeInsets.only(right: 15),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircleAvatar(
                    radius: 10,
                    backgroundColor: type['color'],
                    child: Text(
                        type['id'].toString(),
                        style: TTextTheme.btnNumbering(context)
                    ),
                  ),
                  const SizedBox(width: 5),
                  Text(type['label'], style: TTextTheme.titleSix(context)),
                ],
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
  Widget _buildStaticCarDiagram(BuildContext context, double width) {
    double height = width * 0.75;
    return Center(
      child: Obx(() => Stack(
        children: [
          Image.asset(ImageString.carDamageInspectionImage, width: width, height: height, fit: BoxFit.contain),
          ...controller.damagePoints2.map<Widget>((point) => Positioned(
            left: (point.dx * width) - 10,
            top: (point.dy * height) - 10,
            child: CircleAvatar(
              radius: 10,
              backgroundColor: point.color,
              child: Text(point.typeId.toString(), style: TTextTheme.btnNumbering(context)),
            ),
          )).toList(),
        ],
      )),
    );
  }
  Widget _buildInteractiveCarDiagram(BuildContext context, double width) {
    double height = width * 0.75;

    return Center(
      child: Stack(
        children: [
          Image.asset(
            ImageString.carDamageInspectionImage,
            width: width,
            height: height,
            fit: BoxFit.contain,
          ),
          ...controller.damagePoints2.map((point) => Positioned(
            left: (point.dx * width) - 10,
            top: (point.dy * height) - 10,
            child: CircleAvatar(
              radius: 10,
              backgroundColor: point.color,
              child: Text(
                point.typeId.toString(),
                style: TTextTheme.btnNumbering(context),
              ),
            ),
          )),
        ],
      ),
    );
  }
  Widget _buildInteractiveLegendBox(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: AppColors.tertiaryTextColor.withOpacity(0.7)),
        borderRadius: BorderRadius.circular(8),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: controller.damageTypes2.map<Widget>((type) {
            return Padding(
              padding: const EdgeInsets.only(right: 15),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircleAvatar(
                    radius: 10,
                    backgroundColor: type['color'],
                    child: Text(
                        type['id'].toString(),
                        style: TTextTheme.btnNumbering(context)
                    ),
                  ),
                  const SizedBox(width: 5),
                  Text(type['label'], style: TTextTheme.titleSix(context)),
                ],
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  // Pictures
  Widget _buildUploadPictureCard(BuildContext context, bool isMobile) {

    return LayoutBuilder(builder: (context, bConstraints) {
      double width = bConstraints.maxWidth;

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildImageHeader(context, width),
          const SizedBox(height: 10),
          Text(TextString.requireImages, style: TTextTheme.requireImagesText(context)),
          const SizedBox(height: 20),
          _buildComparisonRow(context, "front", "Front View", isMobile),
          const SizedBox(height: 20),
          _buildComparisonRow(context, "back", "Back View", isMobile),
          const SizedBox(height: 20),
          _buildComparisonRow(context, "left", "Left View", isMobile),
          const SizedBox(height: 20),
          _buildComparisonRow(context, "right", "Right View", isMobile),

          const SizedBox(height: 30),
          Text(TextString.additionalImagesDropOff2, style: TTextTheme.AdditionalText(context), overflow: TextOverflow.ellipsis,
            maxLines: 1,),
          const SizedBox(height: 15),
          _buildAdditionalComparisonSection(context, isMobile),
        ],
      );
    });
  }
  Widget _buildComparisonRow(BuildContext context, String type, String label, bool isMobile) {
    final controller = Get.find<DropOffController>();

    String pickupImg;
    if (type == 'front') {
      pickupImg = controller.pickupFrontImg;
    } else if (type == 'back') pickupImg = controller.pickupBackImg;
    else if (type == 'left') pickupImg = controller.pickupLeftImg;
    else pickupImg = controller.pickupRightImg;

    return isMobile
        ? Column(
      children: [
        _buildStaticBox(context, "$label (Pick up)", pickupImg, isPink: false),
        const SizedBox(height: 12),
        _buildStaticBox(context, "$label (Drop off)", pickupImg, isPink: true),
      ],
    )
        : Row(
      children: [
        Expanded(child: _buildStaticBox(context, "$label (Pick up)", pickupImg, isPink: false)),
        const SizedBox(width: 15),
        Expanded(child: _buildStaticBox(context, "$label (Drop off)", pickupImg, isPink: true)),
      ],
    );
  }
  Widget _buildStaticBox(BuildContext context, String label, String imagePath, {required bool isPink}) {
    return Container(
      height: 300,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
          color: isPink ? AppColors.backgroundOfPickupsWidget : AppColors.secondaryColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.tertiaryTextColor.withOpacity(0.3))
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(
              isPink ? IconString.returnCarIcon : IconString.agreementIcon,
              height: 18,
              color: AppColors.primaryColor
          ),
          const SizedBox(height: 8),
          Text(label, style: TTextTheme.CalendarTitle(context)),
          const SizedBox(height: 12),
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                imagePath,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }
  Widget _buildAdditionalComparisonSection(BuildContext context, bool isMobile) {
    final controller = Get.find<DropOffController>();

    return Column(
      children: [
        _buildAdditionalStaticRow(
            context,
            TextString.additionalPickupText,
            controller.pickupAdditionalImagesDropOff,
            isPink: false,
            isMobile: isMobile
        ),
        const SizedBox(height: 20),

        _buildAdditionalStaticRow(
            context,
            TextString.additionalDropOffText,
            controller.pickupAdditionalImagesDropOff,
            isPink: true,
            isMobile: isMobile
        ),
      ],
    );
  }
  Widget _buildAdditionalStaticRow(BuildContext context, String title, List<String> images, {required bool isPink, required bool isMobile}) {
    double boxSize = isMobile ? 120 : 180;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isPink ? AppColors.backgroundOfPickupsWidget : AppColors.secondaryColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Image.asset(isPink ? IconString.returnCarIcon : IconString.agreementIcon, height: 18, color: AppColors.primaryColor),
              const SizedBox(width: 8),
              Expanded(
                child: Text(title, style: TTextTheme.CalendarTitle(context), overflow: TextOverflow.ellipsis,
                  maxLines: 1,),
              ),
            ],
          ),
          const SizedBox(height: 15),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: List.generate(images.length > 4 ? 4 : images.length, (index) {
              bool isLast = index == 3 && images.length > 3;
              return Stack(
                children: [
                  Container(
                    width: boxSize,
                    height: boxSize,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      image: DecorationImage(image: AssetImage(images[index]), fit: BoxFit.cover),
                    ),
                  ),
                  if (isLast)
                    Positioned.fill(
                      child: Container(
                        decoration: BoxDecoration(color: Colors.black54, borderRadius: BorderRadius.circular(12)),
                        child: Center(
                          child: PrimaryBthDropOff(
                            text: "View All",
                            width: 110,
                            height: 40,
                            onTap: () => _showAllImagesPopup(context, images, isFile: false),
                          ),
                        ),
                      ),
                    ),
                ],
              );
            }),
          ),
        ],
      ),
    );
  }
  Widget _buildImageHeader(BuildContext context, double width) {
    return SizedBox(
      width: double.infinity,
      child: Wrap(
        alignment: width < 350 ? WrapAlignment.start : WrapAlignment.spaceBetween,
        crossAxisAlignment: WrapCrossAlignment.center,
        runSpacing: 8,
        children: [
          Text(
              TextString.dropOffImageDropoff,
              style: TTextTheme.h6Style(context)
          ),
          Obx(() {
            int count = 0;
            if (controller.frontImage.value != null) count++;
            if (controller.backImage.value != null) count++;
            if (controller.leftImage.value != null) count++;
            if (controller.rightImage.value != null) count++;

            return Text(
                "10/10 images uploaded",
                style: TTextTheme.titleThree(context)
            );
          }),
        ],
      ),
    );
  }
  void _showAllImagesPopup(BuildContext context, List<dynamic> allImages, {bool isFile = false}) {
    final PageController pageController = PageController();

    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (dialogContext) {
        return Dialog(
          insetPadding: EdgeInsets.zero,
          backgroundColor: Colors.transparent,
          child: LayoutBuilder(
            builder: (context, constraints) {
              double arrowSize = constraints.maxWidth < 450 ? 25 : 35;
              double padding = constraints.maxWidth < 450 ? 12 : 25;

              return Container(
                width: constraints.maxWidth,
                height: constraints.maxHeight,
                color: AppColors.blackColor.withOpacity(0.9),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Positioned.fill(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: arrowSize + (padding * 2.5)),
                        child: PageView.builder(
                          controller: pageController,
                          itemCount: allImages.length,
                          itemBuilder: (_, index) {
                            return Center(
                              child: InteractiveViewer(
                                minScale: 0.5,
                                maxScale: 4.0,
                                child: isFile
                                    ? (kIsWeb
                                    ? Image.memory(allImages[index].bytes!, fit: BoxFit.contain)
                                    : Image.file(File(allImages[index].path!), fit: BoxFit.contain))
                                    : Image.asset(allImages[index], fit: BoxFit.contain),
                              ),
                            );
                          },
                        ),
                      ),
                    ),

                    Positioned(
                      top: MediaQuery.of(context).padding.top + 20,
                      right: padding,
                      child: IconButton(
                        icon: Icon(Icons.close, color: AppColors.tertiaryTextColor, size: arrowSize + 5),
                        onPressed: () => Navigator.of(dialogContext).pop(),
                      ),
                    ),

                    Positioned(
                      left: padding,
                      child: _buildNavButton(
                        icon: Icons.arrow_back,
                        onPressed: () {
                          if (pageController.page! > 0) {
                            pageController.previousPage(duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
                          }
                        },
                        size: arrowSize,
                      ),
                    ),

                    Positioned(
                      right: padding,
                      child: _buildNavButton(
                        icon: Icons.arrow_forward,
                        onPressed: () {
                          if (pageController.page! < allImages.length - 1) {
                            pageController.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
                          }
                        },
                        size: arrowSize,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }
  Widget _buildNavButton({required IconData icon, required VoidCallback onPressed, required double size}) {
    return IconButton(
      icon: Icon(icon, color: AppColors.tertiaryTextColor, size: size),
      onPressed: onPressed,
    );
  }

}