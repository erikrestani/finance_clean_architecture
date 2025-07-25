import 'package:flutter/material.dart';
import '../entities/account.dart';
import 'account_repository.dart';

class AccountRepositoryImpl implements AccountRepository {
  final List<Account> _accounts = [
    Account(
      id: '1',
      name: 'Nubank',
      balance: 2500.0,
      color: const Color(0xFF8B5CF6),
      iconData: Icons.credit_card,
      createdAt: DateTime.now().subtract(const Duration(days: 30)),
      updatedAt: DateTime.now(),
    ),
    Account(
      id: '2',
      name: 'Money',
      balance: 500.0,
      color: const Color(0xFF10B981),
      iconData: Icons.account_balance_wallet,
      createdAt: DateTime.now().subtract(const Duration(days: 15)),
      updatedAt: DateTime.now(),
    ),
    Account(
      id: '3',
      name: 'PicPay',
      balance: 1200.0,
      color: const Color(0xFFF59E0B),
      iconData: Icons.account_balance,
      createdAt: DateTime.now().subtract(const Duration(days: 7)),
      updatedAt: DateTime.now(),
    ),
  ];

  @override
  Future<List<Account>> getAccounts() async {
    // Simula delay de rede
    await Future.delayed(const Duration(milliseconds: 500));
    return _accounts;
  }

  @override
  Future<Account> getAccountById(String id) async {
    await Future.delayed(const Duration(milliseconds: 300));
    final account = _accounts.firstWhere((account) => account.id == id);
    return account;
  }

  @override
  Future<Account> createAccount(Account account) async {
    await Future.delayed(const Duration(milliseconds: 800));
    _accounts.add(account);
    return account;
  }

  @override
  Future<Account> updateAccount(Account account) async {
    await Future.delayed(const Duration(milliseconds: 600));
    final index = _accounts.indexWhere((a) => a.id == account.id);
    if (index != -1) {
      _accounts[index] = account;
    }
    return account;
  }

  @override
  Future<void> deleteAccount(String id) async {
    await Future.delayed(const Duration(milliseconds: 400));
    _accounts.removeWhere((account) => account.id == id);
  }

  @override
  Future<Account> addBalance(String accountId, double amount) async {
    await Future.delayed(const Duration(milliseconds: 500));
    final index = _accounts.indexWhere((account) => account.id == accountId);
    if (index != -1) {
      final account = _accounts[index];
      final updatedAccount = account.copyWith(
        balance: account.balance + amount,
        updatedAt: DateTime.now(),
      );
      _accounts[index] = updatedAccount;
      return updatedAccount;
    }
    throw Exception('Account not found');
  }

  @override
  Future<Account> subtractBalance(String accountId, double amount) async {
    await Future.delayed(const Duration(milliseconds: 500));
    final index = _accounts.indexWhere((account) => account.id == accountId);
    if (index != -1) {
      final account = _accounts[index];
      if (account.balance < amount) {
        throw Exception('Insufficient balance');
      }
      final updatedAccount = account.copyWith(
        balance: account.balance - amount,
        updatedAt: DateTime.now(),
      );
      _accounts[index] = updatedAccount;
      return updatedAccount;
    }
    throw Exception('Account not found');
  }

  @override
  Future<double> getTotalBalance() async {
    await Future.delayed(const Duration(milliseconds: 200));
    double total = 0.0;
    for (final account in _accounts) {
      total += account.balance;
    }
    return total;
  }
}
