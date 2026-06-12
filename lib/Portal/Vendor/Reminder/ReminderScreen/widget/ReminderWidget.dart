import 'package:car_rental_project/Portal/Vendor/Reminder/ReminderController.dart';
import 'package:car_rental_project/Portal/Vendor/Reminder/ReusableWidgetOfReminder/CustomCalendarReminder.dart';
import 'package:car_rental_project/Portal/Vendor/Reminder/ReusableWidgetOfReminder/PrimaryBtnOfReminder.dart';
import 'package:car_rental_project/Resources/Colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReminderWidget extends StatelessWidget {
  const ReminderWidget({super.key});

  static const List<Map<String, String>> chatUsersData = [
    {'name': 'Jack Milson', 'car': 'RNG-1188 Range Rover Velar', 'time': '24hrs ago', 'status': 'Online'},
    {'name': 'Andrew Myres', 'car': 'AWG-4432 Honda Civic', 'time': '24hrs ago', 'status': 'Offline'},
    {'name': 'Ethan Miles', 'car': 'KWC-2343 Kia Sportage', 'time': '24hrs ago', 'status': 'Online'},
    {'name': 'Jhon Doe', 'car': 'RNG-1188 Range Rover Velar', 'time': '24hrs ago', 'status': 'Away'},
    {'name': 'Andrew Graified', 'car': 'RNG-1188 Range Rover Velar', 'time': '24hrs ago', 'status': 'Online'},
  ];

  @override
  Widget build(BuildContext context) {
    final ReminderController controller = Get.put(ReminderController());

    double screenWidth = MediaQuery.of(context).size.width;
    bool isMobileLayout = screenWidth < 850;

    return Container(
      margin: const EdgeInsets.only(top: 10),
      child: Column(
        children: [
          _buildTopActionBar(controller),
          const SizedBox(height: 16),
          // Pure body panel ko Obx mein wrap kiya taake SMS state par poora panel switch ho sake
          Expanded(
            child: Obx(() {
              // Agar WhatsApp alert selected NAHI hai, to empty state dikhao (Error se bachne ke liye)
              if (controller.selectedAlertType.value != 'whatsapp') {
                return Text("Sms will be done soon");
              }

              // Agar WhatsApp selected hai, to normal layout dikhao
              return isMobileLayout
                  ? _buildMobileLayout(controller)
                  : _buildWebLayout(controller);
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildWebLayout(ReminderController controller) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(width: 320, child: _buildChatList(controller)),
        Expanded(child: _buildChatConversationArea(controller, isMobile: false)),
      ],
    );
  }

  Widget _buildMobileLayout(ReminderController controller) {
    return Obx(() {
      bool isOpen = controller.isChatDetailOpenMobile.value;
      return AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        switchInCurve: Curves.easeInOut,
        switchOutCurve: Curves.easeInOut,
        transitionBuilder: (Widget child, Animation<double> animation) {
          final slideAnimation = Tween<Offset>(begin: const Offset(1.0, 0.0), end: Offset.zero).animate(animation);
          return SlideTransition(position: slideAnimation, child: FadeTransition(opacity: animation, child: child));
        },
        child: isOpen
            ? _buildChatConversationArea(controller, isMobile: true, key: const ValueKey('chat_detail'))
            : _buildChatList(controller, key: const ValueKey('chat_list')),
      );
    });
  }

  Widget _buildTopActionBar(ReminderController controller) {
    return Align(
      alignment: Alignment.topRight,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 2.0),
        decoration: BoxDecoration(color: const Color(0xFFF4F6F9), borderRadius: BorderRadius.circular(8)),
        constraints: const BoxConstraints(maxWidth: 600),
        child: Wrap(
          spacing: 16.0,
          runSpacing: 12.0,
          alignment: WrapAlignment.end,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            _buildResponsiveHeader(controller),
          ],
        ),
      ),
    );
  }

  Widget _buildChatList(ReminderController controller, {Key? key}) {
    return Container(
      key: key,
      constraints: const BoxConstraints.expand(),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(topLeft: Radius.circular(12), bottomLeft: Radius.circular(12)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0), // Padding thodi badhayein taake gaps exact lagein
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    // 1. Select Date Button
                    Flexible(
                      child: Container(
                        height: 40,
                        constraints: const BoxConstraints(
                          minWidth: 100,
                          maxWidth: 160,
                        ),
                        child: Obx(() {
                          String dateDisplay = controller.selectedDateText.value;
                          bool hasSelected = dateDisplay != "Select Date";

                          return PopupMenuButton<void>(
                            padding: EdgeInsets.zero,
                            elevation: 0, // Extra popup container shadow zero kar di
                            offset: const Offset(0, 44),
                            // Inkwell container surface wrapper matching your design background
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                            color: Colors.transparent, // Isko transparent karne se double container background bilkul remove ho jayega

                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10),
                              decoration: BoxDecoration(
                                color: const Color(0xFFF4F6F8),
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: const Color(0xFFE2E8F0), width: 1),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.calendar_today_outlined,
                                    size: 14,
                                    color: hasSelected ? const Color(0xFFFF2D55) : const Color(0xFF4A5568),
                                  ),
                                  const SizedBox(width: 6),
                                  Flexible(
                                    child: Text(
                                      dateDisplay,
                                      style: TextStyle(
                                        color: hasSelected ? const Color(0xFFFF2D55) : const Color(0xFF4A5568),
                                        fontSize: 12,
                                        fontWeight: hasSelected ? FontWeight.w600 : FontWeight.w400,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            itemBuilder: (BuildContext context) {
                              return [
                                PopupMenuItem<void>(
                                  enabled: false, // Core body list tap handler block range selection bypass karne ke liye
                                  padding: EdgeInsets.zero, // Padding zero karne se unwanted nested card spaces remove ho jayenge
                                  child: CustomCalendarReminder(
                                    width: 290,
                                    onDateSelected: (DateTime startOfWeek) {
                                      DateTime endOfWeek = startOfWeek.add(const Duration(days: 6));

                                      // Clean formatting functionality shifted safely
                                      String startMonth = controller.getMonthName(startOfWeek.month);
                                      String endMonth = controller.getMonthName(endOfWeek.month);
                                      String startYear = startOfWeek.year.toString().substring(2);
                                      String endYear = endOfWeek.year.toString().substring(2);

                                      // Format: "1 May,26 to 7 May 26" matching your info box screenshot
                                      String formattedRange = "${startOfWeek.day} $startMonth,$startYear to ${endOfWeek.day} $endMonth $endYear";

                                      controller.selectedDateText.value = formattedRange;
                                      Navigator.of(context).pop();
                                    },
                                    onCancel: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ),
                              ];
                            },
                          );
                        }),
                      ),
                    ),
                    const SizedBox(width: 8), // Perfect gap dono ke darmiyan

                    // 2. Dropdown Filter Button ('All')
                    Flexible(
                      child: Container(
                        height: 40,
                        constraints: const BoxConstraints(
                          minWidth: 70,
                          maxWidth: 110, // Items ke texts bade hain isliye halki si width barhadi
                        ),
                        child: Obx(() {
                          // Dropdown ki check state ko dynamic handle karne ke liye controller variable
                          // Note: controller ke andar 'selectedFilter' aur 'isDropdownOpen' reactive variables initialize kar lein
                          String currentSelection = controller.selectedFilter.value;
                          bool isOpen = controller.isDropdownOpen.value;

                          List<String> statusItems = ['All', 'Pending', 'Overdue', 'Failed', 'Completed'];

                          return PopupMenuButton<String>(
                            constraints: const BoxConstraints(
                              minWidth: 140, // Dropdown menu ki list items ke liye stable width
                              maxHeight: 250,
                            ),
                            offset: const Offset(0, 42), // Box ke thora niche khulega
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                            color: Colors.white,
                            elevation: 4,
                            onOpened: () => controller.isDropdownOpen.value = true,
                            onCanceled: () => controller.isDropdownOpen.value = false,
                            onSelected: (val) {
                              controller.selectedFilter.value = val;
                              controller.isDropdownOpen.value = false;
                            },
                            // --- Trigger Button Container ---
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10),
                              decoration: BoxDecoration(
                                color: const Color(0xFFF4F6F8),
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: const Color(0xFFE2E8F0), width: 1),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Text(
                                      currentSelection,
                                      style: const TextStyle(
                                        color: Color(0xFF1E293B), // Dark text design ke mutabiq
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  const SizedBox(width: 4),
                                  // Dynamic state matching custom icon behaviour
                                  Icon(
                                    isOpen ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                                    size: 18,
                                    color: const Color(0xFF64748B),
                                  ),
                                ],
                              ),
                            ),
                            // --- Dropdown Items List Builder ---
                            itemBuilder: (context) => statusItems.map((item) {
                              bool isSelected = currentSelection == item;
                              return PopupMenuItem<String>(
                                value: item,
                                height: 38, // Items ko clean structure dene ke liye height control
                                child: Row(
                                  children: [
                                    // Custom Red Circular Radio Indicator from your design
                                    Container(
                                      width: 18,
                                      height: 18,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          color: const Color(0xFFFF2D55), // Red boundary line
                                          width: 2,
                                        ),
                                        color: isSelected ? const Color(0xFFFF2D55) : Colors.transparent,
                                      ),
                                      child: isSelected
                                          ? const Icon(Icons.done, size: 10, color: Colors.white)
                                          : null,
                                    ),
                                    const SizedBox(width: 12),
                                    // Text Display matching the style
                                    Text(
                                      item,
                                      style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: isSelected ? FontWeight.bold : FontWeight.w400,
                                        color: isSelected ? const Color(0xFFFF2D55) : const Color(0xFF334155),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }).toList(),
                          );
                        }),
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 14), // Row aur Search bar ke darmiyan exact vertical gap

                // 3. Search by Car Input Field (With Red Border & Custom Height)
                SizedBox(
                  height: 42, // Clean slim input bar height
                  child: TextField(
                    style: const TextStyle(fontSize: 13, color: Colors.black87),
                    cursorColor: const Color(0xFFFF2D55), // Red cursor match
                    decoration: InputDecoration(
                      hintText: 'Search by Car',
                      hintStyle: const TextStyle(
                        color: Color(0xFFA0AEC0), // Perfect light gray hint text
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                      ),
                      fillColor: const Color(0xFFF4F6F8), // Background tint match
                      filled: true,
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),

                      // Default condition border (Thin Pinkish-Red line)
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20), // Fully capsule shaped rounding
                        borderSide: const BorderSide(
                          color: Color(0xFFFF8A9A), // Soft thin red border exact like image_2d5815.png
                          width: 0.8,
                        ),
                      ),

                      // Focus state border (Jab user click kare to dark red ho jaye)
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: const BorderSide(
                          color: Color(0xFFFF2D55),
                          width: 1.2,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Obx(() {
              final currentSelection = controller.selectedChatIndex.value;
              return ListView.separated(
                itemCount: chatUsersData.length,
                padding: EdgeInsets.zero,
                separatorBuilder: (context, index) => const Divider(height: 1, color: Color(0xFFF0F2F5)),
                itemBuilder: (context, index) {
                  bool isSelected = currentSelection == index;
                  var currentItem = chatUsersData[index];
                  return GestureDetector(
                    onTap: () {
                      controller.selectedChatIndex.value = index;
                      Future.delayed(const Duration(milliseconds: 50), () {
                        controller.isChatDetailOpenMobile.value = true;
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      color: isSelected ? const Color(0xFFFF2D55) : Colors.transparent,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                radius: 18,
                                backgroundColor: isSelected ? Colors.white30 : Colors.grey.shade300,
                                child: isSelected
                                    ? const Icon(Icons.person, color: Colors.white)
                                    : Text(currentItem['name']![0], style: TextStyle(fontWeight: FontWeight.bold, color: isSelected ? Colors.white : Colors.black, fontSize: 12)),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(currentItem['name']!, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: isSelected ? Colors.white : Colors.black)),
                                    Text(currentItem['car']!, style: TextStyle(fontSize: 11, color: isSelected ? Colors.white70 : Colors.grey)),
                                  ],
                                ),
                              ),
                              Text(currentItem['time']!, style: TextStyle(fontSize: 10, color: isSelected ? Colors.white70 : Colors.grey)),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              Icon(Icons.done_all, size: 16, color: isSelected ? Colors.white : Colors.blue),
                              const SizedBox(width: 6),
                              Expanded(
                                child: Text(
                                  'Your balance to rent car is insufficient.....',
                                  style: TextStyle(fontSize: 11, color: isSelected ? Colors.white : Colors.grey.shade700),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                              ),
                              if (!isSelected)
                                Container(
                                  padding: const EdgeInsets.all(5),
                                  decoration: const BoxDecoration(color: Color(0xFF00B67A), shape: BoxShape.circle),
                                  child: const Text('2', style: TextStyle(color: Colors.white, fontSize: 9, fontWeight: FontWeight.bold)),
                                )
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }

  // Input field aur overlay ko link karne ke liye global layer link


  Widget _buildChatConversationArea(ReminderController controller, {required bool isMobile, Key? key}) {
    return LayoutBuilder(builder: (context, constraints) {
      bool isCompact = constraints.maxWidth < 450;

      return Container(
        key: key,
        decoration: BoxDecoration(
          color: const Color(0xFFF8FAFC),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(isMobile ? 12 : 0),
            bottomLeft: Radius.circular(isMobile ? 12 : 0),
            topRight: const Radius.circular(12),
            bottomRight: const Radius.circular(12),
          ),
          border: Border.all(color: Colors.grey.shade200),
        ),
        child: Column(
          children: [
            // --- 1. HEADER SECTION ---
            Obx(() {
              int selectedIndex = controller.selectedChatIndex.value;
              var activeUser = chatUsersData[selectedIndex >= chatUsersData.length ? 0 : selectedIndex];
              bool isManualMode = controller.chatMode.value == 'Manual';

              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(topRight: Radius.circular(12)),
                    border: Border(bottom: BorderSide(color: Color(0xFFF0F2F5)))
                ),
                child: Row(
                  children: [
                    if (isMobile) ...[
                      IconButton(
                          icon: const Icon(Icons.arrow_back, color: Colors.black87),
                          onPressed: () => controller.isChatDetailOpenMobile.value = false
                      ),
                      const SizedBox(width: 4),
                    ],
                    CircleAvatar(
                        radius: 20,
                        backgroundColor: Colors.grey.shade200,
                        child: Text(activeUser['name']![0], style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.blueGrey))
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(activeUser['name']!, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black)),
                              Text(activeUser['status']!, style: TextStyle(fontSize: 11, color: activeUser['status'] == 'Online' ? Colors.green : Colors.grey)),
                            ]
                        )
                    ),
                    InkWell(
                      onTap: () => controller.toggleChatMode('Manual'),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                        decoration: BoxDecoration(color: isManualMode ? const Color(0xFFFF2D55) : Colors.transparent, borderRadius: BorderRadius.circular(6), border: Border.all(color: isManualMode ? Colors.transparent : Colors.grey.shade300)),
                        child: Row(children: [Icon(Icons.pan_tool, size: 12, color: isManualMode ? Colors.white : Colors.grey), if (!isCompact) Text(' Manual', style: TextStyle(color: isManualMode ? Colors.white : Colors.grey.shade700, fontSize: 11, fontWeight: FontWeight.w500))]),
                      ),
                    ),
                    const SizedBox(width: 8),
                    InkWell(
                      onTap: () => controller.toggleChatMode('Auto'),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                        decoration: BoxDecoration(color: !isManualMode ? const Color(0xFFFF2D55) : Colors.transparent, borderRadius: BorderRadius.circular(6), border: Border.all(color: !isManualMode ? Colors.transparent : Colors.grey.shade300)),
                        child: Row(children: [Icon(Icons.track_changes_outlined, size: 14, color: !isManualMode ? Colors.white : Colors.grey), const SizedBox(width: 4), Text(isCompact ? 'AI' : 'Auto (AI Alert)', style: TextStyle(color: !isManualMode ? Colors.white : Colors.grey, fontSize: 11, fontWeight: FontWeight.w500))]),
                      ),
                    ),
                  ],
                ),
              );
            }),

            // --- 2. MESSAGES DISPLAY AREA ---
            Expanded(
              child: Container(
                color: const Color(0xFFF8FAFC),
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Obx(() => ListView.builder(
                    itemCount: controller.dynamicMessages.length + 1,
                    itemBuilder: (context, index) {
                      if (index == 0) {
                        return Container(
                            margin: const EdgeInsets.symmetric(vertical: 14),
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20), border: Border.all(color: const Color(0xFFFF8A9A))),
                            child: const Center(child: Text('Rental R1 marked as failed after 3 unsuccessful rent deduction attempts.', style: TextStyle(color: Color(0xFFFF2D55), fontSize: 12)))
                        );
                      }
                      var msg = controller.dynamicMessages[index - 1];
                      return _buildMessageBubble(message: msg['message'], isMe: msg['isMe'], time: msg['time']);
                    }
                )),
              ),
            ),

            // --- 3. EXACT STRUCTURAL BOTTOM AREA ---
            Obx(() {
              bool isManualMode = controller.chatMode.value == 'Manual';
              bool isOpen = controller.isTemplateMenuOpen.value;

              if (!isManualMode) {
                return Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      border: Border(top: BorderSide(color: Color(0xFFF0F2F5)))
                  ),
                  child: const Text(
                      'Auto AI generated reply and alerts to the customer',
                      style: TextStyle(color: Color(0xFFFF2D55), fontSize: 12)
                  ),
                );
              }

              return Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  border: Border(top: BorderSide(color: Color(0xFFF0F2F5))),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // EXACTLY ABOVE THE INPUT BAR (As requested in image_9282ec.png)
                    if (isOpen)
                      Container(
                        height: controller.isCreatingTemplate.value ? 240 : 190,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          border: Border(bottom: BorderSide(color: Color(0xFFF0F2F5))),
                        ),
                        // Handles inner scroll cleanly if layout compresses
                        child: controller.isCreatingTemplate.value
                            ? _buildCreateTemplateForm(controller, isCompact)
                            : _buildTemplateListContent(controller, isCompact),
                      ),

                    // MAIN ACTION INPUT BAR - ALWAYS AT THE VERY BOTTOM
                    Container(
                      padding: EdgeInsets.all(isCompact ? 8 : 12),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (!isCompact)
                            const Text(
                                'Manual - Only you can send messages',
                                style: TextStyle(color: Color(0xFFFF2D55), fontSize: 11, fontWeight: FontWeight.w500)
                            ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              // INTERACTIVE TEMPLATE TOGGLE BUTTON
                              InkWell(
                                onTap: () {
                                  if (!controller.isTemplateMenuOpen.value) {
                                    controller.isCreatingTemplate.value = false;
                                  }
                                  controller.isTemplateMenuOpen.value = !isOpen;
                                },
                                borderRadius: BorderRadius.circular(8),
                                child: Container(
                                  padding: EdgeInsets.symmetric(horizontal: isCompact ? 8 : 12, vertical: 8),
                                  decoration: BoxDecoration(color: const Color(0xFFF4F6F9), borderRadius: BorderRadius.circular(8)),
                                  child: Row(
                                    children: [
                                      const Icon(Icons.assignment_outlined, size: 16, color: Color(0xFFFF2D55)),
                                      const SizedBox(width: 4),
                                      const Text('Template', style: TextStyle(fontSize: 13, color: Colors.black87, fontWeight: FontWeight.w500)),
                                      Icon(isOpen ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down, size: 16, color: Colors.black87),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              const Icon(Icons.attach_file, color: Colors.black87, size: 20),
                              const SizedBox(width: 8),

                              // Message Input Box
                              Flexible(
                                child: SizedBox(
                                  height: 38,
                                  child: TextField(
                                    controller: controller.messageInputController,
                                    decoration: InputDecoration(
                                      hintText: isCompact ? 'Type...' : 'Type your message here...',
                                      contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                                      filled: true,
                                      fillColor: const Color(0xFFF8FAFC),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(20),
                                        borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(20),
                                        borderSide: const BorderSide(color: Color(0xFFFF2D55)),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),

                              // Send Button Action
                              PrimaryBtnReminder(
                                text: isCompact ? '' : 'Send',
                                height: 38,
                                width: isCompact ? 40 : 95,
                                borderRadius: BorderRadius.circular(8),
                                icon: const Icon(Icons.send_outlined, color: Colors.white, size: 18),
                                onTap: () => controller.sendMessage(),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }),
          ],
        ),
      );
    });
  }

  Widget _buildTemplateListContent(ReminderController controller, bool isCompact) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Header Section
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('All templates', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black)),
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(color: const Color(0xFFF1F5F9), borderRadius: BorderRadius.circular(12)),
                    child: Text('${controller.templatesList.length}', style: const TextStyle(fontSize: 11, color: Colors.grey, fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
              PrimaryBtnReminder(
                text: isCompact ? 'Add' : 'Add New Template',
                height: 34,
                width: isCompact ? 65 : 200,
                borderRadius: BorderRadius.circular(6),
                icon: const Icon(Icons.add, color: Colors.white, size: 14),
                onTap: () {
                  controller.isCreatingTemplate.value = true;
                },
              ),
            ],
          ),
        ),
        const Divider(height: 1, color: Color(0xFFF0F2F5)),

        // Scrollable List Content
        Expanded(
          child: ListView.separated(
            padding: EdgeInsets.zero,
            physics: const AlwaysScrollableScrollPhysics(), // Ensures clean inner scrolling
            itemCount: controller.templatesList.length,
            separatorBuilder: (context, idx) => const Divider(height: 1, color: Color(0xFFF0F2F5)),
            itemBuilder: (context, idx) {
              var item = controller.templatesList[idx];
              return InkWell(
                onTap: () => controller.selectTemplate(item['body']!),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(item['title']!, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Colors.black)),
                            const SizedBox(height: 4),
                            Text(item['body']!, style: const TextStyle(fontSize: 12, color: Colors.grey, height: 1.3)),
                          ],
                        ),
                      ),
                      const SizedBox(width: 12),
                      IconButton(
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                        icon: Icon(Icons.delete_outline_outlined, color: const Color(0xFFFF2D55).withOpacity(0.8), size: 18),
                        onPressed: () => controller.deleteTemplate(idx),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildCreateTemplateForm(ReminderController controller, bool isCompact) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // --- 1. HEADER SECTION (Bina buttons ke - Exact image_87265a.png jaisa) ---
        Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0, bottom: 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                  'Create Template',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black)
              ),
              const SizedBox(height: 2),
              Text(
                'You can create New Template here', // Exact subtitle placeholder from screenshot
                style: TextStyle(fontSize: 12, color: Colors.grey.shade400),
              ),
            ],
          ),
        ),

        // --- 2. SCROLLABLE CONTENT AREA (Fields + Bottom Row Buttons) ---
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            physics: const ClampingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title Field
                const Text('Title', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Color(0xFF4A5568))),
                const SizedBox(height: 6),
                SizedBox(
                  height: 40,
                  child: TextField(
                    controller: controller.titleController,
                    style: const TextStyle(fontSize: 14),
                    decoration: InputDecoration(
                      hintText: 'Enter Title',
                      hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 13),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      filled: true,
                      fillColor: Colors.white,
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: Colors.grey.shade300)
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(color: Color(0xFFFF2D55))
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 14),

                // Description Field
                const Text('Description', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Color(0xFF4A5568))),
                const SizedBox(height: 6),
                TextField(
                  controller: controller.descriptionController,
                  maxLines: 2,
                  style: const TextStyle(fontSize: 14),
                  decoration: InputDecoration(
                    hintText: 'Enter Description',
                    hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 13),
                    contentPadding: const EdgeInsets.all(12),
                    filled: true,
                    fillColor: Colors.white,
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: Colors.grey.shade300)
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(color: Color(0xFFFF2D55))
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // --- 3. BOTTOM BUTTONS ROW (Shifted down right side - Exact image_87265a.png) ---
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    // Cancel Button (Black Rounded Background)
                    InkWell(
                      onTap: () => controller.isCreatingTemplate.value = false,
                      borderRadius: BorderRadius.circular(6),
                      child: Container(
                        height: 34,
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        decoration: BoxDecoration(
                          color: const Color(0xFF1A1A1A), // Dark Black background
                          borderRadius: BorderRadius.circular(6),
                        ),
                        alignment: Alignment.center,
                        child: const Text(
                            'Cancel',
                            style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w500)
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),

                    // Save Button (Pink/Red Background)
                    PrimaryBtnReminder(
                      text: 'Save',
                      height: 34,
                      width: 65,
                      borderRadius: BorderRadius.circular(6),
                      onTap: () => controller.addNewTemplate(),
                    ),
                  ],
                ),
                const SizedBox(height: 16), // Padding bottom for safe scrolling
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget _buildMessageBubble({required String message, required bool isMe, required String time}) {
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 250),
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 6),
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          decoration: BoxDecoration(
            color: isMe ? Colors.white : AppColors.backgroundOfPickupsWidget,
            borderRadius: BorderRadius.only(
              topLeft: const Radius.circular(16),
              topRight: const Radius.circular(16),
              bottomLeft: isMe ? const Radius.circular(16) : Radius.zero,
              bottomRight: isMe ? Radius.zero : const Radius.circular(16),
            ),
            // Light shadow for depth
            boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 4, offset: const Offset(0, 2))],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                message,
                style: TextStyle(
                  color: isMe ? Colors.black : Colors.black87,
                  fontSize: 13,
                  height: 1.4, // Line height for better readability
                ),
              ),
              const SizedBox(height: 4),
              Text(
                time,
                style: TextStyle(
                  color: isMe ? Colors.white70 : Colors.grey,
                  fontSize: 9,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildResponsiveHeader(ReminderController controller) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // 450px se kam width ko "Mobile" maana jayega
        bool isMobile = constraints.maxWidth < 450;

        return isMobile
            ? Column( // Mobile par Vertical layout
          children: [

            Padding(padding : EdgeInsets.only(left: 140),child: _buildProgressSection()),
            const SizedBox(height: 12),
            SizedBox(width: double.infinity, child: _buildAlertButtons(controller)),
          ],
        )
            : Row( // Web/Desktop par Horizontal layout
          children: [
            _buildProgressSection(),
            const SizedBox(width: 16),
            Expanded(child: _buildAlertButtons(controller)),
          ],
        );
      },
    );
  }

  Widget _buildProgressSection() {
    return SizedBox(
      width: 160,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('Monthly Messages', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Colors.black)),
          const SizedBox(height: 4),
          Container(
            height: 14,
            width: double.infinity,
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(7)),
            alignment: Alignment.centerLeft,
            child: FractionallySizedBox(
              widthFactor: 5 / 25,
              child: Container(decoration: BoxDecoration(color: const Color(0xFFFF2D55), borderRadius: BorderRadius.circular(7))),
            ),
          ),
          const SizedBox(height: 2),
          const Text('5 out of 25 messages', style: TextStyle(fontSize: 10, color: Colors.grey)),
        ],
      ),
    );
  }

  Widget _buildAlertButtons(ReminderController controller) {
    return Obx(() {
      bool isWhatsappSelected = controller.selectedAlertType.value == 'whatsapp';
      bool isSmsSelected = controller.selectedAlertType.value == 'sms';

      return Row(
        children: [
          // Whatsapp Alert Button
          Flexible( // <--- Expanded ki jagah Flexible
            child: GestureDetector(
              onTap: () => controller.selectedAlertType.value = 'whatsapp',
              child: Container(
                height: 36,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: isWhatsappSelected ? const Color(0xFFFF2D55) : Colors.transparent,
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: isWhatsappSelected ? const Color(0xFFFF2D55) : const Color(0xFFB0B3C6)),
                ),
                child: const FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: Text('Whatsapp Alert', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500)),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),

          // Sms Alert Button
          Flexible( // <--- Expanded ki jagah Flexible
            child: GestureDetector(
              onTap: () => controller.selectedAlertType.value = 'sms',
              child: Container(
                height: 36,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: isSmsSelected ? const Color(0xFFFF2D55) : Colors.white,
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: isSmsSelected ? const Color(0xFFFF2D55) : const Color(0xFFB0B3C6)),
                ),
                child: const FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: Text('Sms Alert', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500)),
                  ),
                ),
              ),
            ),
          ),
        ],
      );
    });
  }


}
