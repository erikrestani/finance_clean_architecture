import 'package:flutter/material.dart';
import '../../domain/entities/account.dart';

class PredefinedAccount {
  final String name;
  final IconData icon;
  final Color color;
  final AccountType accountType;
  final String? bankName;

  const PredefinedAccount({
    required this.name,
    required this.icon,
    required this.color,
    required this.accountType,
    this.bankName,
  });
}

class PredefinedAccounts {
  static const List<PredefinedAccount> debitAccounts = [
    PredefinedAccount(
      name: 'Nubank',
      icon: Icons.account_balance_wallet,
      color: Color(0xFF8A05BE),
      accountType: AccountType.debit,
      bankName: 'Nubank',
    ),
    PredefinedAccount(
      name: 'PicPay',
      icon: Icons.payment,
      color: Color(0xFF00D4AA),
      accountType: AccountType.debit,
      bankName: 'PicPay',
    ),
    PredefinedAccount(
      name: 'Inter',
      icon: Icons.account_balance,
      color: Color(0xFFFF7A00),
      accountType: AccountType.debit,
      bankName: 'Banco Inter',
    ),
    PredefinedAccount(
      name: 'C6 Bank',
      icon: Icons.account_balance_wallet,
      color: Color(0xFF000000),
      accountType: AccountType.debit,
      bankName: 'C6 Bank',
    ),
  ];

  static const List<PredefinedAccount> creditAccounts = [
    PredefinedAccount(
      name: 'Nubank Credit',
      icon: Icons.credit_card,
      color: Color(0xFF8A05BE),
      accountType: AccountType.credit,
      bankName: 'Nubank',
    ),
    PredefinedAccount(
      name: 'Inter Credit',
      icon: Icons.credit_card,
      color: Color(0xFFFF7A00),
      accountType: AccountType.credit,
      bankName: 'Banco Inter',
    ),
    PredefinedAccount(
      name: 'C6 Credit',
      icon: Icons.credit_card,
      color: Color(0xFF000000),
      accountType: AccountType.credit,
      bankName: 'C6 Bank',
    ),
    PredefinedAccount(
      name: 'Other Credit',
      icon: Icons.credit_card,
      color: Color(0xFF3B82F6),
      accountType: AccountType.credit,
    ),
  ];

  static const List<PredefinedAccount> savingsAccounts = [
    PredefinedAccount(
      name: 'Savings',
      icon: Icons.savings,
      color: Color(0xFF10B981),
      accountType: AccountType.savings,
    ),
    PredefinedAccount(
      name: 'Investment',
      icon: Icons.trending_up,
      color: Color(0xFFF59E0B),
      accountType: AccountType.investment,
    ),
  ];

  static List<PredefinedAccount> getAllAccounts() {
    return [
      ...debitAccounts,
      ...creditAccounts,
      ...savingsAccounts,
    ];
  }

  static List<PredefinedAccount> getAccountsByType(AccountType type) {
    switch (type) {
      case AccountType.debit:
        return debitAccounts;
      case AccountType.credit:
        return creditAccounts;
      case AccountType.savings:
        return savingsAccounts;
      case AccountType.investment:
        return savingsAccounts.where((account) => account.accountType == AccountType.investment).toList();
    }
  }
} 