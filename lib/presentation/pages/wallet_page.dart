import 'package:flutter/material.dart';

class WalletPage extends StatelessWidget {
  const WalletPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Wallet', style: Theme.of(context).textTheme.displaySmall),
          const SizedBox(height: 24),
          Text('Account control, balance and manual transactions.'),
        ],
      ),
    );
  }
} 