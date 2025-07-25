import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';
import '../../../domain/entities/account.dart';
import '../../../domain/repositories/account_repository.dart';
import '../../../domain/repositories/account_repository_impl.dart';

part 'wallet_controller.g.dart';

@riverpod
AccountRepository accountRepository(Ref ref) {
  return AccountRepositoryImpl();
}

@riverpod
class WalletController extends _$WalletController {
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
  }) async {
    final repository = ref.read(accountRepositoryProvider);

    final newAccount = Account(
      id: const Uuid().v4(),
      name: name,
      balance: initialBalance,
      color: color,
      iconData: iconData,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );

    await repository.createAccount(newAccount);
    ref.invalidateSelf();
  }

  Future<void> addBalance(String accountId, double amount) async {
    if (amount <= 0) return;

    final repository = ref.read(accountRepositoryProvider);
    await repository.addBalance(accountId, amount);
    ref.invalidateSelf();
  }

  Future<void> subtractBalance(String accountId, double amount) async {
    if (amount <= 0) return;

    final repository = ref.read(accountRepositoryProvider);
    await repository.subtractBalance(accountId, amount);
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
