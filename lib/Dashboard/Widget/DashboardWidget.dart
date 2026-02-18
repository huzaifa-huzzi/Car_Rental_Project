import 'package:car_rental_project/Customers/CustomersController.dart';
import 'package:car_rental_project/Dashboard/DashboardController.dart';
import 'package:car_rental_project/Dashboard/ReusableWidgetOfDashboard/PrimaryButtonOfDashBoard.dart';
import 'package:car_rental_project/Dashboard/Widget/GradientArc.dart';
import 'package:car_rental_project/PickupCar/PickupCarInventory.dart';
import 'package:car_rental_project/Resources/Colors.dart';
import 'package:car_rental_project/Resources/IconStrings.dart';
import 'package:car_rental_project/Resources/ImageString.dart';
import 'package:car_rental_project/Resources/TextString.dart';
import 'package:car_rental_project/Resources/TextTheme.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';


class DashboardContent extends StatelessWidget {
  final bool isMobile;
  final bool isTablet;
  final DashboardController controller = Get.put(DashboardController());

  DashboardContent({
    super.key,
    required this.isMobile,
    required this.isTablet,
  });



  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double width = constraints.maxWidth;

        bool useVerticalLayout = width < 1000;

        return SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(
            isMobile ? 12 : 20,
            isMobile ? 12 : 20,
            isMobile ? 12 : 20,
            0,
          ),
          child: Column(
            children: [
              _buildStatsGrid(width, context),
              const SizedBox(height: 20),

              !useVerticalLayout
                  ? Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 4,
                    child: Column(children: _buildMainSections(context)),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    flex: 2,
                    child: _buildRightSidePanel(context),
                  ),
                ],
              )
                  : Column(
                children: [
                  ..._buildMainSections(context),
                  const SizedBox(height: 20),
                  _buildRightSidePanel(context),
                ],
              )
            ],
          ),
        );
      },
    );
  }

  /// ---------- Extra Widgets --------- ///




   // Main Section Of Screen
  List<Widget> _buildMainSections(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    bool isMobileView = screenWidth < 700;



    return [
      _buildRevenueSummarySection(context),
      const SizedBox(height: 20),

      !isMobileView
          ? LayoutBuilder(
        builder: (context, constraints) {

          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 2,
                child: _statusSectionCard(context, TextString.carStatusText),
              ),
              const SizedBox(width: 20),

              Expanded(
                flex: 1,
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    double screenWidth = MediaQuery.of(context).size.width;
                    double syncHeight;

                    if (screenWidth > 1300) {
                      syncHeight = 240;
                    } else if (screenWidth <= 1300 && screenWidth > 1100) {
                      syncHeight = 230;
                    } else if (screenWidth <= 1300 && screenWidth > 1100) {
                      syncHeight = 230;
                    } else if (screenWidth <= 1100 && screenWidth > 1000) {
                      syncHeight = 230;
                    } else if (screenWidth <= 900 && screenWidth > 800) {
                      syncHeight = 370;
                    } else {
                      syncHeight = 370;
                    }

                    return _dashboardCard(
                      TextString.dropOffStatusText,
                      SizedBox(
                        height: syncHeight - 80,
                        child: Center(
                          child: _buildSimpleBarChart(context),
                        ),
                      ),
                      height: syncHeight,
                    );
                  },
                ),
              ),
            ],
          );
        },
      )
          : Column(
        children: [
          _statusSectionCard(context, TextString.carStatusText, height: null),
          const SizedBox(height: 20),
          _dashboardCard(
            TextString.dropOffStatusText,
            _buildSimpleBarChart(context),
            height: 370,
          ),
        ],
      ),

      const SizedBox(height: 10),
      !isMobileView
          ? LayoutBuilder(
        builder: (context, constraints) {

          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                  child: _buildPickupStatusSection(context)
              ),
              const SizedBox(width: 20),

              Expanded(
                  child: _buildDropoffDamageSection(context)
              ),
            ],
          );
        },
      )
          : Column(
        children: [
          _buildPickupStatusSection(context),
          const SizedBox(height: 20),
          _buildDropoffDamageSection(context),
        ],
      ),
    ];
  }

   //Stat Grids
  Widget _buildStatsGrid(double width,BuildContext context) {
    int crossAxisCount = width < 400 ? 1 : width < 900 ? 2 : 4;
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: crossAxisCount,
      crossAxisSpacing: 16,
      mainAxisSpacing: 16,
      childAspectRatio: 2.8,
      children: [
        _statCard("Total Cars", "214", IconString.carInventoryIcon,context),
        _statCard("Total Customers", "386", IconString.customerIcon,context),
        _statCard("Total Pickups", "214", IconString.agreementIcon,context),
        _statCard("Total Dropoffs", "89", IconString.returnCarIcon,context),
      ],
    );
  }
  Widget _statCard(String title, String value, String icon,BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: _cardDecoration(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 38, height: 38,
            decoration: BoxDecoration(
              color: AppColors.secondaryColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child:Center(
              child:Image.asset(icon, color: AppColors.textColor),
            )
          ),
          const SizedBox(width: 8),


          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  style: TTextTheme.titleFour(context),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.centerLeft,
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                            text: value,
                            style: TTextTheme.h6Style(context),
                        ),
                         TextSpan(
                            text: TextString.unitText,
                            style:TTextTheme.h6Style(context)
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

   // Revenue Summary Chart
  Widget _buildRevenueSummarySection(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        bool isVerySmall = constraints.maxWidth < 250;
        bool isSmall = constraints.maxWidth < 450;

        return Container(
          height: 440,
          padding: const EdgeInsets.all(16),
          decoration: _cardDecoration(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Section
              isSmall
                  ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   Text(TextString.revenueText, style: TTextTheme.btnSix(context)),
                  const SizedBox(height: 10),
                  _buildResponsiveDropdown(),
                ],
              )
                  : Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(TextString.revenueText, style: TTextTheme.btnSix(context)),
                  _buildResponsiveDropdown(),
                ],
              ),
              const SizedBox(height: 15),

              // Legends Section
              isVerySmall
                  ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildLegend(AppColors.primaryColor, TextString.revenueIncome,context),
                  const SizedBox(height: 8),
                  _buildLegend(AppColors.textColor, TextString.revenueExpense,context),
                ],
              )
                  : Row(
                children: [
                  _buildLegend(AppColors.primaryColor, TextString.revenueIncome,context),
                  const SizedBox(width: 15),
                  _buildLegend(AppColors.textColor,  TextString.revenueExpense,context),
                ],
              ),
              const SizedBox(height: 25),

              Expanded(
                child: isSmall
                    ? Theme(
                  data: ThemeData(
                    scrollbarTheme: ScrollbarThemeData(
                      thumbColor: WidgetStateProperty.all(AppColors.primaryColor),
                      thickness: WidgetStateProperty.all(5),
                      radius: const Radius.circular(10),
                      thumbVisibility: WidgetStateProperty.all(true),
                    ),
                  ),
                  child: Scrollbar(
                    controller: controller.revenueScrollController,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      controller: controller.revenueScrollController,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 15),
                        child: SizedBox(
                          width: 600,
                          child: _buildRevenueChart(context),
                        ),
                      ),
                    ),
                  ),
                )
                    : _buildRevenueChart(context),
              ),
            ],
          ),
        );
      },
    );
  }
  Widget _buildRevenueChart(BuildContext context) {
    return Obx(() => BarChart(
      BarChartData(
        maxY: 700,
        minY: -600,
        alignment: BarChartAlignment.spaceAround,
        gridData: FlGridData(
          show: true,
          drawVerticalLine: false,
          checkToShowHorizontalLine: (value) => value % 300 == 0,
          getDrawingHorizontalLine: (value) => FlLine(
            color: AppColors.sideBoxesColor,
            strokeWidth: 1,
            dashArray: [5, 5],
          ),
        ),
        borderData: FlBorderData(show: false),
        titlesData: FlTitlesData(
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 35,
              getTitlesWidget: (value, meta) {
                if (value % 300 == 0) {
                  return Text(value.abs().toInt().toString(),
                      style: TTextTheme.pTwo(context));
                }
                return const SizedBox();
              },
            ),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 35,
              getTitlesWidget: (double value, TitleMeta meta) {
                const months = ['Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'];
                if (value >= 0 && value < 12) {
                  return SideTitleWidget(
                    meta: meta,
                    space: 10,
                    child: Text(months[value.toInt()],
                        style: TTextTheme.pTwo(context)),
                  );
                }
                return const SizedBox();
              },
            ),
          ),
          rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
        ),

        barTouchData: BarTouchData(
          enabled: true,
          touchTooltipData: BarTouchTooltipData(
            getTooltipColor: (BarChartGroupData group) => AppColors.secondaryColor,
            tooltipRoundedRadius: 12,
            tooltipPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            tooltipMargin: 12,
            fitInsideVertically: true,
            fitInsideHorizontally: true,
            getTooltipItem: (group, groupIndex, rod, rodIndex) {
              return BarTooltipItem(
                'Income\n',
                 TTextTheme.pTwo(context),
                children: [
                  TextSpan(
                    text: '\$ ${rod.toY.toInt()}',
                    style: TTextTheme.h2Style(context),
                  ),
                ],
              );
            },
          ),
        ),

        barGroups: List.generate(12, (index) {
          return BarChartGroupData(
            x: index,
            barRods: [
              BarChartRodData(
                toY: (controller.income[index] as num).toDouble(),
                fromY: -(controller.expense[index] as num).toDouble(),
                width: 18,
                borderRadius: BorderRadius.circular(4),
                rodStackItems: [
                  BarChartRodStackItem(-(controller.expense[index] as num).toDouble(), 0, AppColors.textColor),
                  BarChartRodStackItem(0, (controller.income[index] as num).toDouble(), AppColors.primaryColor),
                ],
              ),
            ],
          );
        }),
      ),
    ));
  }
  Widget _buildResponsiveDropdown() {
    return Obx(() {
      // Safety check: Agar kisi wajah se selectedPeriod list mein na ho to crash na kare
      String currentValue = controller.periods.contains(controller.selectedPeriod.value)
          ? controller.selectedPeriod.value
          : controller.periods.first;

      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          color: AppColors.sideBoxesColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            value: currentValue,
            isDense: true,
            icon: const Icon(Icons.keyboard_arrow_down, size: 16),
            onChanged: (val) => controller.updateFilter(val),
            items: controller.periods.map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500)),
              );
            }).toList(),
          ),
        ),
      );
    });
  }
  Widget _buildLegend(Color color, String label,BuildContext context) {
    return Row(
      children: [
        Container(width: 8, height: 8, decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(2))),
         SizedBox(width: 6),
        Text(label, style: TTextTheme.pTwo(context)),
      ],
    );
  }


  // Pickup Status Charts Widget
  Widget _buildPickupStatusSection(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: _cardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: double.infinity,
            child: Wrap(
              alignment: WrapAlignment.spaceBetween,
              crossAxisAlignment: WrapCrossAlignment.center,
              runSpacing: 12,
              children: [
                 Text(
                  TextString.dashboardPickup,
                  style: TTextTheme.h12Style(context),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                     Text(
                        "Sort by: ",
                        style: TTextTheme.sortText(context)
                    ),
                    const SizedBox(width: 4),
                    Obx(() => Container(
                      height: 28,
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      decoration: BoxDecoration(
                        color: AppColors.backgroundOfScreenColor,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: controller.selectedPickupPeriod.value,
                          isDense: true,
                          icon: Icon(Icons.keyboard_arrow_down, size: 14,color: AppColors.quadrantalTextColor),
                          style: TTextTheme.pTwo(context),
                          items: controller.pickupPeriods.map((p) => DropdownMenuItem(
                            value: p,
                            child: Text(p),
                          )).toList(),
                          onChanged: (val) => controller.updatePickupFilter(val),
                        ),
                      ),
                    )),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 15),

          // Bars Section
          Obx(() {
            var data = controller.pickupData[controller.selectedPickupPeriod.value]!;
            return Column(
              children: [
                _buildPickupBar("Completed", data['completed']!, "45 Unit",context),
                const SizedBox(height: 10),
                _buildPickupBar("Awaiting", data['awaiting']!, "40 Unit",context),
                const SizedBox(height: 10),
                _buildPickupBar("Overdue", data['overdue']!, "50 Unit",context),
                const SizedBox(height: 10),
                _buildPickupBar("Processing", data['processing']!, "30 Unit",context),
              ],
            );
          }),
        ],
      ),
    );
  }
  Widget _buildPickupBar(String label, double progress, String unit, BuildContext context) {
    Color bgColor = AppColors.sideBoxesColor;
    Color textColor = AppColors.secondTextColor;
    String status = label.toLowerCase();

    if (status == "completed") {
      bgColor = AppColors.textColor;
      textColor = Colors.white;
    } else if (status == "awaiting") {
      bgColor = AppColors.primaryColor;
      textColor = Colors.white;
    } else if (status == "overdue") {
      bgColor = AppColors.iconsBackgroundColor;
      textColor = AppColors.primaryColor;
    } else if (status == "processing") {
      bgColor = AppColors.backgroundOfScreenColor;
      textColor = AppColors.textColor;
    }
    Color barColor = (status == "completed") ? AppColors.textColor : (status == "awaiting") ? AppColors.primaryColor  : (status == "overdue") ? AppColors.maintenanceBackgroundColor : (status == "processing") ? AppColors.rodOfProcessingColor : bgColor;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: LinearProgressIndicator(
            value: progress,
            minHeight: 10,
            backgroundColor:AppColors.sideBoxesColor,
            color: barColor,
          ),
        ),
        const SizedBox(height: 5),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: bgColor,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: AppColors.sideBoxesColor, width: 0.5),
              ),
              child: Text(
                label,
                style: TTextTheme.titleseven(context).copyWith(
                  color: textColor,
                ),
              ),
            ),
            Text(
              unit,
              style: TTextTheme.titleSmallTexts(context),
            ),
          ],
        ),
      ],
    );
  }

  // DropOff Damage Chart Widget
  Widget _buildDropoffDamageSection(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: _cardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: double.infinity,
            child: Wrap(
              alignment: WrapAlignment.spaceBetween,
              crossAxisAlignment: WrapCrossAlignment.center,
              runSpacing: 10,
              children: [
                 Text(
                  TextString.dashboardDamage,
                  style: TTextTheme.h14Style(context)),

                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                     Text("Sort by: ", style: TTextTheme.sortText(context)),
                    const SizedBox(width: 4),
                    Obx(() => Container(
                      height: 28,
                      padding: const EdgeInsets.symmetric(horizontal: 6),
                      decoration: BoxDecoration(
                        color: AppColors.backgroundOfScreenColor,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: controller.selectedDamagePeriod.value,
                          isDense: true,
                          icon:  Icon(Icons.keyboard_arrow_down, size: 14,color: AppColors.quadrantalTextColor),
                          style:TTextTheme.pTwo(context),
                          items: controller.damagePeriods.map((p) => DropdownMenuItem(
                              value: p,
                              child: Text(p)
                          )).toList(),
                          onChanged: (val) => controller.updateDamageFilter(val),
                        ),
                      ),
                    )),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 10),

          Row(
            children: [
              _buildLegendItem(TextString.damageText, AppColors.primaryColor,context),
              const SizedBox(width: 15),
              _buildLegendItem(TextString.safeText, AppColors.sideBoxesColor,context),
            ],
          ),
          const SizedBox(height: 20),
          SizedBox(height: 160, child: _buildDropoffDamageChart(context)),
        ],
      ),
    );
  }
  Widget _buildLegendItem(String label, Color color,BuildContext context) {
    return Row(
      children: [
        Container(width: 8, height: 8, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
        const SizedBox(width: 6),
        Text(label, style: TTextTheme.pTwo(context)),
      ],
    );
  }
  Widget _buildDropoffDamageChart(BuildContext context) {
    return Obx(() {
      var currentData = controller.damageDataMap[controller.selectedDamagePeriod.value]!;
      double safeY = (currentData['safe'] as num).toDouble();
      double damageY = (currentData['damage'] as num).toDouble();
      String safeCount = currentData['safeCount'].toString();
      String damageCount = currentData['damageCount'].toString();

      return Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 1,
            child: Column(
              children: [
                Expanded(
                  child: BarChart(
                    BarChartData(
                      barTouchData: BarTouchData(
                        enabled: false,
                        handleBuiltInTouches: false,
                      ),
                      gridData: const FlGridData(show: false),
                      borderData: FlBorderData(show: false),
                      titlesData: const FlTitlesData(show: false),
                      barGroups: [
                        BarChartGroupData(x: 0, barRods: [
                          BarChartRodData(toY: safeY, color: AppColors.sideBoxesColor, width: 25, borderRadius: BorderRadius.circular(6))
                        ]),
                        BarChartGroupData(x: 1, barRods: [
                          BarChartRodData(toY: damageY, color: AppColors.primaryColor, width: 25, borderRadius: BorderRadius.circular(6))
                        ]),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                 Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text("50%", style: TTextTheme.dropOffDamageRodGrey(context)),
                    Text("50%", style: TTextTheme.dropOffDamageRodRed(context)),
                  ],
                )
              ],
            ),
          ),

          const SizedBox(width: 8),

          Expanded(
            flex: 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildDamageStat("$damageCount Cars", "50%", AppColors.primaryColor,context),
                const SizedBox(height: 20),
                _buildDamageStat("$safeCount Cars", "50%", AppColors.sideBoxesColor,context),
              ],
            ),
          ),
        ],
      );
    });
  }
  Widget _buildDamageStat(String count, String percent, Color color,BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(2))
            ),
            const SizedBox(width: 6),
            Flexible(
              child: Text(
                count,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                softWrap: false,
                style: TTextTheme.h13Style(context),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(left: 14),
          child: Text(
              percent,
              style: TTextTheme.dropOffDamagePercent(context),
          ),
        ),
      ],
    );
  }

   // Car By Status Chart Widget
  Widget _statusSectionCard(BuildContext context, String title, {double? height}) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Container(
      height: height,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: _cardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(title, style: TTextTheme.h12Style(context)),
          const SizedBox(height: 25),

          LayoutBuilder(
            builder: (context, cardConstraints) {
              if (screenWidth > 1000) {
                return Row(
                  children: [
                    Expanded(child: _statusCircularItem(context, "215", "Available", 0.7)),
                    const SizedBox(width: 8),
                    Expanded(child: _statusCircularItem(context, "215", "Maintenance", 0.5)),
                    const SizedBox(width: 8),
                    Expanded(child: _statusCircularItem(context, "215", "Unavailable", 0.3)),
                  ],
                );
              }
              else {
                return Wrap(
                  spacing: 5,
                  runSpacing: 5,
                  alignment: WrapAlignment.start,
                  children: [
                    SizedBox(
                      width: cardConstraints.maxWidth > 350 ? (cardConstraints.maxWidth - 20) / 2 : cardConstraints.maxWidth,
                      child: _statusCircularItem(context, "215", "Available", 0.7),
                    ),
                    SizedBox(
                      width: cardConstraints.maxWidth > 350 ? (cardConstraints.maxWidth - 20) / 2 : cardConstraints.maxWidth,
                      child: _statusCircularItem(context, "215", "Maintenance", 0.5),
                    ),
                    SizedBox(
                      width: cardConstraints.maxWidth > 350 ? (cardConstraints.maxWidth - 20) / 2 : cardConstraints.maxWidth,
                      child: _statusCircularItem(context, "215", "Unavailable", 0.3),
                    ),
                  ],
                );
              }
            },
          ),
        ],
      ),
    );
  }
  Widget _statusCircularItem(BuildContext context, String units, String label, double progress) {
    late SweepGradient sweepGradient;
    late Color solidColor;
    late Color textColor;
    double screenWidth = MediaQuery.of(context).size.width;

    double circleSize = screenWidth > 1100 ? 65 : 48;

    if (label == "Available") {
      sweepGradient = const SweepGradient(
        startAngle: 0.0,
        endAngle: 3.14 * 2,
        colors: [
          AppColors.availableStart,
          AppColors.availableEnd,
          AppColors.availableStart,
        ],
        stops: [0.0, 0.5, 1.0],
      );
      solidColor = AppColors.primaryColor;
      textColor = AppColors.primaryColor;
    } else if (label == "Maintenance") {
      sweepGradient = const SweepGradient(
        startAngle: 0.0,
        endAngle: 3.14 * 2,
        colors: [
          AppColors.maintenanceStart,
          AppColors.maintenanceEnd,
          AppColors.maintenanceStart,
        ],
        stops: [0.0, 0.5, 1.0],
      );
      solidColor = AppColors.quadrantalTextColor;
      textColor = AppColors.quadrantalTextColor;
    } else {
      sweepGradient = const SweepGradient(
        startAngle: 0.0,
        endAngle: 3.14 * 2,
        colors: [
          AppColors.unavailableStart,
          AppColors.unavailableEnd,
          AppColors.unavailableStart,
        ],
        stops: [0.0, 0.5, 1.0],
      );
      solidColor = AppColors.textColor;
      textColor = AppColors.textColor;
    }

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 12, offset: const Offset(0, 4)),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.all(6.0),
            child: Stack(
              alignment: Alignment.center,
              children: [

            SizedBox(
            width: circleSize,
            height: circleSize,
            child: PerfectGradientArc(
              strokeWidth: circleSize * 0.1,
              progress: progress,
              gradient: sweepGradient,
              bgColor: Colors.grey.shade200,
            ),
          ),

          Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(units, style: TTextTheme.progressBarUnit(context).copyWith(color: textColor)),
                    Text(TextString.unitText, style: TTextTheme.progressBarUnit(context).copyWith(color: textColor)),
                  ],
                ),
              ],
            ),

          ),
          const SizedBox(height: 18),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 9),
            decoration: BoxDecoration(
              color: solidColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              label,
              textAlign: TextAlign.center,
              style: TTextTheme.progressBarUnitText(context),
            ),
          ),
        ],
      ),
    );
  }

  // DropOff Status Widget
  Widget _buildSimpleBarChart(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Align(
          alignment: Alignment.topRight,
          child: Obx(() => Container(
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
            decoration: BoxDecoration(color:AppColors.backgroundOfScreenColor, borderRadius: BorderRadius.circular(6)),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: controller.selectedDropoffPeriod.value,
                isDense: true,
                style: TTextTheme.pTwo(context),
                icon: const Icon(Icons.keyboard_arrow_down, size: 12,color: AppColors.quadrantalTextColor,),
                items: controller.dropoffPeriods.map((p) => DropdownMenuItem(value: p, child: Text(p))).toList(),
                onChanged: (val) => controller.updateDropoffFilter(val),
              ),
            ),
          )),
        ),
        const SizedBox(height: 8),
        Expanded(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                flex: 1,
                child: BarChart(
                  BarChartData(
                    barTouchData: BarTouchData(enabled: false),
                    alignment: BarChartAlignment.center,
                    groupsSpace: 8,
                    gridData: const FlGridData(show: false),
                    borderData: FlBorderData(show: false),
                    titlesData: const FlTitlesData(show: false),
                    barGroups: [
                      BarChartGroupData(x: 0, barRods: [
                        BarChartRodData(toY: 10, color: AppColors.textColor, width: 10, borderRadius: BorderRadius.circular(3))
                      ]),
                      BarChartGroupData(x: 1, barRods: [
                        BarChartRodData(toY: 8, color: AppColors.primaryColor, width: 10, borderRadius: BorderRadius.circular(3))
                      ]),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildDropoffLegend("Completed", "4500", AppColors.primaryColor,context),
                    const SizedBox(height: 6),
                    _buildDropoffLegend("Incomplete", "5200", AppColors.textColor,context),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
  Widget _buildDropoffLegend(String label, String value, Color color, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: color, width: 1.5),
              ),
            ),
            const SizedBox(width: 8),
            Flexible(
              child: Text(
                  label,
                  overflow: TextOverflow.ellipsis,
                  style: TTextTheme.damageStatusBarComplete(context).copyWith(color: color)
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(left: 16),
          child: Text(
            "$value Dropoff",
            overflow: TextOverflow.ellipsis,
            style: TTextTheme.h15Style(context).copyWith(color: color),
          ),
        ),
      ],
    );
  }

   // Right Side Panels in Web
  Widget _buildRightSidePanel(BuildContext context) {
    return Column(
      children: [
        _buildQuickActionsCustom(context),
        const SizedBox(height: 30),
        _buildCarsByBodyType(context),
      ],
    );
  }
   // Quick Action Buttons
  Widget _buildQuickActionsCustom(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                TextString.quickActionText,
                style: TTextTheme.quickDashboardText(context),
                overflow: TextOverflow.ellipsis,
              ),
              const Icon(Icons.more_horiz, size: 20, color: AppColors.textColor),
            ],
          ),
          const SizedBox(height: 16),

          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.secondaryColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: LayoutBuilder(
              builder: (context, constraints) {
                bool isWide = constraints.maxWidth > 350;
                double spacing = 10.0;
                double buttonWidth = isWide
                    ? (constraints.maxWidth - spacing) / 2
                    : constraints.maxWidth;

                return Wrap(
                  spacing: spacing,
                  runSpacing: spacing,
                  children: [
                    AddButtonOfDashboard(
                      text: "Add Car",
                      onTap: () {
                        context.push('/addNewCar');
                      },
                      width: buttonWidth,
                      height: 45,
                    ),
                    AddButtonOfDashboard(
                      text: "Add Customer",
                      onTap: () {
                        Get.lazyPut(() => CustomerController(), fenix: true);
                        context.push('/addNewCustomer', extra: {"hideMobileAppBar": true});
                      },
                      width: buttonWidth,
                      height: 45,
                    ),
                    AddButtonOfDashboard(
                      text: "Add Pickup",
                      onTap: () {
                        Get.lazyPut(() => PickupCarController(), fenix: true);
                        context.push('/addpickup',extra: {"hideMobileAppBar": true});
                      },
                      width: buttonWidth,
                      height: 45,
                    ),
                    AddButtonOfDashboard(
                      text: "Add Dropoff",
                      onTap: (){
                        context.push('/addDropOff');
                      },
                      width: buttonWidth,
                      height: 45,
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
   // Cars Body Type Widget
  Widget _buildCarsByBodyType(BuildContext context) {
    final List<Map<String, dynamic>> bodyTypes = [
      {"type": "Sedan", "units": 12, "value": 0.7, "image": ImageString.sedanCar},
      {"type": "SUV", "units": 12, "value": 0.5, "image": ImageString.suvCar},
      {"type": "Hatchback", "units": 12, "value": 0.6, "image": ImageString.hatchBookCar},
      {"type": "Wagon", "units": 12, "value": 0.4, "image": ImageString.wagonCar},
      {"type": "Ute", "units": 12, "value": 0.8, "image": ImageString.uteCar},
      {"type": "Van", "units": 12, "value": 0.3, "image": ImageString.vanCar},
    ];

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: _cardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           Text(
            TextString.carBodyText,
            style: TTextTheme.h2Style(context)),
          const SizedBox(height: 20),
          Column(
            children: bodyTypes.map((item) => _buildBodyTypeItem(item)).toList(),
          ),
        ],
      ),
    );
  }
  Widget _buildBodyTypeItem(Map<String, dynamic> data) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double maxWidth = constraints.maxWidth;

        bool isExtraSmall = maxWidth < 270;

        return Obx(() {
          bool isSelected = controller.selectedBodyType.value == data['type'];

          return GestureDetector(
            onTap: () => controller.selectedBodyType.value = data['type'],
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              margin: const EdgeInsets.only(bottom: 12),
              padding: EdgeInsets.symmetric(
                  horizontal: isExtraSmall ? 8 : 16,
                  vertical: isExtraSmall ? 10 : 14
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                    color: isSelected ? AppColors.textColor : AppColors.sideBoxesColor,
                    width: isSelected ? 1.5 : 1
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  SizedBox(
                    width: isExtraSmall ? 40 : 80,
                    height: isExtraSmall ? 30 : 50,
                    child: Image.asset(
                      data['image'],
                      fit: BoxFit.contain,
                    ),
                  ),

                  SizedBox(width: isExtraSmall ? 8 : 15),

                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                  data['type'],
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: TTextTheme.carDataTypeText(context)
                              ),
                            ),
                            const SizedBox(width: 4),
                            Text(
                                "${data['units']} Units",
                                style: TTextTheme.carDataTypeTextUnit(context),
                            ),
                          ],
                        ),

                        SizedBox(height: isExtraSmall ? 6 : 10),

                        //  Progress Bar
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: LinearProgressIndicator(
                            value: data['value'],
                            minHeight: isExtraSmall ? 5 : 7,
                            backgroundColor:AppColors.secondaryColor,
                            valueColor: AlwaysStoppedAnimation<Color>(
                                isSelected ? AppColors.primaryColor: AppColors.textColor
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
      },
    );
  }


  // Dashboard Card (helper Widget)
  Widget _dashboardCard(String title, Widget child, {double? height}) {
    return Container(
      height: height, width: double.infinity, padding: const EdgeInsets.all(16),
      decoration: _cardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
          const SizedBox(height: 16),
          Expanded(child: child),
        ],
      ),
    );
  }

   // Box Decoration of the Containers
  BoxDecoration _cardDecoration() => BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14));
}


