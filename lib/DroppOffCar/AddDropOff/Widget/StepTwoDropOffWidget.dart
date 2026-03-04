import 'dart:io';
import 'package:car_rental_project/DroppOffCar/DropOffController.dart';
import 'package:car_rental_project/DroppOffCar/ReusableWidgetOfDropoff/CustomButtonDropOff.dart';
import 'package:car_rental_project/DroppOffCar/ReusableWidgetOfDropoff/HeaderWebDropOffWidget.dart';
import 'package:car_rental_project/DroppOffCar/ReusableWidgetOfDropoff/PrimaryBtnDropOff.dart';
import 'package:car_rental_project/Resources/AppSizes.dart';
import 'package:car_rental_project/Resources/Colors.dart';
import 'package:car_rental_project/Resources/IconStrings.dart';
import 'package:car_rental_project/Resources/ImageString.dart';
import 'package:car_rental_project/Resources/TextString.dart';
import 'package:car_rental_project/Resources/TextTheme.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StepTwoDropOffWidget extends StatelessWidget {
  final controller = Get.find<DropOffController>();

  StepTwoDropOffWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isMobile = MediaQuery
        .of(context)
        .size
        .width < 700;

    return Scaffold(
      backgroundColor: AppColors.backgroundOfScreenColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            // Header
            HeaderWebDropOffWidget(
              mainTitle: 'Drop Off Car',
              showBack: true,
              smallTitle: 'Drop Off / Inspection',
              showSearch: !isMobile,
              showProfile: true,
            ),

            Padding(
              padding: const EdgeInsets.all(20),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(TextString.titleAddHeader, style:TTextTheme.h6Style(context), overflow: TextOverflow.ellipsis, maxLines: 1,),
                      const SizedBox(height: 6),
                      Text(TextString.subtitleHeader, style: TTextTheme.titleThree(context), overflow: TextOverflow.ellipsis, maxLines: 1,
                      ),
                      const SizedBox(height: 15),
                      // Step Badges
                      _buildStepBadges(context),
                      const SizedBox(height: 35),
                      // Damage Inspection Card
                      _buildDamageInspectionComparison(context, isMobile),
                      const SizedBox(height: 45),
                      // Upload Pictures Section
                      _buildUploadPictureCard(context, isMobile),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: _buttonSection(context, isMobile),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  /// ------- Extra Widgets ----------- ///
  // Badges
  Widget _buildStepBadges(BuildContext context) {
    return Container(
      width: 280,
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildStepItem("1", "Step 1", false, context, isCurrent: true),
          _buildStepLine(true),
          _buildStepItem("2", "Step 2", true, context),
          _buildStepLine(true),
          _buildStepItem("3", "Step 3", false, context, isCurrent: true),
        ],
      ),
    );
  }
  Widget _buildStepItem(String stepNum, String label, bool isCompleted,
      BuildContext context, {bool isCurrent = false}) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 24,
          height: 24,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isCompleted ? AppColors.primaryColor : Colors.white,
            border: Border.all(color: AppColors.primaryColor, width: 1.5),
          ),
          child: Center(
            child: isCompleted
                ? const Icon(Icons.check, size: 14, color: Colors.white)
                : isCurrent
                ? Container(
              width: 8,
              height: 8,
              decoration: const BoxDecoration(
                color: AppColors.primaryColor,
                shape: BoxShape.circle,
              ),
            )
                : null,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          label,
          style: TTextTheme.stepsText(context).copyWith(
            color: isCompleted ? AppColors.primaryColor : AppColors.textColor,
          ),
        ),
      ],
    );
  }
  Widget _buildStepLine(bool isActive) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(top: 11.0),
        child: Container(
          height: 1.5,
          color: AppColors.primaryColor,
        ),
      ),
    );
  }

  // Damage Inspection
  Widget _buildDamageInspectionComparison(BuildContext context, bool isMobile) {
    return LayoutBuilder(builder: (context, constraints) {
      double columnWidth = isMobile ? constraints.maxWidth : (constraints
          .maxWidth - 40) / 2;

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              color: AppColors.secondaryColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Image.asset(IconString.damageInspection, height: 20, width: 20),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    "Damage Inspection",
                    style: TTextTheme.DamageStyle(context),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 15),
          _buildToggleWidget(context),
          const SizedBox(height: 20),

          Wrap(
            spacing: 20,
            runSpacing: 20,
            children: [
              SizedBox(
                width: columnWidth,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Pickup Damage", style: TTextTheme.titleSix(context)),
                    const SizedBox(height: 10),
                    _buildLegendBox(context, isInteractive: false),
                    const SizedBox(height: 20),
                    _buildStaticCarDiagram(context, columnWidth),
                  ],
                ),
              ),
              Container(
                width: columnWidth,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.backgroundOfPickupsWidget,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Drop off Damage",
                        style: TTextTheme.titleSix(context).copyWith(
                            fontSize: 14)),
                    const SizedBox(height: 10),
                    _buildLegendBox(context, isInteractive: true),
                    const SizedBox(height: 20),
                    _buildInteractiveCarDiagram(context, columnWidth - 24),
                  ],
                ),
              ),
            ],
          ),
        ],
      );
    });
  }
  Widget _buildLegendBox(BuildContext context, {required bool isInteractive}) {
    Widget buildChipsRow(bool reactive) {
      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        child: Row(
          children: controller.damageTypes3.map((type) {
            bool isSelected = reactive &&
                (controller.selectedDamageType3.value == type['id']);

            return GestureDetector(
              onTap: () {
                if (isInteractive && controller.isDamageInspectionOpen2.value) {
                  controller.selectedDamageType3.value = type['id'];
                }
              },
              child: Container(
                margin: const EdgeInsets.only(right: 12),
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: isSelected ? AppColors.secondaryColor : Colors
                      .transparent,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CircleAvatar(
                      radius: 10,
                      backgroundColor: type['color'],
                      child: Text(type['id'].toString(),
                          style: TTextTheme.btnNumbering(context)),
                    ),
                    const SizedBox(width: 6),
                    Text(type['label'], style: TTextTheme.titleSix(context)),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      );
    }

    return Container(
      height: 50,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: AppColors.tertiaryTextColor.withOpacity(0.4)),
        borderRadius: BorderRadius.circular(8),
      ),
      child: isInteractive
          ? Obx(() => buildChipsRow(true))
          : buildChipsRow(false),
    );
  }
  Widget _buildStaticCarDiagram(BuildContext context, double width) {
    double height = width * 0.75;
    return Center(
      child: SizedBox(
        width: width,
        height: height,
        child: Image.asset(
          ImageString.carDamageInspectionImage,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
  Widget _buildInteractiveCarDiagram(BuildContext context, double width) {
    double height = width * 0.75;
    return Obx(() =>
        IgnorePointer(
          ignoring: !controller.isDamageInspectionOpen2.value,
          child: Opacity(
            opacity: controller.isDamageInspectionOpen2.value ? 1.0 : 0.5,
            child: Center(
              child: GestureDetector(
                onTapDown: (details) {
                  double dx = details.localPosition.dx / width;
                  double dy = details.localPosition.dy / height;

                  int idx = controller.damagePoints3.indexWhere((p) =>
                  (p.dx - dx).abs() < 0.05 && (p.dy - dy).abs() < 0.05);
                  if (idx != -1) {
                    controller.damagePoints3.removeAt(idx);
                  } else {
                    var type = controller.damageTypes3.firstWhere((
                        t) => t['id'] == controller.selectedDamageType3.value);
                    controller.damagePoints3.add(DamagePoint(dx: dx,
                        dy: dy,
                        typeId: type['id'],
                        color: type['color']));
                  }
                },
                child: Stack(
                  children: [
                    Image.asset(
                        ImageString.carDamageInspectionImage, width: width,
                        height: height,
                        fit: BoxFit.contain),
                    ...controller.damagePoints3.map((point) =>
                        Positioned(
                          left: (point.dx * width) - 10,
                          top: (point.dy * height) - 10,
                          child: CircleAvatar(
                            radius: 10, backgroundColor: point.color,
                            child: Text(point.typeId.toString(),
                                style: TTextTheme.btnNumbering(context)),
                          ),
                        )),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
  Widget _buildToggleWidget(BuildContext context) {
    return Obx(() =>
        GestureDetector(
          onTap: () =>
          controller.isDamageInspectionOpen2.value =
          !controller.isDamageInspectionOpen2.value,
          child: Container(
            width: 70,
            height: 32,
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: controller.isDamageInspectionOpen2.value ? AppColors
                  .primaryColor : AppColors.quadrantalTextColor,
            ),
            child: Stack(
              children: [
                AnimatedAlign(
                  duration: const Duration(milliseconds: 200),
                  alignment: controller.isDamageInspectionOpen2.value
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  child: Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(color: Colors.white,
                        borderRadius: BorderRadius.circular(4)),
                  ),
                ),
                Align(
                  alignment: controller.isDamageInspectionOpen2.value
                      ? const Alignment(-0.6, 0)
                      : const Alignment(0.6, 0),
                  child: Text(
                    controller.isDamageInspectionOpen2.value ? "Yes" : "No",
                    style: TTextTheme.btnWhiteColor(context),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
     // Images
  Widget _buildUploadPictureCard(BuildContext context, bool isMobile) {
    return LayoutBuilder(builder: (context, bConstraints) {
      double width = bConstraints.maxWidth;

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildImageHeader(context, width),
          const SizedBox(height: 4),
          Text(TextString.requireImages, style: TTextTheme.requireImagesText(context)),
          const SizedBox(height: 20),

          _buildComparisonRow(context, "front", "Front View", ImageString.frontView, isMobile),
          const SizedBox(height: 15),
          _buildComparisonRow(context, "back", "Back View", ImageString.backView, isMobile),
          const SizedBox(height: 15),
          _buildComparisonRow(context, "left", "Left View", ImageString.leftView, isMobile),
          const SizedBox(height: 15),
          _buildComparisonRow(context, "right", "Right View", ImageString.rightView, isMobile),

          const SizedBox(height: 30),
          Text(TextString.AdditionalImages, style: TTextTheme.AdditionalText(context)),
          const SizedBox(height: 15),

          _buildAdditionalComparisonSection(context, isMobile),
        ],
      );
    });
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
            count += controller.additionalImages.length;

            return Text(
              "$count/10 images uploaded",
              style: TTextTheme.titleThree(context)
            );
          }),
        ],
      ),
    );
  }
  Widget _buildComparisonRow(BuildContext context, String type, String label, String iconPath, bool isMobile) {
    String pickupImagePath = ImageString.backPickImage;
    if (type == 'front') {
      pickupImagePath = ImageString.frontPickImage;
    } else if (type == 'left') pickupImagePath = ImageString.leftPickImage;
    else if (type == 'right') pickupImagePath = ImageString.rightPickImage;

    return isMobile
        ? Column(
      children: [
        _buildStaticPickupBox(context, "$label(Pick up)", pickupImagePath),
        const SizedBox(height: 12),
        _buildInteractiveUploadBox(context, "$label(Drop off)", iconPath, type),
      ],
    )
        : Row(
      children: [
        Expanded(child: _buildStaticPickupBox(context, "$label(Pick up)", pickupImagePath)),
        const SizedBox(width: 15),
        Expanded(child: _buildInteractiveUploadBox(context, "$label(Drop off)", iconPath, type)),
      ],
    );
  }
  Widget _buildStaticPickupBox(BuildContext context, String label, String imagePath) {
    return Container(
      height: 300,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.secondaryColor,
        borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.tertiaryTextColor.withOpacity(0.7))
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(IconString.agreementIcon, height: 20, color: AppColors.primaryColor),
          const SizedBox(height: 8),
          Text(label, style: TTextTheme.CalendarTitle(context)),
          const SizedBox(height: 12),

          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                imagePath,
                width: double.infinity,
                fit: BoxFit.contain,
              ),
            ),
          ),
        ],
      ),
    );
  }
  Widget _buildInteractiveUploadBox(BuildContext context, String label, String iconPath, String type) {
    return Obx(() {
      ImageHolder? image;
      if (type == 'front') {
        image = controller.frontImage.value;
      } else if (type == 'back') {
        image = controller.backImage.value;
      } else if (type == 'left') {
        image = controller.leftImage.value;
      } else if (type == 'right') {
        image = controller.rightImage.value;
      }

      bool hasImage = image != null;

      return GestureDetector(
        onTap: () => controller.pickImageNew(type),
        child: Container(
          height: 300,
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.backgroundOfPickupsWidget,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.tertiaryTextColor.withOpacity(0.7))
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(IconString.returnCarIcon, height: 18, color: AppColors.primaryColor),
              const SizedBox(height: 3),
              Text(label, style: TTextTheme.CalendarTitle(context)),

              Expanded(
                child: hasImage
                    ? Padding(
                  padding: const EdgeInsets.only(top: 12.0),
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: kIsWeb
                            ? Image.memory(image.bytes!, fit: BoxFit.cover, width: double.infinity, height: double.infinity)
                            : Image.file(File(image.path!), fit: BoxFit.cover, width: double.infinity, height: double.infinity),
                      ),
                      Positioned(
                        top: 8, right: 8,
                        child: GestureDetector(
                          onTap: () => controller.removeImageNew(type),
                          child: const CircleAvatar(
                              radius: 12,
                              backgroundColor: AppColors.primaryColor,
                              child: Icon(Icons.close, color: Colors.white, size: 14)
                          ),
                        ),
                      ),
                    ],
                  ),
                )
                    : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(width: double.infinity),

                    Image.asset(iconPath, height: 60, fit: BoxFit.contain),

                    const SizedBox(height: 12),

                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(TextString.clickToUpload, style: TTextTheme.UploadText(context)),
                    ),
                    const SizedBox(height: 4),
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text.rich(
                        TextSpan(
                          text: TextString.jpgsPngs,
                          style: TTextTheme.titleDriver(context),
                          children: [
                            TextSpan(
                              text: TextString.under50,
                              style: TTextTheme.titleTwelve(context),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

    // Additional Images
  Widget _buildAdditionalComparisonSection(BuildContext context, bool isMobile) {
    double boxSize = isMobile ? 160 : 190;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          decoration: BoxDecoration(
            color: AppColors.secondaryColor,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Image.asset(IconString.agreementIcon, height: 20, color: AppColors.primaryColor),
                  const SizedBox(width: 8),
                   Expanded(
                     child: Text(TextString.additionalPickupText,
                        style: TTextTheme.CalendarTitle(context),
                       overflow: TextOverflow.ellipsis,
                       maxLines: 1,
                                       ),
                   ),
                ],
              ),
              const SizedBox(height: 15),

              Wrap(
                spacing: 12,
                runSpacing: 12,
                children: List.generate(
                    controller.pickupAdditionalImages.length > 4 ? 4 : controller.pickupAdditionalImages.length,
                        (index) {
                      bool isLast = index == 3 && controller.pickupAdditionalImages.length > 3;
                      String imgPath = controller.pickupAdditionalImages[index];

                      return Stack(
                        children: [
                          Container(
                            width: boxSize,
                            height: boxSize,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              image: DecorationImage(
                                image: AssetImage(imgPath),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          if (isLast)
                            Positioned.fill(
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.black54,
                                    borderRadius: BorderRadius.circular(12)
                                ),
                                child: Center(
                                  child: PrimaryBthDropOff(
                                    text: "View All",
                                    width: 110,
                                    height: 40,
                                    icon: const Icon(Icons.arrow_forward, color: Colors.white, size: 16),
                                    isIconLeft: true,
                                    onTap: () => _showAllImagesPopup(context, controller.pickupAdditionalImages, isFile: false),
                                  ),
                                ),
                              ),
                            ),
                        ],
                      );
                    }
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 20),
        _buildAdditionalUploadBox(context, isMobile),
      ],
    );
  }
  Widget _buildAdditionalUploadBox(BuildContext context, bool isMobile) {
    return Obx(() {
      var images = controller.additionalImages;
      bool hasImages = images.isNotEmpty;

      return GestureDetector(
        onTap: () {
          if (images.length < 10) {
            controller.pickImageNew('additional');
          }
        },
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          decoration: BoxDecoration(
            color: AppColors.backgroundOfPickupsWidget,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                   Image.asset(IconString.returnCarIcon, height: 20, color:AppColors.primaryColor),
                   SizedBox(width: 10),
                  Expanded(
                    child: Text(TextString.additionalDropOffText,
                        style: TTextTheme.CalendarTitle(context),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              if (!hasImages)
                Center(
                  child: Column(
                    children: [
                      Image.asset(IconString.pickupUploadIcon,),
                      const SizedBox(height: 10),
                      Text(TextString.clickToUpload, style: TTextTheme.UploadText(context)),
                      Text.rich(
                        TextSpan(
                          text:TextString.jpgsPngs,
                          style: TTextTheme.titleDriver(context),
                          children: [
                            TextSpan(
                              text: TextString.under10,
                              style: TTextTheme.titleTwelve(context),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              else
                Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  alignment: WrapAlignment.start,
                  children: List.generate(images.length > 4 ? 4 : images.length, (index) {
                    bool isLast = index == 3 && images.length > 3;
                    var img = images[index];


                    double boxSize = isMobile ? 150 : 180;

                    return Stack(
                      children: [
                        Container(
                          width: boxSize,
                          height: boxSize,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            image: DecorationImage(
                              image: kIsWeb ? MemoryImage(img.bytes!) : FileImage(File(img.path!)) as ImageProvider,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        if (isLast)
                          Positioned.fill(
                            child: Container(
                              color: Colors.black54,
                              child: Center(
                                child: PrimaryBthDropOff(
                                  text: "View All",
                                  width: 110,
                                  height: 40,
                                  onTap: () => _showAllImagesPopup(context, images, isFile: true),
                                ),
                              ),
                            ),
                          )
                        else
                          Positioned(
                            top: 8, right: 8,
                            child: GestureDetector(
                              onTap: () => controller.removeImageNew('additional', index: index),
                              child: const CircleAvatar(radius: 16, backgroundColor: Colors.red, child: Icon(Icons.close, size: 18, color: Colors.white)),
                            ),
                          ),
                      ],
                    );
                  }),
                ),
            ],
          ),
        ),
      );
    });
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
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: Colors.black.withOpacity(0.9),
            child: Stack(
              alignment: Alignment.center,
              children: [
                PageView.builder(
                  controller: pageController,
                  itemCount: allImages.length,
                  itemBuilder: (_, index) {
                    return InteractiveViewer(
                      child: isFile
                          ? (kIsWeb
                          ? Image.memory(allImages[index].bytes!, fit: BoxFit.contain)
                          : Image.file(File(allImages[index].path!), fit: BoxFit.contain))
                          : Image.asset(allImages[index], fit: BoxFit.contain),
                    );
                  },
                ),
                Positioned(
                  top: 40, right: 20,
                  child: IconButton(icon: const Icon(Icons.close, color: Colors.white, size: 30), onPressed: () => Navigator.pop(dialogContext)),
                ),
                _buildNavArrow(Icons.arrow_back, () => pageController.previousPage(duration: const Duration(milliseconds: 300), curve: Curves.ease), true),
                _buildNavArrow(Icons.arrow_forward, () => pageController.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.ease), false),
              ],
            ),
          ),
        );
      },
    );
  }
  Widget _buildNavArrow(IconData icon, VoidCallback onTap, bool isLeft) {
    return Positioned(
      left: isLeft ? 10 : null,
      right: isLeft ? null : 10,
      child: IconButton(icon: Icon(icon, color: Colors.white, size: 40), onPressed: onTap),
    );
  }


  // Button Sections
  Widget _buttonSection(BuildContext context, bool isMobile) {
    const double webButtonWidth = 150.0;
    const double webButtonHeight = 45.0;
    final double spacing = AppSizes.padding(context);

    if (isMobile) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            height: webButtonHeight,
            child: CustomButtonDropOff(
              text: 'Cancel',
              backgroundColor: Colors.transparent,
              textColor: AppColors.textColor,
              borderColor: AppColors.quadrantalTextColor,
              onTap: () {},
            ),
          ),
          SizedBox(height: spacing),
          SizedBox(
            width: webButtonWidth,
            height: webButtonHeight,
            child: PrimaryBthDropOff(
              text: "Continue",
              icon: Image.asset(
                IconString.continueIcon,
              ),
              onTap: () {},
            ),
          ),
        ],
      );
    } else {
      return Row(
        children: [
          Spacer(),
          SizedBox(
            width: webButtonWidth,
            height: webButtonHeight,
            child: CustomButtonDropOff(
              text: 'Cancel',
              backgroundColor: Colors.transparent,
              textColor: AppColors.textColor,
              borderColor: AppColors.quadrantalTextColor,
              onTap: () {},
            ),
          ),
          SizedBox(width: spacing),
          SizedBox(
            width: webButtonWidth,
            height: webButtonHeight,
            child: PrimaryBthDropOff(
              text: "Continue",
              icon: Image.asset(
                IconString.continueIcon,
              ),
              onTap: () {},
            ),
          ),

        ],
      );
    }
  }

}