import 'package:car_rental_project/Resources/Colors.dart';
import 'package:car_rental_project/Resources/TextTheme.dart';
import 'package:flutter/material.dart';

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
  bool _showMonthDropdown = false;
  bool _showYearDropdown = false;
  String _searchQuery = "";

  final List<String> _months = [
    "January", "February", "March", "April", "May", "June",
    "July", "August", "September", "October", "November", "December"
  ];
  List<String> _getYears() {
    return List.generate(101, (index) => (1950 + index).toString());
  }

  @override
  void initState() {
    super.initState();
    DateTime now = DateTime.now();
    _selectedDay = DateTime(now.year, now.month, now.day);
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
          constraints: const BoxConstraints(minWidth: 280, maxWidth: 360),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
            boxShadow: [
              BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 18)
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  IconButton(
                    visualDensity: VisualDensity.compact,
                    onPressed: () => setState(() => _focusedDay = DateTime(_focusedDay.year, _focusedDay.month - 1)),
                    icon: const Icon(Icons.arrow_back_ios_new, size: 14),
                  ),
                  Flexible(
                    flex: 3,
                    child: _buildHeaderBox(
                        _months[_focusedDay.month - 1],
                            () => setState(() { _showMonthDropdown = true; _searchQuery = ""; })
                    ),
                  ),
                  const SizedBox(width: 8),
                  Flexible(
                    flex: 2,
                    child: _buildHeaderBox(
                        _focusedDay.year.toString(),
                            () => setState(() { _showYearDropdown = true; _searchQuery = ""; })
                    ),
                  ),
                  IconButton(
                    visualDensity: VisualDensity.compact,
                    onPressed: () => setState(() => _focusedDay = DateTime(_focusedDay.year, _focusedDay.month + 1)),
                    icon: const Icon(Icons.arrow_forward_ios, size: 14),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              const Divider(height: 1),
              const SizedBox(height: 10),

              /// Days Header
              Row(
                children: ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"]
                    .map((d) => Expanded(
                  child: Center(
                    child: FittedBox(
                      child: Text(d, style: const TextStyle(fontSize: 10, color: Colors.grey, fontWeight: FontWeight.w600)),
                    ),
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
                  mainAxisSpacing: 4,
                  crossAxisSpacing: 4,
                  childAspectRatio: 1,
                ),
                itemBuilder: (context, index) {
                  int dayNum = index - offset + 1;
                  if (dayNum < 1 || dayNum > daysInMonth) return const SizedBox();

                  bool isSelected = _selectedDay != null &&
                      _selectedDay!.day == dayNum &&
                      _selectedDay!.month == _focusedDay.month &&
                      _selectedDay!.year == _focusedDay.year;

                  return GestureDetector(
                    onTap: () => setState(() => _selectedDay = DateTime(_focusedDay.year, _focusedDay.month, dayNum)),
                    child: Container(
                      decoration: BoxDecoration(
                        color: isSelected ? AppColors.primaryColor : Colors.transparent,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: FittedBox(
                          child: Text(
                            "$dayNum",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.normal,
                              color: isSelected ? Colors.white : AppColors.textColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 16),

              /// Footer Buttons
              Row(
                children: [
                  const Spacer(),
                  Expanded(child: _buildActionBtn("Cancel", widget.onCancel, isOutline: true)),
                  const SizedBox(width: 8),
                  Expanded(child: _buildActionBtn("Done", () {
                    if (_selectedDay != null) widget.onDateSelected(_selectedDay!);
                  }, isOutline: false)),
                ],
              )
            ],
          ),
        ),

        /// Search Overlay
        if (_showMonthDropdown)
          _buildSearchOverlay(_months, (val) {
            setState(() {
              _focusedDay = DateTime(_focusedDay.year, _months.indexOf(val) + 1);
              _showMonthDropdown = false;
            });
          }, isMonth: true),

        if (_showYearDropdown)
          _buildSearchOverlay(_getYears(), (val) {
            setState(() {
              _focusedDay = DateTime(int.parse(val), _focusedDay.month);
              _showYearDropdown = false;
            });
          }, isMonth: false),
      ],
    );
  }

  /// Header Dropdown
  Widget _buildHeaderBox(String label, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 36,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          color: AppColors.secondaryColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Expanded(
              child: FittedBox(
                fit: BoxFit.scaleDown,
                alignment: Alignment.centerLeft,
                child: Text(label, style: TTextTheme.titleTwo(context).copyWith(fontSize: 12)),
              ),
            ),
            const Icon(Icons.keyboard_arrow_down, size: 16, color: AppColors.quadrantalTextColor),
          ],
        ),
      ),
    );
  }

  //Searchable Overlay
  Widget _buildSearchOverlay(List<String> items, Function(String) onSelect, {required bool isMonth}) {
    List<String> filtered = items.where((i) => i.toLowerCase().contains(_searchQuery.toLowerCase())).toList();
    String currentVal = isMonth ? _months[_focusedDay.month - 1] : _focusedDay.year.toString();

    return Positioned.fill(
      child: GestureDetector(
        onTap: () => setState(() { _showMonthDropdown = false; _showYearDropdown = false; }),
        child: Container(
          color: Colors.black.withOpacity(0.1),
          child: Center(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
              constraints: const BoxConstraints(maxHeight: 320, maxWidth: 300),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [BoxShadow(color: AppColors.fieldsBackground.withOpacity(0.7), blurRadius: 15)],
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
                        border: Border.all(color: AppColors.primaryColor.withOpacity(0.5)),
                      ),
                      child: TextField(
                        autofocus: true,
                        onChanged: (v) => setState(() => _searchQuery = v),
                        decoration: InputDecoration(
                          hintText: "Search",
                          hintStyle: const TextStyle(fontSize: 13, color: Colors.grey),
                          prefixIcon: const Icon(Icons.search, color: AppColors.primaryColor, size: 18),
                          filled: true,
                          fillColor: AppColors.secondaryColor,
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20), borderSide: BorderSide.none),
                          contentPadding: const EdgeInsets.symmetric(vertical: 8),
                        ),
                      ),
                    ),
                  ),
                  Flexible(
                    child: ListView.builder(
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      itemCount: filtered.length,
                      itemBuilder: (context, index) {
                        String item = filtered[index];
                        bool isSelected = item == currentVal;
                        return ListTile(
                          dense: true,
                          onTap: () => onSelect(item),
                          leading: Container(
                            width: 18, height: 18,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: isSelected ? AppColors.primaryColor : Colors.transparent,
                              border: Border.all(color: AppColors.primaryColor, width: 2),
                            ),
                            child: isSelected ? const Icon(Icons.done, color: Colors.white, size: 10) : null,
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

  // Action Buttons
  Widget _buildActionBtn(String text, VoidCallback onTap, {required bool isOutline}) {
    return Container(
      height: 34,
      constraints: const BoxConstraints(maxWidth: 100),
      child: isOutline
          ? OutlinedButton(
          onPressed: onTap,
          style: OutlinedButton.styleFrom(
              side: const BorderSide(color: AppColors.primaryColor),
              padding: EdgeInsets.zero,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))
          ),
          child: FittedBox(child: Text(text, style: const TextStyle(fontSize: 11, color: AppColors.primaryColor, fontWeight: FontWeight.w600)))
      )
          : ElevatedButton(
          onPressed: onTap,
          style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryColor,
              foregroundColor: Colors.white,
              elevation: 0,
              padding: EdgeInsets.zero,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))
          ),
          child: FittedBox(child: Text(text, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600)))
      ),
    );
  }
}