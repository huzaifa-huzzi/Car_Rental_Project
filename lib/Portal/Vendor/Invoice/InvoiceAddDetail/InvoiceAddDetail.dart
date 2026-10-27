import 'package:car_rental_project/Portal/Vendor/Invoice/InvoiceController.dart';
import 'package:car_rental_project/Portal/Vendor/Invoice/ReusableWidget/HeaderWebInvoiceWidget.dart';
import 'package:car_rental_project/Resources/AppSizes.dart';
import 'package:car_rental_project/Resources/Colors.dart';
import 'package:car_rental_project/Resources/TextTheme.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:dropdown_button2/dropdown_button2.dart';



class InvoiceAddDetail extends StatefulWidget {
  const InvoiceAddDetail({super.key});

  @override
  State<InvoiceAddDetail> createState() => _InvoiceAddDetailState();
}

class _InvoiceAddDetailState extends State<InvoiceAddDetail> {
  final InvoiceController controller = Get.find<InvoiceController>();

  @override
  Widget build(BuildContext context) {
    final isWeb = AppSizes.isWeb(context);

    return Scaffold(
      backgroundColor: AppColors.backgroundOfScreenColor,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.symmetric(
            horizontal: AppSizes.horizontalPadding(context),
            vertical: isWeb ? 24.0 : 20.0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(bottom: isWeb ? 36.0 : 24.0, top: 0),
                child: HeaderWebInvoiceWidget(
                  mainTitle: 'Invoice Detail',
                  smallTitle: "Invoice / Invoice Add Detail",
                  showSmallTitle: true,
                  showBack: true,
                  showProfile: true,
                  showNotification: true,
                  showSettings: true,
                ),
              ),

              LayoutBuilder(
                builder: (context, constraints) {
                  bool isDesktop = constraints.maxWidth >= 1024;
                  return isDesktop
                      ? Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 7,
                        child: Column(
                          children: [
                            _buildBillFromCard(context),
                            SizedBox(height: isWeb ? 24 : 20),
                            _buildCustomerDetailCard(context),
                            SizedBox(height: isWeb ? 24 : 20),
                            _buildRentalDetailCard(context),
                          ],
                        ),
                      ),
                      const SizedBox(width: 24),
                      Expanded(
                        flex: 4,
                        child: _buildSummaryCard(context),
                      ),
                    ],
                  )
                      : Column(
                    children: [
                      _buildBillFromCard(context),
                      const SizedBox(height: 20),
                      _buildCustomerDetailCard(context),
                      const SizedBox(height: 20),
                      _buildRentalDetailCard(context),
                      const SizedBox(height: 20),
                      _buildSummaryCard(context),
                    ],
                  );
                },
              ),
              SizedBox(height: isWeb ? 250.0 : 40.0),
            ],
          ),
        ),
      ),
    );
  }

   /// -------------- Extra Widget ------------------------ ///

  // Bill From Card
  Widget _buildBillFromCard(BuildContext context) {
    List<String> invoiceTypes = ["Manual Invoice", "Automatic Invoice"];
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Bill From Rental Record", style: TTextTheme.bodySemiBold14black(context)),
          const SizedBox(height: 12),
          DropdownButtonHideUnderline(
            child: DropdownButton2<String>(
              isExpanded: true,
              value: controller.selectedInvoiceType.value,
              items: invoiceTypes.map((String type) {
                return DropdownMenuItem<String>(
                  value: type,
                  child: Text(type, style: TTextTheme.bodyRegular14(context)),
                );
              }).toList(),
              onChanged: (String? newValue) {
                if (newValue != null) {
                  controller.selectedInvoiceType.value = newValue;
                }
              },
              onMenuStateChange: (isOpen) {
                setState(() {
                  controller.isBillDropdownOpen = isOpen;
                });
              },
              buttonStyleData: ButtonStyleData(
                height: 48,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: AppColors.secondaryColor,
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              iconStyleData: IconStyleData(
                icon: Icon(
                  controller.isBillDropdownOpen ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                  color: Colors.grey,
                ),
              ),
              dropdownStyleData: DropdownStyleData(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.white,
                ),
                offset: const Offset(0, -5),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Customer Detail Card
  Widget _buildCustomerDetailCard(BuildContext context) {
    bool isMobile = MediaQuery.of(context).size.width < 700;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Customer Detail", style: TTextTheme.h2Style(context).copyWith(fontSize: 18)),
          const SizedBox(height: 4),
          Text("Here you can fill customer detail", style: TTextTheme.bodyRegular14(context).copyWith(color: Colors.grey)),
          const SizedBox(height: 24),
          isMobile
              ? Column(
            children: [
              _buildTextField(context, "Name", "Enter Name"),
              const SizedBox(height: 16),
              _buildTextField(context, "Email Address", "Enter Email Address"),
              const SizedBox(height: 16),
              _buildPhoneField(context, "Phone No"),
              const SizedBox(height: 16),
              _buildTextField(context, "Address", "Enter Address"),
            ],
          )
              : Column(
            children: [
              Row(
                children: [
                  Expanded(child: _buildTextField(context, "Name", "Enter Name")),
                  const SizedBox(width: 16),
                  Expanded(child: _buildTextField(context, "Email Address", "Enter Email Address")),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(child: _buildPhoneField(context, "Phone No")),
                  const SizedBox(width: 16),
                  Expanded(child: _buildTextField(context, "Address", "Enter Address")),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Rental Detail Card
  Widget _buildRentalDetailCard(BuildContext context) {
    bool isMobile = MediaQuery.of(context).size.width < 700;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Rental Detail", style: TTextTheme.h2Style(context).copyWith(fontSize: 18)),
          const SizedBox(height: 4),
          Text("Here you can fill rental detail", style: TTextTheme.bodyRegular14(context).copyWith(color: Colors.grey)),
          const SizedBox(height: 24),
          isMobile
              ? Column(
            children: [
              _buildTextField(context, "Car Name", "Enter Name"),
              const SizedBox(height: 16),
              _buildTextField(context, "Registration No", "Enter Registration Number"),
              const SizedBox(height: 16),
              _buildDateField(context, controller.pickupDateController, controller.pickupDateLink, "Pick up Date", "18/10/26"),
              const SizedBox(height: 16),
              _buildDateField(context, controller.returnDateController, controller.returnDateLink, "Return Date", "18/10/26"),
              const SizedBox(height: 16),
              _buildTextField(context, "Daily Rate", "0"),
            ],
          )
              : Column(
            children: [
              Row(
                children: [
                  Expanded(child: _buildTextField(context, "Car Name", "Enter Name")),
                  const SizedBox(width: 16),
                  Expanded(child: _buildTextField(context, "Registration No", "Enter Registration Number")),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(child: _buildDateField(context, controller.pickupDateController, controller.pickupDateLink, "Pick up Date", "18/10/26")),
                  const SizedBox(width: 16),
                  Expanded(child: _buildDateField(context, controller.returnDateController, controller.returnDateLink, "Return Date", "18/10/26")),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(child: _buildTextField(context, "Daily Rate", "0")),
                  const SizedBox(width: 16),
                  const Spacer(),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Summary Card
  Widget _buildSummaryCard(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Summary", style: TTextTheme.h2Style(context).copyWith(fontSize: 18)),
          const SizedBox(height: 4),
          Text("Here is the summary detail", style: TTextTheme.bodyRegular14(context).copyWith(color: Colors.grey)),
          const SizedBox(height: 24),
          _buildSummaryRow("Rental", "\$ 0.00"),
          const SizedBox(height: 14),
          _buildSummaryRow("Extras", "\$ 0.00"),
          const SizedBox(height: 14),
          _buildSummaryRow("Tax (8%)", "\$ 0.00"),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 20),
            child: Divider(height: 1, color: Colors.grey),
          ),
          _buildSummaryRow("Total", "\$ 0.00", isTotal: true),
          const SizedBox(height: 28),
          SizedBox(
            width: double.infinity,
            height: 48,
            child: OutlinedButton(
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: AppColors.primaryColor),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              ),
              child: Text(
                "Save as Draft Preview",
                style: TTextTheme.bodySemiBold14(context).copyWith(color: AppColors.primaryColor),
              ),
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryColor,
                elevation: 0,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              ),
              child: Text(
                "Finalize Invoice",
                style: TTextTheme.bodySemiBold14White(context),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value, {bool isTotal = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: isTotal
              ? TTextTheme.h2Style(context).copyWith(fontSize: 16)
              : TTextTheme.bodyRegular14(context).copyWith(color: Colors.black87),
        ),
        Text(
          value,
          style: isTotal
              ? TTextTheme.h2Style(context).copyWith(fontSize: 18, color: AppColors.primaryColor)
              : TTextTheme.bodySemiBold14black(context).copyWith(color: AppColors.primaryColor),
        ),
      ],
    );
  }

  Widget _buildTextField(BuildContext context, String label, String hint) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TTextTheme.medium12(context)),
        const SizedBox(height: 6),
        TextField(
          cursorColor: AppColors.blackColor,
          style: TTextTheme.textFieldWrittenText(context).copyWith(color: AppColors.blackColor),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TTextTheme.bodyRegular14(context).copyWith(color: Colors.grey[400]),
            filled: true,
            fillColor: AppColors.secondaryColor,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          ),
        ),
      ],
    );
  }

   // Date Field
  Widget _buildDateField(BuildContext context, TextEditingController dateController, LayerLink link, String label, String hint) {
    return CompositedTransformTarget(
      link: link,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: TTextTheme.medium12(context)),
          const SizedBox(height: 6),
          InkWell(
            onTap: () {
              controller.toggleSingleDateCalendar(context, link, dateController);
            },
            borderRadius: BorderRadius.circular(12),
            child: AbsorbPointer(
              child: TextField(
                controller: dateController,
                cursorColor: AppColors.blackColor,
                style: TTextTheme.textFieldWrittenText(context).copyWith(color: AppColors.blackColor),
                decoration: InputDecoration(
                  hintText: hint,
                  hintStyle: TTextTheme.bodyRegular14(context).copyWith(color: Colors.grey[400]),
                  suffixIcon: const Icon(Icons.event, size: 18, color: AppColors.blackColor),
                  filled: true,
                  fillColor: AppColors.secondaryColor,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

   // Phone Field
  Widget _buildPhoneField(BuildContext context, String label) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TTextTheme.medium12(context)),
        const SizedBox(height: 6),
        Obx(() {
          final List<Country> countryList = controller.getFilteredCountries();

          return TextFormField(
            controller: controller.phoneController,
            keyboardType: TextInputType.phone,
            style: TTextTheme.insidetextfieldWrittenText(context),
            cursorColor: AppColors.blackColor,
            decoration: InputDecoration(
              filled: true,
              fillColor: AppColors.secondaryColor,
              hintText: "Enter number",
              hintStyle: TTextTheme.bodyRegular14(context).copyWith(color: Colors.grey[400]),
              prefixIcon: Padding(
                padding: const EdgeInsets.only(left: 4),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    DropdownButtonHideUnderline(
                      child: DropdownButton2<Country>(
                        isExpanded: false,
                        value: countryList.firstWhere(
                              (c) => c.name == controller.selectedCountryName.value,
                          orElse: () => countryList.first,
                        ),
                        selectedItemBuilder: (context) {
                          return countryList.map((Country country) {
                            return Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const SizedBox(width: 8),
                                _buildCircleFlag(country.countryCode),
                                const SizedBox(width: 8),
                                Text(
                                  "+${country.phoneCode}",
                                  style: TTextTheme.bodyRegular14(context).copyWith(color: AppColors.blackColor),
                                ),
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
                                  child: Text(
                                    country.name,
                                    style: const TextStyle(fontSize: 13),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  "+${country.phoneCode}",
                                  style: TTextTheme.bodyRegular14(context),
                                ),
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
                          icon: Icon(Icons.keyboard_arrow_down_rounded, size: 20, color: Colors.black54),
                        ),
                        dropdownStyleData: DropdownStyleData(
                          maxHeight: 350,
                          width: 250,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.white,
                          ),
                          offset: const Offset(0, -5),
                        ),
                        dropdownSearchData: DropdownSearchData(
                          searchController: controller.searchController,
                          searchInnerWidgetHeight: 50,
                          searchInnerWidget: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextField(
                              controller: controller.searchController,
                              decoration: InputDecoration(
                                hintText: "Search country...",
                                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                                isDense: true,
                              ),
                            ),
                          ),
                          searchMatchFn: (item, searchValue) {
                            return item.value!.name.toLowerCase().contains(searchValue.toLowerCase()) ||
                                item.value!.phoneCode.contains(searchValue);
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            ),
          );
        }),
      ],
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
          cacheWidth: 48,
          cacheHeight: 48,
          errorBuilder: (context, error, stackTrace) => const Icon(Icons.flag, size: 14),
        ),
      ),
    );
  }
}