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

  var isTemplateMenuOpen = false.obs;

  // Static list for templates as shown in image_9282ec.png
  // FIX: 'final List<...>' ki jagah 'RxList<Map<String, String>>' use karein ya fir simple 'var' use karein
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

  // Jab template par click ho toh text field mein message copy ho jaye
  void selectTemplate(String body) {
    messageInputController.text = body;
    isTemplateMenuOpen.value = false; // Menu close ho jaye
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

      // Clear inputs after successful save
      titleController.clear();
      descriptionController.clear();

      // Wapis list view par switch karne ke liye flag false
      isCreatingTemplate.value = false;
    } else {
      // Agar fields khali hon toh error alert
      Get.snackbar(
        'Error',
        'Please fill both Title and Description fields',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.redAccent.withValues(alpha: 0.1),
        colorText: Colors.red,
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