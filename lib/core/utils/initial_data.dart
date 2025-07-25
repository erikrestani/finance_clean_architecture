import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import '../../domain/entities/account.dart';
import '../../domain/entities/transaction.dart';
import '../../domain/repositories/local_storage_repository.dart';

class InitialData {
  static Future<void> addSampleData() async {
    final localStorage = LocalStorageRepositoryImpl();

    final existingAccounts = await localStorage.getAccounts();
    if (existingAccounts.isNotEmpty) {
      return;
    }

    final accounts = [
      Account(
        id: const Uuid().v4(),
        name: 'Nubank',
        balance: 2500.0,
        color: const Color(0xFF8B5CF6),
        iconData: Icons.credit_card,
        accountType: AccountType.debit,
        createdAt: DateTime.now().subtract(const Duration(days: 30)),
        updatedAt: DateTime.now(),
      ),
      Account(
        id: const Uuid().v4(),
        name: 'Money',
        balance: 500.0,
        color: const Color(0xFF10B981),
        iconData: Icons.account_balance_wallet,
        accountType: AccountType.debit,
        createdAt: DateTime.now().subtract(const Duration(days: 15)),
        updatedAt: DateTime.now(),
      ),
      Account(
        id: const Uuid().v4(),
        name: 'PicPay',
        balance: 1200.0,
        color: const Color(0xFFF59E0B),
        iconData: Icons.account_balance,
        accountType: AccountType.debit,
        createdAt: DateTime.now().subtract(const Duration(days: 7)),
        updatedAt: DateTime.now(),
      ),
    ];

    await localStorage.saveAccounts(accounts);

    for (final account in accounts) {
      final transactions = [
        if (account.name == 'Nubank') ...[
          Transaction(
            id: const Uuid().v4(),
            amount: 500.0,
            description: 'Salary',
            type: TransactionType.credit,
            date: DateTime.now().subtract(const Duration(days: 2)),
          ),
          Transaction(
            id: const Uuid().v4(),
            amount: 45.50,
            description: 'Restaurant',
            type: TransactionType.debit,
            date: DateTime.now().subtract(const Duration(days: 1)),
          ),
          Transaction(
            id: const Uuid().v4(),
            amount: 120.0,
            description: 'Electricity Bill',
            type: TransactionType.debit,
            date: DateTime.now().subtract(const Duration(hours: 6)),
          ),
        ],

        if (account.name == 'Money') ...[
          Transaction(
            id: const Uuid().v4(),
            amount: 200.0,
            description: 'Freelance work',
            type: TransactionType.credit,
            date: DateTime.now().subtract(const Duration(hours: 2)),
          ),
          Transaction(
            id: const Uuid().v4(),
            amount: 15.0,
            description: 'Coffee',
            type: TransactionType.debit,
            date: DateTime.now().subtract(const Duration(minutes: 30)),
          ),
          Transaction(
            id: const Uuid().v4(),
            amount: 80.0,
            description: 'Grocery shopping',
            type: TransactionType.debit,
            date: DateTime.now().subtract(const Duration(hours: 1)),
          ),
        ],

        if (account.name == 'PicPay') ...[
          Transaction(
            id: const Uuid().v4(),
            amount: 300.0,
            description: 'Investment deposit',
            type: TransactionType.credit,
            date: DateTime.now().subtract(const Duration(days: 3)),
          ),
          Transaction(
            id: const Uuid().v4(),
            amount: 25.0,
            description: 'Uber ride',
            type: TransactionType.debit,
            date: DateTime.now().subtract(const Duration(hours: 4)),
          ),
          Transaction(
            id: const Uuid().v4(),
            amount: 150.0,
            description: 'Internet bill',
            type: TransactionType.debit,
            date: DateTime.now().subtract(const Duration(days: 1)),
          ),
        ],
      ];

      for (final transaction in transactions) {
        await localStorage.addTransaction(account.id, transaction);
      }
    }
  }
}
