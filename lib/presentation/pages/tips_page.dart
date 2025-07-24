import 'package:flutter/material.dart';

class TipsPage extends StatelessWidget {
  const TipsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Tips', style: Theme.of(context).textTheme.displaySmall),
          const SizedBox(height: 24),
          Text('Static content with financial tips.'),
        ],
      ),
    );
  }
} 