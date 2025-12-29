

import 'package:get/get.dart';

class CustomerController extends  GetxController {
   /// TableView Screen
  var selectAge = "".obs;

  RxBool isFilterOpen = false.obs;
  var hoveredRowIndex = (-1).obs;
  void toggleFilter() {
    isFilterOpen.value = !isFilterOpen.value;
  }





}