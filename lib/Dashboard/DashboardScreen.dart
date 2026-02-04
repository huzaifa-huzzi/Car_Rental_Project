import 'package:car_rental_project/Resources/TextTheme.dart';
import 'package:flutter/material.dart';


class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children:  [
        Center(
          child: Text(
            "Dashboard is coming Soon!",
            style: TTextTheme.h1Style(context),
          ),
        )
      ],
    );
  }
}
