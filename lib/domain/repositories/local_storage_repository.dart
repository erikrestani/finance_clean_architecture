import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../entities/account.dart';
import '../entities/transaction.dart';

abstract class LocalStorageRepository {
  Future<List<Account>> getAccounts();
  Future<void> saveAccounts(List<Account> accounts);
  Future<List<Transaction>> getTransactions(String accountId);
  Future<void> saveTransactions(
    String accountId,
    List<Transaction> transactions,
  );
  Future<void> addTransaction(String accountId, Transaction transaction);
  Future<void> deleteAccount(String accountId);
}

class LocalStorageRepositoryImpl implements LocalStorageRepository {
  static const String _accountsKey = 'accounts';
  static const String _transactionsPrefix = 'transactions_';

  @override
  Future<List<Account>> getAccounts() async {
    final prefs = await SharedPreferences.getInstance();
    final accountsJson = prefs.getStringList(_accountsKey) ?? [];

    return accountsJson
        .map((json) => Account.fromJson(jsonDecode(json)))
        .toList();
  }

  @override
  Future<void> saveAccounts(List<Account> accounts) async {
    final prefs = await SharedPreferences.getInstance();
    final accountsJson = accounts
        .map((account) => jsonEncode(account.toJson()))
        .toList();

    await prefs.setStringList(_accountsKey, accountsJson);
  }

  @override
  Future<List<Transaction>> getTransactions(String accountId) async {
    final prefs = await SharedPreferences.getInstance();
    final transactionsJson =
        prefs.getStringList('$_transactionsPrefix$accountId') ?? [];

    return transactionsJson
        .map((json) => Transaction.fromJson(jsonDecode(json)))
        .toList();
  }

  @override
  Future<void> saveTransactions(
    String accountId,
    List<Transaction> transactions,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    final transactionsJson = transactions
        .map((transaction) => jsonEncode(transaction.toJson()))
        .toList();

    await prefs.setStringList(
      '$_transactionsPrefix$accountId',
      transactionsJson,
    );
  }

  @override
  Future<void> addTransaction(String accountId, Transaction transaction) async {
    final transactions = await getTransactions(accountId);
    transactions.add(transaction);
    await saveTransactions(accountId, transactions);
  }

  @override
  Future<void> deleteAccount(String accountId) async {
    final prefs = await SharedPreferences.getInstance();

    final accounts = await getAccounts();
    accounts.removeWhere((account) => account.id == accountId);
    await saveAccounts(accounts);

    await prefs.remove('$_transactionsPrefix$accountId');
  }
}
