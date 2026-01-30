import 'package:car_rental_project/DroppOffCar/DropOffController.dart';
import 'package:car_rental_project/Resources/Colors.dart';
import 'package:car_rental_project/Resources/IconStrings.dart';
import 'package:car_rental_project/Resources/ImageString.dart';
import 'package:car_rental_project/Resources/TextTheme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Resources/AppSizes.dart' show AppSizes;

class AddDropOffWidget extends StatelessWidget {
  final TextEditingController searchController = TextEditingController();
  final RxString searchQuery = "".obs;
  // Maan letay hain aapka Dropoff controller ya Customer controller yahan hai
  final RxString selectedSearchType = "Name".obs;

  AddDropOffWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      bool isTyping = searchQuery.value.isNotEmpty;

      return Container(
        width: double.infinity,
        constraints: const BoxConstraints(minHeight: 220),
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 15)],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. Header Section
            Text("Add Dropoff Car", style: TTextTheme.h5Style(context)),
            const SizedBox(height: 4),
            Text("Enter the specification for the car return details", style: TTextTheme.pTwo(context).copyWith(color: Colors.grey)),

            const Padding(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: Divider(height: 1, color: Color(0xFFEEEEEE)),
            ),

            // 2. SEARCH ROW (Integrated logic from your snippet)
            Row(
              children: [
                _buildCategorySelection(
                    context,
                    Get.put(DropOffController()), // Controller pass karein
                    52,                          // Height pass karein
                    true                         // showText pass karein
                ),
                const SizedBox(width: 12),

                // Integrated Search Bar (Aapka _searchBarWithButton wala logic)
                Expanded(
                  child: Container(
                    height: 52,
                    padding: const EdgeInsets.only(left: 16, right: 6),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFEFEF), // Pinkish as per Dropoff design
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.search, size: 18, color: Colors.grey),
                        const SizedBox(width: 10),
                        Expanded(
                          child: TextField(
                            controller: searchController,
                            onChanged: (val) => searchQuery.value = val,
                            style: TTextTheme.titleTwo(context),
                            decoration: const InputDecoration(
                              hintText: "Search Pickup by customer",
                              hintStyle: TextStyle(color: Colors.grey, fontSize: 13),
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.zero,
                            ),
                          ),
                        ),
                        // THE SEARCH BUTTON (Integrated inside)
                        GestureDetector(
                          onTap: () {},
                          child: Container(
                            height: 40,
                            padding: const EdgeInsets.symmetric(horizontal: 24),
                            decoration: BoxDecoration(
                              color: AppColors.primaryColor,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            alignment: Alignment.center,
                            child: Text("Search", style: TTextTheme.btnSearch(context)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            // 3. Results Section
            if (isTyping) ...[
              const SizedBox(height: 30),
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 3,
                separatorBuilder: (context, index) => const Divider(height: 40, color: Color(0xFFF5F5F5)),
                itemBuilder: (context, index) => _buildResultItem(context),
              ),
            ],
          ],
        ),
      );
    });
  }

  /// --- Extra Widgets ---------///

  Widget _buildCategorySelection(BuildContext context, DropOffController controller, double height, bool showText) {
    final double screenWidth = MediaQuery.of(context).size.width;
    bool shouldShowText = screenWidth > 600 ? showText : false;
    double maxWidth = shouldShowText ? (screenWidth > 1100 ? 200 : 150) : 60;

    return Container(
      height: height,
      constraints: BoxConstraints(maxWidth: maxWidth),
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: AppColors.backgroundOfPickupsWidget,
        borderRadius: BorderRadius.circular(AppSizes.borderRadius(context)),
      ),
      child: Theme(
        data: Theme.of(context).copyWith(
          dividerColor: Colors.transparent,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.white).copyWith(surface: Colors.white),
        ),
        child: PopupMenuButton<String>(
          offset: const Offset(0, 45),
          color: AppColors.backgroundOfPickupsWidget,
          elevation: 8,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          onSelected: (val) => controller.selectedSearchType.value = val,
          itemBuilder: (context) => [
            _buildPopupItem("Customer Name", IconString.nameIcon, context),
            _buildPopupItem("Vin Number", IconString.vinNumberIcon, context),
            _buildPopupItem("Registration", IconString.registrationIcon, context),
            _buildPopupItem("Car Name", IconString.carNameIcon, context, isLast: true),
          ],
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(_getIconPathForType(controller.selectedSearchType.value), width: 18, color: AppColors.quadrantalTextColor),
              if (shouldShowText) ...[
                const SizedBox(width: 6),
                Flexible(
                  child: Text(
                    controller.selectedSearchType.value,
                    style: TTextTheme.titleThree(context),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
              ],
              const Icon(Icons.keyboard_arrow_down, size: 16, color: AppColors.secondTextColor),
            ],
          ),
        ),
      ),
    );
  }

  PopupMenuItem<String> _buildPopupItem(String text, String icon, BuildContext context, {bool isFirst = false, bool isLast = false}) {
    return PopupMenuItem(
      value: text,
      padding: EdgeInsets.zero,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              children: [
                Image.asset(icon, color: AppColors.quadrantalTextColor, width: 18),
                const SizedBox(width: 12),
                Text(text, style: TTextTheme.titleThree(context)),
              ],
            ),
          ),
          if (!isLast) Divider(height: 1, thickness: 0.5, color: AppColors.primaryColor),
        ],
      ),
    );
  }

  // Icons Paths for the category
  String _getIconPathForType(String type) {
    switch (type) {
      case "Customer Name": return IconString.nameIcon;
      case "Vin Number": return IconString.vinNumberIcon;
      case "Registration": return IconString.registrationIcon;
      case "Car Name": return IconString.carInventoryIcon;
      default: return IconString.nameIcon;
    }
  }


  Widget _buildResultItem(BuildContext context) {
    return Row(
      children: [
        const CircleAvatar(radius: 18, backgroundImage: AssetImage(ImageString.userImage)),
        const SizedBox(width: 12),
        Expanded(flex: 2, child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text("Jack Morrison", style: TTextTheme.btnOne(context).copyWith(fontSize: 13)),
          const Text("JackMorrison@rhyta.com", style: TextStyle(fontSize: 10, color: Colors.grey)),
        ])),
        Expanded(flex: 2, child: _buildLabelValue(context, "VIN Number", "JTNBA3HK003001234")),
        Expanded(flex: 2, child: _buildLabelValue(context, "Registration", "1234567890")),
        Expanded(flex: 2, child: _buildLabelValue(context, "Car Name", "Toyota Corolla (2017)")),
        Expanded(flex: 1, child: _buildStatusChip("Completed", const Color(0xFF1B2B33))),
        const SizedBox(width: 12),
        ElevatedButton(onPressed: () {},
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.primaryColor, padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
            child: const Text("Select", style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold))),
      ],
    );
  }

  Widget _buildLabelValue(BuildContext context, String label, String value) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(label, style: const TextStyle(fontSize: 10, color: Colors.grey)),
      const SizedBox(height: 4),
      Text(value, style: TTextTheme.btnOne(context).copyWith(fontSize: 11)),
    ]);
  }

  Widget _buildStatusChip(String label, Color color) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const Text("Status", style: TextStyle(fontSize: 10, color: Colors.grey)),
      const SizedBox(height: 4),
      Container(padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4), decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(4)),
          child: Text(label, style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold))),
    ]);
  }
}