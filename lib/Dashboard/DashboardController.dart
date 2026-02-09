import 'package:get/get.dart';

class DashboardController extends GetxController {

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

    // Logic for updating bars
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


  void updateFilter(String? newValue) {
    if (newValue != null) {
      selectedPeriod.value = newValue;
      income.shuffle();
      expense.shuffle();
    }
  }
}