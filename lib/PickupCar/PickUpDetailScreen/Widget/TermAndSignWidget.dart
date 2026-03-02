import 'package:flutter/material.dart';

class TermsAndSignScreen extends StatelessWidget {
  const TermsAndSignScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final bool isMobile = screenWidth < 800;

    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(isMobile ? 15 : 30),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Terms and Conditions", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 15),
            // Terms ka text yahan dalein
            Text("Acceptance of Term: ...", style: TextStyle(color: Colors.grey)),

            SizedBox(height: 40),

            Text("Signature", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 15),
            // Signature pad yahan dalein
            Container(height: 120, color: Colors.grey.shade100, child: Center(child: Text("Signature Pad"))),
          ],
        ),
      ),
    );
  }
}