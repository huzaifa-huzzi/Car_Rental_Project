import 'package:car_rental_project/Portal/Vendor/DropOffCar/DropOffController.dart';
import 'package:car_rental_project/Portal/Vendor/DropOffCar/ReusableWidgetOfDropoff/HeaderWebDropOffWidget.dart';
import 'package:car_rental_project/Portal/Vendor/PickupCar/ReusableWidgetOfPickup/AddButtonOfPickup.dart';
import 'package:car_rental_project/Resources/AppSizes.dart';
import 'package:car_rental_project/Resources/Colors.dart';
import 'package:car_rental_project/Resources/TextString.dart';
import 'package:car_rental_project/Resources/TextTheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';


class AddDropOffTandC extends StatelessWidget {
  const AddDropOffTandC({super.key});

  @override
  Widget build(BuildContext context) {
    if (!Get.isRegistered<DropOffController>()) {
      Get.put(DropOffController());
    }
    final controller = Get.find<DropOffController>();
    bool isWeb = AppSizes.isWeb(context);

    return Scaffold(
      backgroundColor: AppColors.backgroundOfScreenColor,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.all(AppSizes.horizontalPadding(context)),
                child: HeaderWebDropOffWidget(
                  mainTitle: 'Add DropOff T&C',
                  showBack: true,
                  showSmallTitle: true,
                  smallTitle: 'DropOff Car/DropOff T&C',
                  showSearch: isWeb,
                  showSettings: isWeb,
                  showAddButton: true,
                  showNotification: true,
                  showProfile: true,
                  onAddPressed: (){
                    context.push('/addDropOff', extra: {"hideMobileAppBar": true});
                  },
                ),
              ),

              // MAIN Content
              Padding(
                padding: EdgeInsets.symmetric(horizontal: AppSizes.horizontalPadding(context)),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(TextString.DropOfftandCTitle, style:TTextTheme.h6Style(context)),
                      const SizedBox(height: 4),
                      Text(TextString.tandCSubtitle2,
                          style: TTextTheme.titleThree(context)),

                      const SizedBox(height: 24),

                      // TOOLBAR
                      GetBuilder<DropOffController>(
                          builder: (controller) {
                            return Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: AppColors.tertiaryTextColor.withOpacity(0.7)),
                              ),
                              child: Wrap(
                                spacing: 12,
                                runSpacing: 10,
                                crossAxisAlignment: WrapCrossAlignment.center,
                                children: [
                                  _buildSelectableTextBtn("H1", quill.Attribute.h1, controller,context),
                                  _buildSelectableTextBtn("H2", quill.Attribute.h2, controller,context),
                                  _buildSelectableTextBtn("H3", quill.Attribute.h3, controller,context),
                                  const SizedBox(height: 20, child: VerticalDivider(thickness: 1)),

                                  _buildSizeDropdown(controller,context),

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

                      // EDITOR AREA
                      _buildEditorArea(controller,context),

                      const SizedBox(height: 24),

                      // SAVE BUTTON
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
  // Texts Btn
  Widget _buildSelectableTextBtn(
      String label,
      quill.Attribute attr,
      DropOffController controller,
      BuildContext context
      ) {
    return GetBuilder<DropOffController>(
      builder: (controller) {
        bool isActive = controller.isStyleActive(attr);

        return InkWell(
          onTap: () => controller.toggleStyle(attr),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: isActive ? AppColors.toolBackground : Colors.transparent,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              label,
              style: TTextTheme.AdditionalText(context)
            ),
          ),
        );
      },
    );
  }

  // Icon Btn
  Widget _buildSelectableIconBtn(IconData icon, quill.Attribute attr, DropOffController controller) {
    bool isActive = controller.isStyleActive(attr);
    return InkWell(
      onTap: () => controller.toggleStyle(attr),
      child: Container(
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: isActive ? AppColors.toolBackground : Colors.transparent,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Icon(icon, size: 20, color: isActive ? AppColors.blackColor : AppColors.textColor),
      ),
    );
  }

  // DropDown
  Widget _buildSizeDropdown(DropOffController controller, BuildContext context) {
    return Obx(() {
      bool isOpen = controller.isSizeOpen.value;

      return PopupMenuButton<String>(
        elevation: 4,
        offset: const Offset(0, 40),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        color: AppColors.toolBackground,
        onOpened: () => controller.isSizeOpen.value = true,
        onCanceled: () => controller.isSizeOpen.value = false,
        onSelected: (String val) {
          controller.changeFontSize(val);
          controller.isSizeOpen.value = false;
        },

        itemBuilder: (BuildContext context) {
          return ['12', '14', '16', '18', '20', '24'].map((String s) {
            return PopupMenuItem<String>(
              value: s,
              height: 35,
              padding: EdgeInsets.zero,
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Text(s, style: TTextTheme.stepsText(context)),
              ),
            );
          }).toList();
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            color: AppColors.toolBackground,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                controller.selectedSize.value.isEmpty ? "Size" : controller.selectedSize.value,
                style: TTextTheme.stepsText(context),
              ),
              const SizedBox(width: 4),
              Icon(
                  isOpen ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                  size: 18,
                  color: AppColors.tertiaryTextColor
              ),
            ],
          ),
        ),
      );
    });
  }

  // Editable Area
  Widget _buildEditorArea(DropOffController controller, BuildContext context) {
    return Container(
      height: 350,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.tertiaryTextColor.withOpacity(0.7)),
      ),
      child: Stack(
        children: [
          Obx(() {
            double currentSize = double.tryParse(controller.selectedSize.value) ?? 16.0;

            return Theme(
              data: Theme.of(context).copyWith(
                textSelectionTheme: TextSelectionThemeData(
                  cursorColor: AppColors.blackColor,
                  selectionColor: AppColors.secondTextColor.withOpacity(0.3),
                  selectionHandleColor: AppColors.blackColor,
                ),
              ),
              child: quill.QuillEditor.basic(
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
                        color: AppColors.blackColor,
                      ),
                      const quill.HorizontalSpacing(0, 0),
                      const quill.VerticalSpacing(0, 0),
                      const quill.VerticalSpacing(0, 0),
                      null,
                    ),
                  ),
                ),
              ),
            );
          }),

          GetBuilder<DropOffController>(
            builder: (controller) {
              if (controller.termsController.document.isEmpty() ||
                  controller.termsController.document.toPlainText().trim().isEmpty) {
                return Positioned(
                  top: 10,
                  left: 10,
                  child: IgnorePointer(
                    child: Text(
                      "Write here...",
                      style: TTextTheme.CalendarSubtitle(context),
                    ),
                  ),
                );
              }
              return const SizedBox();
            },
          ),

          Positioned(
            bottom: 0,
            right: 0,
            child: Text(
              "Max(2000 words)",
              style: TTextTheme.hirerSelected(context),
            ),
          ),
        ],
      ),
    );
  }

  // Notification
  void _showActivatedNotification(BuildContext context, DropOffController controller) {
    OverlayState? overlayState = Overlay.of(context);
    late OverlayEntry overlayEntry;

    double screenWidth = MediaQuery.of(context).size.width;

    double popupWidth = screenWidth < 390 ? screenWidth - 80 : 320;

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
                          TextString.tandCVersiontitle ,
                          style: TTextTheme.titleSmallRegister(context).copyWith(
                            fontSize: screenWidth < 300 ? 12 : 14,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 2),
                        Text(
                          TextString.tandCVersion2,
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