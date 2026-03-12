import 'package:car_rental_project/Portal/Vendor/DroppOffCar/DropOffController.dart';
import 'package:car_rental_project/Resources/Colors.dart';
import 'package:car_rental_project/Resources/TextTheme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ResponsiveDropOffTimer extends StatelessWidget {
  final double width;
  final Function(String) onTimeSelected;
  final VoidCallback onCancel;
  final DropOffController controller = Get.find<DropOffController>();

  ResponsiveDropOffTimer({super.key, required this.width, required this.onTimeSelected, required this.onCancel});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double effectiveWidth = width > screenWidth - 30 ? screenWidth - 30 : width;

    return Container(
      width: effectiveWidth,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(color: AppColors.fieldsBackground, blurRadius: 10, spreadRadius: 2)],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 150,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(child: _buildPickerColumn(context, 12, (index) => controller.updateHour(index + 1), true)),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: Text(":", style: TTextTheme.hourlyTitle(context)),
                ),
                Flexible(child: _buildPickerColumn(context, 60, (index) => controller.updateMinute(index), false)),
                const SizedBox(width: 8),
                _buildAMPMToggle(context),
              ],
            ),
          ),
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              _btn(context, "Cancel", onCancel, isOutline: true),
              const SizedBox(width: 8),
              _btn(context, "Done", () => onTimeSelected(controller.formattedTime), isOutline: false),
            ],
          ),
        ],
      ),
    );
  }
   /// ----------- Extra Widgets -------- ///
  // picker
  Widget _buildPickerColumn(BuildContext context, int count, Function(int) onChanged, bool isHour) {
    return CupertinoPicker(
      itemExtent: 40,
      scrollController: FixedExtentScrollController(initialItem: isHour ? 10 : 29),
      onSelectedItemChanged: onChanged,
      children: List.generate(count, (i) {
        String val = isHour ? "${i + 1}" : i.toString().padLeft(2, '0');
        return Center(child: Text(val, style: TTextTheme.hourlyTitle(context)));
      }),
    );
  }

  // Am/Pm
  Widget _buildAMPMToggle(BuildContext context) {
    return Container(
      width: 45,
      height: 85,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.tertiaryTextColor.withOpacity(0.2)),
      ),
      child: Column(
        children: [
          _ampmItem("AM", true, context),
          _ampmItem("PM", false, context),
        ],
      ),
    );
  }
  Widget _ampmItem(String label, bool am, BuildContext context) {
    return Obx(() {
      bool selected = controller.isAM.value == am;
      return Expanded(
        child: GestureDetector(
          onTap: () => controller.togglePeriod(am),
          behavior: HitTestBehavior.opaque,
          child: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: selected ? AppColors.backgroundOfPickupsWidget : Colors.transparent,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(label, style: TTextTheme.hourlySubtitle(context).copyWith(
                color: selected ? AppColors.primaryColor : AppColors.textColor,
            )),
          ),
        ),
      );
    });
  }

   // Buttons
  Widget _btn(BuildContext context, String label, VoidCallback onTap, {required bool isOutline}) {
    return SizedBox(
      height: 32,
      width: 65,
      child: isOutline
          ? OutlinedButton(
          onPressed: onTap,
          style: OutlinedButton.styleFrom(
            side: const BorderSide(color: AppColors.primaryColor),
            padding: EdgeInsets.zero,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
          child: Text(label, style: TTextTheme.calendarBtnCancel(context))
      )
          : ElevatedButton(
          onPressed: onTap,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primaryColor,
            padding: EdgeInsets.zero,
            elevation: 0,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
          child: Text(label, style: TTextTheme.calendarBtnDone(context))
      ),
    );
  }
}