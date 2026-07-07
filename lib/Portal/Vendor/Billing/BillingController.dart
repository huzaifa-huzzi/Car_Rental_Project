import 'package:car_rental_project/Resources/Colors.dart';
import 'package:car_rental_project/Resources/IconStrings.dart';
import 'package:car_rental_project/Resources/TextTheme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BillingController extends GetxController {
  var openedDropdown2 = "".obs;
  var searchCarText = "".obs;
  var isDefaultPayment = false.obs;
  var selectedTabIndex = 0.obs;

  var dropdownErrors = <String, String>{}.obs;
  var selectedMonth = "".obs;
  var selectedYear = "".obs;
  final nameController = TextEditingController();
  final numberController = TextEditingController();
  final cvcController = TextEditingController();

  int get currentYear => DateTime.now().year;

  List<String> get yearsList => List.generate(
      (currentYear - 1950) + 1,
          (index) => (currentYear - index).toString()
  );

  final List<String> monthsList = [
    "January", "February", "March", "April", "May", "June",
    "July", "August", "September", "October", "November", "December"
  ];

  List<String> getFilteredItems(String id) {
    String query = searchCarText.value.toLowerCase();
    if (id == "year") {
      return yearsList.where((year) => year.contains(query)).toList();
    } else if (id == "month") {
      return monthsList.where((month) => month.toLowerCase().contains(query)).toList();
    }
    return [];
  }


  final RxString billingAddress = "".obs;
  final TextEditingController addressFieldController = TextEditingController();
  void showBillingAddressDialog(BuildContext context) {
    final bool isEdit = billingAddress.value.trim().isNotEmpty;
    addressFieldController.text = isEdit ? billingAddress.value : "";

    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        final double screenWidth = MediaQuery.of(context).size.width;
        final bool isMobile = screenWidth < 600;

        return Dialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
          insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          child: Container(
            constraints: const BoxConstraints(maxWidth: 500),
            width: isMobile ? screenWidth * 0.95 : 500,
            padding: EdgeInsets.all(isMobile ? 16 : 24),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    isEdit ? "Edit Billing Address" : "Save Billing Address",
                    style: TTextTheme.h2Style(context),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    isEdit ? "Edit Billing Address Here" : "Save Billing Address Here",
                    style: TTextTheme.bodyRegular14Search(context),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    "Billing Address",
                    style: TTextTheme.medium12(context),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.secondaryColor,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
                    child: TextField(
                      keyboardType: TextInputType.text,
                      controller: addressFieldController,
                      cursorColor: Colors.black,
                      style: TTextTheme.loginInsideTextField(context),
                      decoration: InputDecoration(
                        hintText: "Enter Billing Address",
                        hintStyle: TTextTheme.textFieldWrittenText(context),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  if (isMobile) ...[
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton(
                        onPressed: () => Navigator.pop(context),
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(color: AppColors.unavailableEnd.withOpacity(0.7)),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                          padding: const EdgeInsets.symmetric(vertical: 14),
                        ),
                        child: Text("Cancel", style: TTextTheme.btnCancel(context).copyWith(color: AppColors.textColor)),
                      ),
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          if (addressFieldController.text.trim().isNotEmpty) {
                            billingAddress.value = addressFieldController.text.trim();
                            Navigator.pop(context);
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primaryColor,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                          padding: const EdgeInsets.symmetric(vertical: 14),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(IconString.uploadIcon, height: 16, width: 16, color: Colors.white),
                            const SizedBox(width: 6),
                            Flexible(
                              child: Text(
                                isEdit ? "Edit Billing Address" : "Save Billing Address",
                                style: TTextTheme.medium14(context).copyWith(color: Colors.white),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ] else ...[
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () => Navigator.pop(context),
                            style: OutlinedButton.styleFrom(
                              side: BorderSide(color: AppColors.unavailableEnd.withOpacity(0.7)),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                              padding: const EdgeInsets.symmetric(vertical: 16),
                            ),
                            child: Text("Cancel", style: TTextTheme.btnCancel(context).copyWith(color: AppColors.textColor)),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              if (addressFieldController.text.trim().isNotEmpty) {
                                billingAddress.value = addressFieldController.text.trim();
                                Navigator.pop(context);
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primaryColor,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                              padding: const EdgeInsets.symmetric(vertical: 16),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(IconString.uploadIcon, height: 16, width: 16, color: Colors.white),
                                const SizedBox(width: 6),
                                Flexible(
                                  child: Text(
                                    isEdit ? "Edit Billing Address" : "Save Billing Address",
                                    style: TTextTheme.medium14(context).copyWith(color: Colors.white),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
          ),
        );
      },
    );
  }
  void clearAllFields() {
    nameController.clear();
    numberController.clear();
    addressFieldController.dispose();
    cvcController.clear();
    selectedMonth.value = "";
    selectedYear.value = "";
    isDefaultPayment.value = false;
    searchCarText.value = "";
    openedDropdown2.value = "";
  }
}