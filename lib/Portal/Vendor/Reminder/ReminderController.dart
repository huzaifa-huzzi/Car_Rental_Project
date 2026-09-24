import 'package:car_rental_project/Resources/Colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReminderController extends GetxController {
  var selectedAlertType = 'whatsapp'.obs;
  var selectedAlertType2 = 'sms'.obs;

  var selectedChatIndex = 0.obs;

  var isChatDetailOpenMobile = false.obs;

  void changeAlertType(String type) {
    selectedAlertType.value = type;
  }

  final TextEditingController messageInputController = TextEditingController();

  var dynamicMessages = <Map<String, dynamic>>[
  {
  'message': "Your card has insufficient balance. Please recharge your account to avoid rental interruption.",
  'isMe': true,
  'time': "7:40"
  },
  {
  'message': "Your card has insufficient balance. Please recharge your account to avoid rental interruption.",
  'isMe': false,
  'time': "7:40"
  },
  ].obs;
  void sendMessage() {
  if (messageInputController.text.trim().isNotEmpty) {
  dynamicMessages.add({
  'message': messageInputController.text.trim(),
  'isMe': true,
  'time': "${DateTime.now().hour}:${DateTime.now().minute.toString().padLeft(2, '0')}",
  });
  messageInputController.clear();
  }
  }

  var selectedFilter = 'All'.obs;
  var isDropdownOpen = false.obs;

  var selectedDateText = "Select Date".obs;

  String getMonthName(int monthNumber) {
    final List<String> months = [
      "Jan", "Feb", "Mar", "Apr", "May", "Jun",
      "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"
    ];
    return months[monthNumber - 1];
  }

  var chatMode = 'Manual'.obs;

  void toggleChatMode(String mode) {
    chatMode.value = mode;
  }


  var isSearching = false.obs;
  var filteredTemplatesList = <Map<String, String>>[].obs;

  void filterTemplates(String query) {
    if (query.trim().isEmpty) {
      isSearching.value = false;
      filteredTemplatesList.clear();
    } else {
      isSearching.value = true;
      filteredTemplatesList.assignAll(
        templatesList.where((template) =>
        template['title']!.toLowerCase().contains(query.toLowerCase()) ||
            template['body']!.toLowerCase().contains(query.toLowerCase())
        ).toList(),
      );
    }
  }

  var isTemplateMenuOpen = false.obs;

  RxList<Map<String, String>> templatesList = [
    {
      "title": "Payment Reminder",
      "body": "Hi Marcus, friendly reminder your weekly payment of \$1440 is due 5/7/2026."
    },
    {
      "title": "Payment Failed",
      "body": "Hi Marcus, we couldn't process \$1440 for Range Rover Velar. We'll retry in 24h — or update your card any time."
    },
    {
      "title": "Overdue Vehicle",
      "body": "Hi Marcus, your Range Rover Velar was due back 5/7/2026. Please confirm a return time."
    },
    {
      "title": "Return Confirmation",
      "body": "Thanks Marcus — Range Rover Velar marked as returned. Final invoice on its way."
    },
  ].obs;
  void selectTemplate(String body) {
    messageInputController.text = body;
    isTemplateMenuOpen.value = false;
  }


  var isCreatingTemplate = false.obs;
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  void addNewTemplate() {
    if (titleController.text.trim().isNotEmpty && descriptionController.text.trim().isNotEmpty) {
      templatesList.add({
        'title': titleController.text.trim(),
        'body': descriptionController.text.trim(),
      });
      titleController.clear();
      descriptionController.clear();

      isCreatingTemplate.value = false;
    } else {
      Get.snackbar(
        'Error',
        'Please fill both Title and Description fields',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.redAccent.withValues(alpha: 0.1),
        colorText: AppColors.primaryColor,
      );
    }
  }

  void deleteTemplate(int index) {
    templatesList.removeAt(index);
  }

  @override
  void onClose() {
  messageInputController.dispose();
  titleController.dispose();
  descriptionController.dispose();
  super.onClose();
  }

}