import 'package:car_rental_project/Portal/Vendor/Reminder/ReminderController.dart';
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
                    Flexible( // Flexible use kiya taake screen choti hone par shrink ho sake
                      child: Container(
                        height: 40,
                        constraints: const BoxConstraints(
                          minWidth: 100, // Choti screen par minimum itna squeeze ho sake
                          maxWidth: 160, // Web panel par is se zyada lamba na ho
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF4F6F8),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: const Color(0xFFE2E8F0), width: 1),
                        ),
                        child: InkWell(
                          onTap: () {},
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.calendar_today_outlined, size: 14, color: Color(0xFF4A5568)),
                              SizedBox(width: 6),
                              Flexible( // Text overflow block karne ke liye
                                child: Text(
                                  'Select Date',
                                  style: TextStyle(color: Color(0xFF4A5568), fontSize: 12, fontWeight: FontWeight.w400),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8), // Perfect gap dono ke darmiyan

                    // 2. Dropdown Filter Button ('All')
                    Flexible(
                      child: Container(
                        height: 40,
                        constraints: const BoxConstraints(
                          minWidth: 70,  // Minimum width limit
                          maxWidth: 100, // Web par dropdown ko zyada lamba nahi hone dega
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF4F6F8),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: const Color(0xFFE2E8F0), width: 1),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: 'All',
                            isDense: true,
                            isExpanded: true, // Internal space stretch karega layout ko hilaye bina
                            icon: const Icon(Icons.keyboard_arrow_down, size: 18, color: Color(0xFF4A5568)),
                            style: const TextStyle(color: Color(0xFF4A5568), fontSize: 12, fontWeight: FontWeight.w400),
                            items: <String>['All'].map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value, overflow: TextOverflow.ellipsis),
                              );
                            }).toList(),
                            onChanged: (newValue) {},
                          ),
                        ),
                      ),
                    ),
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
            // --- HEADER ---
            Obx(() {
              int selectedIndex = controller.selectedChatIndex.value;
              var activeUser = chatUsersData[selectedIndex >= chatUsersData.length ? 0 : selectedIndex];

              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.only(topRight: Radius.circular(12)), border: Border(bottom: BorderSide(color: Color(0xFFF0F2F5)))),
                child: Row(
                  children: [
                    if (isMobile) ...[
                      IconButton(icon: const Icon(Icons.arrow_back, color: Colors.black87), onPressed: () => controller.isChatDetailOpenMobile.value = false),
                      const SizedBox(width: 4),
                    ],
                    CircleAvatar(radius: 20, backgroundColor: Colors.grey.shade200, child: Text(activeUser['name']![0], style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.blueGrey))),
                    const SizedBox(width: 12),
                    Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Text(activeUser['name']!, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black)),
                      Text(activeUser['status']!, style: TextStyle(fontSize: 11, color: activeUser['status'] == 'Online' ? Colors.green : Colors.grey)),
                    ])),
                    // Manual Badge
                    Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6), decoration: BoxDecoration(color: const Color(0xFFFF2D55), borderRadius: BorderRadius.circular(6)),
                      child: Row(children: [const Icon(Icons.pan_tool, size: 12, color: Colors.white), if (!isCompact) const Text(' Manual(Human Only)', style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w500))]),
                    ),
                    const SizedBox(width: 8),
                    // Auto Badge
                    Row(children: [const Icon(Icons.grid_3x3, size: 14, color: Colors.grey), if (!isCompact) const Text(' Auto', style: TextStyle(color: Colors.grey, fontSize: 11))]),
                  ],
                ),
              );
            }),

            // --- MESSAGES ---
            Expanded(child: Container(color: const Color(0xFFF8FAFC), padding: const EdgeInsets.symmetric(horizontal: 16), child: Obx(() => ListView.builder(
                itemCount: controller.dynamicMessages.length + 1,
                itemBuilder: (context, index) {
                  if (index == 0) return Container(margin: const EdgeInsets.symmetric(vertical: 14), padding: const EdgeInsets.all(10), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20), border: Border.all(color: const Color(0xFFFF8A9A))), child: const Center(child: Text('Rental R1 marked as failed.', style: TextStyle(color: Color(0xFFFF2D55), fontSize: 12))));
                  var msg = controller.dynamicMessages[index - 1];
                  return _buildMessageBubble(message: msg['message'], isMe: msg['isMe'], time: msg['time']);
                })))),

            // --- BOTTOM INPUT BAR (Responsive Fix) ---
            Container(
              padding: EdgeInsets.all(isCompact ? 8 : 12), // Compact mein padding kam
              decoration: const BoxDecoration(
                  color: Colors.white,
                  border: Border(top: BorderSide(color: Color(0xFFF0F2F5)))
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (!isCompact) const Text('Manual - Only you can send messages', style: TextStyle(color: Color(0xFFFF2D55), fontSize: 11, fontWeight: FontWeight.w500)),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      // 1. Template Button (Compact mein sirf icon)
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: isCompact ? 6 : 12, vertical: 8),
                        decoration: BoxDecoration(color: const Color(0xFFF4F6F9), borderRadius: BorderRadius.circular(8)),
                        child: Row(
                          children: [
                            const Icon(Icons.assignment_outlined, size: 16, color: Color(0xFFFF2D55)),
                            if (!isCompact) ...[
                              const SizedBox(width: 6),
                              const Text('Template', style: TextStyle(fontSize: 13, color: Colors.black87, fontWeight: FontWeight.w500)),
                              const Icon(Icons.keyboard_arrow_down, size: 16, color: Colors.black87),
                            ],
                          ],
                        ),
                      ),
                        const SizedBox(width: 8),
                        const Icon(Icons.attach_file, color: Colors.black87, size: 20),


                      const SizedBox(width: 8),

                      // TextField ko isi tarah set karo
                      Flexible(
                        child: SizedBox(
                          height: 38,
                          width:isCompact ?  180 : double.infinity,
                          child: TextField(
                            controller: controller.messageInputController,
                            decoration: InputDecoration(
                              // choti screen par hint chota kar dein taake overflow na ho
                              hintText: isCompact ? 'Type' : 'Type your message here',
                              contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                              filled: true,
                              fillColor: Colors.white,
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
                              ),
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(width: 8),

                      PrimaryBtnReminder(
                        text: isCompact ? '' : 'Send',
                        height: 38,
                        width: isCompact ? 60 : 95,
                        borderRadius: BorderRadius.circular(8),
                        icon: const Icon(Icons.send_outlined, color: Colors.white, size: 18),
                        onTap: () => controller.sendMessage(),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ]
            )
      );
    });
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
