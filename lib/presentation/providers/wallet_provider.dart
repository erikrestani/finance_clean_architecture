import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../data/repositories/account_repository_impl.dart';
import '../../domain/entities/account.dart';
import '../../domain/repositories/account_repository.dart';
import 'auth_provider.dart';

part 'wallet_provider.g.dart';

@riverpod
AccountRepository accountRepository(Ref ref) {
  final apiClient = ref.watch(apiClientProvider);
  return AccountRepositoryImpl(apiClient);
}

@riverpod
class WalletNotifier extends _$WalletNotifier {
  @override
  Future<List<Account>> build() async {
    final repository = ref.read(accountRepositoryProvider);
    return await repository.getAccounts();
  }

  Future<void> addAccount({
    required String name,
    required double initialBalance,
    required Color color,
    required IconData iconData,
    required AccountType accountType,
  }) async {
    final repository = ref.read(accountRepositoryProvider);
    
    final account = Account(
      id: '',
      name: name,
      balance: initialBalance,
      color: color,
      iconData: iconData,
      accountType: accountType,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );

    await repository.createAccount(account);
    ref.invalidateSelf();
  }

  Future<void> addBalance(String accountId, double amount, String description) async {
    final repository = ref.read(accountRepositoryProvider);
    await repository.addBalance(accountId, amount, description);
    ref.invalidateSelf();
  }

  Future<void> subtractBalance(String accountId, double amount, String description) async {
    final repository = ref.read(accountRepositoryProvider);
    await repository.subtractBalance(accountId, amount, description);
    ref.invalidateSelf();
  }

  Future<void> deleteAccount(String accountId) async {
    final repository = ref.read(accountRepositoryProvider);
    await repository.deleteAccount(accountId);
    ref.invalidateSelf();
  }

  Future<void> updateAccount(Account account) async {
    final repository = ref.read(accountRepositoryProvider);
    await repository.updateAccount(account);
    ref.invalidateSelf();
  }
}

@riverpod
Future<double> totalBalance(Ref ref) async {
  final repository = ref.read(accountRepositoryProvider);
  return await repository.getTotalBalance();
} 