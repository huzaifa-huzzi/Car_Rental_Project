import 'dart:io';
import 'package:car_rental_project/Portal/Vendor/Payment/ReusableWidget/PrimaryBtnOfPayment.dart';
import 'package:car_rental_project/Portal/Vendor/Payment/paymentController.dart';
import 'package:car_rental_project/Resources/AppSizes.dart';
import 'package:car_rental_project/Resources/Colors.dart';
import 'package:car_rental_project/Resources/IconStrings.dart';
import 'package:car_rental_project/Resources/TextString.dart' show TextString;
import 'package:car_rental_project/Resources/TextTheme.dart';
import 'package:country_picker/country_picker.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddPaymentWidget extends StatelessWidget {
  AddPaymentWidget({super.key});


  final controller = Get.put(PaymentController());

  final LayerLink _dueLink = LayerLink();
  final LayerLink _fromLink = LayerLink();
  final LayerLink _toLink = LayerLink();

  @override
  Widget build(BuildContext context) {
    final bool isMobile = AppSizes.isMobile(context);
    final bool showSideBySide = AppSizes.isWeb(context);

    return Column(
      children: [
        _buildCard(
          title: TextString.titlePaymentAdd,context,
          subtitle: TextString.titlePaymentAddSubtitle,
          child: Column(
            children: [
              _buildResponsiveRow(isMobile, [
                _buildField(context, TextString.field1,TextString.field1Subtitle , controller.invoiceIdController, "invoice"),
                _buildField(context, TextString.field2, TextString.field2Subtitle , controller.customerNameController, "customer"),
                _buildPhoneField(context, "Phone Number"),
              ]),
              const SizedBox(height: 20),
              _buildResponsiveRow(isMobile, [
                _buildPaymentAmountField(
                    context,
                    TextString.field4,
                    controller.paymentAmountController,
                    "amount"
                ),
                _buildDateField(context, TextString.field5,TextString.field5Subtitle  , controller.dueDateController, _dueLink,),
                if (!isMobile) const SizedBox(),
              ]),
            ],
          ),
        ),

        const SizedBox(height: 24),

        showSideBySide
            ? Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: _buildCarDetail(context, isMobile)),
            const SizedBox(width: 24),
            Expanded(child: _buildRentalPeriod(context, isMobile)),
          ],
        )
            : Column(
          children: [
            _buildCarDetail(context, isMobile),
            const SizedBox(height: 24),
            _buildRentalPeriod(context, isMobile),
          ],
        ),

        const SizedBox(height: 24),
        _buildCard(
          title: TextString.fieldUpload,context,
          subtitle: TextString.fieldUploadSubtitle,
          child: Obx(() {
            return controller.selectedImage2.value != null
                ? _buildSelectedImagePreview(context)
                : _buildUploadBox(context);
          }),
        ),
        const SizedBox(height: 32),

        Align(
          alignment: Alignment.centerRight,
          child: PrimaryBtnOfPayment(
            text: "Mark as Complete",
            onTap: () {
              showCompletionDialog(context);
            },
            borderRadius: BorderRadius.circular(8),
            width: 180,
          ),
        ),

        const SizedBox(height: 32),
        _buildOtherPaymentsTable(context),
        const SizedBox(height: 22),
      ],
    );
  }


 /// ---------- Extra Widget --------- ///

     // Field
  Widget _buildField(BuildContext context, String label, String hint, TextEditingController ctr, String id) {
    final Map<String, FocusNode> focusNodes = {};
    focusNodes[id] ??= FocusNode();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TTextTheme.bodyRegular14(context)),
        const SizedBox(height: 8),
        ListenableBuilder(
          listenable: focusNodes[id]!,
          builder: (context, child) {
            bool hasFocus = focusNodes[id]!.hasFocus;
            return Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                boxShadow: hasFocus ? [
                  BoxShadow(
                    color: AppColors.fieldsBackground.withOpacity(0.06),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ] : [],
              ),
              child: TextField(
                cursorColor: AppColors.blackColor,
                controller: ctr,
                focusNode: focusNodes[id],
                style: TTextTheme.titleinputTextField(context),
                decoration: InputDecoration(
                  hintText: hint,
                  hintStyle: TTextTheme.bodyRegular16(context),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  filled: true,
                  fillColor: Colors.white,
                  hoverColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide:  BorderSide(color: AppColors.toolBackground),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: AppColors.toolBackground),
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }

//  Date Field
  Widget _buildDateField(
      BuildContext context,
      String label,
      String hint,
      TextEditingController ctr,
      LayerLink link,
      ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TTextTheme.bodyRegular14(context)),
        const SizedBox(height: 8),
        CompositedTransformTarget(
          link: link,
          child: TextField(
            cursorColor: AppColors.blackColor,
            controller: ctr,
            readOnly: true,
            onTap: () => controller.toggleCalendar2(
                context,
                link,
                ctr,
                320,
            ),
            style: TTextTheme.titleinputTextField(context),
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: TTextTheme.bodyRegular16(context),
              suffixIcon: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Image.asset(
                    IconString.calendarIcon,
                    width: 18,
                    color: AppColors.quadrantalTextColor
                ),
              ),
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              filled: true,
              fillColor: Colors.white,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: AppColors.toolBackground),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: AppColors.toolBackground),
              ),
            ),
          ),
        ),
      ],
    );
  }

  //  Car Detail Section
  Widget _buildCarDetail(BuildContext context, bool isMobile) {
    return _buildCard(
      context,
      title: TextString.carDetailTitlepayment,
      subtitle: TextString.carDetailTitleSubtitle,
      child: Obx(() {
        if (!controller.isCarSelected.value) {
          return _buildPickupPlaceholder(context);
        }
        return Column(
          children: [
            _buildResponsiveRow(isMobile, [
              _buildField(context, TextString.carField1, TextString.carField1Subtitle, controller.carNameController, "carName"),
              _buildCustomDropdown(context, TextString.carField4, ["Sedan", "SUV", "Hatchback"], controller.selectedCarType, id: "carType"),
            ]),
            const SizedBox(height: 15),
            _buildResponsiveRow(isMobile, [
              _buildField(context, TextString.carField2, TextString.carField2Subtitle, controller.registrationController, "registration"),
              _buildCustomDropdown(context, TextString.carField3, ["Manual", "Automatic"], controller.selectedTransmission, id: "transmission"),
            ]),
          ],
        );
      }),
    );
  }
  Widget _buildPickupPlaceholder(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.quadrantalTextColor.withOpacity(0.7)),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
               Image.asset(IconString.returnCarIcon, color: AppColors.primaryColor, width: 20,height: 20,),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(TextString.paymentPickupTitle, style: TTextTheme.PickupPayment(context)),
                  Text(TextString.paymentPickupSubtitle, style: TTextTheme.bodyRegular12Gay10(context)),
                ],
              ),
            ],
          ),
          const SizedBox(height: 25),
          PrimaryBtnOfPayment(
            text: "Select The pickup",
            height: 48,
            width: double.infinity,
            onTap: () {
              controller.isCarSelected.value = true;
            },
            icon: Image.asset(IconString.pickCarIconArrow, color: Colors.white, width: 18,height: 18,),
            isIconLeft: true,
            borderRadius: BorderRadius.circular(10),
          ),
        ],
      ),
    );
  }

  //  Rental Period Section
  Widget _buildRentalPeriod(BuildContext context, bool isMobile) {
    return _buildCard(
      context,
      title: TextString.RentDetailTitlepayment,
      subtitle: TextString.RentDetailTitleSubtitle,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildDateField(
              context,
              TextString.rentField1,
              TextString.rentField1subtitle,
              controller.fromDateController,
              _fromLink
          ),

          const SizedBox(height: 15),
          _buildDateField(
              context,
              TextString.rentField2,
              TextString.rentField2subtitle,
              controller.toDateController,
              _toLink
          ),

          const SizedBox(height: 15),
          _buildField(
              context,
              TextString.rentField3,
              TextString.rentField3subtitle,
              controller.durationController,
              "duration"
          ),
        ],
      ),
    );
  }

  //  Reusable Responsive Row
  Widget _buildResponsiveRow(bool isMobile, List<Widget> children) {
    if (isMobile) {
      return Column(
        children: children.map((w) => Padding(
          padding: const EdgeInsets.only(bottom: 15),
          child: w,
        )).toList(),
      );
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: children.asMap().entries.map((entry) {
        int index = entry.key;
        Widget w = entry.value;

        return Expanded(
          child: Padding(
            padding: EdgeInsets.only(
              right: index == children.length - 1 ? 0 : 20,
            ),
            child: w,
          ),
        );
      }).toList(),
    );
  }

  //  Dropdown
  Widget _buildCustomDropdown(BuildContext context, String label, List<String> items, RxString selected, {required String id}) {
    return Obx(() {
      bool isOpen = controller.openedDropdown2.value == id;
      String errorMsg = controller.dropdownErrors[id] ?? "";
      bool hasError = errorMsg.isNotEmpty;

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: TTextTheme.titleTwo(context)),
          const SizedBox(height: 6),
          LayoutBuilder(builder: (context, constraints) {
            return PopupMenuButton<String>(
              constraints: BoxConstraints(
                minWidth: constraints.maxWidth,
                maxWidth: constraints.maxWidth,
                maxHeight: 400,
              ),
              offset: const Offset(0, 48),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              color: Colors.white,
              onOpened: () => controller.openedDropdown2.value = id,
              onCanceled: () => controller.openedDropdown2.value = "",
              onSelected: (val) {
                selected.value = val;
                if (controller.dropdownErrors.containsKey(id)) {
                  controller.dropdownErrors[id] = "";
                }
                controller.openedDropdown2.value = "";
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                height: 48,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: hasError ? AppColors.primaryColor : AppColors.toolBackground,
                    width: 1.2,
                  ),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        selected.value.isEmpty ? "Select $label..." : selected.value,
                        style: TTextTheme.pOne(context).copyWith(
                          color: selected.value.isEmpty ? Colors.grey : Colors.black,
                        ),
                      ),
                    ),
                    Image.asset(
                      isOpen ? IconString.upsideDropdownIcon : IconString.dropdownIcon,
                      height: 18,
                    ),
                  ],
                ),
              ),
              itemBuilder: (context) {
                return items.map((item) {
                  bool isSelected = selected.value == item;
                  return PopupMenuItem<String>(
                    value: item,
                    child: Row(
                      children: [
                        Container(
                          width: 22,
                          height: 22,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: isSelected ? AppColors.primaryColor : Colors.transparent,
                            border: Border.all(
                              color: AppColors.primaryColor,
                              width: 2,
                            ),
                          ),
                          child: isSelected
                              ? const Center(
                            child: Icon(Icons.done, color: Colors.white, size: 14),
                          )
                              : null,
                        ),
                        const SizedBox(width: 12),
                        Text(item, style: TTextTheme.medium14(context)),
                      ],
                    ),
                  );
                }).toList();
              },
            );
          }),
          if (hasError)
            Padding(
              padding: const EdgeInsets.only(top: 6, left: 4),
              child: Text(
                errorMsg,
                style: TTextTheme.ErrorStyle(context),
              ),
            ),
        ],
      );
    });
  }

  //  Card Helper
  Widget _buildCard(BuildContext context,{required String title, required String subtitle, required Widget child}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(color: AppColors.fieldsBackground.withOpacity(0.02), blurRadius: 15, offset: const Offset(0, 5))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: TTextTheme.h2Style(context)),
          Text(subtitle, style: TTextTheme.bodyRegular16(context)),
          const SizedBox(height: 24),
          child,
        ],
      ),
    );
  }

  // Image Fetching
  Widget _buildSelectedImagePreview(BuildContext context) {
    final image = controller.selectedImage2.value;
    if (image == null) return const SizedBox.shrink();
    final bool isSmallScreen = MediaQuery.of(context).size.width < 400;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.backgroundOfPickupsWidget,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Center(
        child: IntrinsicWidth(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: 350,
                child: Stack(
                  children: [
                    Container(
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(12),
                          topRight: Radius.circular(12),
                        ),
                      ),
                      child: ClipRRect(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(12),
                          topRight: Radius.circular(12),
                        ),
                        child: (kIsWeb || image.bytes != null)
                            ? Image.memory(image.bytes!, fit: BoxFit.contain)
                            : Image.file(File(image.path!), fit: BoxFit.contain),
                      ),
                    ),
                    Positioned.fill(
                      child: MouseRegion(
                        onEnter: (_) => controller.setHover2(true),
                        onExit: (_) => controller.setHover2(false),
                        child: InkWell(
                          onTap: () => _showImagePopup(context),
                          child: Obx(() => AnimatedOpacity(
                            duration: const Duration(milliseconds: 200),
                            opacity: controller.isImageHovered2.value ? 1.0 : 0.0,
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.5),
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(12),
                                  topRight: Radius.circular(12),
                                ),
                              ),
                              child: const Center(
                                child: Icon(
                                  Icons.zoom_in,
                                  color: Colors.white,
                                  size: 60,
                                ),
                              ),
                            ),
                          )),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: AppColors.backgroundOfScreenColor),
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(12),
                    bottomRight: Radius.circular(12),
                  ),
                ),
                child: isSmallScreen
                    ? Column(
                  children: [
                    Row(
                      children: [
                        Image.asset(IconString.receiptIcon, height: 20),
                        const SizedBox(width: 8),
                        Expanded(child: Text(image.name ?? "Receipt.png", style: TTextTheme.bodyRegular12black(context), overflow: TextOverflow.ellipsis)),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Align(
                      alignment: Alignment.centerRight,
                      child: GestureDetector(
                        onTap: () => controller.clearSelection2(),
                        child: Text("cancel", style: TTextTheme.bodyRegular12Primary(context)),
                      ),
                    ),
                  ],
                )
                    : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Image.asset(IconString.receiptIcon),
                        const SizedBox(width: 8),
                        Text(image.name ?? "Receipt.png", style: TTextTheme.bodyRegular12black(context)),
                      ],
                    ),
                    GestureDetector(
                      onTap: () => controller.clearSelection2(),
                      child: Text("cancel", style: TTextTheme.bodyRegular12Primary(context)),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  void _showImagePopup(BuildContext context) {
    final image = controller.selectedImage2.value;
    if (image == null) return;

    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        elevation: 0,
        insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            /// Close Button
            Padding(
              padding: const EdgeInsets.only(bottom: 15),
              child: GestureDetector(
                onTap: () => Navigator.of(context).pop(),
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration:  BoxDecoration(
                    color: AppColors.sideBoxesColor,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(color: AppColors.fieldsBackground.withOpacity(0.7), blurRadius: 10, spreadRadius: 1)
                    ],
                  ),
                  child: const Icon(
                    Icons.close,
                    color: Colors.black,
                    size: 28,
                  ),
                ),
              ),
            ),
            Flexible(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: InteractiveViewer(
                    panEnabled: true,
                    minScale: 0.5,
                    maxScale: 4.0,
                    child: kIsWeb
                        ? Image.memory(
                      image.bytes!,
                      fit: BoxFit.contain,
                      width: double.infinity,
                    )
                        : Image.file(
                      File(image.path!),
                      fit: BoxFit.contain,
                      width: double.infinity,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  Widget _buildUploadBox(BuildContext context) {
    return GestureDetector(
      onTap: () => controller.pickPaymentReceipt2(),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 40),
        decoration: BoxDecoration(
          color: AppColors.backgroundOfPickupsWidget,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Image.asset(IconString.invoicesIcon, color:AppColors.primaryColor,),
            const SizedBox(height: 12),
            Text(
                TextString.uploadPaymentReceipt,
                style: TTextTheme.h1Style(context)
            ),

            const SizedBox(height: 4),
            RichText(
              text:  TextSpan(
                style: TTextTheme.bodyRegular16secondary(context),
                children: [
                  TextSpan(text: TextString.paymentJpeg),
                  TextSpan(text: TextString.under10, style: TTextTheme.bodyRegular16Primary(context)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Tables
  Widget _buildOtherPaymentsTable(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            text: TextSpan(
              style: TTextTheme.h2Style(context),
              children: [
                 TextSpan(text:  TextString.otherPayment),
                TextSpan(text: TextString.adamJhones, style: TTextTheme.h2PrimaryStyle(context)),
              ],
            ),
          ),
           Text(TextString.listOfPayment, style: TTextTheme.bodyRegular16(context) ),
          const SizedBox(height: 20),

          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 1190,
                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  decoration: BoxDecoration(
                    color: AppColors.secondaryColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      _cell(width: 180, child: _headerCell(TextString.header1payment, controller,context)),
                      _cell(width: 160, child: _headerCell(TextString.header7payment, controller,context)),
                      _cell(width: 230, child: _headerCell(TextString.header2payment, controller,context)),
                      _cell(width: 190, child: _headerCell(TextString.header3payment, controller,context)),
                      _cell(width: 110, child: _headerCell(TextString.header4payment, controller,context)),
                      _cell(width: 130, child: _headerCell(TextString.header5payment, controller,context, isCenter: true, canSort: false)),
                      _cell(width: 130, child: _headerCell(TextString.header6payment, controller,context, isCenter: true, canSort: false)),
                    ],
                  ),
                ),

                Obx(() => Column(
                  children: controller.otherPaymentsList.map((data) {
                    return SizedBox(
                        width: 1190,
                        child: _buildSimplePaymentRow(data, context)
                    );
                  }).toList(),
                )),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _headerCell(
      String title,
      PaymentController controller,
      BuildContext context, {
        bool isCenter = false,
        bool canSort = true,
      }) {
    return InkWell(
      onTap: canSort ? () => controller.toggleSort2(title) : null,
      borderRadius: BorderRadius.circular(4),
      child: Row(
        mainAxisAlignment: isCenter ? MainAxisAlignment.center : MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Flexible(
            child: Text(
              title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TTextTheme.medium14tableHeading(context),
            ),
          ),

          if (canSort) ...[
            const SizedBox(width: 4),
            Obx(() {
              bool isCurrent = controller.sortColumn2.value == title;
              int order = isCurrent ? controller.sortOrder2.value : 0;

              return Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.keyboard_arrow_up_rounded,
                      size: 14,
                      color: order == 1 ? AppColors.primaryColor : AppColors.quadrantalTextColor,
                    ),
                    Transform.translate(
                      offset: const Offset(0, -9),
                      child: Icon(
                        Icons.keyboard_arrow_down_rounded,
                        size: 14,
                        color: order == 2 ? AppColors.primaryColor : AppColors.quadrantalTextColor,
                      ),
                    ),
                  ],
                ),
              );
            }),
          ],
        ],
      ),
    );
  }
  Widget _buildSimplePaymentRow(Map data, BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: BoxDecoration(
        color: AppColors.backgroundOfTableContainer,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.sideBoxesColor.withOpacity(0.7), width: 1),
      ),
      child: Row(
        children: [
          _cell(width: 180, child: Text(data["id"] ?? "", style: TTextTheme.bodySemiBold14black(context), overflow: TextOverflow.ellipsis)),
          _cell(width: 160, child: Text(data["customerName"] ?? "", style: TTextTheme.bodySemiBold14black(context), overflow: TextOverflow.ellipsis)),
          _cell(width: 230, child: Text(data["duration"] ?? "", style: TTextTheme.tableRegular14black(context))),
          _cell(width: 190, child: Text(data["car"] ?? "", style: TTextTheme.tableRegular14black(context), overflow: TextOverflow.ellipsis)),
          _cell(width: 110, child: Text("\$${data["amount"]}",
              style: TTextTheme.hPickupStyle(context))),
          _cell(width: 130, child: Center(
            child: Container(
              constraints: const BoxConstraints(minWidth: 70),
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
              decoration: BoxDecoration(
                color: AppColors.pendingColor,
                borderRadius: BorderRadius.circular(20),
              ),
              child:  Text(TextString.pending, style: TTextTheme.hPending(context)),
            ),
          )),
          _cell(width: 130, child: Center(
            child: SizedBox(
              height: 32,
              width: 100,
              child: OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppColors.primaryColor,
                  side: BorderSide(color: AppColors.primaryColor),
                  padding: EdgeInsets.zero,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.visibility_outlined, size: 14),
                    const SizedBox(width: 4),
                     Text("View", style: TTextTheme.tableRegular14Primary(context)),
                  ],
                ),
              ),
            ),
          )),
        ],
      ),
    );
  }
  Widget _cell({required double width, required Widget child}) {
    return SizedBox(width: width, child: child);
  }

  Widget _buildPhoneField(BuildContext context, String label) {
    final List<Country> countryList = CountryService().getAll();
    final FocusNode phoneFocusNode = FocusNode();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TTextTheme.bodyRegular14(context)),
        const SizedBox(height: 8),

        ListenableBuilder(
          listenable: phoneFocusNode,
          builder: (context, child) {
            bool hasFocus = phoneFocusNode.hasFocus;

            return Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                boxShadow: hasFocus ? [
                  BoxShadow(
                    color: AppColors.fieldsBackground.withOpacity(0.06),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ] : [],
              ),
              child: TextFormField(
                controller: controller.phoneController,
                focusNode: phoneFocusNode,
                keyboardType: TextInputType.phone,
                style: TTextTheme.titleinputTextField(context),
                cursorColor: AppColors.blackColor,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  hintText: "Enter number",
                  hintStyle: TTextTheme.bodyRegular16(context),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: AppColors.toolBackground),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: AppColors.toolBackground),
                  ),
                  prefixIcon: Padding(
                    padding: const EdgeInsets.only(left: 4),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        DropdownButtonHideUnderline(
                          child: Obx(() => DropdownButton2<Country>(
                            isExpanded: false,
                            value: countryList.firstWhere(
                                  (c) => c.name == controller.selectedCountryName.value,
                              orElse: () => countryList.firstWhere((c) => c.name == "Australia"),
                            ),
                            selectedItemBuilder: (context) {
                              return countryList.map((Country country) {
                                return Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const SizedBox(width: 8),
                                    _buildCircleFlag(country.countryCode),
                                    const SizedBox(width: 10),
                                    Text("+${country.phoneCode}",
                                        style: TTextTheme.bodyRegular14(context)
                                            .copyWith(color: AppColors.blackColor)),
                                  ],
                                );
                              }).toList();
                            },
                            items: countryList.map((Country country) {
                              return DropdownMenuItem<Country>(
                                value: country,
                                child: Row(
                                  children: [
                                    _buildCircleFlag(country.countryCode),
                                    const SizedBox(width: 10),
                                    Expanded(
                                      child: Text(country.name,
                                          style: const TextStyle(fontSize: 13),
                                          overflow: TextOverflow.ellipsis),
                                    ),
                                    Text("+${country.phoneCode}",
                                        style: TTextTheme.titleinputTextField(context)),
                                  ],
                                ),
                              );
                            }).toList(),
                            onChanged: (Country? value) {
                              if (value != null) {
                                controller.selectedCountryName.value = value.name;
                                controller.selectedCode.value = "+${value.phoneCode}";
                              }
                            },
                            buttonStyleData: const ButtonStyleData(
                              height: 48,
                              padding: EdgeInsets.symmetric(horizontal: 4),
                            ),
                            iconStyleData: const IconStyleData(
                              icon: Icon(Icons.keyboard_arrow_down_rounded,
                                  size: 20, color: Colors.black54),
                            ),
                            dropdownStyleData: DropdownStyleData(
                              maxHeight: 350,
                              width: 250,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: Colors.white),
                              offset: const Offset(0, -5),
                            ),
                            dropdownSearchData: DropdownSearchData(
                              searchController: controller.searchController,
                              searchInnerWidgetHeight: 50,
                              searchInnerWidget: _buildSearchField(
                                  context, controller.searchController),
                              searchMatchFn: (item, searchValue) {
                                return item.value!.name
                                    .toLowerCase()
                                    .contains(searchValue.toLowerCase()) ||
                                    item.value!.phoneCode.contains(searchValue);
                              },
                            ),
                          )),
                        ),
                        Container(
                          height: 24,
                          width: 1,
                          color: AppColors.toolBackground.withOpacity(0.5),
                          margin: const EdgeInsets.symmetric(horizontal: 8),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
  Widget _buildSearchField(BuildContext context, TextEditingController searchController) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: TextFormField(
        cursorColor: AppColors.blackColor,
        controller: searchController,
        style: TTextTheme.textFieldWrittenText(context),
        decoration: InputDecoration(
          isDense: true,
          fillColor: AppColors.backgroundOfScreenColor,
          filled: true,
          hintText: 'Search',
          hintStyle: TTextTheme.titleTwo(context),
          prefixIcon: const Icon(Icons.search, size: 18, color: AppColors.primaryColor),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(color: AppColors.primaryColor),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(color: AppColors.primaryColor),
          ),
        ),
      ),
    );
  }
  Widget _buildCircleFlag(String code) {
    return Container(
      width: 24,
      height: 24,
      decoration: const BoxDecoration(shape: BoxShape.circle),
      child: ClipOval(
        child: Image.network(
          'https://flagcdn.com/w80/${code.toLowerCase()}.png',
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) => const Icon(Icons.flag, size: 14),
        ),
      ),
    );
  }




  Widget _buildPaymentAmountField(BuildContext context, String label, TextEditingController ctr, String id) {
    final Map<String, FocusNode> focusNodes = {};
    focusNodes[id] ??= FocusNode();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TTextTheme.bodyRegular14(context)),
        const SizedBox(height: 8),
        ListenableBuilder(
          listenable: focusNodes[id]!.hasFocus ? focusNodes[id]! : focusNodes[id]!,
          builder: (context, child) {
            bool hasFocus = focusNodes[id]!.hasFocus;

            return Container(
              height: 48,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: AppColors.toolBackground),
                boxShadow: hasFocus ? [
                  BoxShadow(
                    color: AppColors.fieldsBackground.withOpacity(0.06),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ] : [],
              ),
              child: Row(
                children: [
                  Obx(() {
                    bool isOpen = controller.openedDropdownPayment.value == id;

                    return PopupMenuButton<Country>(
                      constraints: const BoxConstraints(
                        minWidth: 280,
                        maxWidth: 300,
                        maxHeight: 400,
                      ),
                      offset: const Offset(0, 44),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      color: Colors.white,
                      onOpened: () {
                        controller.openedDropdownPayment.value = id;
                      },
                      onCanceled: () {
                        controller.openedDropdownPayment.value = "";
                        controller.searchCountryText.value = "";
                      },
                      onSelected: (Country country) {
                        controller.updateCountryAndCurrency(country);
                        controller.openedDropdownPayment.value = "";
                        controller.searchCountryText.value = "";
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        height: double.infinity,
                        color: Colors.transparent,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              controller.selectedCountryFlag.value,
                              style: const TextStyle(fontSize: 20),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              controller.selectedCountryCode.value,
                              style: TTextTheme.titleinputTextField(context).copyWith(
                                color: AppColors.quadrantalTextColor,
                              ),
                            ),
                            const SizedBox(width: 4),
                            Icon(
                              isOpen ? Icons.keyboard_arrow_up_rounded : Icons.keyboard_arrow_down_rounded,
                              size: 18,
                              color: AppColors.quadrantalTextColor,
                            ),
                          ],
                        ),
                      ),
                      itemBuilder: (context) {
                        return [
                          PopupMenuItem<Country>(
                            enabled: false,
                            value: null,
                            child: StatefulBuilder(
                              builder: (context, menuState) {
                                return Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Container(
                                      height: 40,
                                      margin: const EdgeInsets.symmetric(vertical: 4),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        border: Border.all(color: AppColors.primaryColor),
                                      ),
                                      child: TextField(
                                        cursorColor: AppColors.blackColor,
                                        autofocus: true,
                                        style: TTextTheme.titleinputTextField(context),
                                        onChanged: (val) {
                                          controller.searchCountryText.value = val;
                                          menuState(() {});
                                        },
                                        decoration: InputDecoration(
                                          hintText: "Search country...",
                                          hintStyle: TTextTheme.bodyRegular14Search(context),
                                          prefixIcon: Icon(Icons.search, color: AppColors.primaryColor, size: 18),
                                          filled: true,
                                          fillColor: AppColors.backgroundOfScreenColor,
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(20),
                                            borderSide: BorderSide.none,
                                          ),
                                          contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                                        ),
                                      ),
                                    ),
                                    const Divider(),
                                    Container(
                                      constraints: const BoxConstraints(maxHeight: 250),
                                      width: 260,
                                      child: SingleChildScrollView(
                                        child: Column(
                                          children: controller.getFilteredCountries().map((country) {
                                            bool isSelected = controller.selectedCountryCode.value == country.countryCode.toUpperCase();

                                            return InkWell(
                                              onTap: () {
                                                Navigator.of(context).pop(country);
                                              },
                                              child: Padding(
                                                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 4),
                                                child: Row(
                                                  children: [
                                                    Container(
                                                      width: 22,
                                                      height: 22,
                                                      decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        color: isSelected ? AppColors.primaryColor : Colors.transparent,
                                                        border: Border.all(color: AppColors.primaryColor, width: 2),
                                                      ),
                                                      child: isSelected
                                                          ? const Center(child: Icon(Icons.done, color: Colors.white, size: 14))
                                                          : null,
                                                    ),
                                                    const SizedBox(width: 12),
                                                    Text(country.flagEmoji, style: const TextStyle(fontSize: 14)),
                                                    const SizedBox(width: 8),
                                                    Expanded(
                                                      child: Text(
                                                        "${country.name} (${country.countryCode.toUpperCase()})",
                                                        style: TTextTheme.medium14(context),
                                                        overflow: TextOverflow.ellipsis,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            );
                                          }).toList(),
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                          ),
                        ];
                      },
                    );
                  }),
                  Container(
                    width: 1,
                    height: 28,
                    color: AppColors.toolBackground,
                  ),
                  Expanded(
                    child: Obx(() {
                      return TextField(
                        controller: ctr,
                        focusNode: focusNodes[id],
                        keyboardType: const TextInputType.numberWithOptions(decimal: true),
                        cursorColor: AppColors.blackColor,
                        style: TTextTheme.titleinputTextField(context),
                        decoration: InputDecoration(
                          prefixIcon: Padding(
                            padding: const EdgeInsets.only(left: 14, top: 13),
                            child: Text(
                              controller.selectedCurrencySymbol.value,
                              style: TTextTheme.titleinputTextField(context).copyWith(
                                color: AppColors.quadrantalTextColor,
                              ),
                            ),
                          ),
                          hintText: "0.0",
                          hintStyle: TTextTheme.bodyRegular16(context).copyWith(color: Colors.grey.withOpacity(0.5)),
                          contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                          filled: true,
                          fillColor: Colors.transparent,
                          border: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                        ),
                      );
                    }),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }


   // Dialog 1
  void showCompletionDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        double screenWidth = MediaQuery.of(context).size.width;
        bool shouldStackButtons = screenWidth < 380;

        return Dialog(
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.white,
          insetPadding: const EdgeInsets.symmetric(horizontal: 20),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Container(
            width: 450,
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: AppColors.emojiBackground,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Text("🤨", style: TextStyle(fontSize: 24)),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                           Text(
                            TextString.paymentAsCompleted,
                            style: TTextTheme.h2Style(context)
                          ),
                          const SizedBox(height: 6),
                          Text(
                       TextString.paymentAsCompletedSubtitle,
                            style:TTextTheme.bodyRegular16(context)
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: AppColors.sideBoxesColor,
                          shape: BoxShape.circle,
                        ),
                        child:  Icon(Icons.close, size: 16, color: AppColors.blackColor),
                      ),
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                    ),
                  ],
                ),
                const SizedBox(height: 32),
                shouldStackButtons
                    ? Column(
                  children: [
                    _buildButton(context, "Save", isOutlined: true, isFullWidth: true),
                    const SizedBox(height: 12),
                    _buildButton(context, "Cancel", isOutlined: false, isFullWidth: true),
                  ],
                )
                    : Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    _buildButton(context, "Save", isOutlined: true, isFullWidth: false),
                    const SizedBox(width: 12),
                    _buildButton(context, "Cancel", isOutlined: false, isFullWidth: false),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
  Widget _buildButton(BuildContext context, String text, {required bool isOutlined, required bool isFullWidth}) {
    return SizedBox(
      width: isFullWidth ? double.infinity : 110,
      height: 48,
      child: isOutlined
          ? OutlinedButton(
        onPressed: (){
          Navigator.pop(context);
          showSuccessDialog(context);
        },
        style: OutlinedButton.styleFrom(
          side: const BorderSide(color: AppColors.primaryColor, width: 1),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
        child: Text(text, style: TTextTheme.resendText(context)),
      )
          : ElevatedButton(
        onPressed: () => Navigator.pop(context),
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryColor,
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
        child: Text(text, style:TTextTheme.btnWhiteColor2(context)),
      ),
    );
  }

   // Dialog 2
  void showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Container(
            width: 450,
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: AppColors.emojiBackground,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Text("👍", style: TextStyle(fontSize: 24)),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                           Text(
                           TextString.markedSuccessFully,
                            style: TTextTheme.h2Style(context)
                          ),
                          const SizedBox(height: 8),
                          Text(
                            TextString.markedSuccessFullySubtitle,
                            style: TTextTheme.bodyRegular16(context),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: AppColors.sideBoxesColor,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.close, size: 16, color: AppColors.blackColor),
                      ),
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
