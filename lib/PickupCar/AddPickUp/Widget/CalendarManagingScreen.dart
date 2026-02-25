import 'package:car_rental_project/Resources/Colors.dart';
import 'package:car_rental_project/Resources/TextTheme.dart';
import 'package:flutter/material.dart';

class CustomCalendarPopup extends StatefulWidget {
  final Function(DateTime) onDateSelected;
  final VoidCallback onCancel;
  final double width;

  const CustomCalendarPopup({
    super.key,
    required this.onDateSelected,
    required this.onCancel,
    required this.width,
  });

  @override
  State<CustomCalendarPopup> createState() => _CustomCalendarPopupState();
}

class _CustomCalendarPopupState extends State<CustomCalendarPopup> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  Widget build(BuildContext context) {
    int daysInMonth =
        DateTime(_focusedDay.year, _focusedDay.month + 1, 0).day;

    int firstDayWeekday =
        DateTime(_focusedDay.year, _focusedDay.month, 1).weekday;

    int offset = firstDayWeekday - 1;
    int totalCellsNeeded = offset + daysInMonth;

    return Container(
      width: widget.width,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 15,
            offset: const Offset(0, 8),
          )
        ],
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          double availableWidth = constraints.maxWidth;

          double cellSize = (availableWidth / 7).clamp(32, 42);

          return Padding(
            padding: const EdgeInsets.fromLTRB(15, 10, 15, 15),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [

                /// HEADER
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      visualDensity: VisualDensity.compact,
                      onPressed: () {
                        setState(() {
                          _focusedDay = DateTime(
                              _focusedDay.year, _focusedDay.month - 1);
                        });
                      },
                      icon: const Icon(Icons.arrow_back_ios, size: 14),
                    ),
                    Text(
                      "${_getMonthName(_focusedDay.month)} (${_focusedDay.year})",
                      style: TTextTheme.titleTwo(context),
                    ),
                    IconButton(
                      visualDensity: VisualDensity.compact,
                      onPressed: () {
                        setState(() {
                          _focusedDay = DateTime(
                              _focusedDay.year, _focusedDay.month + 1);
                        });
                      },
                      icon: const Icon(Icons.arrow_forward_ios, size: 14),
                    ),
                  ],
                ),

                const Divider(),

                /// DAYS HEADER
                Row(
                  children: ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"]
                      .map(
                        (d) => Expanded(
                      child: Center(
                        child: Text(
                          d,
                          style: TTextTheme.titleFour(context)
                              .copyWith(color: Colors.grey),
                        ),
                      ),
                    ),
                  )
                      .toList(),
                ),

                const SizedBox(height: 10),

                /// GRID
                SizedBox(
                  height: (cellSize * 3) + 30,
                  child: Column(
                    children: [
                      Expanded(
                        child: GridView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: totalCellsNeeded,
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 7,
                            mainAxisSpacing: 3,
                            crossAxisSpacing: 3,
                            childAspectRatio: 2.6,
                          ),
                          itemBuilder: (context, index) {
                            int dayNum = index - offset + 1;

                            if (dayNum < 1 || dayNum > daysInMonth) {
                              return const SizedBox();
                            }

                            bool isSelected =
                                _selectedDay?.day == dayNum &&
                                    _selectedDay?.month == _focusedDay.month &&
                                    _selectedDay?.year == _focusedDay.year;

                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  _selectedDay = DateTime(
                                    _focusedDay.year,
                                    _focusedDay.month,
                                    dayNum,
                                  );
                                });
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: isSelected
                                      ? AppColors.primaryColor
                                      : Colors.transparent,
                                  shape: BoxShape.circle,
                                ),
                                child: Center(
                                  child: Text(
                                    "$dayNum",
                                    style: TTextTheme.titleFour(context).copyWith(
                                      color: isSelected
                                          ? Colors.white
                                          : AppColors.textColor,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),

                      const SizedBox(height: 6),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          SizedBox(
                            height: 28,
                            width: 68,
                            child: OutlinedButton(
                              onPressed: widget.onCancel,
                              style: OutlinedButton.styleFrom(
                                side: const BorderSide(color: AppColors.primaryColor),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                padding: EdgeInsets.zero,
                              ),
                              child: Text("Cancel", style: TTextTheme.calendarBtnCancel(context).copyWith(fontSize: 11)),
                            ),
                          ),
                          const SizedBox(width: 8),
                          SizedBox(
                            height: 28,
                            width: 68,
                            child: ElevatedButton(
                              onPressed: () {
                                if (_selectedDay != null) widget.onDateSelected(_selectedDay!);
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.primaryColor,
                                foregroundColor: Colors.white,
                                elevation: 0,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                padding: EdgeInsets.zero,
                              ),
                              child: Text("Done", style: TTextTheme.calendarBtnDone(context).copyWith(fontSize: 11)),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  String _getMonthName(int month) => [
    "January",
    "February",
    "March",
    "April",
    "May",
    "June",
    "July",
    "August",
    "September",
    "October",
    "November",
    "December"
  ][month - 1];
}