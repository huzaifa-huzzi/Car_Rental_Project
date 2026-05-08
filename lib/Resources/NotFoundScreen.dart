import 'package:car_rental_project/Portal/Vendor/DropOffCar/ReusableWidgetOfDropoff/PrimaryBtnDropOff.dart';
import 'package:car_rental_project/Resources/ImageString.dart';
import 'package:car_rental_project/Resources/TextString.dart';
import 'package:car_rental_project/Resources/TextTheme.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class NotFoundScreen extends StatelessWidget {
  const NotFoundScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(ImageString.ErrorScreen, height: 250),
            const SizedBox(height: 20),
            Text(
              TextString.title,
              style: TTextTheme.h1StyleBlack(context),
            ),
            const SizedBox(height: 10),
            Text(
              TextString.foundSubtitle,
              style: TTextTheme.btnTwomain(context),
            ),
            const SizedBox(height: 30),
           PrimaryBthDropOff(width: 150,height: 40,text: "Go to Dashboard", onTap: () => context.go('/dashboard'))
          ],
        ),
      ),
    );
  }
}