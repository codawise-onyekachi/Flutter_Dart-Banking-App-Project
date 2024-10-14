import 'package:flutter/material.dart';

class SavingsPage extends StatelessWidget {
  const SavingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Savings'),
        backgroundColor: Colors.grey, // Background color of the AppBar
        centerTitle: true, // This centers the title
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Total Savings:',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 10),
            Text(
              '\$10,000.00', // Example savings amount
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            // Additional savings information can go here
          ],
        ),
      ),
    );
  }
}
