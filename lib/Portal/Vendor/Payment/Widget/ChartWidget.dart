import 'package:car_rental_project/Portal/Vendor/Payment/paymentController.dart';
import 'package:car_rental_project/Resources/Colors.dart';
import 'package:car_rental_project/Resources/IconStrings.dart';
import 'package:car_rental_project/Resources/TextString.dart';
import 'package:car_rental_project/Resources/TextTheme.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChartWidget extends StatelessWidget {
final PaymentController controller = Get.put(PaymentController());
final LayerLink _calendarLink = LayerLink();
final TextEditingController _dateController = TextEditingController();

ChartWidget({super.key});

@override
Widget build(BuildContext context) {
  return LayoutBuilder(builder: (context, constraints) {
    bool isMobile = constraints.maxWidth < 550;

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          isMobile ? _buildMobileHeader(context) : _buildDesktopHeader(context),
          const SizedBox(height: 16),
          _buildSelectedDateIndicator(context),
          const SizedBox(height: 40),
          isMobile ? _buildMobileScrollableChart(context) : _buildDesktopChart(context),
        ],
      ),
    );
  });
}

/// ----------- Extra Widgets --------- ///

 // Range Selectors
Widget _buildDateRangeChip(BuildContext context) {
  return CompositedTransformTarget(
    link: _calendarLink,
    child: InkWell(
      onTap: () => controller.toggleCalendar(context, _calendarLink, _dateController, 280),
      child:  Container(
        height: 40,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: AppColors.quadrantalTextColor.withOpacity(0.3)),
          boxShadow: [
            BoxShadow(
              color: AppColors.fieldsBackground.withOpacity(0.05),
              spreadRadius: 1,
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.date_range_outlined, size: 18, color: AppColors.quadrantalTextColor),
            const SizedBox(width: 8),
            Text(TextString.pickDate, style: TTextTheme.bodyRegular14(context)),
          ],
        ),
      ),
    ),
  );
}
Widget _buildSelectedDateIndicator(BuildContext context) {
  return Obx(() {
    String label = TextString.selecteddate;
    if (controller.selectedFilter.value == "Monthly") {
      label = TextString.selectedMonth;
    } else if (controller.selectedFilter.value == "Yearly") {
      label = TextString.selectedYear;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
          color: AppColors.signaturePadColor,
          borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
              Icons.date_range_outlined,
              size: 16,
              color: AppColors.quadrantalTextColor
          ),
          const SizedBox(width: 8),
          RichText(
            text: TextSpan(
              style: TTextTheme.bodyRegular12(context).copyWith(color: AppColors.quadrantalTextColor),
              children: [
                TextSpan(text: "$label: "),
                TextSpan(
                  text: controller.selectedDateRangeText.value,
                  style: TTextTheme.h2StyleSubtitle(context),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  });
}


 // Header
  Widget _buildDesktopHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildTitles(context),
        Row(children: [_buildDateRangeChip(context), const SizedBox(width: 12), _buildWeeklyFilterDropdown(context)]),
      ],
    );
  }
  Widget _buildMobileHeader(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTitles(context),
        const SizedBox(height: 16),
        _buildDateRangeChip(context),
        const SizedBox(height: 12),
        _buildWeeklyFilterDropdown(context),
      ],
    );
  }

   /// Remaining TextThemes
   // Charts
  Widget _buildDesktopChart(BuildContext context) {
    return AspectRatio(
      aspectRatio: 2.5,
      child: Row(
        children: [
          _buildYAxisLabels(context),
          const SizedBox(width: 10),
          Expanded(
            child: Obx(() {
              return BarChart(_buildBarChartData(double.infinity,context));
            }),
          ),
        ],
      ),
    );
  }
Widget _buildMobileScrollableChart(BuildContext context) {
  double scrollWidth = controller.selectedFilter.value == "Yearly" ? 600 : 550;

  return SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    child: SizedBox(
      width: scrollWidth,
      child: AspectRatio(
        aspectRatio: 1.5,
        child: Row(
          children: [
            _buildYAxisLabels(context),
            const SizedBox(width: 10),
            Expanded(
              child: Obx(() {
                return BarChart(_buildBarChartData(scrollWidth,context));
              }),
            ),
          ],
        ),
      ),
    ),
  );
}
BarChartData _buildBarChartData(double screenWidth,BuildContext context) {
  List<String> weeklyLabels = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"];
  List<String> monthlyLabels = ["Week 1", "Week 2", "Week 3", "Week 4"];
  List<String> yearlyLabels = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"];

  List<String> currentLabels;
  if (controller.selectedFilter.value == "Weekly") {
    currentLabels = weeklyLabels;
  } else if (controller.selectedFilter.value == "Monthly") {
    currentLabels = monthlyLabels;
  } else {
    currentLabels = yearlyLabels;
  }

  double effectiveWidth = screenWidth == double.infinity ? 1000 : screenWidth;
  int totalBars = currentLabels.length;
  double availableWidth = effectiveWidth - 40;
  double rodWidth;
  if (controller.selectedFilter.value == "Yearly") {
    rodWidth = (availableWidth / (totalBars * 2.5)).clamp(12, 25);
  } else if (controller.selectedFilter.value == "Monthly") {
    rodWidth = (availableWidth / (totalBars * 1.5)).clamp(20, 70);
  } else {
    rodWidth = (availableWidth / (totalBars * 2)).clamp(10, 50);
  }

  return BarChartData(
    maxY: controller.getMaxY,
    alignment: BarChartAlignment.spaceBetween,
    gridData: const FlGridData(show: false),
    borderData: FlBorderData(show: false),
    barTouchData: BarTouchData(enabled: false),

    titlesData: FlTitlesData(
      show: true,
      bottomTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          getTitlesWidget: (value, meta) {
            int index = value.toInt();
            if (index < 0 || index >= currentLabels.length) return const SizedBox.shrink();
            return SideTitleWidget(
              meta: meta,
              space: 10,
              child: Text(
                  currentLabels[index],
                  style: TTextTheme.bodyRegular14(context)
              ),
            );
          },
          reservedSize: 35,
        ),
      ),
      leftTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
      topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
      rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
    ),

    barGroups: List.generate(
      controller.currentChartData.length,
          (index) => BarChartGroupData(
        x: index,
        barRods: [
          BarChartRodData(
            toY: controller.currentChartData[index],
            color: AppColors.primaryColor,
            width: rodWidth, // 🔥 Updated rodWidth
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(6),
                topRight: Radius.circular(6)
            ),
          ),
        ],
      ),
    ),
  );
}


    // Titles
Widget _buildTitles(BuildContext context) {
  return Obx(() {
    String mainTitle = TextString.weeklyRevenue;
    String subTitle = TextString.revenuePerDay;


    if (controller.selectedFilter.value == "Monthly") {
      mainTitle = TextString.monthlyrevenue;
      subTitle = TextString.monthlyrevenuesubtitle;
    } else if (controller.selectedFilter.value == "Yearly") {
      mainTitle = TextString.yearlyRevenue;
      subTitle = TextString.monthlyrevenuesubtitle;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
            mainTitle,
            style: TTextTheme.h2Style(context)
        ),
        const SizedBox(height: 4),
        Text(
            subTitle,
            style: TTextTheme.chartTitle(context)
        ),
      ],
    );
  });
}

   // Charts Axis
  Widget _buildYAxisLabels(BuildContext context) {
    return SizedBox(
      width: 45,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildYLabel("\$50k",context), _buildYLabel("\$40k",context),
          _buildYLabel("\$30k",context), _buildYLabel("\$20k",context),
          _buildYLabel("\$10k",context), _buildYLabel("\$1k",context),
          _buildYLabel("\$500",context),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
  Widget _buildYLabel(String label,BuildContext context) {
    return Text(label, textAlign: TextAlign.right, style: TTextTheme.bodyRegular14(context));
  }
   // Weekly Filter Dropdown
Widget _buildWeeklyFilterDropdown(BuildContext context) {
  List<String> filters = ["Weekly", "Monthly", "Yearly"];

  return Obx(() {
    final isOpen = controller.isWeeklyDropOpen.value;
    final selectedValue = controller.selectedFilter.value;

    return PopupMenuButton<String>(
      offset: const Offset(0, 45),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: Colors.white,

      onOpened: () => controller.isWeeklyDropOpen.value = true,
      onCanceled: () => controller.isWeeklyDropOpen.value = false,

      onSelected: (val) {
        controller.selectedFilter.value = val;
        controller.isWeeklyDropOpen.value = false;
        controller.updateDateRange(DateTime.now());
      },

      child: Container(
        height: 40,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
              color: AppColors.quadrantalTextColor.withOpacity(0.3)),
          boxShadow: [
            BoxShadow(
              color: AppColors.fieldsBackground.withOpacity(0.05),
              spreadRadius: 1,
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              selectedValue,
              style: TTextTheme.bodyRegular14(context),
            ),
            const SizedBox(width: 8),
            Transform.rotate(
              angle: isOpen ? 3.14159 : 0,
              child: Image.asset(
                IconString.weeklyDropwnIcon,
                height: 18,
                width: 18,
                color: AppColors.quadrantalTextColor,
              ),
            ),
          ],
        ),
      ),

      itemBuilder: (context) => filters.map((String value) {
        return PopupMenuItem<String>(
          value: value,
          child: Text(value,
              style: TTextTheme.bodyRegular14(context)),
        );
      }).toList(),
    );
  });
}
}