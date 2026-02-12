import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DashboardController extends GetxController {

  final ScrollController revenueScrollController = ScrollController();

  var selectedPeriod = 'Last 8 Month'.obs;
  final List<String> periods = ['Last 3 Month', 'Last 6 Month', 'Last 8 Month', 'Yearly'];


  var income = <double>[450, 520, 580, 540, 480, 600, 540, 460, 520, 580, 560, 610].obs;
  var expense = <double>[320, 380, 400, 360, 420, 440, 380, 350, 420, 410, 430, 420].obs;

  var selectedDropoffPeriod = 'Last 30 Days'.obs;
  final List<String> dropoffPeriods = ['Last 7 Days', 'Last 30 Days', 'Last 8 Month'];

  var completedDropoffs = 1000.obs;
  var incompleteDropoffs = 1200.obs;




  void updateDropoffFilter(String? val) {
    if (val == null) return;
    selectedDropoffPeriod.value = val;

    if (val == 'Last 7 Days') {
      completedDropoffs.value = 250;
      incompleteDropoffs.value = 300;
    } else if (val == 'Last 8 Month') {
      completedDropoffs.value = 4500;
      incompleteDropoffs.value = 5200;
    } else {
      completedDropoffs.value = 1000;
      incompleteDropoffs.value = 1200;
    }
  }


  var selectedPickupPeriod = 'Last 30 Days'.obs;
  final List<String> pickupPeriods = ['Last 7 Days', 'Last 30 Days', 'Last Year'];

  final pickupData = {
    'Last 7 Days': {'completed': 0.3, 'awaiting': 0.2, 'overdue': 0.1, 'processing': 0.5},
    'Last 30 Days': {'completed': 0.8, 'awaiting': 0.4, 'overdue': 0.6, 'processing': 0.3},
    'Last Year': {'completed': 0.9, 'awaiting': 0.1, 'overdue': 0.2, 'processing': 0.4},
  }.obs;

  void updatePickupFilter(String? val) {
    if (val != null) selectedPickupPeriod.value = val;
  }


  var selectedDamagePeriod = 'Last 30 Days'.obs;
  final List<String> damagePeriods = ['Last 7 Days', 'Last 30 Days', 'Last Year'];

  final damageDataMap = {
    'Last 7 Days': {'safe': 4.0, 'damage': 7.0, 'safeCount': "500", 'damageCount': "1,200"},
    'Last 30 Days': {'safe': 6.0, 'damage': 10.0, 'safeCount': "1,456", 'damageCount': "2,841"},
    'Last Year': {'safe': 9.0, 'damage': 12.0, 'safeCount': "5,000", 'damageCount': "10,000"},
  }.obs;

  void updateDamageFilter(String? val) {
    if (val != null) selectedDamagePeriod.value = val;
  }


  void updateFilter(String? newValue) {
    if (newValue != null) {
      selectedPeriod.value = newValue;
      income.shuffle();
      expense.shuffle();
    }
  }


  var selectedBodyType = 'SUV'.obs;

  void selectBodyType(String type) {
    selectedBodyType.value = type;
  }


 // On close function
  @override
  void onClose() {
    revenueScrollController.dispose();
    super.onClose();
  }
}


