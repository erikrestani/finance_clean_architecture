import 'package:flutter/material.dart';

class ReportScreen extends StatelessWidget {
  const ReportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Report', style: Theme.of(context).textTheme.displaySmall),
          const SizedBox(height: 24),
          Text('Expense and income visualization with static charts.'),
        ],
      ),
    );
  }
}
