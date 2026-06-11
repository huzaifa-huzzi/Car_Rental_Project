import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReminderController extends GetxController {
  var selectedAlertType = 'whatsapp'.obs;

  // Track karne ke liye ke is waqt kis user ki chat open hai
  var selectedChatIndex = 0.obs;

  // Mobile par chat details screen open karne ke liye toggle
  var isChatDetailOpenMobile = false.obs;

  void changeAlertType(String type) {
    selectedAlertType.value = type;
  }

  // --- NEW: Message Sending Logic Variables ---
  final TextEditingController messageInputController = TextEditingController();

  // Fake reactive messages list jo UI par instantly update hogi
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

  // Message Send karne ka function
  void sendMessage() {
  if (messageInputController.text.trim().isNotEmpty) {
  dynamicMessages.add({
  'message': messageInputController.text.trim(),
  'isMe': true, // User khud bhej raha hai
  'time': "${DateTime.now().hour}:${DateTime.now().minute.toString().padLeft(2, '0')}",
  });
  messageInputController.clear(); // Send karne ke baad text field saaf
  }
  }

  @override
  void onClose() {
  messageInputController.dispose();
  super.onClose();
  }

}