import 'dart:io';
import 'package:car_rental_project/PickupCar/PickupCarInventory.dart';
import 'package:car_rental_project/PickupCar/ReusableWidgetOfPickup/AddButtonOfPickup.dart';
import 'package:car_rental_project/PickupCar/ReusableWidgetOfPickup/AddPickupButton.dart';
import 'package:car_rental_project/PickupCar/ReusableWidgetOfPickup/HeaderWebPickupWidget.dart';
import 'package:car_rental_project/Resources/AppSizes.dart';
import 'package:car_rental_project/Resources/Colors.dart';
import 'package:car_rental_project/Resources/IconStrings.dart';
import 'package:car_rental_project/Resources/ImageString.dart';
import 'package:car_rental_project/Resources/TextTheme.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import '../../../Resources/TextString.dart' show TextString;


class StepTwoSelectionWidget extends StatelessWidget {
  final PickupCarController controller = Get.find();

  StepTwoSelectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final isWeb = AppSizes.isWeb(context);
    final bool isMobile = AppSizes.isMobile(context);
    double padding = 24.0;

    return Scaffold(
      backgroundColor: AppColors.backgroundOfScreenColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),

             // Header of the Screen
            HeaderWebPickupWidget(
              mainTitle: 'Add Pickup Car',
              showBack: true,
              showSmallTitle: true,
              smallTitle: 'Pickup Car / Add Pickup Car',
              showSearch: isWeb,
              showSettings: isWeb,
              showAddButton: false,
              showNotification: true,
              showProfile: true,
            ),
            
            Padding(
              padding: const EdgeInsets.all(20),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(padding),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Header
                          Text(TextString.titleViewPickStepTwo, style: TTextTheme.h6Style(context)),
                          const SizedBox(height: 6),
                          Text(TextString.titleViewSubtitleStepTwo,
                              style: TTextTheme.titleThree(context)),
                          const SizedBox(height: 7),
                          _buildStepBadges(context),

                          const SizedBox(height: 20),
                          _buildDamageInspectionCard(context),
                          const SizedBox(height: 30),
                          _buildUploadPictureCard(context, isMobile),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),
            /// Buttons
          Padding(
            padding: EdgeInsets.only(
              right: 20,
              left: isMobile ? 20 : 0,),
            child:  _buttonSection(context, isMobile),
            ),
            const SizedBox(height: 20), 
          ],
        ),
      ),
    );
  }

    /// ------- Extra Widgtes ------///

  Widget _buildStepBadges(BuildContext context) {
    return Container(
      width: 280,
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildStepItem("1", "Step 1", false, context,isCurrent: true),
          _buildStepLine(true),
          _buildStepItem("2", "Step 2", true, context),
          _buildStepLine(true),
          _buildStepItem("3", "Step 3", false, context, isCurrent: true),
        ],
      ),
    );
  }
  Widget _buildStepItem(String stepNum, String label, bool isCompleted, BuildContext context, {bool isCurrent = false}) {
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

   /// Damage Inspection
  Widget _buildDamageInspectionCard(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final double cardWidth = constraints.maxWidth;
        bool isMobile = cardWidth < 700;

        double responsiveWidth = isMobile ? cardWidth * 0.95 : cardWidth * 0.85;
        if (responsiveWidth > 950) responsiveWidth = 950;
        double height = responsiveWidth * 0.5;

        return Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: AppColors.tertiaryTextColor, width: 0.7),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (isMobile)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildDamageHeading(context),
                    const SizedBox(height: 15),
                    _buildControlsUnit(context, isMobile),
                  ],
                )
              else
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Flexible(
                      flex: 0,
                      child: _buildDamageHeading(context),
                    ),
                    Flexible(
                      child: _buildControlsUnit(context, isMobile),
                    ),
                  ],
                ),

              const SizedBox(height: 40),

              Obx(() {
                return IgnorePointer(
                  ignoring: !controller.isDamageInspectionOpen.value,
                  child: Opacity(
                    opacity: controller.isDamageInspectionOpen.value ? 1.0 : 0.4,
                    child: Center(
                      child: GestureDetector(
                        onTapDown: (details) {
                          double dx = details.localPosition.dx / responsiveWidth;
                          double dy = details.localPosition.dy / height;

                          int existingIndex = controller.damagePoints2.indexWhere(
                                (p) => (p.dx - dx).abs() < 0.04 && (p.dy - dy).abs() < 0.04,
                          );

                          if (existingIndex != -1) {
                            controller.damagePoints2.removeAt(existingIndex);
                          } else {
                            var type = controller.damageTypes2.firstWhere(
                                    (t) => t['id'] == controller.selectedDamageType2.value);

                            controller.damagePoints2.add(
                              DamagePoint(
                                dx: dx,
                                dy: dy,
                                typeId: type['id'],
                                color: type['color'],
                              ),
                            );
                          }
                        },
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Image.asset(
                              ImageString.carDamageInspectionImage,
                              width: responsiveWidth,
                              height: height,
                              fit: BoxFit.contain,
                            ),
                            ...controller.damagePoints2.map((point) {
                              return Positioned(
                                left: (point.dx * responsiveWidth) - 10,
                                top: (point.dy * height) - 10,
                                child: CircleAvatar(
                                  radius: 10,
                                  backgroundColor: point.color,
                                  child: Text(
                                    point.typeId.toString(),
                                    style: TTextTheme.btnNumbering(context),
                                  ),
                                ),
                              );
                            }),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ],
          ),
        );
      },
    );
  }
  Widget _buildControlsUnit(BuildContext context, bool isMobile) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildToggleWidget(context),
        const SizedBox(width: 15),
        Flexible(
          child: _buildChipsContainer(context, isMobile: isMobile),
        ),
      ],
    );
  }
  Widget _buildChipsContainer(BuildContext context, {required bool isMobile}) {
    return Container(
      height: 52,
      padding: const EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: AppColors.tertiaryTextColor,width: 0.8),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Obx(() {
        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          child: Row(
            children: controller.damageTypes2.map((type) {
              bool isSelected = controller.selectedDamageType2.value == type['id'];
              return GestureDetector(
                onTap: () {
                  if (controller.isDamageInspectionOpen.value) {
                    controller.selectedDamageType2.value = type['id'];
                  }
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 10),
                  margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 6),
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: isSelected ? AppColors.secondaryColor : Colors.transparent,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 11,
                        backgroundColor: type['color'],
                        child:Center(
                          child: Text(type['id'].toString(),
                              style: TTextTheme.btnNumbering(context)) ,
                        )
                      ),
                      const SizedBox(width: 8),
                      Text(type['label'], style: TTextTheme.titleSix(context)),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        );
      }),
    );
  }
  Widget _buildDamageHeading(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(IconString.damageInspection, height: 20, width: 20),
            const SizedBox(width: 8),
            Flexible(
              child: Text(
                "Damage Inspection",
                style: TTextTheme.DamageStyle(context),
                softWrap: true,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        const SizedBox(height: 2),
        Padding(
          padding: const EdgeInsets.only(left: 28),
          child: Text(
            "Fill the Report",
            style: TTextTheme.titleThree(context),
            softWrap: true,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
  Widget _buildToggleWidget(BuildContext context) {
  return Obx(() => GestureDetector(
  onTap: () => controller.isDamageInspectionOpen.value = !controller.isDamageInspectionOpen.value,
  child: Container(
  width: 60,
  height: 32,
  padding: const EdgeInsets.all(4),
  decoration: BoxDecoration(
  borderRadius: BorderRadius.circular(8),
  color: controller.isDamageInspectionOpen.value ? AppColors.primaryColor : AppColors.quadrantalTextColor,
  ),
  child: Stack(
  children: [
  AnimatedAlign(
  duration: const Duration(milliseconds: 200),
  alignment: controller.isDamageInspectionOpen.value ? Alignment.centerRight : Alignment.centerLeft,
  child: Container(
  width: 24,
  height: 24,
  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(4)),
  ),
  ),
  Align(
  alignment: controller.isDamageInspectionOpen.value ? const Alignment(-0.6, 0) : const Alignment(0.6, 0),
  child: Text(
  controller.isDamageInspectionOpen.value ? "Yes" : "No",
  style:TTextTheme.btnWhiteColor(context),
  ),
  ),
  ],
  ),
  ),
  ));
  }
  /// Add Picture Section
  Widget _buildUploadPictureCard(BuildContext context, bool isMobile) {
    return LayoutBuilder(builder: (context, bConstraints) {
      double width = bConstraints.maxWidth;

      return Container(
        padding: EdgeInsets.all(width < 400 ? 12 : 24),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: AppColors.tertiaryTextColor, width: 0.7),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: double.infinity,
              child: Wrap(
                alignment: width < 350 ? WrapAlignment.start : WrapAlignment.spaceBetween,
                crossAxisAlignment: WrapCrossAlignment.center,
                runSpacing: 8,
                children: [
                  Text(
                    "Upload picture",
                    style: TTextTheme.h6Style(context).copyWith(
                      fontSize: width < 300 ? 14 : 18,
                    ),
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
                      style: TTextTheme.titleThree(context).copyWith(
                        fontSize: width < 300 ? 9 : 12,
                      ),
                    );
                  }),
                ],
              ),
            ),

            const SizedBox(height: 4),
            Text("Require images", style: TTextTheme.requireImagesText(context)),
            const SizedBox(height: 20),
            LayoutBuilder(builder: (context, innerConstraints) {
              int crossAxisCount = innerConstraints.maxWidth < 550 ? 1 : 2;

              double aspectRatio = innerConstraints.maxWidth < 350
                  ? 1.2
                  : (innerConstraints.maxWidth < 600 ? 1.5 : 1.9);

              return GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: crossAxisCount,
                mainAxisSpacing: 15,
                crossAxisSpacing: 15,
                childAspectRatio: aspectRatio,
                children: [
                  _buildImagePickerBox(context, "1: Front View", ImageString.frontView, 'front', innerConstraints.maxWidth),
                  _buildImagePickerBox(context, "2: Back View", ImageString.backView, 'back', innerConstraints.maxWidth),
                  _buildImagePickerBox(context, "3: Left view", ImageString.leftView, 'left', innerConstraints.maxWidth),
                  _buildImagePickerBox(context, "4: Right View", ImageString.rightView, 'right', innerConstraints.maxWidth),
                ],
              );
            }),

            const SizedBox(height: 30),
            Text("Additional Images (Max 6)", style: TTextTheme.AdditionalText(context)),
            const SizedBox(height: 15),
            _buildAdditionalUploadBox(context, isMobile),
          ],
        ),
      );
    });
  }
  Widget _buildImagePickerBox(BuildContext context, String label, String iconPath, String type, double boxWidth) {
    return Obx(() {
      ImageHolder? image;
      if (type == 'front') {
        image = controller.frontImage.value;
      } else if (type == 'back') image = controller.backImage.value;
      else if (type == 'left') image = controller.leftImage.value;
      else if (type == 'right') image = controller.rightImage.value;

      bool hasImage = image != null;

      return GestureDetector(
        onTap: () => controller.pickImageNew(type),
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.secondaryColor,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Stack(
            children: [
              Positioned(
                top: 8,
                left: 10,
                child: Text(
                    label,
                    style: TTextTheme.AdditionalText(context),
                ),
              ),

              Center(
                child: hasImage
                    ? ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: kIsWeb
                      ? Image.memory(image.bytes!, fit: BoxFit.cover, width: double.infinity, height: double.infinity)
                      : Image.file(File(image.path!), fit: BoxFit.cover, width: double.infinity, height: double.infinity),
                )
                    : Padding(
                  padding: const EdgeInsets.only(top: 20, bottom: 5),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Flexible(
                        child: Image.asset(
                          iconPath,
                          height: boxWidth < 300 ? 30 : 45,
                          fit: BoxFit.contain,
                        ),
                      ),
                      const SizedBox(height: 4),
                      FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text("Click to upload", style: TTextTheme.UploadText(context)),
                      ),
                      FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text.rich(
                          TextSpan(
                            text: "JPEG, PNG ",
                            style: TTextTheme.titleDriver(context),
                            children: [
                              TextSpan(
                                text: "(Must be under 50 MB)",
                                style: TTextTheme.titleTwelve(context),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              if (hasImage)
                Positioned(
                  top: 5, right: 5,
                  child: GestureDetector(
                    onTap: () => controller.removeImageNew(type),
                    child: const CircleAvatar(
                      radius: 10,
                      backgroundColor: AppColors.primaryColor,
                      child: Icon(Icons.close, color: Colors.white, size: 12),
                    ),
                  ),
                ),
            ],
          ),
        ),
      );
    });
  }
  Widget _buildAdditionalUploadBox(BuildContext context, bool isMobile) {
    return Obx(() {
      bool hasImages = controller.additionalImages.isNotEmpty;

      return GestureDetector(
        onTap: () {
          if (controller.additionalImages.length < 6) {
            controller.pickImageNew('additional');
          }
        },
        behavior: HitTestBehavior.opaque,
        child: Container(
          width: double.infinity,
          constraints: const BoxConstraints(minHeight: 150),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.secondaryColor,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            mainAxisAlignment: hasImages ? MainAxisAlignment.start : MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (!hasImages)
                Center(
                  child: Column(
                    children: [
                      Image.asset(IconString.pickupUploadIcon,),
                      const SizedBox(height: 10),
                       Text("Click to upload", style: TTextTheme.UploadText(context)),
                      SizedBox(height: 4,),
                      Text.rich(
                        TextSpan(
                          text: "JPEG, PNG ",
                          style: TTextTheme.titleDriver(context),
                          children: [
                            TextSpan(
                              text: "(Must be under 50 MB)",
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
                  children: controller.additionalImages.asMap().entries.map((entry) {
                    int idx = entry.key;
                    var img = entry.value;
                    return Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Container(
                          width: 85,
                          height: 85,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: AppColors.tertiaryTextColor),
                            image: DecorationImage(
                              image: kIsWeb ? MemoryImage(img.bytes!) : FileImage(File(img.path!)) as ImageProvider,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Positioned(
                          top: -6,
                          right: -6,
                          child: GestureDetector(
                            onTap: () => controller.removeImageNew('additional', index: idx),
                            child:  CircleAvatar(
                              radius: 11,
                              backgroundColor: AppColors.primaryColor,
                              child: Icon(Icons.close, size: 14, color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    );
                  }).toList(),
                ),
            ],
          ),
        ),
      );
    });
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
            child: AddPickUpButton(
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
            child: AddButtonOfPickup(
              text: "Continue",
              icon: Image.asset(
                IconString.continueIcon,
              ),
              onTap: () {
                context.push('/stepThreeWidgetScreen', extra: {"hideMobileAppBar": true});
              },
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
            child: AddPickUpButton(
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
            child: AddButtonOfPickup(
              text: "Continue",
              icon: Image.asset(
                IconString.continueIcon,
              ),
              onTap: () {
                context.push('/stepThreeWidgetScreen', extra: {"hideMobileAppBar": true});
              },
            ),
          ),

        ],
      );
    }
  }

}