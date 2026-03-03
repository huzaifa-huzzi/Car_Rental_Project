import 'package:car_rental_project/PickupCar/PickUpDetailScreen/Widget/AdditionalImagesWidget.dart';
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
            /// DAMAGE INSPECTION SECTION
            _buildDamageInspectionHeader(context),
            const SizedBox(height: 15),

            _buildDamageLegend(context),

            const SizedBox(height: 20),
            _buildStaticCarDiagram(context, screenWidth, isMobile),

            const SizedBox(height: 40),

            /// PICKUP PICTURES SECTION
            _buildPicturesHeader(context),
            const SizedBox(height: 4),
            Text("Require images", style: TTextTheme.requireImagesText(context)),

            const SizedBox(height: 20),
            _buildStaticImageGrid(context, screenWidth),

            const SizedBox(height: 30),
            Text("Additional Images (Max 6)", style: TTextTheme.AdditionalText(context)),
            const SizedBox(height: 15),
            AdditionalImagesBox()
          ],
        ),
      ),
    );
  }

  /// ---- Extra Widgets ------ ///

   // Damage Inspection
  Widget _buildDamageInspectionHeader(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
      decoration: BoxDecoration(
        color: AppColors.secondaryColor,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        children: [
          Image.asset(IconString.damageInspection, height: 18, width: 18),
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
    );
  }
  Widget _buildDamageLegend(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFFDDE4ED)),
        borderRadius: BorderRadius.circular(8),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: controller.damageTypes.map((type) {
            return Padding(
              padding: const EdgeInsets.only(right: 20),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 11,
                    backgroundColor: type['color'],
                    child: Text(
                      type['id'].toString(),
                      style: TTextTheme.btnNumbering(context).copyWith(fontSize: 10),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(type['label'], style: TTextTheme.titleSix(context)),
                ],
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
  Widget _buildStaticCarDiagram(BuildContext context, double screenWidth, bool isMobile) {
    double diagramWidth = isMobile ? screenWidth - 60 : 800;
    double diagramHeight = diagramWidth * 0.5;

    return Center(
      child: SizedBox(
        width: diagramWidth,
        height: diagramHeight,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Image.asset(
              ImageString.carDamageInspectionImage,
              fit: BoxFit.contain,
            ),
            ...controller.damagePoints.map((point) {
              return Positioned(
                left: (point.dx * diagramWidth) - 10,
                top: (point.dy * diagramHeight) - 10,
                child: CircleAvatar(
                  radius: 10,
                  backgroundColor: point.color,
                  child: Text(
                    point.typeId.toString(),
                    style: TTextTheme.btnNumbering(context).copyWith(fontSize: 10),
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

   // Pictures Section
  Widget _buildPicturesHeader(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        bool shouldWrap = constraints.maxWidth < 280;

        return SizedBox(
          width: double.infinity,
          child: shouldWrap
              ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Pickup Pictures", style: TTextTheme.h6Style(context)),
              const SizedBox(height: 6),
              _buildImageCountText(context),
            ],
          )
              : Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  "Pickup Pictures",
                  style: TTextTheme.h6Style(context),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(width: 10),
              _buildImageCountText(context),
            ],
          ),
        );
      },
    );
  }
  Widget _buildImageCountText(BuildContext context) {
    return Obx(() {
      int count = _getTotalImageCount();
      return Text(
        "$count/10 images uploaded",
        style: TTextTheme.titleThree(context),
      );
    });
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
  Widget _buildStaticImageGrid(BuildContext context, double width) {
    int crossAxisCount = width < 600 ? 1 : 2;
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: crossAxisCount,
      mainAxisSpacing: 15,
      crossAxisSpacing: 15,
      childAspectRatio: 1.8,
      children: [
        _staticImageBox(context, "1: Front View", ImageString.frontPickImage),
        _staticImageBox(context, "2: Back View", ImageString.backPickImage),
        _staticImageBox(context, "3: Left view", ImageString.leftPickImage),
        _staticImageBox(context, "4: Right View", ImageString.rightPickImage),
      ],
    );
  }
  Widget _staticImageBox(BuildContext context, String label, String imagePath) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.secondaryColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Stack(
        children: [
          Positioned(
            top: 10,
            left: 12,
            child: Text(label, style: TTextTheme.AdditionalText(context)),
          ),
          Center(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                imagePath,
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
              ),
            ),
          ),
        ],
      ),
    );
  }
}