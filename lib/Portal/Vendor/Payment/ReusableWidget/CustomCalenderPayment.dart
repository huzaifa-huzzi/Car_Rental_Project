import 'package:car_rental_project/Resources/Colors.dart';
import 'package:car_rental_project/Resources/TextTheme.dart';
import 'package:flutter/material.dart';

class CustomCalendarPayment extends StatefulWidget {
  final Function(DateTime) onDateSelected;
  final VoidCallback onCancel;
  final double width;

  const CustomCalendarPayment({
    super.key,
    required this.onDateSelected,
    required this.onCancel,
    required this.width,
  });

  @override
  State<CustomCalendarPayment> createState() => _CustomCalendarPaymentState();
}

class _CustomCalendarPaymentState extends State<CustomCalendarPayment> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedWeekStart;
  bool _showMonthList = false;
  bool _showYearList = false;
  String _searchQuery = "";

  final List<String> _months = [
    "January", "February", "March", "April", "May", "June",
    "July", "August", "September", "October", "November", "December"
  ];

  @override
  void initState() {
    super.initState();
    _selectedWeekStart = _getStartOfWeek(DateTime.now());
  }

  DateTime _getStartOfWeek(DateTime date) {
    return date.subtract(Duration(days: date.weekday - 1));
  }

  void _closeDropdowns() {
    setState(() {
      _showMonthList = false;
      _showYearList = false;
      _searchQuery = "";
    });
  }

  @override
  Widget build(BuildContext context) {
    int daysInMonth = DateTime(_focusedDay.year, _focusedDay.month + 1, 0).day;
    int firstDayWeekday = DateTime(_focusedDay.year, _focusedDay.month, 1).weekday;
    int offset = firstDayWeekday - 1;
    int rowCount = ((daysInMonth + offset) / 7).ceil();

    return Container(
      width: widget.width,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 10)],
      ),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    IconButton(
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(maxWidth: 30),
                      icon: const Icon(Icons.arrow_back_ios, size: 14),
                      onPressed: () => setState(() {
                        _focusedDay = DateTime(_focusedDay.year, _focusedDay.month - 1);
                        _closeDropdowns();
                      }),
                    ),
                    Expanded(
                      flex: 2,
                      child: _buildHeaderTrigger(_months[_focusedDay.month - 1], () {
                        setState(() { _showMonthList = !_showMonthList; _showYearList = false; _searchQuery = ""; });
                      }),
                    ),
                    const SizedBox(width: 4),
                    Expanded(
                      flex: 2,
                      child: _buildHeaderTrigger(_focusedDay.year.toString(), () {
                        setState(() { _showYearList = !_showYearList; _showMonthList = false; _searchQuery = ""; });
                      }),
                    ),
                    IconButton(
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(maxWidth: 30),
                      icon: const Icon(Icons.arrow_forward_ios, size: 14),
                      onPressed: () => setState(() {
                        _focusedDay = DateTime(_focusedDay.year, _focusedDay.month + 1);
                        _closeDropdowns();
                      }),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                const Divider(height: 1),
                const SizedBox(height: 10),

                // Days Row
                Row(
                  children: ["", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"]
                      .map((d) => Expanded(child: Center(child: Text(d, style: TTextTheme.bodyRegular14Search(context).copyWith(fontSize: 11))))).toList(),
                ),
                const SizedBox(height: 8),

                // Weekly Grid
                Column(
                  children: List.generate(rowCount, (rowIndex) {
                    return _buildWeekRow(rowIndex, offset, daysInMonth);
                  }),
                ),

                const SizedBox(height: 16),
                if (_selectedWeekStart != null) _buildSelectedInfoBox(),
                const SizedBox(height: 16),

                // Action Buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    _buildActionButton("Cancel", widget.onCancel, true),
                    const SizedBox(width: 8),
                    _buildActionButton("Done", () {
                      if (_selectedWeekStart != null) widget.onDateSelected(_selectedWeekStart!);
                    }, false),
                  ],
                )
              ],
            ),
          ),
          if (_showMonthList || _showYearList)
            Positioned.fill(child: GestureDetector(onTap: _closeDropdowns, child: Container(color: Colors.transparent))),

          if (_showMonthList)
            _buildSearchableList(_months, (val) {
              setState(() { _focusedDay = DateTime(_focusedDay.year, _months.indexOf(val) + 1); _showMonthList = false; });
            }, isMonth: true),

          if (_showYearList)
            _buildSearchableList(
                List.generate(50, (i) => (DateTime.now().year - 25 + i).toString()).reversed.toList(),
                    (val) {
                  setState(() { _focusedDay = DateTime(int.parse(val), _focusedDay.month); _showYearList = false; });
                }, isMonth: false),
        ],
      ),
    );
  }


   /// ----------- Extra Widget ------- ///

   // Week Row
  Widget _buildWeekRow(int rowIndex, int offset, int daysInMonth) {
    DateTime firstDayOfWeek = DateTime(_focusedDay.year, _focusedDay.month, (rowIndex * 7) - offset + 1);
    bool isWeekSelected = _selectedWeekStart != null &&
        _selectedWeekStart!.year == firstDayOfWeek.year &&
        _selectedWeekStart!.month == firstDayOfWeek.month &&
        (_selectedWeekStart!.day - firstDayOfWeek.day).abs() < 7;

    return GestureDetector(
      onTap: () => setState(() => _selectedWeekStart = _getStartOfWeek(firstDayOfWeek)),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 2),
        decoration: BoxDecoration(
          color: isWeekSelected ? AppColors.primaryColor : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            Expanded(child: Center(child: Text("W${rowIndex + 1}", style: TTextTheme.tableRegular14black(context).copyWith(fontSize: 11, color: isWeekSelected ? Colors.white : AppColors.quadrantalTextColor, fontWeight: FontWeight.bold)))),
            ...List.generate(7, (colIndex) {
              int dayNum = (rowIndex * 7) + colIndex - offset + 1;
              bool isValid = dayNum > 0 && dayNum <= daysInMonth;
              return Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Center(child: Text(isValid ? "$dayNum" : "", style: TTextTheme.tableRegular14black(context).copyWith(fontSize: 12, color: isWeekSelected ? Colors.white : AppColors.blackColor))),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

   // Searchable List
  Widget _buildSearchableList(List<String> items, Function(String) onSelect, {required bool isMonth}) {
    List<String> filtered = items.where((i) => i.toLowerCase().contains(_searchQuery.toLowerCase())).toList();
    String currentVal = isMonth ? _months[_focusedDay.month - 1] : _focusedDay.year.toString();

    return Positioned(
      top: 55, left: 15, right: 15, bottom: 60,
      child: Material(
        elevation: 12,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), border: Border.all(color: AppColors.signaturePadColor)),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextField(
                  autofocus: true,
                  onChanged: (v) => setState(() => _searchQuery = v),
                  decoration: InputDecoration(
                    hintText: "Search",
                    prefixIcon: const Icon(Icons.search, size: 18, color: AppColors.primaryColor),
                    enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(20), borderSide: const BorderSide(color: AppColors.primaryColor)),
                    focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(20), borderSide: const BorderSide(color: AppColors.primaryColor, width: 1.5)),
                    contentPadding: const EdgeInsets.symmetric(vertical: 8),
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: filtered.length,
                  itemBuilder: (context, index) {
                    bool isSelected = filtered[index] == currentVal;
                    return ListTile(
                      dense: true,
                      onTap: () => onSelect(filtered[index]),
                      leading: Container(
                        width: 20, height: 20,
                        decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: AppColors.primaryColor, width: 2), color: isSelected ? AppColors.primaryColor : Colors.transparent),
                        child: isSelected ? const Icon(Icons.done, size: 12, color: Colors.white) : null,
                      ),
                      title: Text(
                        filtered[index],
                        style: TTextTheme.medium14(context).copyWith(
                            color: isSelected ? AppColors.primaryColor : Colors.black87
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
   // SelectedInfoBox
  Widget _buildSelectedInfoBox() {
    DateTime end = _selectedWeekStart!.add(const Duration(days: 6));
    String range = "${_selectedWeekStart!.day} ${_getMonthAbbr(_selectedWeekStart!.month)},${_selectedWeekStart!.year.toString().substring(2)} to ${end.day} ${_getMonthAbbr(end.month)} ${end.year.toString().substring(2)}";

    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: AppColors.signaturePadColor,
          borderRadius: BorderRadius.circular(10)
      ),
      child: Row(
        children: [
          const Icon(Icons.check_circle, color: AppColors.primaryColor, size: 20),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              "Selected Week: $range",
              style: TTextTheme.bodyRegular12(context),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

   // Action Button
  Widget _buildActionButton(String text, VoidCallback onTap, bool isOutline) {
    return SizedBox(
      height: 35,
      child: isOutline
          ? OutlinedButton(
        onPressed: onTap,
        style: OutlinedButton.styleFrom(side: const BorderSide(color: AppColors.primaryColor), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
        child: Text(text, style: TTextTheme.calendarBtnCancel(context)),
      )
          : ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(backgroundColor: AppColors.primaryColor, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)), elevation: 0),
        child: Text(text, style: TTextTheme.calendarBtnDone(context)),
      ),
    );
  }

   // Header Trigger
  Widget _buildHeaderTrigger(String label, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
        decoration: BoxDecoration(
          color: AppColors.backgroundOfScreenColor,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: AppColors.quadrantalTextColor.withOpacity(0.4)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              child: Text(
                label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TTextTheme.pOne(context).copyWith(fontSize: 12),
              ),
            ),
            const Icon(Icons.keyboard_arrow_down, size: 16, color: AppColors.blackColor),
          ],
        ),
      ),
    );
  }

  String _getMonthAbbr(int month) => _months[month - 1].substring(0, 3);
}