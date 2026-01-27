import 'package:car_rental_project/PickupCar/PickupCarInventory.dart';
import 'package:car_rental_project/PickupCar/ReusableWidgetOfPickup/AddButtonOfPickup.dart';
import 'package:car_rental_project/PickupCar/ReusableWidgetOfPickup/AddPickupButton.dart';
import 'package:car_rental_project/PickupCar/ReusableWidgetOfPickup/HeaderWebPickupWidget.dart';
import 'package:car_rental_project/PickupCar/ReusableWidgetOfPickup/SuccessConfirmationPickupDialog.dart';
import 'package:car_rental_project/Resources/AppSizes.dart';
import 'package:car_rental_project/Resources/Colors.dart';
import 'package:car_rental_project/Resources/IconStrings.dart';
import 'package:car_rental_project/Resources/ImageString.dart';
import 'package:car_rental_project/Resources/TextTheme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';


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
                    _buildStepBadges(context),

                    Padding(
                      padding: EdgeInsets.all(padding),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Header
                          Text("Add Pickup Car", style: TTextTheme.h6Style(context)),
                          const SizedBox(height: 6),
                          Text("Enter the specification for the pre rental details",
                              style: TTextTheme.titleThree(context)),

                          const SizedBox(height: 25),

                          // Non-Editable Content
                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.all(isMobile ? 15 : 30),
                            decoration: BoxDecoration(
                              color: AppColors.backgroundOfScreenColor,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [

                                /// CUSTOMER NAME SECTION
                                _buildSection(context,
                                    title: "Customer Name",
                                    icon: IconString.customerNameIcon,
                                    child: _buildDetailedCustomerCard(context, isMobile)),
                                const SizedBox(height: 25),

                                /// CAR DETAILS SECTION
                                _buildSection(context,
                                    title: "Car",
                                    icon: IconString.pickupCarIcon,
                                    child: _buildDetailedCarCard(context, isMobile)),
                                const SizedBox(height: 25),

                                /// RENT PURPOSE SECTION
                                _buildSection(context,
                                    title: "Rent Purpose",
                                    icon: IconString.rentPurposeIcon,
                                    child: IgnorePointer(
                                      child: _toggleStatusTag(context, "Personal Use", controller.isPersonalUse),
                                    )),
                                const SizedBox(height: 25),

                                /// PAYMENT METHOD SECTION
                                _buildSection(context,
                                    title: "Payment Method",
                                    icon: IconString.paymentMethodIcon,
                                    child: IgnorePointer(
                                      child: _toggleStatusTag(context, "Manual Payments", controller.isManualPayment),
                                    )),
                                const SizedBox(height: 25),

                                /// RENT AMOUNT SECTION
                                _buildSection(context,
                                    title: "Rent Amount",
                                    icon: IconString.rentMoneyIcon,
                                    child: _buildInfoGrid(context, [
                                      {"label": "Weekly Rent", "controller": controller.weeklyRentController, "hint": "2600 \$"},
                                      {"label": "Daily Rent", "controller": controller.rentDueAmountController, "hint": "2600 \$"},
                                    ], isMobile, isEditable: false)),
                                const SizedBox(height: 25),

                                /// BOND PAYMENT SECTION
                                _buildSection(context,
                                    title: "Bond Payment",
                                    icon: IconString.bondPaymentIcon,
                                    child: _buildInfoGrid(context, [
                                      {"label": "Bond Amount", "controller": controller.bondAmountController, "hint": "2600 \$"},
                                      {"label": "Paid Bond", "controller": controller.paidBondController, "hint": "600 \$"},
                                      {"label": "Left Bond", "controller": controller.dueBondAmountController, "hint": "2000 \$"},
                                    ], isMobile, isEditable: false)),
                                const SizedBox(height: 25),

                                /// CAR REPORT SECTION
                                _buildSection(context,
                                  title: "Car Report",
                                  icon: IconString.carReportIcon,
                                  child: _buildInfoGrid(context, [
                                    {"label": "Pickup ODO", "controller": controller.odoController, "hint": "12457678", "hasIcon": false},
                                    {"label": "Pickup Fuel Level", "controller": controller.fuelLevelController, "hint": "Full (100%)", "hasIcon": true},
                                    {"label": "Interior Cleanliness", "controller": controller.interiorCleanlinessController, "hint": "Excellent", "hasIcon": true},
                                    {"label": "Exterior Cleanliness", "controller": controller.exteriorCleanlinessController, "hint": "Excellent", "hasIcon": true},
                                  ], isMobile, isEditable: false),
                                ),
                                const SizedBox(height: 25),

                                /// DAMAGE INSPECTION SECTION
                                _buildSection(context,
                                    title: "Damage Inspection",
                                    icon: IconString.damageInspection,
                                    child: _buildDamageInspectionCard(context, isMobile)),
                                const SizedBox(height: 25),

                                /// PICKUP NOTE SECTION
                                _buildSection(
                                  context,
                                  title: "Pickup Note",
                                  icon: IconString.pickupNote,
                                  child: IgnorePointer(
                                    child: _buildCommentField(
                                        context,
                                        "Pickup Comments",
                                        controller.additionalCommentsController,
                                        "Audi A6 is a luxurious and sophisticated sedan, ideal for both daily commutes and extended journeys. Renowned for its powerful performance and advanced technology features, the A6 provides a refined driving experience with exceptional comfort. Audi A6 is a luxurious and sophisticated sedan, ideal for both daily commutes and extended journeys. Renowned for its powerful performance and advanced technology features, the A6 provides a refined driving experience with exceptional comfort."
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 25),

                                /// CAR PICTURE SECTION
                                _buildSection(context,
                                    title: "Car Picture",
                                    icon: IconString.carPictureIconPickup,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text("Car Image (Max 10)", style: TTextTheme.dropdowninsideText(context)),
                                        const SizedBox(height: 10),
                                        _imageBox(context),
                                      ],
                                    )),
                                const SizedBox(height: 25),

                                /// RENT TIME SECTION
                                _buildSection(context,
                                    title: "Rent Time",
                                    icon: IconString.rentTimeIcon,
                                    showBadge: true,
                                    child: _buildRentTimeSection(context, isMobile)),
                                const SizedBox(height: 25),
                              ],
                            ),
                          ),

                          const SizedBox(height: 30),

                          /// Terms & Signatures
                          _buildTermsAndConditions(context),
                          const SizedBox(height: 25),
                          _buildSignatureSection(context, isMobile),

                          const SizedBox(height: 40),

                          /// Buttons
                          _buttonSection(context, isMobile),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20), 
          ],
        ),
      ),
    );
  }

    /// ------- Extra Widgtes ------///

  Widget _buildInfoGrid(BuildContext context, List<Map<String, dynamic>> items, bool isMobile, {bool isEditable = true}) {
    final double availableWidth = MediaQuery.of(context).size.width;

    return Wrap(
      spacing: 20,
      runSpacing: 15,
      children: items.map((item) {
        double itemWidth = isMobile ? (availableWidth - 100) : (availableWidth / 5);

        return SizedBox(
          width: itemWidth,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(item['label']!, style: TTextTheme.dropdowninsideText(context)),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.all(3),
                decoration: BoxDecoration(
                  color: AppColors.secondaryColor,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: TextFormField(
                  controller: item['controller'],
                  enabled: isEditable,
                  readOnly: !isEditable,
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

  Widget _buildStepBadge(String text, bool isActive, BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      decoration: BoxDecoration(
        color: isActive ? AppColors.primaryColor :  AppColors.backgroundOfPickupsWidget,
        borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(8), bottomRight: Radius.circular(8)),
      ),
      child: Text(text, style: TTextTheme.btnWhiteColor(context)),
    );
  }

  Widget _buildStepBadges(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20),
      child: Row(
        children: [
          _buildStepBadge("Step 1", false, context),
          const SizedBox(width: 8),
          _buildStepBadge("Step 2", true, context),
        ],
      ),
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
            decoration: InputDecoration(hintText: hint, border: InputBorder.none, hintStyle: TTextTheme.pOne(context)),
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
            color: Colors.white,
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

  // Rent time Section
  Widget _buildRentTimeSection(BuildContext context, bool isMobile) {
    if (isMobile) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Agreement Start Time",
              style: TTextTheme.dropdowninsideText(context)),
          const SizedBox(height: 8),
          _editableTimeField(controller.startDateController, "02/12/2025",context),
          const SizedBox(height: 8),
          _editableTimeField(controller.startTimeController, "12:12 PM",context),

          const SizedBox(height: 24),

          Text("Agreement End Time",
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
              Text("Agreement Start Time",
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
              Text("Agreement End Time",
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
              child: _signatureCard("Signed by Owner", controller.ownerNameController),
            ),
            SizedBox(
              width: cardWidth,
              child: _signatureCard("Signed by Hirer", controller.hirerNameController),
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
            border: Border.all(color: AppColors.primaryColor, width: 0.2),
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
                  Flexible(
                    flex: forceVertical ? 0 : 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ConstrainedBox(
                          constraints: const BoxConstraints(maxWidth: 100, minHeight: 30),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              const SizedBox(height: 20),
                              const Divider(thickness: 1, color: AppColors.tertiaryTextColor),
                            ],
                          ),
                        ),
                        Text("Full Name", style: TTextTheme.titleFullName(context)),
                      ],
                    ),
                  ),

                  if (forceVertical) const SizedBox(height: 15) else const SizedBox(width: 10),

                  Flexible(
                    flex: forceVertical ? 0 : 1,
                    child: Column(
                      crossAxisAlignment: forceVertical ? CrossAxisAlignment.start : CrossAxisAlignment.end,
                      children: [
                        ConstrainedBox(
                          constraints: const BoxConstraints(maxWidth: 100, minHeight: 30),
                          child: Column(
                            crossAxisAlignment: forceVertical ? CrossAxisAlignment.start : CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              const SizedBox(height: 20),
                              const Divider(thickness: 1, color: AppColors.tertiaryTextColor),
                            ],
                          ),
                        ),
                        Text("Signature", style: TTextTheme.titleFullName(context)),
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
    bool isMobileView = MediaQuery.of(context).size.width < 600;

    return Container(
      width: double.infinity,
      constraints: const BoxConstraints(minHeight: 180),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColors.tertiaryTextColor,
          width: 1.5,
        ),
      ),
      child: LayoutBuilder(builder: (context, constraints) {
        final double itemWidth = isMobileView ? (constraints.maxWidth - 24) / 2 : 110;

        return Wrap(
          spacing: 12,
          runSpacing: 12,
          children: List.generate(10, (index) {
            return Container(
              height: 100,
              width: itemWidth,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: AppColors.tertiaryTextColor, width: 1),
                image: DecorationImage(
                  image: AssetImage(ImageString.astonPic),
                  fit: BoxFit.cover,
                ),
              ),
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
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 20),
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
                    _buildProfileImage(30, 40),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text("Carlie Harvy", style: TTextTheme.titleOne(context), maxLines: 1, overflow: TextOverflow.ellipsis),
                          Text("Driver", style: TTextTheme.btnTwo(context)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              SizedBox(width: 60, child: AddButtonOfPickup(text: "View", onTap: () {})),
            ],
          ),
          SizedBox(height: 15),
          /// Scrollable Info for Mobile
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            physics:  BouncingScrollPhysics(),
            child: Row(
              children: [
                _infoBlock(IconString.smsIcon, "Email", "Contact@SoftSnip.com.au", context),
                const SizedBox(width: 12),
                _infoBlock(IconString.callIcon, "Contact Number", "+12 3456 7890", context),
                const SizedBox(width: 12),
                _infoBlock(IconString.location, "Address", "Toronto, California, 1234", context),
                const SizedBox(width: 12),
                _infoBlock(IconString.nidIcon, "NID Number", "123 456 789", context),
                const SizedBox(width: 12),
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
              Text("Carlie Harvy", style: TTextTheme.titleOne(context)),
              Text("Driver", style: TTextTheme.btnTwo(context)),
            ],
          ),
        ],
      ),

      /// INFO BLOCKS
      const SizedBox(width: 20),
      _infoBlock(IconString.smsIcon, "Email", "Contact@SoftSnip.com.au", context),
      const SizedBox(width: 15),
      _infoBlock(IconString.callIcon, "Contact Number", "+12 3456 7890", context),
      const SizedBox(width: 15),
      _infoBlock(IconString.location, "Address", "Toronto, California, 1234", context),
      const SizedBox(width: 15),
      _infoBlock(IconString.nidIcon, "NID Number", "123 456 789", context),
      const SizedBox(width: 18),

      /// VIEW BUTTON
      AddButtonOfPickup(text: "View", width: 90, onTap: () {}),
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
                            Text("Aston 2025", style: TTextTheme.titleSix(context), overflow: TextOverflow.ellipsis),
                            Text("Martin", style: TTextTheme.h3Style(context), overflow: TextOverflow.ellipsis),
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
                  _infoRowTag(label: "Registration", value: "1234567890", context: context),
                  const SizedBox(width: 10),
                  _infoRowTag(
                    label: "VIN",
                    value: "JTNBA3HK003001234",
                    labelColor: AppColors.backgroundOfVin,
                    context: context,
                  ),
                  const SizedBox(width: 30),
                  _buildSpecColumn(context, label: "Transmission", value: "Auto", imagePath: IconString.transmissionIcon),
                  const SizedBox(width: 30),
                  _buildSpecColumn(context, label: "Capacity", value: "2 seats", imagePath: IconString.capacityIcon),
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

            bool enableScroll = maxWidth < 750;

            Widget content = Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: _buildCarContent(context, enableScroll),
            );


            return enableScroll
                ? SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: ConstrainedBox(
                constraints: BoxConstraints(minWidth: 970),
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
            height: enableScroll ? 70 : 130,
            alignment: Alignment.center,
            child: Image.asset(
              ImageString.astonPic,
              fit: BoxFit.contain,
            ),
          ),

          const SizedBox(width: 15),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Range Rover 2024", style: TTextTheme.titleFour(context)),
              Text("Velar", style: TTextTheme.h3Style(context)),

              if (!enableScroll) ...[
                const SizedBox(height: 12),
                _infoRowTag(label: "Registration", value: "1234567890", context: context),
                const SizedBox(height: 8),
                _infoRowTag(
                  label: "VIN",
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
            _infoRowTag(label: "Registration", value: "1234567890", context: context),
            const SizedBox(width: 10),
            _infoRowTag(
              label: "VIN",
              value: "JTNBA3HK003001234",
              labelColor: AppColors.backgroundOfVin,
              context: context,
            ),
          ],
        ),

      _buildSpecColumn(context, label: "Transmission", value: "Automatic", imagePath: IconString.transmissionIcon),
      _buildSpecColumn(context, label: "Capacity", value: "2 seats", imagePath: IconString.capacityIcon),

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
        Text("Price", style:  TTextTheme.titleFour(context)),
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

  // Terms and Condition
  Widget _buildTermsAndConditions(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.primaryColor, width: 0.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
              "Terms & Conditions",
              style: TTextTheme.titleRadios(context)
          ),
          const SizedBox(height: 10),
          Text(
            "Audi A6 is a luxurious and sophisticated sedan, ideal for both daily commutes and extended journeys. "
                "Renowned for its powerful performance and advanced technology features, the A6 provides a refined "
                "driving experience with exceptional comfort. Audi A6 is a luxurious and sophisticated sedan, "
                "ideal for both daily commutes and extended journeys. Renowned for its powerful performance "
                "and advanced technology features, the A6 provides a refined driving experience with exceptional comfort.",
            style: TTextTheme.pTwo(context),
            textAlign: TextAlign.justify,
          ),
        ],
      ),
    );
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
              text: 'Back',
              backgroundColor: Colors.white,
              textColor: AppColors.textColor,
              borderColor: AppColors.quadrantalTextColor,
              onTap: () {
                context.push('/addpickup', extra: {"hideMobileAppBar": true});
              },
            ),
          ),
          SizedBox(height: spacing),
          SizedBox(
            width: webButtonWidth,
            height: webButtonHeight,
            child: AddButtonOfPickup(
              text: "Confirm",
                onTap: () {
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (BuildContext context) {
                      return const SuccessConfirmationPickupDialog();
                    },
                  );
                }
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
              text: 'Back',
              backgroundColor: Colors.white,
              textColor: AppColors.textColor,
              borderColor: AppColors.quadrantalTextColor,
              onTap: () {
                context.push('/addpickup', extra: {"hideMobileAppBar": true});
              },
            ),
          ),
          SizedBox(width: spacing),
          SizedBox(
            width: webButtonWidth,
            height: webButtonHeight,
            child: AddButtonOfPickup(
              text: "Confirm",
                onTap: () {
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (BuildContext context) {
                      return const SuccessConfirmationPickupDialog();
                    },
                  );
                }
            ),
          ),

        ],
      );
    }
  }

}