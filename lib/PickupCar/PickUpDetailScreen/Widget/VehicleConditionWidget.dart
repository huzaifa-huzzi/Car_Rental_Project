import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:car_rental_project/PickupCar/PickupCarInventory.dart';
import 'package:car_rental_project/Resources/Colors.dart';
import 'package:car_rental_project/Resources/IconStrings.dart';
import 'package:car_rental_project/Resources/ImageString.dart';
import 'package:car_rental_project/Resources/TextTheme.dart';

class VehicleConditionScreen extends StatelessWidget {
  final PickupCarController controller = Get.find();

  VehicleConditionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final bool isMobile = screenWidth < 800;

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
            /// 1: DAMAGE INSPECTION SECTION
            _buildDamageInspectionHeader(context),
            const SizedBox(height: 15),
            _buildDamageLegend(context),
            const SizedBox(height: 20),
            _buildStaticCarDiagram(context, screenWidth, isMobile),

            const SizedBox(height: 40),

            /// 2: PICKUP PICTURES SECTION
            _buildPicturesHeader(context),
            const SizedBox(height: 20),
            _buildMainImageGrid(context, screenWidth),

            const SizedBox(height: 30),
            Text("Additional Images (Max 6)", style: TTextTheme.AdditionalText(context)),
            const SizedBox(height: 15),
            _buildAdditionalImagesBox(context, isMobile),
          ],
        ),
      ),
    );
  }

  /// --- DAMAGE INSPECTION WIDGETS ---

  Widget _buildDamageInspectionHeader(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
      decoration: BoxDecoration(
        color: const Color(0xFFF0F7FF), // Light bluish background like SS
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        children: [
          Image.asset(IconString.damageInspection, height: 18, width: 18),
          const SizedBox(width: 10),
          Text("Damage Inspection", style: TTextTheme.DamageStyle(context)),
        ],
      ),
    );
  }

  Widget _buildDamageLegend(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: controller.damageTypes2.map((type) {
          return Container(
            margin: const EdgeInsets.only(right: 10),
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 7,
                  backgroundColor: type['color'],
                  child: Text(type['id'].toString(), style: const TextStyle(fontSize: 8, color: Colors.white)),
                ),
                const SizedBox(width: 6),
                Text(type['label'], style: TTextTheme.titleSix(context).copyWith(fontSize: 12)),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildStaticCarDiagram(BuildContext context, double screenWidth, bool isMobile) {
    // Responsive width calculation
    double diagramWidth = isMobile ? screenWidth - 60 : 800;
    double diagramHeight = diagramWidth * 0.5;

    return Center(
      child: SizedBox(
        width: diagramWidth,
        height: diagramHeight,
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Static Image - No GestureDetector to prevent clicks
            Image.asset(
              ImageString.carDamageInspectionImage,
              fit: BoxFit.contain,
            ),
            // Existing points will still show if any
            ...controller.damagePoints2.map((point) {
              return Positioned(
                left: (point.dx * diagramWidth) - 10,
                top: (point.dy * diagramHeight) - 10,
                child: CircleAvatar(
                  radius: 10,
                  backgroundColor: point.color,
                  child: Text(point.typeId.toString(), style: const TextStyle(fontSize: 10, color: Colors.white)),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  /// --- PICTURES SECTION WIDGETS ---

  Widget _buildPicturesHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text("Pickup Pictures", style: TTextTheme.h6Style(context)),
        Obx(() {
          int count = _getTotalImageCount();
          return Text("$count/10 images uploaded", style: TTextTheme.titleThree(context));
        }),
      ],
    );
  }

  int _getTotalImageCount() {
    int count = 0;
    if (controller.frontImage.value != null) count++;
    if (controller.backImage.value != null) count++;
    if (controller.leftImage.value != null) count++;
    if (controller.rightImage.value != null) count++;
    count += controller.additionalImages.length;
    return count;
  }

  Widget _buildMainImageGrid(BuildContext context, double width) {
    int crossAxisCount = width < 600 ? 1 : 2;
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: crossAxisCount,
      mainAxisSpacing: 15,
      crossAxisSpacing: 15,
      childAspectRatio: 1.8,
      children: [
        _imagePickerBox(context, "1: Front View", ImageString.frontView, 'front'),
        _imagePickerBox(context, "2: Back View", ImageString.backView, 'back'),
        _imagePickerBox(context, "3: Left View", ImageString.leftView, 'left'),
        _imagePickerBox(context, "4: Right View", ImageString.rightView, 'right'),
      ],
    );
  }

  Widget _imagePickerBox(BuildContext context, String label, String icon, String type) {
    return Obx(() {
      var image = _getImageByType(type);
      return GestureDetector(
        onTap: () => controller.pickImageNew(type),
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.secondaryColor,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Stack(
            children: [
              Positioned(top: 10, left: 12, child: Text(label, style: TTextTheme.AdditionalText(context))),
              Center(
                child: image != null
                    ? ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: kIsWeb
                      ? Image.memory(image.bytes!, fit: BoxFit.cover, width: double.infinity, height: double.infinity)
                      : Image.file(File(image.path!), fit: BoxFit.cover, width: double.infinity, height: double.infinity),
                )
                    : Image.asset(icon, height: 40),
              ),
            ],
          ),
        ),
      );
    });
  }

  dynamic _getImageByType(String type) {
    if (type == 'front') return controller.frontImage.value;
    if (type == 'back') return controller.backImage.value;
    if (type == 'left') return controller.leftImage.value;
    if (type == 'right') return controller.rightImage.value;
    return null;
  }

  Widget _buildAdditionalImagesBox(BuildContext context, bool isMobile) {
    return Obx(() {
      return Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.secondaryColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            ...controller.additionalImages.asMap().entries.map((entry) {
              return _thumbnailImage(entry.value, entry.key);
            }).toList(),
            if (controller.additionalImages.length < 6)
              GestureDetector(
                onTap: () => controller.pickImageNew('additional'),
                child: Container(
                  width: 85, height: 85,
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8), border: Border.all(color: Colors.grey.shade300)),
                  child: const Icon(Icons.add, color: AppColors.primaryColor),
                ),
              ),
          ],
        ),
      );
    });
  }

  Widget _thumbnailImage(dynamic img, int index) {
    return Stack(
      children: [
        Container(
          width: 85, height: 85,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            image: DecorationImage(
              image: kIsWeb ? MemoryImage(img.bytes!) : FileImage(File(img.path!)) as ImageProvider,
              fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned(
          top: -2, right: -2,
          child: GestureDetector(
            onTap: () => controller.removeImageNew('additional', index: index),
            child: const CircleAvatar(radius: 10, backgroundColor: Colors.red, child: Icon(Icons.close, size: 12, color: Colors.white)),
          ),
        ),
      ],
    );
  }
}