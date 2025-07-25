import 'package:flutter/material.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Dashboard', style: Theme.of(context).textTheme.displaySmall),
          const SizedBox(height: 24),
          Text('Financial summary, balance, expenses, income and shortcuts.'),
        ],
      ),
    );
  }
} 