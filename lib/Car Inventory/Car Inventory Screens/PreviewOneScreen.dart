import 'package:car_rental_project/Car%20Inventory/Widgets/CardListHeaderWidget.dart';
import 'package:car_rental_project/Car%20Inventory/Widgets/HeaderWebWidget.dart';
import 'package:flutter/material.dart';

class PreviewOneScreen extends StatelessWidget {
  const PreviewOneScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,

      body: Column(
        children: [

          /// -------------------------------
          /// 🔵 MAIN WEB HEADER
          /// -------------------------------
           HeaderWebWidget(mainTitle: 'Cars',),


          /// spacing below header
          const SizedBox(height: 14),

          /// -------------------------------
          /// 🔵 CAR LIST HEADER (search + filter + add car etc.)
          /// -------------------------------
          CardListHeaderWidget(
            onSearch: () {
              print("Search pressed");
            },
            onFilter: () {
              print("Filter pressed");
            },
            onListView: () {
              print("List view pressed");
            },
            onGridView: () {
              print("Grid view pressed");
            },
            onAddCar: () {
              print("Add car pressed");
            },
          ),

          /// -------------------------------
          /// Your screen content
          /// -------------------------------
          Expanded(
            child: Center(
              child: Text(
                "Preview One Screen",
                style: TextStyle(fontSize: 20),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
