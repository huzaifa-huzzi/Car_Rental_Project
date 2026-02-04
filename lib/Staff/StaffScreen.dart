import 'package:car_rental_project/Resources/TextTheme.dart';
import 'package:flutter/material.dart';


class StaffScreen extends StatefulWidget {
  const StaffScreen({super.key});

  @override
  State<StaffScreen> createState() => _StaffScreenState();
}

class _StaffScreenState extends State<StaffScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children:  [
        Center(
          child: Text(
            "Staff is coming Soon!",
            style: TTextTheme.h1Style(context),
          ),
        )
      ],
    );
  }
}