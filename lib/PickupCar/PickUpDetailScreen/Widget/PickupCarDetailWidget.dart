import 'dart:io';
import 'package:car_rental_project/PickupCar/ReusableWidgetOfPickup/AddButtonOfPickup.dart';
import 'package:car_rental_project/PickupCar/ReusableWidgetOfPickup/AddPickupButton.dart';
import 'package:car_rental_project/PickupCar/ReusableWidgetOfPickup/PickupDeletePopup.dart';
import 'package:car_rental_project/Resources/TextString.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:car_rental_project/PickupCar/PickupCarInventory.dart';
import 'package:car_rental_project/Resources/ImageString.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:car_rental_project/Resources/Colors.dart';
import 'package:car_rental_project/Resources/IconStrings.dart';
import 'package:car_rental_project/Resources/TextTheme.dart';
import 'package:go_router/go_router.dart';

class PickupDetailWidget extends StatelessWidget {
  PickupDetailWidget({super.key});

  final controller = Get.find<PickupCarController>();

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final bool isMobile = screenWidth < 800;

    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(isMobile ? 15 : 30),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ///  PAGE TITLE Section
            _buildPageHeader(context, isMobile),
            const SizedBox(height: 25),

            ///  CUSTOMER NAME SECTION
            _buildSection(context,
                title:TextString.titleViewCustomer,
                icon: IconString.customerNameIcon,
                child: _buildDetailedCustomerCard(context, isMobile)),
            const SizedBox(height: 25),

            ///  CAR DETAILS SECTION
            _buildSection(context,
                title: TextString.titleViewCar,
                icon: IconString.pickupCarIcon,
                child: _buildDetailedCarCard(context, isMobile)),
            const SizedBox(height: 25),

            /// RENT PURPOSE Section
            _buildSection(context,
                title: TextString.titleRentPurpose,
                icon: IconString.rentPurposeIcon,
                child: _toggleStatusTag(context,TextString.subtitleRentPurpose, controller.isPersonalUse)),

            const SizedBox(height: 25),

            ///  PAYMENT METHOD
            _buildSection(context,
                title: TextString.titlePaymentMethod,
                icon: IconString.paymentMethodIcon,
                child: _toggleStatusTag(context, TextString.subtitlePaymentMethod, controller.isManualPayment)),
            const SizedBox(height: 25),

            ///  RENT AMOUNT SECTION
            _buildSection(context,
                title: TextString.titleViewRentAmount,
                icon: IconString.rentMoneyIcon,
                child: _buildInfoGrid(context, [
                  {"label":TextString.subtitleWeeklyRent, "controller": controller.weeklyRentController, "hint": "2600 \$"},
                  {"label": TextString.subtitleDailyRent, "controller": controller.rentDueAmountController, "hint": "2600 \$"},
                ], isMobile)),
            const SizedBox(height: 25),
            ///  Bond Payment Section
            _buildSection(context,
                title:TextString.titleBondPayment,
                icon: IconString.bondPaymentIcon,
                child: _buildInfoGrid(context, [
                  {
                    "label": TextString.subtitleBondAmount,
                    "controller": controller.bondAmountController,
                    "hint": "2600 \$"
                  },
                  {
                    "label": TextString.subtitlePaidBond,
                    "controller": controller.paidBondController,
                    "hint": "600 \$"
                  },
                  {
                    "label": TextString.subtitleLeftBond,
                    "controller": controller.dueBondAmountController,
                    "hint": "2000 \$"
                  },
                ], isMobile)),
            const SizedBox(height: 25),

            ///  Car Report Section
            _buildSection(context,
              title: TextString.titleCarReport,
              icon: IconString.carReportIcon,
              child: _buildInfoGrid(context, [
                {"label": TextString.subtitlePickupOdo, "controller": controller.odoController, "hint": "12457678", "hasIcon": false},
                {"label": TextString.subtitlePickFuelLevel, "controller": controller.fuelLevelController, "hint": "Full (100%)", "hasIcon": true},
                {"label": TextString.subtitleInteriorCleanliness, "controller": controller.interiorCleanlinessController, "hint": "Excellent", "hasIcon": true},
                {"label": TextString.subtitleExteriorCleanliness, "controller": controller.exteriorCleanlinessController, "hint": "Excellent", "hasIcon": true},
              ], isMobile),
            ),
            const SizedBox(height: 25),
            ///  Damage Inspection Section
            _buildSection(context,
                title: TextString.titleDamageInspection,
                icon: IconString.damageInspection,
                child: _buildDamageInspectionCard(context, isMobile)),
            const SizedBox(height: 25),
            /// Pickup Note Section
            _buildSection(
              context,
              title:TextString.titlePickupNote ,
              icon: IconString.pickupNote,
              child: _buildCommentField(
                  context,
                  TextString.subtitlePickupComments,
                  controller.additionalCommentsController,
                  TextString.subtitleViewPickup
              ),
            ),
            const SizedBox(height: 25),
            ///  Car Picture Section
            _buildSection(context,
                title: TextString.titleCarPicture,
                icon: IconString.carPictureIconPickup,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(TextString.subtitleCarPicture,
                        style: TTextTheme.dropdowninsideText(context)),
                    const SizedBox(height: 10),
                    _imageBox(context),
                  ],
                )),
            const SizedBox(height: 25),
            /// Rent Section
            _buildSection(context,
                title: TextString.titleRentTime,
                icon: IconString.rentTimeIcon,
                showBadge: true,
                child: _buildRentTimeSection(context, isMobile)),
            const SizedBox(height: 25),

            ///  SIGNATURE SECTION
            _buildSection(context,
                title: TextString.titleSignature,
                icon: IconString.signatureIcon,
                child: _buildSignatureSection(context, isMobile)),

            const SizedBox(height: 50),
          ],
        ),
      ),
    );
  }

  /// --- Extra Widgets ---

  // Grids of the TextFields
  Widget _buildInfoGrid(BuildContext context, List<Map<String, dynamic>> items, bool isMobile) {
    final double availableWidth = MediaQuery.of(context).size.width;

    return Wrap(
      spacing: 20,
      runSpacing: 15,
      children: items.map((item) {
        double itemWidth = isMobile
            ? (availableWidth - 60)
            : (availableWidth / 4.5);

        return SizedBox(
          width: itemWidth,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(item['label']!,
                  style: TTextTheme.dropdowninsideText(context)),
              const SizedBox(height: 8),
              Container(
                padding: EdgeInsets.all(3),
                decoration: BoxDecoration(
                  color: AppColors.secondaryColor,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: TextFormField(
                  cursorColor: AppColors.blackColor,
                  controller: item['controller'],
                  textAlignVertical: TextAlignVertical.center,
                  style: TTextTheme.insidetextfieldWrittenText(context),
                  decoration: InputDecoration(
                    hintText: item['hint'],
                    prefixIcon: item['hasIcon'] == true
                        ? Padding(
                      padding: const EdgeInsets.only(left: 10, right: 8),
                      child: Icon(Icons.check_circle_outline,
                          size: 18,
                          color: AppColors.textColor),
                    )
                        : null,
                    prefixIconConstraints: const BoxConstraints(
                      minWidth: 40,
                      minHeight: 0,
                    ),
                    hintStyle: TTextTheme.insidetextfieldWrittenText(context),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                    border: InputBorder.none,
                    isDense: true,
                  ),
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  // pickup Note Field
  Widget _buildCommentField(BuildContext context, String label, TextEditingController controller, String hint) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TTextTheme.dropdowninsideText(context)),
        const SizedBox(height: 8),
        Container(
          height: 100,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(color: AppColors.secondaryColor, borderRadius: BorderRadius.circular(8)),
          child: TextFormField(
            cursorColor: AppColors.blackColor,
            controller: controller,
            maxLines: 4,
            decoration: InputDecoration(hintText: hint, border: InputBorder.none, hintStyle: TTextTheme.titleFour(context)),
          ),
        ),
      ],
    );
  }

  // Damage Inspection
  Widget _buildDamageInspectionCard(BuildContext context, bool isMobile) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.quadrantalTextColor),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Wrap(
            spacing: 16,
            runSpacing: 10,
            children: controller.damageTypes.map((type) {
              return Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: type['color'],
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      type['id'].toString(),
                      style: TTextTheme.btnNumbering(context),
                    ),
                  ),
                  const SizedBox(width: 6),
                  Text(
                    type['label'],
                    style: TTextTheme.titleSix(context),
                  ),
                ],
              );
            }).toList(),
          ),
        ),

        const SizedBox(height: 24),
        Align(
          alignment: Alignment.centerLeft,
          child: LayoutBuilder(
            builder: (context, constraints) {
              double width = constraints.maxWidth > 600 ? 600 : constraints.maxWidth;

              return Container(
                width: width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(
                    ImageString.carDamageInspectionImage,
                    width: width,
                    fit: BoxFit.contain,
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }


  // Start Header
  Widget _buildPageHeader(BuildContext context, bool isMobile) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// TITLE SECTION
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                TextString.titleViewPick ,
                style: TTextTheme.h6Style(context),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
              Text(
                TextString.titleViewSubtitle,
                style: TTextTheme.titleThree(context),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ],
          ),
        ),

        const SizedBox(width: 8),

        /// BUTTONS SECTION
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            AddPickUpButton(
              text: isMobile ? "" : "Edit",
              iconPath: IconString.editIcon,
              iconColor: AppColors.secondTextColor,
              width: isMobile ? 38 : 110,
              height: 38,
              textColor: AppColors.secondTextColor,
              borderColor: AppColors.sideBoxesColor,
              onTap: (){
                context.push('/editPickUp', extra: {"hideMobileAppBar": true});
              },
            ),
            const SizedBox(width: 6),
            AddPickUpButton(
              text: isMobile ? "" : "Delete",
              iconPath: IconString.deleteIcon,
              iconColor: AppColors.secondTextColor,
              width: isMobile ? 38 : 110,
              height: 38,
              textColor: AppColors.secondTextColor,
              borderColor: AppColors.sideBoxesColor,
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return ResponsiveDeletePickupDialog(
                      onCancel: () {
                        Navigator.pop(context);
                      },
                      onConfirm: () {
                        Navigator.pop(context);
                      },
                    );
                  },
                );
              },
            ),
          ],
        ),
      ],
    );
  }

  // Rent time Section
  Widget _buildRentTimeSection(BuildContext context, bool isMobile) {
    if (isMobile) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(TextString.subtitleAgreementTime,
              style: TTextTheme.dropdowninsideText(context)),
          const SizedBox(height: 8),
          _editableTimeField(controller.startDateController, "02/12/2025",context),
          const SizedBox(height: 8),
          _editableTimeField(controller.startTimeController, "12:12 PM",context),

          const SizedBox(height: 24),

          Text(TextString.subtitleAgreementEndTime,
              style: TTextTheme.dropdowninsideText(context)),
          const SizedBox(height: 8),
          _editableTimeField(controller.endDateController, "02/12/2025",context),
          const SizedBox(height: 8),
          _editableTimeField(controller.endTimeController, "12:12 PM",context),
        ],
      );
    }


    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(TextString.subtitleAgreementTime,
                  style: TTextTheme.dropdowninsideText(context)),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(child: _editableTimeField(controller.startDateController, "02/12/2025",context)),
                  const SizedBox(width: 8),
                  Expanded(child: _editableTimeField(controller.startTimeController, "12:12 PM",context)),
                ],
              ),
            ],
          ),
        ),
        Container(
          width: 180,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          alignment: Alignment.center,
          child: Column(
            children: [
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(child: Container(height: 1.5, color: AppColors.iconsBackgroundColor)),
                  const SizedBox(width: 5),
                  const Icon(Icons.access_time, color: AppColors.primaryColor, size: 22),
                  const SizedBox(width: 5),
                  Expanded(
                    child: Stack(
                      alignment: Alignment.centerRight,
                      clipBehavior: Clip.none,
                      children: [
                        Container(height: 1.5, color:AppColors.iconsBackgroundColor),
                        const Positioned(
                          right: -5,
                          child: Icon(Icons.chevron_right, color: AppColors.iconsBackgroundColor, size: 20),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(TextString.subtitleAgreementEndTime,
                  style: TTextTheme.dropdowninsideText(context)),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(child: _editableTimeField(controller.endDateController, "02/12/2025",context)),
                  const SizedBox(width: 8),
                  Expanded(child: _editableTimeField(controller.endTimeController, "12:12 PM",context)),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _editableTimeField(TextEditingController textController, String hint,BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.secondaryColor,
        borderRadius: BorderRadius.circular(6),
      ),
      child: TextFormField(
        cursorColor: AppColors.blackColor,
        controller: textController,
        style: TTextTheme.insidetextfieldWrittenText(context),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TTextTheme.insidetextfieldWrittenText(context),
          contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          border: InputBorder.none,
          isDense: true,
        ),
      ),
    );
  }


  // Signature Section
  Widget _buildSignatureSection(BuildContext context, bool isMobile) {
    return LayoutBuilder(
      builder: (context, constraints) {
        bool stackVertical = constraints.maxWidth < 600;

        double cardWidth = stackVertical
            ? constraints.maxWidth
            : (constraints.maxWidth - 40) / 2;

        return Wrap(
          spacing: 40,
          runSpacing: 20,
          children: [
            SizedBox(
              width: cardWidth,
              child: _signatureCard(TextString.subtitleOwnerSignature, controller.ownerNameController),
            ),
            SizedBox(
              width: cardWidth,
              child: _signatureCard(TextString.subtitleHirerSignature, controller.hirerNameController),
            ),
          ],
        );
      },
    );
  }

  Widget _signatureCard(String title, TextEditingController nameController) {
    return LayoutBuilder(
      builder: (context, innerConstraints) {
        bool forceVertical = innerConstraints.maxWidth < 300;

        return Container(
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: AppColors.primaryColor,width: 0.2),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: TTextTheme.titleRadios(context)),
              const SizedBox(height: 20),

              Flex(
                direction: forceVertical ? Axis.vertical : Axis.horizontal,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: forceVertical ? CrossAxisAlignment.start : CrossAxisAlignment.end,
                children: [
                  ///  Full Name Section
                  Flexible(
                    flex: forceVertical ? 0 : 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ConstrainedBox(
                          constraints: const BoxConstraints(maxWidth: 100),
                          child: Column(
                            children: [
                              TextFormField(
                                cursorColor: AppColors.blackColor,
                                controller: nameController,
                                style: TTextTheme.h2Style(context),
                                decoration: const InputDecoration(
                                  isDense: true,
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.zero,
                                ),
                              ),
                              const Divider(thickness: 1, color: AppColors.tertiaryTextColor),
                            ],
                          ),
                        ),
                        Text(TextString.subtitleFullName, style: TTextTheme.titleFullName(context)),
                      ],
                    ),
                  ),

                  if (forceVertical) const SizedBox(height: 15) else const SizedBox(width: 10),

                  ///  Signature Section
                  Flexible(
                    flex: forceVertical ? 0 : 1,
                    child: Column(
                      crossAxisAlignment: forceVertical ? CrossAxisAlignment.start : CrossAxisAlignment.end,
                      children: [
                        ConstrainedBox(
                          constraints: const BoxConstraints(maxWidth: 100),
                          child: Column(
                            crossAxisAlignment: forceVertical ? CrossAxisAlignment.start : CrossAxisAlignment.end,
                            children: [
                              Text(
                                nameController.text.isEmpty ? "Sign" : nameController.text,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontFamily: 'Cursive',
                                  color: Colors.black87,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const Divider(thickness: 1, color: AppColors.tertiaryTextColor),
                            ],
                          ),
                        ),
                        Text(TextString.subtitleSign, style: TTextTheme.titleFullName(context)),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  // Image Sections
  Widget _imageBox(BuildContext context) {
    bool isMobileView = MediaQuery.of(context).size.width < 600 && !kIsWeb;

    return GestureDetector(
      onTap: () => controller.uploadInspectionPhotos(),
      child: Obx(() {
        return Container(
          width: double.infinity,
          constraints: const BoxConstraints(minHeight: 180),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: AppColors.tertiaryTextColor,
              width: 1.5,
            ),
          ),
          child: controller.vehicleInspectionImages.isEmpty
              ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppColors.iconsBackgroundColor,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Image.asset(IconString.cameraIcon, color: AppColors.primaryColor, width: 18),
                  ),
                  const SizedBox(width: 5),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppColors.iconsBackgroundColor,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Image.asset(IconString.uploadIcon, color: AppColors.primaryColor),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Text(TextString.titleImage, style: TTextTheme.btnOne(context)),
              Text(TextString.subtitleImage, style: TTextTheme.documnetIsnideSmallText2(context)),
            ],
          )
              : LayoutBuilder(builder: (context, constraints) {
            final double itemWidth = isMobileView ? (constraints.maxWidth - 12) / 2 : 100;

            return Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                ...controller.vehicleInspectionImages.map((imageHolder) {
                  int index = controller.vehicleInspectionImages.indexOf(imageHolder);
                  return Stack(
                    children: [
                      Container(
                        height: 100,
                        width: itemWidth,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: AppColors.tertiaryTextColor, width: 1),
                          image: DecorationImage(
                            image: kIsWeb
                                ? MemoryImage(imageHolder.bytes!)
                                : FileImage(File(imageHolder.path!)) as ImageProvider,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ],
                  );
                }),
              ],
            );
          }),
        );
      }),
    );
  }

  Widget _buildSection(BuildContext context, {
    required String title,
    required String icon,
    required Widget child,
    bool showBadge = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          decoration: BoxDecoration(
            color: AppColors.secondaryColor,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              Image.asset(icon, width: 20, height: 20),
              const SizedBox(width: 10),

              Expanded(
                child: Text(
                    title,
                    style: TTextTheme.h6Style(context)),
              ),
            ],
          ),
        ),
        const SizedBox(height: 15),
        child,
      ],
    );
  }

  // For Web
  Widget _buildDetailedCustomerCard(BuildContext context, bool isMobile) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
      decoration: BoxDecoration(
        color: AppColors.backgroundOfPickupsWidget,
        borderRadius: BorderRadius.circular(12),
      ),
      child: isMobile
          ? Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Row(
                  children: [
                    _buildProfileImage(35, 45),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(TextString.titleCustomerImage, style: TTextTheme.titleOne(context), maxLines: 1, overflow: TextOverflow.ellipsis),
                          Text(TextString.titleDriver, style: TTextTheme.btnTwo(context)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              SizedBox(width: 70, child: AddButtonOfPickup(text: "View", onTap: () {})),
            ],
          ),
          SizedBox(height: 15),
          /// Scrollable Info for Mobile
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            physics:  BouncingScrollPhysics(),
            child: Row(
              children: [
                _infoBlock(IconString.smsIcon, TextString.titleEmail, "Contact@SoftSnip.com.au", context),
                const SizedBox(width: 15),
                _infoBlock(IconString.callIcon, TextString.titleContact, "+12 3456 7890", context),
                const SizedBox(width: 15),
                _infoBlock(IconString.location, TextString.titleAddress, "Toronto, California, 1234", context),
                const SizedBox(width: 15),
                _infoBlock(IconString.nidIcon, TextString.titleNid, "123 456 789", context),
                const SizedBox(width: 15),
              ],
            ),
          ),
        ],
      )
          : LayoutBuilder(
        builder: (context, constraints) {
          bool useScroll = constraints.maxWidth < 1000;

          Widget content = Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: _buildCustomerRowContent(context, false),
          );

          return useScroll
              ? SingleChildScrollView(scrollDirection: Axis.horizontal, child: content)
              : content;
        },
      ),
    );
  }

  // Customer Card for mobile
  List<Widget> _buildCustomerRowContent(BuildContext context, bool isMobile) {
    return [
      /// PROFILE
      Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildProfileImage(50, 50),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(TextString.titleCustomerImage, style: TTextTheme.titleOne(context)),
              Text(TextString.titleDriver, style: TTextTheme.btnTwo(context)),
            ],
          ),
        ],
      ),

      /// INFO BLOCKS
      const SizedBox(width: 20),
      _infoBlock(IconString.smsIcon, TextString.titleEmail, "Contact@SoftSnip.com.au", context),
      const SizedBox(width: 20),
      _infoBlock(IconString.callIcon, TextString.titleContact, "+12 3456 7890", context),
      const SizedBox(width: 20),
      _infoBlock(IconString.location, TextString.titleAddress, "Toronto, California, 1234", context),
      const SizedBox(width: 20),
      _infoBlock(IconString.nidIcon, TextString.titleNid, "123 456 789", context),
      const SizedBox(width: 20),

      /// VIEW BUTTON
      AddButtonOfPickup(text: "View", width: 100, onTap: () {}),
    ];
  }

  // profile image at the start
  Widget _buildProfileImage(double w, double h) {
    return Container(
      padding: const EdgeInsets.all(1.5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.primaryColor, width: 0.5),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.asset(ImageString.customerUser, width: w, height: h, fit: BoxFit.cover),
      ),
    );
  }


  // detail Card for web
  Widget _buildDetailedCarCard(BuildContext context, bool isMobile) {
    return Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: isMobile ? 18 : 15),
        decoration: BoxDecoration(
          color: AppColors.backgroundOfPickupsWidget,
          borderRadius: BorderRadius.circular(12),
        ),
        child: isMobile
            ? Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Center(child: Image.asset(ImageString.astonPic, width: 100)),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(TextString.titleCarImage, style: TTextTheme.titleSix(context), overflow: TextOverflow.ellipsis),
                            Text(TextString.titleCarImage2, style: TTextTheme.h3Style(context), overflow: TextOverflow.ellipsis),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                AddButtonOfPickup(text: "View", width: 65, onTap: () {}),
              ],
            ),
            const SizedBox(height: 12),

            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              child: Row(
                children: [
                  _infoRowTag(label:TextString.titleRegistration, value: "1234567890", context: context),
                  const SizedBox(width: 10),
                  _infoRowTag(
                    label: TextString.titleVin,
                    value: "JTNBA3HK003001234",
                    labelColor: AppColors.backgroundOfVin,
                    context: context,
                  ),
                  const SizedBox(width: 30),
                  _buildSpecColumn(context, label: TextString.titleTransmission, value: "Auto", imagePath: IconString.transmissionIcon),
                  const SizedBox(width: 30),
                  _buildSpecColumn(context, label: TextString.titleCapacity, value: "2 seats", imagePath: IconString.capacityIcon),
                  const SizedBox(width: 25),
                  _buildPriceColumn(context),
                ],
              ),
            ),
          ],
        )
            :  LayoutBuilder(
          builder: (context, constraints) {
            double maxWidth = constraints.maxWidth;

            bool enableScroll = maxWidth < 700;

            Widget content = Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: _buildCarContent(context, enableScroll),
            );


            return enableScroll
                ? SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: ConstrainedBox(
                constraints: BoxConstraints(minWidth: 950),
                child: content,
              ),
            )
                : content;
          },
        )

    );
  }

  // detail card for mobile
  List<Widget> _buildCarContent(BuildContext context, bool enableScroll) {
    return [
      Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: enableScroll ? 80 : 130,
            alignment: Alignment.center,
            child: Image.asset(
              ImageString.astonPic,
              width: 135,
              fit: BoxFit.contain,
            ),
          ),

          const SizedBox(width: 15),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(TextString.titleCarImage, style: TTextTheme.titleFour(context)),
              Text(TextString.titleCarImage2, style: TTextTheme.h3Style(context)),

              if (!enableScroll) ...[
                const SizedBox(height: 12),
                _infoRowTag(label: TextString.titleRegistration, value: "1234567890", context: context),
                const SizedBox(height: 8),
                _infoRowTag(
                  label: TextString.titleVin,
                  value: "JTNBA3HK003001234",
                  labelColor: AppColors.backgroundOfVin,
                  context: context,
                ),
              ],
            ],
          ),
        ],
      ),

      if (enableScroll)
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _infoRowTag(label: TextString.titleRegistration, value: "1234567890", context: context),
            const SizedBox(width: 10),
            _infoRowTag(
              label: TextString.titleVin,
              value: "JTNBA3HK003001234",
              labelColor: AppColors.backgroundOfVin,
              context: context,
            ),
          ],
        ),

      _buildSpecColumn(context, label: TextString.titleTransmission, value: "Automatic", imagePath: IconString.transmissionIcon),
      _buildSpecColumn(context, label: TextString.titleCapacity, value: "2 seats", imagePath: IconString.capacityIcon),

      Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildPriceColumn(context),
          const SizedBox(width: 25),
          AddButtonOfPickup(text: "View", width: 100, onTap: () {}),
        ],
      ),
    ];
  }

  // price block of car
  Widget _buildPriceColumn(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(TextString.titlePrice, style:  TTextTheme.titleFour(context)),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("\$130", style:TTextTheme.h5Style(context)),
            Text("/Weekly", style: TTextTheme.titleTwo(context)),
          ],
        ),
      ],
    );
  }


  Widget _buildSpecColumn(BuildContext context, {
    required String label,
    required String value,
    required String imagePath,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: AppColors.secondaryColor,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Image.asset(
            imagePath,
            width: 20,
            height: 20,
            fit: BoxFit.contain,
          ),
        ),
        const SizedBox(height: 5),
        Text(
          label,
          style: TTextTheme.titleFour(context),
        ),
        Text(
          value,
          style: TTextTheme.titleSmallTexts(context),
        ),
      ],
    );
  }


  Widget _infoRowTag({
    required String label,
    required String value,
    Color labelColor = AppColors.textColor,
    required BuildContext context,
  }) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        /// LABEL BOX
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
            color: labelColor,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(6),
              bottomLeft: Radius.circular(6),
            ),
          ),
          child: Text(
            label,
            style: TTextTheme.titleeight(context),
          ),
        ),

        /// VALUE BOX
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
            color: AppColors.secondaryColor,
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(6),
              bottomRight: Radius.circular(6),
            ),
          ),
          child: Text(
            value,
            style: TTextTheme.titleseven(context),
          ),
        ),
      ],
    );
  }



  Widget _infoBlock(String imagePath, String label, String value, BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        /// IMAGE CONTAINER
        Container(
          padding: const EdgeInsets.all(7),
          decoration: BoxDecoration(
            color: AppColors.secondaryColor,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Image.asset(
            imagePath,
            width: 16,
            height: 16,
            fit: BoxFit.contain,
          ),
        ),
        const SizedBox(width: 8),

        /// TEXT SECTION
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                label,
                style: TTextTheme.pFour(context),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
              Text(
                value,
                style: TTextTheme.pOne(context),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ],
          ),
        ),
      ],
    );
  }


  Widget _toggleStatusTag(BuildContext context, String text, RxBool stateVariable) {
    return Obx(() => GestureDetector(
      onTap: () {
        stateVariable.value = !stateVariable.value;
      },
      child: Container(
        padding:  EdgeInsets.symmetric(horizontal: 15, vertical: 12),
        decoration: BoxDecoration(
          color: AppColors.backgroundOfPickupsWidget,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              stateVariable.value ? Icons.radio_button_checked : Icons.radio_button_off,
              size: 16,
              color: AppColors.blackColor,
            ),
            SizedBox(width: 10),
            Text(
              text,
              style: TTextTheme.titleRadios(context),
            ),
          ],
        ),
      ),
    ));
  }
}