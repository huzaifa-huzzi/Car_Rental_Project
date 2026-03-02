import 'package:car_rental_project/PickupCar/ReusableWidgetOfPickup/AddButtonOfPickup.dart';
import 'package:car_rental_project/Resources/Colors.dart';
import 'package:car_rental_project/Resources/ImageString.dart';
import 'package:car_rental_project/Resources/TextTheme.dart';
import 'package:flutter/material.dart';

class AdditionalImagesBox extends StatelessWidget {
  const AdditionalImagesBox({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> allImages = [
      ImageString.frontPickImage,
      ImageString.backPickImage,
      ImageString.leftPickImage,
      ImageString.rightPickImage,
      ImageString.frontPickImage,
      ImageString.backPickImage,
    ];

    List<String> displayedImages = allImages.take(4).toList();

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.secondaryColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Additional Images", style: TTextTheme.h6Style(context)),
          const SizedBox(height: 15),
          LayoutBuilder(
            builder: (context, constraints) {
              int crossAxisCount = constraints.maxWidth < 600 ? 2 : 4;

              return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: displayedImages.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 1.0,
                ),
                itemBuilder: (gridContext, index) {
                  bool isLast = index == 3 && allImages.length > 4;

                  return _buildThumbnailWidget(
                    displayedImages[index],
                    isLast,
                    allImages,
                    context
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildThumbnailWidget(
      String imagePath,
      bool isLast,
      List<String> allImages,
      BuildContext context,
      ) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: AppColors.tertiaryTextColor),
            image: DecorationImage(
              image: AssetImage(imagePath),
              fit: BoxFit.cover,
            ),
          ),
        ),
        if (isLast)
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black54,
                borderRadius: BorderRadius.circular(8),
              ),
              alignment: Alignment.center,
              child: AddButtonOfPickup(
                text: "View All",
                height: 40,
                width: 120,
                icon: const Icon(Icons.arrow_forward, color: Colors.white, size: 16),
                onTap: () {
                  _showAllImagesPopup(context, allImages);
                },
              )
            ),
          ),
      ],
    );
  }

  void _showAllImagesPopup(BuildContext context, List<String> allImages) {
    final PageController pageController = PageController();

    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (dialogContext) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: Container(
            width: MediaQuery.of(dialogContext).size.width * 0.8,
            height: MediaQuery.of(dialogContext).size.height * 0.7,
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.9),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Stack(
              children: [
                PageView.builder(
                  controller: pageController,
                  itemCount: allImages.length,
                  itemBuilder: (_, index) {
                    return Padding(
                      padding: const EdgeInsets.all(20),
                      child: Image.asset(
                        allImages[index],
                        fit: BoxFit.contain,
                      ),
                    );
                  },
                ),

                Positioned(
                  top: 10,
                  right: 10,
                  child: IconButton(
                    icon: const Icon(Icons.close, color: Colors.white, size: 30),
                    onPressed: () => Navigator.of(dialogContext).pop(),
                  ),
                ),
                Positioned(
                  left: 10,
                  top: 0,
                  bottom: 0,
                  child: Center(
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back_ios, color: Colors.white, size: 40),
                      onPressed: () {
                        pageController.previousPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                      },
                    ),
                  ),
                ),

                Positioned(
                  right: 10,
                  top: 0,
                  bottom: 0,
                  child: Center(
                    child: IconButton(
                      icon: const Icon(Icons.arrow_forward_ios, color: Colors.white, size: 40),
                      onPressed: () {
                        pageController.nextPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}