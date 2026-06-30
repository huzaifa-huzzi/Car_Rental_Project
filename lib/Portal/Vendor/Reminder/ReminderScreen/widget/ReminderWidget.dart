import 'package:car_rental_project/Portal/Vendor/Reminder/ReminderController.dart';
import 'package:car_rental_project/Portal/Vendor/Reminder/ReusableWidgetOfReminder/CustomCalendarReminder.dart';
import 'package:car_rental_project/Portal/Vendor/Reminder/ReusableWidgetOfReminder/PrimaryBtnOfReminder.dart';
import 'package:car_rental_project/Resources/Colors.dart';
import 'package:car_rental_project/Resources/IconStrings.dart';
import 'package:car_rental_project/Resources/ImageString.dart';
import 'package:car_rental_project/Resources/TextString.dart';
import 'package:car_rental_project/Resources/TextTheme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';



class ReminderWidget extends StatelessWidget {
  const ReminderWidget({super.key});

  static const List<Map<String, String>> chatUsersData = [
    {
      'name': 'Jack Milson',
      'car': 'RNG-1188 Range Rover Velar',
      'time': '24hrs ago',
      'status': 'Online',
    },
    {
      'name': 'Andrew Myres',
      'car': 'AWG-4432 Honda Civic',
      'time': '24hrs ago',
      'status': 'Offline',
    },
    {
      'name': 'Ethan Miles',
      'car': 'KWC-2343 Kia Sportage',
      'time': '24hrs ago',
      'status': 'Online',
    },
    {
      'name': 'Jhon Doe',
      'car': 'RNG-1188 Range Rover Velar',
      'time': '24hrs ago',
      'status': 'Offline',
    },
    {
      'name': 'Andrew Graified',
      'car': 'RNG-1188 Range Rover Velar',
      'time': '24hrs ago',
      'status': 'Online',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final ReminderController controller = Get.put(ReminderController());

    final double screenWidth = MediaQuery.of(context).size.width;
    final bool isMobileLayout = screenWidth < 850;

    return Container(
      margin: const EdgeInsets.only(top: 10),
      child: Column(
        children: [
          _buildTopActionBar(context, controller),
          const SizedBox(height: 16),

          Expanded(
            child: isMobileLayout
                ? _buildMobileLayout(context, controller)
                : _buildWebLayout(context, controller),
          ),
        ],
      ),
    );
  }
}

/// ---------- Extra Widget --------- ///

// Web layout
Widget _buildWebLayout(BuildContext context,ReminderController controller) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(width: 320, child: _buildChatList(context,controller)),
      Expanded(child: _buildChatConversationArea(controller, isMobile: false)),
    ],
  );
}

// Mobile layout
Widget _buildMobileLayout(BuildContext context,ReminderController controller) {
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
          : _buildChatList(context,controller, key: const ValueKey('chat_list')),
    );
  });
}

// Top Action bar
Widget _buildTopActionBar(BuildContext context, ReminderController controller) {
  return Obx(() {
    bool isSmsSelected = controller.selectedAlertType.value == 'sms';

    return Align(
      alignment: isSmsSelected ? Alignment.topCenter : Alignment.topRight,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 2.0),
        decoration: BoxDecoration(
          color: isSmsSelected ? Colors.transparent : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
        ),
        constraints: BoxConstraints(
          maxWidth: isSmsSelected ? MediaQuery.of(context).size.width : 600,
        ),
        child: isSmsSelected
            ? _buildResponsiveHeader(context, controller)
            : Wrap(
          spacing: 16.0,
          runSpacing: 12.0,
          alignment: WrapAlignment.end,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            _buildResponsiveHeader(context, controller),
          ],
        ),
      ),
    );
  });
}

Widget _buildResponsiveHeader(BuildContext context, ReminderController controller) {
  return Obx(() {
    bool isSmsSelected = controller.selectedAlertType.value == 'sms';

    return Container(
      width: double.infinity,
      padding: isSmsSelected
          ? const EdgeInsets.symmetric(horizontal: 10, vertical: 12)
          : EdgeInsets.zero,
      decoration: BoxDecoration(
        color: isSmsSelected ? Colors.white : Colors.transparent,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isSmsSelected ? AppColors.signaturePadColor : Colors.transparent,
        ),
        boxShadow: isSmsSelected
            ? [
          BoxShadow(
            color: AppColors.blackColor.withValues(alpha: 0.02),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ]
            : [],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Flexible(
            flex: 3,
            child: _buildProgressSection(context, isSmsSelected),
          ),
          const SizedBox(width: 4),
          Flexible(
            flex: 4,
            child: _buildAlertButtons(context, controller),
          ),
        ],
      ),
    );
  });
}

Widget _buildProgressSection(BuildContext context, bool isSmsSelected) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        TextString.reminderOne,
        style: TTextTheme.bodySemiBold14black(context),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      const SizedBox(height: 4),
      Container(
        height: 12,
        constraints: BoxConstraints(maxWidth: isSmsSelected ? 250 : 160),
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppColors.signaturePadColor,
          borderRadius: BorderRadius.circular(6),
        ),
        alignment: Alignment.centerLeft,
        child: FractionallySizedBox(
          widthFactor: 5 / 25,
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.primaryColor,
              borderRadius: BorderRadius.circular(6),
            ),
          ),
        ),
      ),
      const SizedBox(height: 2),
      Text(
        TextString.reminderTwo,
        style: TTextTheme.bodyRegular12Gay10(context),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    ],
  );
}

Widget _buildAlertButtons(BuildContext context, ReminderController controller) {
  return Obx(() {
    bool isWhatsappSelected = controller.selectedAlertType.value == 'whatsapp';
    bool isSmsSelected = controller.selectedAlertType.value == 'sms';

    const double desktopButtonWidth = 100;
    const double mobileMinWidth     = 70;

    bool useFlexLayout = MediaQuery.of(context).size.width < 500;

    Widget buildSingleButton({
      required String label,
      required bool isSelected,
      required VoidCallback onTap,
    }) {
      Widget buttonBody = Container(
        height: 34,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primaryColor : Colors.white,
          borderRadius: BorderRadius.circular(6),
          border: Border.all(
            color: isSelected ? Colors.transparent : AppColors.secondTextColor,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              label,
              style: isSelected ? TTextTheme.btnWhiteColor(context) : TTextTheme.btnTwo(context),
            ),
          ),
        ),
      );

      return useFlexLayout
          ? Expanded(
        child: ConstrainedBox(
          constraints: const BoxConstraints(minWidth: mobileMinWidth, maxWidth: desktopButtonWidth),
          child: GestureDetector(onTap: onTap, child: buttonBody),
        ),
      )
          : SizedBox(
        width: desktopButtonWidth,
        child: GestureDetector(onTap: onTap, child: buttonBody),
      );
    }

    return Row(
      mainAxisSize: useFlexLayout ? MainAxisSize.max : MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        buildSingleButton(
          label: TextString.reminderThree,
          isSelected: isWhatsappSelected,
          onTap: () => controller.selectedAlertType.value = 'whatsapp',
        ),
        const SizedBox(width: 6),
        buildSingleButton(
          label:TextString.reminderFour ,
          isSelected: isSmsSelected,
          onTap: () => controller.selectedAlertType.value = 'sms',
        ),
      ],
    );
  });
}

// chatlist Widget
Widget _buildChatList(BuildContext context,ReminderController controller, {Key? key}) {
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
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [

                  Flexible(
                    child: Container(
                      height: 40,
                      constraints: const BoxConstraints(
                        minWidth: 100,
                        maxWidth: 160,
                      ),
                      child: Obx(() {
                        String dateDisplay = controller.selectedDateText.value;

                        return PopupMenuButton<void>(
                          padding: EdgeInsets.zero,
                          elevation: 0,
                          offset: const Offset(0, 44),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          color: Colors.transparent,

                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            decoration: BoxDecoration(
                              color: AppColors.signaturePadColor,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: AppColors.unavailableEnd, width: 1),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Image.asset(
                                  IconString.calendarIcon,
                                  height: 14,
                                  width: 14,
                                ),
                                const SizedBox(width: 6),
                                Flexible(
                                  child: Text(
                                    dateDisplay,
                                    style: TTextTheme.titleSix(context),
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
                                enabled: false,
                                padding: EdgeInsets.zero,
                                child: CustomCalendarReminder(
                                  width: 290,
                                  onDateSelected: (DateTime startOfWeek) {
                                    DateTime endOfWeek = startOfWeek.add(const Duration(days: 6));

                                    String startMonth = controller.getMonthName(startOfWeek.month);
                                    String endMonth = controller.getMonthName(endOfWeek.month);
                                    String startYear = startOfWeek.year.toString().substring(2);
                                    String endYear = endOfWeek.year.toString().substring(2);
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
                  const SizedBox(width: 8),
                  Flexible(
                    child: Container(
                      height: 40,
                      constraints: const BoxConstraints(
                        minWidth: 70,
                        maxWidth: 110,
                      ),
                      child: Obx(() {
                        String currentSelection = controller.selectedFilter.value;
                        bool isOpen = controller.isDropdownOpen.value;

                        List<String> statusItems = ['All', 'Pending', 'Overdue', 'Failed', 'Completed'];

                        return PopupMenuButton<String>(
                          constraints: const BoxConstraints(
                            minWidth: 140,
                            maxHeight: 250,
                          ),
                          offset: const Offset(0, 42),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          color: Colors.white,
                          elevation: 4,
                          onOpened: () => controller.isDropdownOpen.value = true,
                          onCanceled: () => controller.isDropdownOpen.value = false,
                          onSelected: (val) {
                            controller.selectedFilter.value = val;
                            controller.isDropdownOpen.value = false;
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            decoration: BoxDecoration(
                              color: AppColors.signaturePadColor,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color:  AppColors.unavailableEnd, width: 1),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    currentSelection,
                                    style: TTextTheme.titleUpperHeading(context),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                const SizedBox(width: 4),
                                Icon(
                                  isOpen ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                                  size: 18,
                                  color: AppColors.secondTextColor,
                                ),
                              ],
                            ),
                          ),
                          itemBuilder: (context) => statusItems.map((item) {
                            bool isSelected = currentSelection == item;
                            return PopupMenuItem<String>(
                              value: item,
                              height: 38,
                              child: Row(
                                children: [
                                  Container(
                                    width: 18,
                                    height: 18,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color:AppColors.primaryColor,
                                        width: 2,
                                      ),
                                      color: isSelected ? AppColors.primaryColor : Colors.transparent,
                                    ),
                                    child: isSelected
                                        ? const Icon(Icons.done, size: 10, color: Colors.white)
                                        : null,
                                  ),
                                  const SizedBox(width: 12),
                                  Text(
                                    item,
                                    style: TTextTheme.titleseven(context),
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
              const SizedBox(height: 14),

              SizedBox(
                height: 42,
                child: Obx(() {
                  bool isSms = controller.selectedAlertType.value == 'sms';
                  return TextField(
                    style: TTextTheme.insidetextfieldWrittenText(context),
                    cursorColor:AppColors.textColor,
                    decoration: InputDecoration(
                      hintText: isSms ?  TextString.reminderFive:TextString.reminderSix ,
                      hintStyle: TTextTheme.titleinputTextField(context),
                      fillColor: AppColors.signaturePadColor,
                      filled: true,
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: const BorderSide(
                          color: AppColors.primaryColor,
                          width: 0.4,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: const BorderSide(
                          color: AppColors.primaryColor,
                          width: 0.2,
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ],
          ),
        ),
        Expanded(
          child: Obx(() {
            final currentSelection = controller.selectedChatIndex.value;
            return ListView.separated(
              itemCount: ReminderWidget.chatUsersData.length,
              padding: EdgeInsets.zero,
              separatorBuilder: (context, index) => const Divider(height: 0.7, color: AppColors.unavailableEnd),
              itemBuilder: (context, index) {
                bool isSelected = currentSelection == index;
                var currentItem = ReminderWidget.chatUsersData[index];
                return GestureDetector(
                  onTap: () {
                    controller.selectedChatIndex.value = index;
                    Future.delayed(const Duration(milliseconds: 50), () {
                      controller.isChatDetailOpenMobile.value = true;
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    color: isSelected ? AppColors.primaryColor : AppColors.signaturePadColor,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 18,
                              backgroundImage: AssetImage(ImageString.customerUser),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(currentItem['name']!, style: isSelected ?TTextTheme.medium14White(context) : TTextTheme.medium14black(context) ),
                                  Text(currentItem['car']!, style:isSelected? TTextTheme.tableRegular14Signature(context) : TTextTheme.tableRegular14Unavailable(context)),
                                ],
                              ),
                            ),
                            Text(currentItem['time']!, style:isSelected ? TTextTheme.titleeight(context) :TTextTheme.bodyRegular12black(context)),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Icon(Icons.done_all, size: 16, color: isSelected ? Colors.white : AppColors.fourBackground),
                            const SizedBox(width: 6),
                            Expanded(
                              child: Text(
                                TextString.reminderSeven,
                                style: isSelected ? TTextTheme.btnWhiteColor(context) : TTextTheme.tableRegular14black(context),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                            ),
                            if (!isSelected)
                              Container(
                                padding:  EdgeInsets.all(5),
                                decoration: BoxDecoration(color: AppColors.activeColor2, shape: BoxShape.circle),
                                child:  Text('2', style: TTextTheme.btnWhiteColor(context)),
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

// conversation Area

Widget _buildChatConversationArea(ReminderController controller, {required bool isMobile, Key? key}) {
  return LayoutBuilder(builder: (context, constraints) {
    bool isCompact = constraints.maxWidth < 450;

    return Container(
      key: key,
      decoration: BoxDecoration(
        color: AppColors.signaturePadColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(isMobile ? 12 : 0),
          bottomLeft: Radius.circular(isMobile ? 12 : 0),
          topRight: const Radius.circular(12),
          bottomRight: const Radius.circular(12),
        ),
        border: Border.all(color: AppColors.conversationAreaColors),
      ),
      child: Column(
        children: [
          Obx(() {
            int selectedIndex = controller.selectedChatIndex.value;
            var activeUser = ReminderWidget.chatUsersData[selectedIndex >= ReminderWidget.chatUsersData.length ? 0 : selectedIndex];
            bool isManualMode = controller.chatMode.value == 'Manual';

            TextStyle statusStyle;
            if (activeUser['status'] == 'Offline') {
              statusStyle = TTextTheme.tableRegular14Primary(context);
            } else {
              statusStyle = TTextTheme.tableRegular14Completed(context);
            }

            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(topRight: Radius.circular(12)),
                  border: Border(bottom: BorderSide(color: AppColors.conversationAreaColors))
              ),
              child: Row(
                children: [
                  if (isMobile) ...[
                    IconButton(
                        icon: const Icon(Icons.arrow_back, color: AppColors.secondTextColor),
                        onPressed: () => controller.isChatDetailOpenMobile.value = false
                    ),
                    const SizedBox(width: 4),
                  ],
                  CircleAvatar(
                    radius: 22,
                    backgroundImage:AssetImage(ImageString.customerUser),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(activeUser['name']!, style: TTextTheme.medium14black(context)),
                            Text(activeUser['status']!, style: statusStyle),
                          ]
                      )
                  ),
                  InkWell(
                    onTap: () => controller.toggleChatMode('Manual'),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                      decoration: BoxDecoration(color: isManualMode ? AppColors.primaryColor : Colors.transparent, borderRadius: BorderRadius.circular(6)),
                      child: Row(children: [Image.asset(IconString.manualIcon, height: 16,width: 16, color: isManualMode ? Colors.white : AppColors.unavailableEnd), if (!isCompact) Text(' Manual (Human Only)', style: isManualMode ? TTextTheme.medium14White(context) : TTextTheme.tableRegular14(context) )]),
                    ),
                  ),
                  const SizedBox(width: 8),
                  InkWell(
                    onTap: () => controller.toggleChatMode('Auto'),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                      decoration: BoxDecoration(color: !isManualMode ? AppColors.primaryColor: Colors.transparent, borderRadius: BorderRadius.circular(6),),
                      child: Row(children: [Image.asset(IconString.autoIcon, height: 14,width: 14, color: !isManualMode ? Colors.white : Colors.grey), const SizedBox(width: 4), Text(isCompact ? 'AI' : 'Auto', style: !isManualMode ? TTextTheme.medium14White(context) : TTextTheme.tableRegular14(context) )]),
                    ),
                  ),
                ],
              ),
            );
          }),
          Expanded(
            child: Container(
              color: AppColors.backgroundOfScreenColor,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Obx(() => ListView.builder(
                  itemCount: controller.dynamicMessages.length + 1,
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      return Container(
                          margin: const EdgeInsets.symmetric(vertical: 14),
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20), border: Border.all(color: AppColors.primaryColor)),
                          child: Center(child: Text(TextString.reminderEight, style: TTextTheme.medium14Primary(context)))
                      );
                    }
                    var msg = controller.dynamicMessages[index - 1];
                    return _buildMessageBubble(context,message: msg['message'], isMe: msg['isMe'], time: msg['time']);
                  }
              )),
            ),
          ),
          Obx(() {
            bool isManualMode = controller.chatMode.value == 'Manual';
            bool isOpen = controller.isTemplateMenuOpen.value;
            bool isSmsSelected = controller.selectedAlertType.value == 'sms';

            if (!isManualMode) {
              return Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                decoration: const BoxDecoration(
                    color: Colors.white,
                    border: Border(top: BorderSide(color: AppColors.signaturePadColor))
                ),
                child:  Text(
                    isSmsSelected
                        ? TextString.reminderNine
                        : TextString.reminderNine,
                    style: TTextTheme.medium12Primary(context)
                ),
              );
            }

            return Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                border: Border(top: BorderSide(color: AppColors.signaturePadColor)),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (isOpen)
                    Container(
                      height: controller.isCreatingTemplate.value ? 240 : 190,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        border: Border(bottom: BorderSide(color: AppColors.signaturePadColor)),
                      ),
                      child: controller.isCreatingTemplate.value
                          ? _buildCreateTemplateForm(context,controller, isCompact)
                          : _buildTemplateListContent(context,controller, isCompact),
                    ),
                  Container(
                    padding: EdgeInsets.all(isCompact ? 8 : 12),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (!isCompact)
                          Text(
                              TextString.reminderTen,
                              style: TTextTheme.medium12Primary(context)
                          ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
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
                                decoration: BoxDecoration(color: AppColors.signaturePadColor, borderRadius: BorderRadius.circular(8)),
                                child: Row(
                                  children: [
                                    Image.asset(IconString.templateIcon, height: 16,width: 16),
                                    const SizedBox(width: 4),
                                    Text(TextString.reminderEleven, style: TTextTheme.medium12(context)),
                                    Icon(isOpen ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down, size: 16, color: AppColors.textColor),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Image.asset(IconString.linkIcon, color: AppColors.textColor,width: 20,height: 20,),
                            const SizedBox(width: 8),
                            Flexible(
                              child: SizedBox(
                                height: 38,
                                child: TextField(
                                  cursorColor: AppColors.primaryColor,
                                  controller: controller.messageInputController,
                                  decoration: InputDecoration(
                                    hintText: isCompact ? 'Type...' : 'Type your message here...',
                                    contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                                    filled: true,
                                    fillColor: AppColors.signaturePadColor,
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                      borderSide:  BorderSide(color: AppColors.quadrantalTextColor.withValues(alpha: 0.7)),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                      borderSide:  BorderSide(color: AppColors.primaryColor),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            PrimaryBtnReminder(
                              text: isCompact ? '' : 'Send',
                              height: 38,
                              width: isCompact ? 65 : 95,
                              borderRadius: BorderRadius.circular(8),
                              icon: Image.asset(IconString.sendIcon, width: 18,height: 18,),
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

Widget _buildTemplateListContent(BuildContext context,ReminderController controller, bool isCompact) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(TextString.reminderTwelve, style: TTextTheme.PickupPayment(context)),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(color: AppColors.signaturePadColor, borderRadius: BorderRadius.circular(12)),
                  child: Text('${controller.templatesList.length}', style: TTextTheme.medium12(context)),
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
      Divider(height: 1, color: AppColors.blackColor),
      Expanded(
        child: ListView.separated(
          padding: EdgeInsets.zero,
          physics: const AlwaysScrollableScrollPhysics(),
          itemCount: controller.templatesList.length,
          separatorBuilder: (context, idx) => const Divider(height: 1, color: AppColors.unavailableEnd),
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
                          Text(item['title']!, style: TTextTheme.medium16(context)),
                          const SizedBox(height: 4),
                          Text(item['body']!, style: TTextTheme.CalendarSubtitle(context)),
                        ],
                      ),
                    ),
                    const SizedBox(width: 12),
                    IconButton(
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                      icon: Image.asset(IconString.deleteIcon, color: AppColors.primaryColor, width: 18,height: 18,),
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

Widget _buildCreateTemplateForm(BuildContext context,ReminderController controller, bool isCompact) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      Padding(
        padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0, bottom: 12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
                TextString.reminderTwelve,
                style: TTextTheme.PickupPayment(context)
            ),
            const SizedBox(height: 2),
            Text(
              TextString.reminderThirteen,
              style: TTextTheme.btncustomer(context),
            ),
          ],
        ),
      ),
      Expanded(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          physics: const ClampingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(TextString.reminder14, style: TTextTheme.CalendarSubtitle(context)),
              const SizedBox(height: 6),
              SizedBox(
                height: 40,
                child: TextField(
                  cursorColor: AppColors.blackColor,
                  controller: controller.titleController,
                  style: TTextTheme.titleTwo(context),
                  decoration: InputDecoration(
                    hintText:TextString.reminder15,
                    hintStyle: TTextTheme.bodyRegular16(context),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    filled: true,
                    fillColor: Colors.white,
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: AppColors.quadrantalTextColor.withValues(alpha: 0.7))
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide:  BorderSide(color: AppColors.primaryColor)
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 14),
              Text(TextString.reminder16, style: TTextTheme.CalendarSubtitle(context)),
              const SizedBox(height: 6),
              TextField(
                cursorColor: AppColors.blackColor,
                controller: controller.descriptionController,
                maxLines: 2,
                style:TTextTheme.titleTwo(context),
                decoration: InputDecoration(
                  hintText: TextString.reminder17,
                  hintStyle: TTextTheme.bodyRegular16(context),
                  contentPadding: const EdgeInsets.all(12),
                  filled: true,
                  fillColor: Colors.white,
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color:  AppColors.quadrantalTextColor.withValues(alpha: 0.7))
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide:  BorderSide(color:AppColors.primaryColor )
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  InkWell(
                    onTap: () => controller.isCreatingTemplate.value = false,
                    borderRadius: BorderRadius.circular(6),
                    child: Container(
                      height: 34,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        color: AppColors.secondTextColor,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      alignment: Alignment.center,
                      child:  Text(
                        TextString.reminder18,
                        style: TTextTheme.btnSave(context),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  PrimaryBtnReminder(
                    text: TextString.reminder19,
                    height: 34,
                    width: 65,
                    borderRadius: BorderRadius.circular(6),
                    onTap: () => controller.addNewTemplate(),
                  ),
                ],
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      )
    ],
  );
}

Widget _buildMessageBubble(BuildContext context,{required String message, required bool isMe, required String time}) {
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
          boxShadow: [BoxShadow(color: AppColors.blackColor.withValues(alpha: 0.05), blurRadius: 4, offset: const Offset(0, 2))],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
                message,
                style: TTextTheme.medium12(context)
            ),
            const SizedBox(height: 4),
            Text(
              time,
              style: TTextTheme.bodyRegular12Gay10(context),
            ),
          ],
        ),
      ),
    ),
  );
}