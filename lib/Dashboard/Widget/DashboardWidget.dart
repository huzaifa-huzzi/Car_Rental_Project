import 'package:car_rental_project/Dashboard/DashboardController.dart';
import 'package:car_rental_project/Dashboard/ReusableWidgetOfDashboard/PrimaryButtonOfDashBoard.dart';
import 'package:car_rental_project/Resources/Colors.dart';
import 'package:car_rental_project/Resources/ImageString.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:get/get.dart';


class DashboardContent extends StatelessWidget {
  final bool isMobile;
  final bool isTablet;

  // Controller ko inject karein
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
        // Tablet aur Mobile dono ke liye vertical layout rakhein taake overflow na ho
        bool useVerticalLayout = isMobile || isTablet;

        return SingleChildScrollView(
          padding: EdgeInsets.all(isMobile ? 12 : 20),
          child: Column(
            children: [
              _buildStatsGrid(constraints.maxWidth),
              const SizedBox(height: 20),

              useVerticalLayout
                  ? Column( // Tablet aur Mobile pe ek ke niche ek
                children: [
                  ..._buildMainSections(context),
                  const SizedBox(height: 20),
                  _buildRightSidePanel(), // Yeh ab hamesha niche aayega full width ke saath
                ],
              )
                  : Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Left Side (Revenue Chart etc)
                  Expanded(
                    flex: 4, // Isse thoda kam kar sakte hain agar right side ko jagah deni hai
                    child: Column(children: _buildMainSections(context)),
                  ),

                  const SizedBox(width: 20), // Dono panels ke beech gap

                  // Right Side Panel (Quick Actions + Body Type)
                  Expanded(
                    flex: 2, // 🔥 Isse 1 se barha kar 2 (ya 1.5) kar den. Isse right panel wide ho jayega.
                    child: _buildRightSidePanel(),
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }

  /* ===================== TOP STATS ===================== */

  Widget _buildStatsGrid(double width) {
    int crossAxisCount = width < 400 ? 1 : width < 900 ? 2 : 4;
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: crossAxisCount,
      crossAxisSpacing: 16,
      mainAxisSpacing: 16,
      childAspectRatio: 2.8,
      children: [
        _statCard("Total Cars", "214", Icons.directions_car),
        _statCard("Total Customers", "386", Icons.people),
        _statCard("Total Pickups", "214", Icons.inventory_2),
        _statCard("Total Dropoffs", "89", Icons.assignment_turned_in),
      ],
    );
  }

  Widget _statCard(String title, String value, IconData icon) {
    return Container(
      // Padding ko thoda kam kiya taake space bache
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: _cardDecoration(),
      child: Row(
        // MainAxisAlignment ko center rakhein taake agar space ho to content bura na lage
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Icon Container
          Container(
            width: 38, height: 38, // Size thoda chota kiya
            decoration: BoxDecoration(
              color: const Color(0xFFF1F5F9),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, size: 18, color: const Color(0xFF334155)),
          ),
          const SizedBox(width: 8),


          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontSize: 11, color: Color(0xFF94A3B8), fontWeight: FontWeight.w500),
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
                            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF0F172A))
                        ),
                        const TextSpan(
                            text: " Unit",
                            style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: Color(0xFF64748B))
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

  /* ===================== MAIN SECTIONS ===================== */

  List<Widget> _buildMainSections(BuildContext context) {
    bool isWide = !isMobile;
    double targetHeight = 200; // Desktop height
    double mobileHeight = 300; // Mobile height
    double statusMobileHeight = 460; // Mobile height

    return [
      _buildRevenueSummarySection(context),
      const SizedBox(height: 20),
      isWide
          ? Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: _statusSectionCard("Cars by Status", height: targetHeight),
          ),
          const SizedBox(width: 20),
          Expanded(
            flex: 1,
            child: _dashboardCard(
              "Dropoff Status",
              _buildSimpleBarChart(),
              height: targetHeight,
            ),
          ),
        ],
      )
          : Column(
        children: [
          // 🔥 Yahan height pass karna zaroori tha crash rokne ke liye
          _statusSectionCard("Cars by Status", height: statusMobileHeight),
          const SizedBox(height: 20),
          _dashboardCard(
            "Dropoff Status",
            _buildSimpleBarChart(),
            height: mobileHeight,
          ),
        ],
      ),

      const SizedBox(height: 20),

      isWide
          ? Row(
        children: [
          Expanded(child: _buildPickupStatusSection()),
          const SizedBox(width: 20),
          Expanded(child: _buildDropoffDamageSection()),
        ],
      )
          : Column(
        children: [
          _buildPickupStatusSection(),
          const SizedBox(height: 20),
          _buildDropoffDamageSection(),
        ],
      ),
    ];
  }

  /* ===================== REVENUE SECTION (CONTROLLER INTEGRATED) ===================== */

  Widget _buildRevenueSummarySection(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        bool isVerySmall = constraints.maxWidth < 250;
        bool isSmall = constraints.maxWidth < 450;

        return Container(
          height: 440, // Scrollbar ki jagah ke liye height thodi mazeed barha di
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
                  const Text("Revenue Summary", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  const SizedBox(height: 10),
                  _buildResponsiveDropdown(),
                ],
              )
                  : Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Revenue Summary", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  _buildResponsiveDropdown(),
                ],
              ),
              const SizedBox(height: 15),

              // Legends Section (Adaptive)
              isVerySmall
                  ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildLegend(Colors.red, "Income"),
                  const SizedBox(height: 8),
                  _buildLegend(const Color(0xFF1E293B), "Expenses"),
                ],
              )
                  : Row(
                children: [
                  _buildLegend(Colors.red, "Income"),
                  const SizedBox(width: 15),
                  _buildLegend(const Color(0xFF1E293B), "Expenses"),
                ],
              ),
              const SizedBox(height: 25),

              // 🔥 Custom Styled Scrollbar for Mobile/Small views
              Expanded(
                child: isSmall
                    ? Theme(
                  data: ThemeData(
                    scrollbarTheme: ScrollbarThemeData(
                      thumbColor: WidgetStateProperty.all(Colors.red.withOpacity(0.8)), // Scrollbar Red jesa dikhega
                      thickness: WidgetStateProperty.all(4), // Patla aur sleek design
                      radius: const Radius.circular(10),
                      thumbVisibility: WidgetStateProperty.all(true), // Hamesha nazar aaye
                    ),
                  ),
                  child: Scrollbar(
                    // Scrollbar ko titles ke upar lane ke liye padding settings
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 15), // Scrollbar aur Bottom Titles ke beech gap
                        child: SizedBox(
                          width: 600, // Thodi width barha di taake scroll smooth ho
                          child: _buildRevenueChart(),
                        ),
                      ),
                    ),
                  ),
                )
                    : _buildRevenueChart(),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildRevenueChart() {
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
            color: Colors.grey.withOpacity(0.1),
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
                      style: const TextStyle(color: Colors.grey, fontSize: 10));
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
                        style: const TextStyle(color: Colors.grey, fontSize: 10, fontWeight: FontWeight.w500)),
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
            getTooltipColor: (group) => Colors.white,
            tooltipRoundedRadius: 8,
            fitInsideHorizontally: true,
            fitInsideVertically: true,
          ),
        ),

        barGroups: List.generate(12, (index) {
          return BarChartGroupData(
            x: index,
            barRods: [
              BarChartRodData(
                toY: (controller.income[index] as num).toDouble(),
                fromY: -(controller.expense[index] as num).toDouble(),
                width: 16,
                borderRadius: BorderRadius.circular(4),
                rodStackItems: [
                  BarChartRodStackItem(-(controller.expense[index] as num).toDouble(), 0, const Color(0xFF1E293B)),
                  BarChartRodStackItem(0, (controller.income[index] as num).toDouble(), Colors.red),
                ],
              ),
            ],
          );
        }),
      ),
    ));
  }

// Separate Dropdown Widget for Cleanliness
  Widget _buildResponsiveDropdown() {
    return Obx(() => Container(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: const Color(0xFFF8F9FA),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: controller.selectedPeriod.value,
          isDense: true, // Space bachane ke liye
          icon: const Icon(Icons.keyboard_arrow_down, size: 16),
          onChanged: (val) => controller.updateFilter(val),
          items: controller.periods.map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value, style: const TextStyle(fontSize: 11)),
            );
          }).toList(),
        ),
      ),
    ));
  }

  Widget _buildLegend(Color color, String label) {
    return Row(
      children: [
        Container(width: 8, height: 8, decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(2))),
        const SizedBox(width: 6),
        Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
      ],
    );
  }

  /* ===================== OTHER CHARTS & PANEL ===================== */


  Widget _buildPickupStatusSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: _cardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 🔥 Wrap ko SizedBox mein dala taake ye poori width le sake
          SizedBox(
            width: double.infinity,
            child: Wrap(
              alignment: WrapAlignment.spaceBetween, // Desktop pe door rakhega
              crossAxisAlignment: WrapCrossAlignment.center,
              runSpacing: 12, // Mobile pe shift hone pe gap
              children: [
                const Text(
                  "Pickup Status",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Color(0xFF1E293B)
                  ),
                ),

                // Right side group
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                        "Sort by: ",
                        style: TextStyle(color: Colors.grey, fontSize: 10)
                    ),
                    const SizedBox(width: 4),
                    Obx(() => Container(
                      height: 28,
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF1F5F9),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: controller.selectedPickupPeriod.value,
                          isDense: true,
                          icon: const Icon(Icons.keyboard_arrow_down, size: 14),
                          style: const TextStyle(
                              fontSize: 10,
                              color: Colors.black87,
                              fontWeight: FontWeight.bold
                          ),
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

          const SizedBox(height: 25),

          // Bars Section
          Obx(() {
            var data = controller.pickupData[controller.selectedPickupPeriod.value]!;
            return Column(
              children: [
                _buildPickupBar("Completed", data['completed']!, "45 Unit", const Color(0xFF1E293B)),
                const SizedBox(height: 20),
                _buildPickupBar("Awaiting", data['awaiting']!, "40 Unit", Colors.red),
                const SizedBox(height: 20),
                _buildPickupBar("Overdue", data['overdue']!, "50 Unit", const Color(0xFFFFBABD)),
                const SizedBox(height: 20),
                _buildPickupBar("Processing", data['processing']!, "30 Unit", const Color(0xFFCBD5E1)),
              ],
            );
          }),
        ],
      ),
    );
  }

  Widget _buildPickupBar(String label, double progress, String unit, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 1. Progress Bar (Top)
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: LinearProgressIndicator(
            value: progress,
            minHeight: 10, // 🔥 Standard thickness
            backgroundColor: const Color(0xFFF1F5F9),
            color: color,
          ),
        ),
        const SizedBox(height: 10), // 🔥 Bar aur Text ke darmiyan gap

        // 2. Info Row (Bottom)
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                label,
                style: TextStyle(fontSize: 10, color: color, fontWeight: FontWeight.bold),
              ),
            ),
            Text(
              unit,
              style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1E293B)
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildDropoffDamageSection() {
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
                const Text(
                  "Dropoff Damage",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Color(0xFF1E293B)),
                ),

                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text("Sort by: ", style: TextStyle(color: Colors.grey, fontSize: 10)),
                    const SizedBox(width: 4),
                    // 🔥 Ab ye sirf Damage section ko control karega
                    Obx(() => Container(
                      height: 28,
                      padding: const EdgeInsets.symmetric(horizontal: 6),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF1F5F9),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: controller.selectedDamagePeriod.value, // 👈 Naya Variable
                          isDense: true,
                          icon: const Icon(Icons.keyboard_arrow_down, size: 14),
                          style: const TextStyle(fontSize: 10, color: Colors.black87, fontWeight: FontWeight.bold),
                          items: controller.damagePeriods.map((p) => DropdownMenuItem(
                              value: p,
                              child: Text(p)
                          )).toList(),
                          onChanged: (val) => controller.updateDamageFilter(val), // 👈 Naya Function
                        ),
                      ),
                    )),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 10),

          // Damage/Safe Legend
          Row(
            children: [
              _buildLegendItem("Damage", Colors.red),
              const SizedBox(width: 15),
              _buildLegendItem("Safe", Colors.grey.shade300),
            ],
          ),
          const SizedBox(height: 20),
          SizedBox(height: 160, child: _buildDropoffDamageChart()),
        ],
      ),
    );
  }

// Chota helper legend ke liye
  Widget _buildLegendItem(String label, Color color) {
    return Row(
      children: [
        Container(width: 8, height: 8, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
        const SizedBox(width: 6),
        Text(label, style: const TextStyle(fontSize: 10, color: Colors.grey)),
      ],
    );
  }

  Widget _buildDropoffDamageChart() {
    return Obx(() {
      var currentData = controller.damageDataMap[controller.selectedDamagePeriod.value]!;
      double safeY = (currentData['safe'] as num).toDouble();
      double damageY = (currentData['damage'] as num).toDouble();
      String safeCount = currentData['safeCount'].toString();
      String damageCount = currentData['damageCount'].toString();

      return Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // 1. Chart Section
          Expanded(
            flex: 1,
            child: Column(
              children: [
                Expanded(
                  child: BarChart(
                    BarChartData(
                      gridData: const FlGridData(show: false),
                      borderData: FlBorderData(show: false),
                      titlesData: const FlTitlesData(show: false),
                      barGroups: [
                        BarChartGroupData(x: 0, barRods: [
                          BarChartRodData(toY: safeY, color: Colors.grey.shade200, width: 25, borderRadius: BorderRadius.circular(6))
                        ]),
                        BarChartGroupData(x: 1, barRods: [
                          BarChartRodData(toY: damageY, color: Colors.red, width: 25, borderRadius: BorderRadius.circular(6))
                        ]),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text("50%", style: TextStyle(fontSize: 10, color: Colors.grey)),
                    Text("50%", style: TextStyle(fontSize: 10, color: Colors.red, fontWeight: FontWeight.bold)),
                  ],
                )
              ],
            ),
          ),

          const SizedBox(width: 8),

          // 2. Stats Section
          Expanded(
            flex: 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 🔥 Dynamic Counts with Ellipsis
                _buildDamageStat("$damageCount Cars", "50%", Colors.red),
                const SizedBox(height: 20),
                _buildDamageStat("$safeCount Cars", "50%", Colors.grey.shade300),
              ],
            ),
          ),
        ],
      );
    });
  }

  Widget _buildDamageStat(String count, String percent, Color color) {
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
            // 🔥 Text ko Flexible mein dala aur Ellipsis lagaya
            Flexible(
              child: Text(
                count,
                overflow: TextOverflow.ellipsis, // Lambe text ko '...' kar dega
                maxLines: 1,
                softWrap: false,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(left: 14),
          child: Text(
              percent,
              style: TextStyle(color: Colors.grey.shade500, fontSize: 10)
          ),
        ),
      ],
    );
  }

  Widget _statusSectionCard(String title, {double? height}) {
    return Container(
      height: height, // Yahan aap 220 ya 240 pass kar sakte hain
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12), // 🔥 Vertical padding 16 se 12 ki
      decoration: _cardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)), // 🔥 Font 15 se 14
          const SizedBox(height: 40), // 🔥 Gap kam kiya
          !isMobile
              ? Row(
            children: [
              Expanded(child: _statusCircularItem("215", "Available", Colors.red, 0.7)),
              const SizedBox(width: 8), // Gap kam kiya
              Expanded(child: _statusCircularItem("215", "Maintenance", Colors.grey.shade500, 0.5)),
              const SizedBox(width: 8),
              Expanded(child: _statusCircularItem("215", "Unavailable", Colors.black, 0.3)),
            ],
          )
              : Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _statusCircularItem("215", "Available", Colors.red, 0.7),
              const SizedBox(height: 14),
              _statusCircularItem("215", "Maintenance", Colors.grey.shade500, 0.5),
              const SizedBox(height: 14),
              _statusCircularItem("215", "Unavailable", Colors.black, 0.3),
            ],
          ),
        ],
      ),
    );
  }

  Widget _statusCircularItem(String units, String label, Color color, double progress) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8), // 🔥 Vertical padding 20 se 12 ki
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 8, offset: const Offset(0, 2)),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: 50, height: 50, // 🔥 Circle size 65 se 50 kiya (Height bachegi)
                child: CircularProgressIndicator(value: 1.0, strokeWidth: 5, color: Colors.grey.shade100),
              ),
              SizedBox(
                width: 50, height: 50,
                child: CircularProgressIndicator(value: progress, strokeWidth: 5, color: color, strokeCap: StrokeCap.round),
              ),
              Text(units, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: color)),
            ],
          ),
          const SizedBox(height: 10), // Gap kam kiya
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 6), // Button slim kiya
            decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(6)),
            child: Text(label, textAlign: TextAlign.center, style: const TextStyle(color: Colors.white, fontSize: 9, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  Widget _buildSimpleBarChart() {
    return Column(
      mainAxisSize: MainAxisSize.min, // 🔥 Content ke hisab se height le
      children: [
        Align(
          alignment: Alignment.topRight,
          child: Obx(() => Container(
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1), // Slimmer dropdown
            decoration: BoxDecoration(color: const Color(0xFFF1F5F9), borderRadius: BorderRadius.circular(6)),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: controller.selectedDropoffPeriod.value,
                isDense: true,
                style: const TextStyle(fontSize: 9, color: Colors.black87, fontWeight: FontWeight.bold),
                icon: const Icon(Icons.keyboard_arrow_down, size: 12),
                items: controller.dropoffPeriods.map((p) => DropdownMenuItem(value: p, child: Text(p))).toList(),
                onChanged: (val) => controller.updateDropoffFilter(val),
              ),
            ),
          )),
        ),
        const SizedBox(height: 8), // Gap 10 se 8 kiya
        Expanded(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center, // Center alignment for better look
            children: [
              Expanded(
                flex: 1,
                child: BarChart(
                  BarChartData(
                    barTouchData: BarTouchData(enabled: false),
                    alignment: BarChartAlignment.center,
                    groupsSpace: 8, // Bars ko close kiya
                    gridData: const FlGridData(show: false),
                    borderData: FlBorderData(show: false),
                    titlesData: const FlTitlesData(show: false),
                    barGroups: [
                      BarChartGroupData(x: 0, barRods: [
                        BarChartRodData(toY: 10, color: const Color(0xFF1E293B), width: 10, borderRadius: BorderRadius.circular(3))
                      ]),
                      BarChartGroupData(x: 1, barRods: [
                        BarChartRodData(toY: 8, color: Colors.red, width: 10, borderRadius: BorderRadius.circular(3))
                      ]),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildDropoffLegend("Completed", "4500", Colors.red),
                    const SizedBox(height: 6), // Gap kam kiya
                    _buildDropoffLegend("Incomplete", "5200", const Color(0xFF1E293B)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
// Helper legend widget
  Widget _buildDropoffLegend(String label, String value, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 6, height: 6, // Chota dot
              decoration: BoxDecoration(color: color, shape: BoxShape.circle),
            ),
            const SizedBox(width: 6),
            Flexible( // 🔥 Text ko wrap hone mein madad karega
              child: Text(
                  label,
                  overflow: TextOverflow.ellipsis, // Agar jagah na ho to ... dikhaye
                  style: TextStyle(color: color.withOpacity(0.7), fontSize: 10)
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(left: 12),
          child: Text(
              "$value Dropoff",
              overflow: TextOverflow.ellipsis, // 🔥 Overflow fix
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 11, // Font thoda chota kiya alignment ke liye
                  color: Color(0xFF0F172A)
              )
          ),
        ),
      ],
    );
  }

  Widget _buildRightSidePanel() {
    return Column(
      children: [
        SizedBox(height: 50,),
        _buildQuickActionsCustom(),
        const SizedBox(height: 50),
        _buildCarsByBodyType(),
      ],
    );
  }
  Widget _buildQuickActionsCustom() {
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
        mainAxisSize: MainAxisSize.min, // Jitna content, utni height
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Quick Actions",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.black87),
                overflow: TextOverflow.ellipsis,
              ),
              const Icon(Icons.more_horiz, size: 20, color: Color(0xFF94A3B8)),
            ],
          ),
          const SizedBox(height: 16),

          // Buttons Container
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFFF1F5F9), // Light grey background
              borderRadius: BorderRadius.circular(12),
            ),
            child: LayoutBuilder(
              builder: (context, constraints) {
                // Logic: Agar width 350 se zyada hai to 2 buttons, warna 1
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
                      onTap: () => print("Add Car Clicked"),
                      width: buttonWidth,
                      height: 45, // Fix height taake pyara lage
                    ),
                    AddButtonOfDashboard(
                      text: "Add Customer",
                      onTap: () => print("Add Customer Clicked"),
                      width: buttonWidth,
                      height: 45,
                    ),
                    AddButtonOfDashboard(
                      text: "Add Pickup",
                      onTap: () => print("Add Pickup Clicked"),
                      width: buttonWidth,
                      height: 45,
                    ),
                    AddButtonOfDashboard(
                      text: "Add Dropoff",
                      onTap: () => print("Add Dropoff Clicked"),
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
  Widget _buildCarsByBodyType() {
    final List<Map<String, dynamic>> bodyTypes = [
      {"type": "Sedan", "units": 12, "value": 0.7, "image": ImageString.corollaPicFive},
      {"type": "SUV", "units": 12, "value": 0.5, "image": ImageString.corollaPicFive},
      {"type": "Hatchback", "units": 12, "value": 0.6, "image": ImageString.corollaPicFive},
      {"type": "Wagon", "units": 12, "value": 0.4, "image": ImageString.corollaPicFive},
      {"type": "Ute", "units": 12, "value": 0.8, "image": ImageString.corollaPicFive},
    ];

    return Container(
      padding: const EdgeInsets.all(20), // Padding barha di
      decoration: _cardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Cars by Body Type",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Color(0xFF1E293B)),
          ),
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

        // 🔥 Overflow fix logic: Jab width 270 se kam ho
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
                    color: isSelected ? const Color(0xFF1E293B) : Colors.grey.shade100,
                    width: isSelected ? 1.5 : 1
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  // 1. Image Section: Extra small screen par size drastically kam kar diya
                  Container(
                    width: isExtraSmall ? 40 : 80,
                    height: isExtraSmall ? 30 : 50,
                    child: Image.asset(
                      data['image'],
                      fit: BoxFit.contain,
                    ),
                  ),

                  SizedBox(width: isExtraSmall ? 8 : 15),

                  // 2. Info Section: Expanded taake bachi hui width mein wrap ho jaye
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Car Name aur Units ko Flexible banaya
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                  data['type'],
                                  overflow: TextOverflow.ellipsis, // Text katega nahi, ... dikhayega
                                  maxLines: 1,
                                  style: TextStyle(
                                      fontSize: isExtraSmall ? 11 : 13,
                                      color: isSelected ? Colors.black : Colors.grey.shade600,
                                      fontWeight: isSelected ? FontWeight.bold : FontWeight.w500
                                  )
                              ),
                            ),
                            const SizedBox(width: 4),
                            Text(
                                "${data['units']} Units",
                                style: TextStyle(
                                    fontSize: isExtraSmall ? 10 : 12,
                                    fontWeight: FontWeight.bold,
                                    color: const Color(0xFF1E293B)
                                )
                            ),
                          ],
                        ),

                        SizedBox(height: isExtraSmall ? 6 : 10),

                        // 3. Progress Bar
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: LinearProgressIndicator(
                            value: data['value'],
                            minHeight: isExtraSmall ? 5 : 7,
                            backgroundColor: const Color(0xFFF1F5F9),
                            valueColor: AlwaysStoppedAnimation<Color>(
                                isSelected ? Colors.red : const Color(0xFF1E293B)
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

  BoxDecoration _cardDecoration() => BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14));
}


