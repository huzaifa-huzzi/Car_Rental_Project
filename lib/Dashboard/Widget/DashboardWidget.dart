import 'package:car_rental_project/Dashboard/DashboardController.dart';
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
                  : Row( // Sirf Desktop/Web pe side-by-side
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(flex: 3, child: Column(children: _buildMainSections(context))),
                  const SizedBox(width: 20),
                  Expanded(flex: 1, child: _buildRightSidePanel()),
                ],
              ),
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

    return [
      _buildRevenueSummarySection(context),
      const SizedBox(height: 20),
      isWide
          ? Row(
        crossAxisAlignment: CrossAxisAlignment.start, // Stretch ki jagah start use karein
        children: [
          // Cars by Status Section
          Expanded(
              flex: 2,
              child: _statusSectionCard("Cars by Status")
          ),
          const SizedBox(width: 20),
          // Dropoff Status Section - Height yahan define kar di hai error se bachne ke liye
          Expanded(
              flex: 1,
              child: SizedBox(
                  height: 310, // Fixed height taake layout crash na ho
                  child: _dashboardCard("Dropoff Status", _buildSimpleBarChart())
              )
          ),
        ],
      )
          : Column(
        children: [
          _statusSectionCard("Cars by Status"),
          const SizedBox(height: 20),
          _dashboardCard("Dropoff Status", _buildSimpleBarChart(), height: 320),
        ],
      ),
    ];
  }

  /* ===================== REVENUE SECTION (CONTROLLER INTEGRATED) ===================== */

  Widget _buildRevenueSummarySection(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        bool isSmall = constraints.maxWidth < 450;

        return Container(
          height: 400,
          padding: const EdgeInsets.all(20),
          decoration: _cardDecoration(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Responsive Header
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
              const SizedBox(height: 12),
              // Legends
              Row(
                children: [
                  _buildLegend(Colors.red, "Income"),
                  const SizedBox(width: 15),
                  _buildLegend(const Color(0xFF1E293B), "Expenses"),
                ],
              ),
              const SizedBox(height: 30),
              // 🔥 Web pe Full Width, Mobile pe Scrollable
              Expanded(
                child: isSmall
                    ? SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: SizedBox(width: 500, child: _buildRevenueChart()),
                )
                    : _buildRevenueChart(), // Web/Tablet pe direct expanded
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
        maxY: 700, minY: -600,
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
          // ... (leftTitles aur bottomTitles pehle wale hi rahen ge)
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 40,
              getTitlesWidget: (value, meta) {
                if (value % 300 == 0) {
                  return Text(value.abs().toInt().toString(),
                      style: const TextStyle(color: Colors.grey, fontSize: 10));
                }
                return const SizedBox();
              },
            ),
          ),
          rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (double value, TitleMeta meta) {
                const months = ['Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'];
                if (value >= 0 && value < 12) {
                  return SideTitleWidget(
                    meta: meta,
                    space: 10,
                    child: Text(months[value.toInt()], style: const TextStyle(color: Colors.grey, fontSize: 10)),
                  );
                }
                return const SizedBox();
              },
            ),
          ),
        ),

        /* ================= TOOLTIP & TOUCH SETTINGS ================= */
        barTouchData: BarTouchData(
          enabled: true,
          handleBuiltInTouches: true, // Built-in touch handling ko enable rakhen
          touchTooltipData: BarTouchTooltipData(
            getTooltipColor: (group) => Colors.white,
            tooltipRoundedRadius: 8,
            tooltipPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            fitInsideHorizontally: true, // Tooltip screen se bahar nahi jaye ga
            fitInsideVertically: true,
            getTooltipItem: (group, groupIndex, rod, rodIndex) {
              return BarTooltipItem(
                'Income\n',
                const TextStyle(color: Colors.grey, fontSize: 10),
                children: [
                  TextSpan(
                    text: '\$${controller.income[group.x.toInt()]}',
                    style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 14
                    ),
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
                toY: controller.income[index],
                fromY: -controller.expense[index],
                width: 16,
                borderRadius: BorderRadius.circular(4),
                rodStackItems: [
                  BarChartRodStackItem(-controller.expense[index], 0, const Color(0xFF1E293B)),
                  BarChartRodStackItem(0, controller.income[index], Colors.red),
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

  Widget _statusSectionCard(String title) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: _cardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
          const SizedBox(height: 20),
          // 🔥 Agar mobile nahi hai (Web/Tablet), to hamesha Row mein dikhao
          !isMobile
              ? Row(
            children: [
              Expanded(child: _statusCircularItem("215", "Available", Colors.red, 0.7)),
              const SizedBox(width: 12),
              Expanded(child: _statusCircularItem("215", "Maintenance", Colors.grey.shade500, 0.5)),
              const SizedBox(width: 12),
              Expanded(child: _statusCircularItem("215", "Unavailable", Colors.black, 0.3)),
            ],
          )
              : Column( // Mobile par ek ke niche ek
            children: [
              _statusCircularItem("215", "Available", Colors.red, 0.7),
              const SizedBox(height: 12),
              _statusCircularItem("215", "Maintenance", Colors.grey.shade500, 0.5),
              const SizedBox(height: 12),
              _statusCircularItem("215", "Unavailable", Colors.black, 0.3),
            ],
          ),
        ],
      ),
    );
  }

  Widget _statusCircularItem(String units, String label, Color color, double progress) {
    return Container(
      // Padding thodi barhayi hai design ke liye
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: 65, height: 65,
                child: CircularProgressIndicator(
                  value: 1.0, strokeWidth: 7, color: Colors.grey.shade100,
                ),
              ),
              SizedBox(
                width: 65, height: 65,
                child: CircularProgressIndicator(
                  value: progress, strokeWidth: 7, color: color,
                  strokeCap: StrokeCap.round,
                ),
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(units, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: color)),
                  const Text("Units", style: TextStyle(fontSize: 9, color: Colors.grey)),
                ],
              ),
            ],
          ),
          const SizedBox(height: 15),
          // Label Button Style
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 8),
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              label,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSimpleBarChart() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Dropdown (Wahi purana wala logic)
        Align(
          alignment: Alignment.topRight,
          child: Obx(() => Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            decoration: BoxDecoration(
              color: const Color(0xFFF1F5F9),
              borderRadius: BorderRadius.circular(8),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: controller.selectedDropoffPeriod.value,
                isDense: true,
                style: const TextStyle(fontSize: 11, color: Colors.black87, fontWeight: FontWeight.bold),
                icon: const Icon(Icons.keyboard_arrow_down, size: 16),
                items: controller.dropoffPeriods.map((p) => DropdownMenuItem(value: p, child: Text(p))).toList(),
                onChanged: (val) => controller.updateDropoffFilter(val),
              ),
            ),
          )),
        ),
        const SizedBox(height: 10),
        Expanded(
          child: Row(
            children: [
              // Bar Chart Section
              Expanded(
                flex: 1,
                child: Obx(() {
                  double maxVal = (controller.completedDropoffs.value > controller.incompleteDropoffs.value
                      ? controller.completedDropoffs.value
                      : controller.incompleteDropoffs.value).toDouble();

                  return BarChart(
                    BarChartData(
                      alignment: BarChartAlignment.spaceEvenly,
                      maxY: maxVal * 1.2,
                      gridData: const FlGridData(show: false),
                      borderData: FlBorderData(show: false),
                      titlesData: const FlTitlesData(show: false),
                      barGroups: [
                        BarChartGroupData(
                          x: 0,
                          barRods: [
                            BarChartRodData(
                              toY: controller.incompleteDropoffs.value.toDouble(),
                              color: const Color(0xFF1E293B),
                              width: 12,
                              borderRadius: const BorderRadius.vertical(top: Radius.circular(4)),
                            ),
                          ],
                        ),
                        BarChartGroupData(
                          x: 1,
                          barRods: [
                            BarChartRodData(
                              toY: controller.completedDropoffs.value.toDouble(),
                              color: Colors.red,
                              width: 12,
                              borderRadius: const BorderRadius.vertical(top: Radius.circular(4)),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                }),
              ),
              Expanded(
                flex: 1,
                child: Obx(() => Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Flexible(child: _buildDropoffLegend("Completed", "${controller.completedDropoffs.value}", Colors.red)),
                    const SizedBox(height: 12),
                    Flexible(child: _buildDropoffLegend("Incomplete", "${controller.incompleteDropoffs.value}", const Color(0xFF1E293B))),
                  ],
                )),
              ),
            ],
          ),
        ),
      ],
    );
  }

// Helper legend widget
  Widget _buildDropoffLegend(String label, String value, Color color) {
    return FittedBox(
      fit: BoxFit.scaleDown,
      alignment: Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Icon(Icons.circle, size: 8, color: color),
              const SizedBox(width: 6),
              Text(label, style: TextStyle(color: color.withOpacity(0.8), fontSize: 11)),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 14),
            child: Text("$value Dropoff", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
          ),
        ],
      ),
    );
  }

  Widget _buildRightSidePanel() {
    return Column(
      children: [
        _dashboardCard(
          "Quick Actions",
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFFF1F5F9),
              borderRadius: BorderRadius.circular(12),
            ),
            child: LayoutBuilder(
              builder: (context, constraints) {
                // Agar width zyada hai (Web/Tablet), to 2 columns dikhao
                int crossAxisCount = constraints.maxWidth > 350 ? 2 : 1;

                return GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: crossAxisCount,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 3.5, // Buttons ki height control karne ke liye
                  children: [
                    _actionButton("Add Car"),
                    _actionButton("Add Customer"),
                    _actionButton("Add Pickup"),
                    _actionButton("Add Dropoff"),
                  ],
                );
              },
            ),
          ),
          height: 220, // Grid use karne se height thodi kam ho jayegi
        ),
        const SizedBox(height: 20),
        _dashboardCard("Cars by Body Type", Column(children: List.generate(5, (index) => Padding(padding: const EdgeInsets.symmetric(vertical: 8), child: LinearProgressIndicator(value: 0.7, backgroundColor: Colors.grey.shade200, color: Colors.red, minHeight: 6)))), height: 260),
      ],
    );
  }
  Widget _actionButton(String title, {bool isLast = false}) {
    return Padding(
      padding: EdgeInsets.only(bottom: isLast ? 0 : 10),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFFF3141),
            foregroundColor: Colors.white,
            elevation: 0,
            // Padding thodi kam ki hai taka small screens par overflow na ho
            padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 8),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
          onPressed: () {},
          child: FittedBox( // 🔥 Yeh text ko button ke mutabiq chota kar dega
            fit: BoxFit.scaleDown,
            child: Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15, // Base font size
              ),
            ),
          ),
        ),
      ),
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
