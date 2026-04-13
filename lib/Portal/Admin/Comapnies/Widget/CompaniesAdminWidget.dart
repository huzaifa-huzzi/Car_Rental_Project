import 'package:car_rental_project/Resources/IconStrings.dart';
import 'package:car_rental_project/Resources/TextTheme.dart' show TTextTheme;
import 'package:flutter/material.dart';

class CompaniesAdminWidget extends StatelessWidget {
  const CompaniesAdminWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // Responsive Row
            _buildStatsRow(context),

            const SizedBox(height: 40),

            Text("Company Management Table", style: TTextTheme.h2Style(context)),
          ],
        ),
      ),
    );
  }

  Widget _buildStatsRow(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double width = constraints.maxWidth;

        double itemWidth;
        int crossAxisCount;


        if (width > 850) {
          crossAxisCount = 4;
          itemWidth = (width - (16 * 3)) / 4;
        } else if (width > 550) {
          crossAxisCount = 2;
          itemWidth = (width - 16) / 2;
        } else {
          crossAxisCount = 1;
          itemWidth = width;
        }

        return Wrap(
          spacing: 16,
          runSpacing: 16,
          children: [
            _statCard(context, "Total Companies", "35", "3 more companies joined", IconString.paymentIconBlack, itemWidth),
            _statCard(context, "Active Companies", "22", "3 more companies activated", IconString.completedIcon, itemWidth),
            _statCard(context, "Suspended Companies", "6", "3 more cars added", IconString.actionRequiredIcon, itemWidth),
            _statCard(context, "New companies joined", "8", "3 more companies joined", IconString.submittedIcon, itemWidth),
          ],
        );
      },
    );
  }

  Widget _statCard(BuildContext context, String title, String value, String sub, String icon, double width) {
    return Container(
      width: width,
      // Mobile pe height thodi zyada rakhi hai taake overflow na ho
      constraints: const BoxConstraints(minHeight: 130),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 10),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween, // Content ko spread rakhega
        children: [
          Row(
            children: [
              Image.asset(icon, height: 18, width: 18),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  title,
                  style: TTextTheme.bodyRegular14tertiary(context),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),

          const SizedBox(height: 10), // Padding for spacing

          Text(
            value,
            style: TTextTheme.h1Style(context).copyWith(
              fontSize: 26,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 4),

          Text(
            sub,
            style: TTextTheme.bodySecondRegular10(context).copyWith(color: Colors.grey),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}