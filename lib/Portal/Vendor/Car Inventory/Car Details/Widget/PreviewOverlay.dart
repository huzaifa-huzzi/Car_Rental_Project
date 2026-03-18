import 'package:car_rental_project/Resources/AppSizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Car Directory/CarInventoryController.dart';

class CarDocumentPreviewOverlay extends StatelessWidget {
  CarDocumentPreviewOverlay({super.key});

  final controller = Get.find<CarInventoryController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (!controller.isOpen.value) return const SizedBox.shrink();

      final bool isMobile = AppSizes.isMobile(context);
      final double screenHeight = MediaQuery.of(context).size.height;
      final double screenWidth = MediaQuery.of(context).size.width;

      return Positioned.fill(
        child: Material(
          color: Colors.black.withOpacity(0.85),
          child: Stack(
            children: [
              Positioned(
                top: 20,
                left: 20,
                right: 20,
                child: Row(
                  children: [
                    const Spacer(),
                    IconButton(
                      onPressed: controller.close,
                      icon: const Icon(Icons.close_fullscreen, color: Colors.white, size: 30),
                    ),
                  ],
                ),
              ),

              //  ZOOMED IMAGE AREA
              Center(
                child: Container(
                  width: isMobile ? screenWidth * 0.95 : screenWidth * 0.85,
                  height: screenHeight * 0.8,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(color: Colors.black.withOpacity(0.3), blurRadius: 20)
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: InteractiveViewer(
                      panEnabled: true,
                      minScale: 0.5,
                      maxScale: 4.0,
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Image.asset(
                          controller.imagePath.value,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }}