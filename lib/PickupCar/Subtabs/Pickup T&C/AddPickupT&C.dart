import 'package:car_rental_project/PickupCar/PickupCarInventory.dart';
import 'package:car_rental_project/PickupCar/ReusableWidgetOfPickup/AddButtonOfPickup.dart';
import 'package:car_rental_project/PickupCar/ReusableWidgetOfPickup/HeaderWebPickupWidget.dart';
import 'package:car_rental_project/Resources/AppSizes.dart';
import 'package:car_rental_project/Resources/Colors.dart';
import 'package:car_rental_project/Resources/TextTheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;
import 'package:get/get.dart';


class AddPickupTandC extends StatelessWidget {
  const AddPickupTandC({super.key});

  @override
  Widget build(BuildContext context) {
    if (!Get.isRegistered<PickupCarController>()) {
      Get.put(PickupCarController());
    }
    final controller = Get.find<PickupCarController>();
    bool isWeb = AppSizes.isWeb(context);

    return Scaffold(
      backgroundColor: AppColors.backgroundOfScreenColor,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// HEADER SECTION
              Padding(
                padding: EdgeInsets.all(AppSizes.horizontalPadding(context)),
                child: HeaderWebPickupWidget(
                  mainTitle: 'Add Pickup T&C',
                  showBack: true,
                  showSmallTitle: true,
                  smallTitle: 'Pickup Car/Pickup T&C',
                  showSearch: isWeb,
                  showSettings: isWeb,
                  showAddButton: false,
                  showNotification: true,
                  showProfile: true,
                ),
              ),

              /// MAIN WHITE CARD
              Padding(
                padding: EdgeInsets.symmetric(horizontal: AppSizes.horizontalPadding(context)),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey.shade200),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Add Pickup Terms & Conditions", style: TTextTheme.hPickupStyle(context)),
                      const SizedBox(height: 4),
                      Text("Every save create a new version automatically",
                          style: TextStyle(color: AppColors.tertiaryTextColor.withOpacity(0.6), fontSize: 13)),

                      const SizedBox(height: 24),

                      /// FUNCTIONAL TOOLBAR
                      GetBuilder<PickupCarController>(
                          builder: (controller) {
                            return Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: Colors.grey.shade200),
                              ),
                              child: Wrap(
                                spacing: 12,
                                runSpacing: 10,
                                crossAxisAlignment: WrapCrossAlignment.center,
                                children: [
                                  _buildSelectableTextBtn("H1", quill.Attribute.h1, controller),
                                  _buildSelectableTextBtn("H2", quill.Attribute.h2, controller),
                                  _buildSelectableTextBtn("H3", quill.Attribute.h3, controller),
                                  const SizedBox(height: 20, child: VerticalDivider(thickness: 1)),

                                  _buildSizeDropdown(controller),

                                  const SizedBox(height: 20, child: VerticalDivider(thickness: 1)),
                                  _buildSelectableIconBtn(Icons.format_bold, quill.Attribute.bold, controller),
                                  _buildSelectableIconBtn(Icons.format_italic, quill.Attribute.italic, controller),
                                  _buildSelectableIconBtn(Icons.format_underlined, quill.Attribute.underline, controller),
                                  _buildSelectableIconBtn(Icons.format_list_bulleted, quill.Attribute.ol, controller),
                                ],
                              ),
                            );
                          }
                      ),

                      const SizedBox(height: 16),

                      /// EDITOR AREA WITH DYNAMIC CURSOR & FIXED PLACEHOLDER
                      _buildEditorArea(controller),

                      const SizedBox(height: 24),

                      /// SAVE BUTTON
                      Align(
                        alignment: Alignment.centerRight,
                        child: CompositedTransformTarget(
                          link: controller.saveButtonLink,
                          child: AddButtonOfPickup(
                            text: "Save as a new Version",
                            width: 180,
                            onTap: () {
                              _showActivatedNotification(context, controller);
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 140),
            ],
          ),
        ),
      ),
    );
  }

  /// --------- Extra Widgets ------ ///
  Widget _buildSelectableTextBtn(String label, quill.Attribute attr, PickupCarController controller) {
    bool isActive = controller.isStyleActive(attr);
    return InkWell(
      onTap: () => controller.toggleStyle(attr),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: isActive ? const Color(0xFFF2F4F7) : Colors.transparent,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Text(label,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: isActive ? Colors.black : const Color(0xFF1D2939)
            )
        ),
      ),
    );
  }

  Widget _buildSelectableIconBtn(IconData icon, quill.Attribute attr, PickupCarController controller) {
    bool isActive = controller.isStyleActive(attr);
    return InkWell(
      onTap: () => controller.toggleStyle(attr),
      child: Container(
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: isActive ? const Color(0xFFF2F4F7) : Colors.transparent,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Icon(icon, size: 20, color: isActive ? Colors.black : const Color(0xFF1D2939)),
      ),
    );
  }

  Widget _buildSizeDropdown(PickupCarController controller) {
    return Obx(() => PopupMenuButton<String>(
      offset: const Offset(0, 40),
      onSelected: (String val) => controller.changeFontSize(val),
      itemBuilder: (BuildContext context) {
        return ['12', '14', '16', '18', '20', '24'].map((String s) {
          return PopupMenuItem<String>(
            value: s,
            height: 35,
            child: Text(s, style: const TextStyle(color: Color(0xFF667085), fontSize: 14)),
          );
        }).toList();
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: const Color(0xFFF2F4F7),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
                controller.selectedSize.value.isEmpty ? "Size" : controller.selectedSize.value,
                style: const TextStyle(color: Color(0xFF667085), fontSize: 14)
            ),
            const SizedBox(width: 4),
            const Icon(Icons.keyboard_arrow_down, size: 18, color: Color(0xFF667085)),
          ],
        ),
      ),
    ));
  }

  Widget _buildEditorArea(PickupCarController controller) {
    return Container(
      height: 350,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Stack(
        children: [
          Obx(() {
            double currentSize = double.tryParse(controller.selectedSize.value) ?? 16.0;

            return quill.QuillEditor.basic(
              controller: controller.termsController,
              config: quill.QuillEditorConfig(
                autoFocus: false,
                expands: true,
                padding: EdgeInsets.zero,
                showCursor: true,
                customStyles: quill.DefaultStyles(
                  paragraph: quill.DefaultTextBlockStyle(
                    TextStyle(
                      fontSize: currentSize,
                      height: 1.4,
                      color: AppColors.blackColor
                    ),
                    const quill.HorizontalSpacing(0, 0),
                    const quill.VerticalSpacing(0, 0),
                    const quill.VerticalSpacing(0, 0),
                    null,
                  ),
                ),
              ),
            );
          }),

          GetBuilder<PickupCarController>(
            builder: (controller) {
              if (controller.termsController.document.isEmpty()) {
                return const Positioned(
                  top: 4,
                  left: 4,
                  child: IgnorePointer(
                    child: Text(
                      "Write here...",
                      style: TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                  ),
                );
              }
              return const SizedBox();
            },
          ),
    const Positioned(
    bottom: 0,
    right: 0,
    child: Text(
    "Max(2000 words)",
    style: TextStyle(
    color: Color(0xFF667085),
    fontSize: 12,
    ),
    ),
    ),
        ],
      ),
    );
  }

  void _showActivatedNotification(BuildContext context, PickupCarController controller) {
    OverlayState? overlayState = Overlay.of(context);
    late OverlayEntry overlayEntry;

    double screenWidth = MediaQuery.of(context).size.width;

    double popupWidth = screenWidth < 352 ? screenWidth - 80 : 320;

    overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        width: popupWidth,
        child: CompositedTransformFollower(
          link: controller.saveButtonLink,
          showWhenUnlinked: false,
          offset: Offset(
              screenWidth < 400 ? -(popupWidth - 140) : -120,
              45
          ),
          child: Material(
            elevation: 8,
            borderRadius: BorderRadius.circular(12),
            color: Colors.transparent,
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.fieldsBackground,
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  )
                ],
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Version 4 has updated",
                          style: TTextTheme.titleSmallRegister(context).copyWith(
                            fontSize: screenWidth < 300 ? 12 : 14,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 2),
                        Text(
                          "New Version has now active",
                          style: TTextTheme.titleThree(context).copyWith(
                            fontSize: screenWidth < 300 ? 10 : 12,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  GestureDetector(
                    onTap: () => overlayEntry.remove(),
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: AppColors.tertiaryTextColor,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.close,
                        size: 14,
                        color: AppColors.textColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );

    overlayState.insert(overlayEntry);

    Future.delayed(const Duration(seconds: 3), () {
      if (overlayEntry.mounted) {
        overlayEntry.remove();
      }
    });
  }
}