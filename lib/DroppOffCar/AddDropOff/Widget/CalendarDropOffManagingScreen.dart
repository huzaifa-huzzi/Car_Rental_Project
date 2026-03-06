import 'package:car_rental_project/Resources/Colors.dart';
import 'package:car_rental_project/Resources/TextTheme.dart';
import 'package:flutter/material.dart';

class CustomCalendarDropOff extends StatefulWidget {
  final Function(DateTime) onDateSelected;
  final VoidCallback onCancel;
  final double width;

  const CustomCalendarDropOff({
    super.key,
    required this.onDateSelected,
    required this.onCancel,
    required this.width,
  });

  @override
  State<CustomCalendarDropOff> createState() => _CustomCalendarDropOffState();
}

class _CustomCalendarDropOffState extends State<CustomCalendarDropOff> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  Widget build(BuildContext context) {
    int daysInMonth = DateTime(_focusedDay.year, _focusedDay.month + 1, 0).day;
    int firstDayWeekday = DateTime(_focusedDay.year, _focusedDay.month, 1).weekday;
    int offset = firstDayWeekday - 1;
    int totalCellsNeeded = offset + daysInMonth;

    return Container(
      width: widget.width,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          /// HEADER (Month/Year)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                visualDensity: VisualDensity.compact,
                constraints: const BoxConstraints(),
                onPressed: () => setState(() => _focusedDay = DateTime(_focusedDay.year, _focusedDay.month - 1)),
                icon: const Icon(Icons.arrow_back_ios, size: 14),
              ),
              Text(
                "${_getMonthName(_focusedDay.month)} (${_focusedDay.year})",
                style: TTextTheme.titleTwo(context),
              ),
              IconButton(
                visualDensity: VisualDensity.compact,
                constraints: const BoxConstraints(),
                onPressed: () => setState(() => _focusedDay = DateTime(_focusedDay.year, _focusedDay.month + 1)),
                icon: const Icon(Icons.arrow_forward_ios, size: 14),
              ),
            ],
          ),
          const Divider(),

          /// DAYS HEADER (Mon-Sun)
          Row(
            children: ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"]
                .map((d) => Expanded(
              child: Center(
                child: Text(d, style: TTextTheme.titleFour(context).copyWith(color: Colors.grey, fontSize: 10)),
              ),
            )).toList(),
          ),
          const SizedBox(height: 8),

          /// CALENDAR GRID
          Flexible(
            child: GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: totalCellsNeeded,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 7,
                mainAxisSpacing: 5,
                crossAxisSpacing: 5,
                  childAspectRatio: 1.1,
              ),
              itemBuilder: (context, index) {
                int dayNum = index - offset + 1;
                if (dayNum < 1 || dayNum > daysInMonth) return const SizedBox();

                bool isSelected = _selectedDay?.day == dayNum &&
                    _selectedDay?.month == _focusedDay.month &&
                    _selectedDay?.year == _focusedDay.year;

                return GestureDetector(
                  onTap: () => setState(() => _selectedDay = DateTime(_focusedDay.year, _focusedDay.month, dayNum)),
                  child: Container(
                    decoration: BoxDecoration(
                      color: isSelected ? AppColors.primaryColor : Colors.transparent,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        "$dayNum",
                        style: TTextTheme.titleFour(context).copyWith(
                          fontSize: 12,
                          color: isSelected ? Colors.white : AppColors.textColor,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          const SizedBox(height: 12),

          /// BUTTONS Row
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              _buildBtn("Cancel", widget.onCancel, context, true),
              const SizedBox(width: 8),
              _buildBtn("Done", () {
                if (_selectedDay != null) widget.onDateSelected(_selectedDay!);
              }, context, false),
            ],
          )
        ],
      ),
    );
  }

  // Helper Button to keep UI clean
  Widget _buildBtn(String text, VoidCallback onTap, BuildContext context, bool isOutline) {
    return SizedBox(
      height: 28,
      width: 65,
      child: isOutline
          ? OutlinedButton(
        onPressed: onTap,
        style: OutlinedButton.styleFrom(
          side: const BorderSide(color: AppColors.primaryColor),
          padding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        child: Text(text, style: TTextTheme.calendarBtnCancel(context).copyWith(fontSize: 10)),
      )
          : ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryColor,
          padding: EdgeInsets.zero,
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        child: Text(text, style: TTextTheme.calendarBtnDone(context).copyWith(fontSize: 10, color: Colors.white)),
      ),
    );
  }

  String _getMonthName(int month) => ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"][month - 1];
}