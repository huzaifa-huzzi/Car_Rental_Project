import 'package:car_rental_project/Resources/Colors.dart';
import 'package:car_rental_project/Resources/TextTheme.dart';
import 'package:flutter/material.dart';

class CustomCalendarCar extends StatefulWidget {
  final Function(DateTime) onDateSelected;
  final VoidCallback onCancel;
  final double width;

  const CustomCalendarCar({
    super.key,
    required this.onDateSelected,
    required this.onCancel,
    required this.width,
  });

  @override
  State<CustomCalendarCar> createState() => _CustomCalendarPaymentState();
}

class _CustomCalendarPaymentState extends State<CustomCalendarCar> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  final DateTime _today = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
  bool _showMonthDropdown = false;
  bool _showYearDropdown = false;
  String _searchQuery = "";

  final List<String> _months = [
    "January", "February", "March", "April", "May", "June",
    "July", "August", "September", "October", "November", "December"
  ];

  List<String> _getYears() {
    int currentYear = DateTime.now().year;
    return List.generate(10, (index) => (currentYear - index).toString());
  }

  @override
  void initState() {
    super.initState();
    _selectedDay = _today;
  }

  @override
  Widget build(BuildContext context) {
    int daysInMonth = DateTime(_focusedDay.year, _focusedDay.month + 1, 0).day;
    int firstDayWeekday = DateTime(_focusedDay.year, _focusedDay.month, 1).weekday;
    int offset = firstDayWeekday - 1;
    int totalCellsNeeded = offset + daysInMonth;

    return Stack(
      children: [
        Container(
          width: widget.width,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    visualDensity: VisualDensity.compact,
                    onPressed: () => setState(() => _focusedDay = DateTime(_focusedDay.year, _focusedDay.month - 1)),
                    icon: const Icon(Icons.arrow_back_ios, size: 14),
                  ),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () => setState(() {
                          _showMonthDropdown = true;
                          _showYearDropdown = false;
                          _searchQuery = "";
                        }),
                        child: Text("${_months[_focusedDay.month - 1]} ", style: TTextTheme.titleTwo(context)),
                      ),
                      GestureDetector(
                        onTap: () => setState(() {
                          _showYearDropdown = true;
                          _showMonthDropdown = false;
                          _searchQuery = "";
                        }),
                        child: Text("(${_focusedDay.year})", style: TTextTheme.titleTwo(context)),
                      ),
                    ],
                  ),

                  IconButton(
                    visualDensity: VisualDensity.compact,
                    onPressed: () => setState(() => _focusedDay = DateTime(_focusedDay.year, _focusedDay.month + 1)),
                    icon: const Icon(Icons.arrow_forward_ios, size: 14),
                  ),
                ],
              ),
              const Divider(),
              Row(
                children: ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"]
                    .map((d) => Expanded(
                  child: Center(
                    child: Text(d, style: TTextTheme.titleFour(context).copyWith(color: Colors.grey, fontSize: 10)),
                  ),
                )).toList(),
              ),
              const SizedBox(height: 8),
              GridView.builder(
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

                  DateTime currentCellDate = DateTime(_focusedDay.year, _focusedDay.month, dayNum);
                  bool isFuture = currentCellDate.isAfter(_today);
                  bool isSelected = _selectedDay != null &&
                      _selectedDay!.year == currentCellDate.year &&
                      _selectedDay!.month == currentCellDate.month &&
                      _selectedDay!.day == currentCellDate.day;

                  return GestureDetector(
                    onTap: isFuture ? null : () => setState(() => _selectedDay = currentCellDate),
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
                            color: isFuture
                                ? Colors.grey.withOpacity(0.3)
                                : (isSelected ? Colors.white : AppColors.textColor),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),

              const SizedBox(height: 16),
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
        ),
        if (_showMonthDropdown)
          _buildSearchableList(_months, (val) {
            int newMonth = _months.indexOf(val) + 1;
            setState(() {
              _focusedDay = DateTime(_focusedDay.year, newMonth);
              _showMonthDropdown = false;
            });
          }, isMonth: true),
        if (_showYearDropdown)
          _buildSearchableList(_getYears(), (val) {
            setState(() {
              _focusedDay = DateTime(int.parse(val), _focusedDay.month);
              _showYearDropdown = false;
            });
          }, isMonth: false),
      ],
    );
  }

  /// --------- Extra Widget -------- ///
  // Searchable List
  Widget _buildSearchableList(List<String> items, Function(String) onSelect, {required bool isMonth}) {
    List<String> filtered = items.where((i) => i.toLowerCase().contains(_searchQuery.toLowerCase())).toList();
    String currentVal = isMonth ? _months[_focusedDay.month - 1] : _focusedDay.year.toString();

    return Positioned.fill(
      child: GestureDetector(
        onTap: () => setState(() { _showMonthDropdown = false; _showYearDropdown = false; }),
        child: Container(
          color: Colors.black.withOpacity(0.05),
          child: Center(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
              constraints: const BoxConstraints(maxHeight: 300),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 10, spreadRadius: 1)],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      height: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: AppColors.primaryColor),
                      ),
                      child: TextField(
                        autofocus: true,
                        cursorColor: AppColors.blackColor,
                        onChanged: (v) => setState(() => _searchQuery = v),
                        style: TTextTheme.titleinputTextField(context),
                        decoration: InputDecoration(
                          hintText: "Search",
                          hintStyle: TTextTheme.bodyRegular14Search(context),
                          prefixIcon: const Icon(Icons.search, color: AppColors.primaryColor, size: 18),
                          filled: true,
                          fillColor: AppColors.backgroundOfScreenColor,
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20), borderSide: BorderSide.none),
                          contentPadding: const EdgeInsets.symmetric(vertical: 8),
                        ),
                      ),
                    ),
                  ),
                  Flexible(
                    child: ListView.separated(
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      itemCount: filtered.length,
                      separatorBuilder: (_, __) => const Divider(height: 1),
                      itemBuilder: (context, index) {
                        String item = filtered[index];
                        bool isSelected = item == currentVal;
                        return ListTile(
                          dense: true,
                          onTap: () => onSelect(item),
                          leading: Container(
                            width: 20, height: 20,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: isSelected ? AppColors.primaryColor : Colors.transparent,
                              border: Border.all(color: AppColors.primaryColor, width: 2),
                            ),
                            child: isSelected ? const Icon(Icons.done, color: Colors.white, size: 12) : null,
                          ),
                          title: Text(item, style: TTextTheme.medium14(context)),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Bottom Action
  Widget _buildBtn(String text, VoidCallback onTap, BuildContext context, bool isOutline) {
    return SizedBox(
      height: 32,
      width: 75,
      child: isOutline
          ? OutlinedButton(
        onPressed: onTap,
        style: OutlinedButton.styleFrom(
          side: const BorderSide(color: AppColors.primaryColor),
          padding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        child: Text(text, style: TTextTheme.calendarBtnCancel(context).copyWith(fontSize: 11)),
      )
          : ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryColor,
          padding: EdgeInsets.zero,
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        child: Text(text, style: TTextTheme.calendarBtnDone(context).copyWith(fontSize: 11, color: Colors.white)),
      ),
    );
  }
}