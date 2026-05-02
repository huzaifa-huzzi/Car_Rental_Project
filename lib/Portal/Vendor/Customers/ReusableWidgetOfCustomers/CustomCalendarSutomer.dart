import 'package:car_rental_project/Resources/Colors.dart';
import 'package:car_rental_project/Resources/TextTheme.dart';
import 'package:flutter/material.dart';

class CustomCalendarCustomer extends StatefulWidget {
  final Function(DateTime) onDateSelected;
  final VoidCallback onCancel;
  final double width;
  final bool allowFuture;

  const CustomCalendarCustomer({
    super.key,
    required this.onDateSelected,
    required this.onCancel,
    required this.width,
    this.allowFuture = true,
  });

  @override
  State<CustomCalendarCustomer> createState() => _CustomCalendarCustomerState();
}

class _CustomCalendarCustomerState extends State<CustomCalendarCustomer> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  final DateTime _today = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
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
    _selectedDay = _today;
  }

  @override
  Widget build(BuildContext context) {
    int daysInMonth = DateTime(_focusedDay.year, _focusedDay.month + 1, 0).day;
    int firstDayWeekday = DateTime(_focusedDay.year, _focusedDay.month, 1).weekday;
    int offset = firstDayWeekday - 1;

    return Container(
      width: widget.width,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
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
                        setState(() {
                          _showMonthList = !_showMonthList;
                          _showYearList = false;
                          _searchQuery = "";
                        });
                      }),
                    ),

                    const SizedBox(width: 4),
                    Expanded(
                      flex: 2,
                      child: _buildHeaderTrigger(_focusedDay.year.toString(), () {
                        setState(() {
                          _showYearList = !_showYearList;
                          _showMonthList = false;
                          _searchQuery = "";
                        });
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

                Row(
                  children: ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"]
                      .map((d) => Expanded(
                    child: Center(
                      child: Text(d, style: TTextTheme.bodyRegular14Search(context)),
                    ),
                  ))
                      .toList(),
                ),
                const SizedBox(height: 8),
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 42,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 7,
                    mainAxisSpacing: 2,
                    crossAxisSpacing: 2,
                    childAspectRatio: 1,
                  ),
                  itemBuilder: (context, index) {
                    int dayNum = index - offset + 1;
                    if (dayNum < 1 || dayNum > daysInMonth) return const SizedBox();

                    DateTime currentCellDate = DateTime(_focusedDay.year, _focusedDay.month, dayNum);
                    bool isFuture = currentCellDate.isAfter(_today);
                    bool isDisabled = !widget.allowFuture && isFuture;

                    bool isSelected = _selectedDay != null &&
                        _selectedDay!.year == currentCellDate.year &&
                        _selectedDay!.month == currentCellDate.month &&
                        _selectedDay!.day == currentCellDate.day;

                    return GestureDetector(
                      onTap: isDisabled ? null : () {
                        setState(() {
                          _selectedDay = currentCellDate;
                          _closeDropdowns();
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: isSelected ? AppColors.primaryColor : Colors.transparent,
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Text(
                            "$dayNum",
                            style: isSelected
                                ? TTextTheme.tableRegular14black(context).copyWith(color: Colors.white)
                                : TTextTheme.tableRegular14black(context)
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
                    TextButton(
                      onPressed: widget.onCancel,
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        side: BorderSide(
                          color: AppColors.primaryColor,
                          width: 1.2,
                        ),
                      ),
                      child: Text(
                        "Cancel",
                        style: TTextTheme.calendarBtnCancel(context),
                      ),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryColor,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        elevation: 0,
                      ),
                      onPressed: () {
                        if (_selectedDay != null) widget.onDateSelected(_selectedDay!);
                      },
                      child:  Text("Done", style: TTextTheme.calendarBtnDone(context)),
                    ),
                  ],
                )
              ],
            ),
          ),
          if (_showMonthList || _showYearList)
            Positioned.fill(
              child: GestureDetector(
                onTap: _closeDropdowns,
                child: Container(color: Colors.transparent),
              ),
            ),
          if (_showMonthList)
            _buildSearchableList(_months, (val) {
              int index = _months.indexOf(val) + 1;
              setState(() {
                _focusedDay = DateTime(_focusedDay.year, index);
                _showMonthList = false;
              });
            }, isMonth: true),

          if (_showYearList)
            _buildSearchableList(
                List.generate(100, (i) => (DateTime.now().year - 80 + i).toString()).reversed.toList(),
                    (val) {
                  setState(() {
                    _focusedDay = DateTime(int.parse(val), _focusedDay.month);
                    _showYearList = false;
                  });
                }, isMonth: false),
        ],
      ),
    );
  }

  /// ---------- Extra Widgets ----------- ///

  void _closeDropdowns() {
    setState(() {
      _showMonthList = false;
      _showYearList = false;
    });
  }

  Widget _buildHeaderTrigger(String label, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
        decoration: BoxDecoration(
          color: AppColors.secondaryColor,
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
                  style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                      color: Colors.black87
                  ),
                ),
            ),
            const SizedBox(width: 4),
            const Icon(Icons.keyboard_arrow_down, size: 18, color: AppColors.quadrantalTextColor),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchableList(List<String> items, Function(String) onSelect, {required bool isMonth}) {
    List<String> filtered = items.where((i) => i.toLowerCase().contains(_searchQuery.toLowerCase())).toList();
    String currentVal = isMonth ? _months[_focusedDay.month - 1] : _focusedDay.year.toString();

    return Positioned(
      top: 55,
      left: 15,
      right: 15,
      bottom: 60,
      child: Material(
        elevation: 12,
        shadowColor: Colors.black26,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.signaturePadColor),
          ),
          child: Column(
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
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                    ),
                  ),
                ),
              ),

              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: filtered.length,
                  itemBuilder: (context, index) {
                    String item = filtered[index];
                    bool isSelected = item == currentVal;

                    return ListTile(
                      dense: true,
                      visualDensity: VisualDensity.compact,
                      onTap: () => onSelect(item),
                      leading: Container(
                        width: 22,
                        height: 22,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: isSelected ? AppColors.primaryColor : Colors.transparent,
                          border: Border.all(
                            color: AppColors.primaryColor,
                            width: 2,
                          ),
                        ),
                        child: isSelected
                            ? const Center(
                          child: Icon(Icons.done, color: Colors.white, size: 14),
                        )
                            : null,
                      ),
                      title: Text(
                        item,
                        style: TTextTheme.medium14(context).copyWith(
                          color: isSelected ? AppColors.primaryColor : Colors.black87,
                          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                        ),
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
}