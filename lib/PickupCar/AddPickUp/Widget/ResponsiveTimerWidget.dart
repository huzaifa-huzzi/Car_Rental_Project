import 'package:car_rental_project/PickupCar/PickupCarInventory.dart';
import 'package:car_rental_project/Resources/Colors.dart';
import 'package:car_rental_project/Resources/TextTheme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ResponsiveTimePicker extends StatelessWidget {
  final double width;
  final Function(String) onTimeSelected;
  final VoidCallback onCancel;
  final PickupCarController controller = Get.put(PickupCarController());

  ResponsiveTimePicker({
    super.key,
    required this.width,
    required this.onTimeSelected,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    double effectiveWidth = width < 250 ? 250 : width;

    return Container(
      width: effectiveWidth,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 20)],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 150,
            child: Row(
              children: [
                Expanded(
                  child: CupertinoPicker(
                    scrollController: FixedExtentScrollController(initialItem: 10),
                    itemExtent: 40,
                    onSelectedItemChanged: (index) => controller.updateHour(index + 1),
                    children: List.generate(12, (i) => Center(child: Text("${i + 1}", style: TTextTheme.hourlyTitle(context)))),
                  ),
                ),
                 Text(":", style: TTextTheme.hourlyTitle(context)),
                Expanded(
                  child: CupertinoPicker(
                    scrollController: FixedExtentScrollController(initialItem: 29),
                    itemExtent: 40,
                    onSelectedItemChanged: (index) => controller.updateMinute(index),
                    children: List.generate(60, (i) => Center(child: Text(i.toString().padLeft(2, '0'), style:TTextTheme.hourlyTitle(context)))),
                  ),
                ),
                Obx(() => Container(
                  width: 65,
                  height: 90,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: AppColors.tertiaryTextColor),
                  ),
                  child: Column(
                    children: [
                      _ampmButton("AM", true,context),
                      _ampmButton("PM", false,context),
                    ],
                  ),
                )),
              ],
            ),
          ),
          const SizedBox(height: 15),
          // Buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SizedBox(
                height: 28,
                width: 68,
                child: OutlinedButton(
                  onPressed:onCancel,
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
    );
  }

  /// ----------- Extra Widgets ---------- ///

   // Am/Pm Buttons
  Widget _ampmButton(String text, bool am,BuildContext context) {
    bool selected = controller.isAM.value == am;
    return Expanded(
      child: GestureDetector(
        onTap: () => controller.togglePeriod(am),
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: selected ? AppColors.backgroundOfPickupsWidget : Colors.transparent,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(text, style: TTextTheme.hourlySubtitle(context).copyWith(color:selected ? AppColors.primaryColor : AppColors.textColor )),
        ),
      ),
    );
  }
}