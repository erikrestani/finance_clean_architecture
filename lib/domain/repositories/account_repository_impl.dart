import 'package:uuid/uuid.dart';
import '../entities/account.dart';
import '../entities/transaction.dart';
import 'account_repository.dart';
import 'local_storage_repository.dart';

class AccountRepositoryImpl implements AccountRepository {
  final LocalStorageRepository _localStorage = LocalStorageRepositoryImpl();

  @override
  Future<List<Account>> getAccounts() async {
    return await _localStorage.getAccounts();
  }

  @override
  Future<Account> getAccountById(String id) async {
    final accounts = await _localStorage.getAccounts();
    return accounts.firstWhere((account) => account.id == id);
  }

  @override
  Future<Account> createAccount(Account account) async {
    final accounts = await _localStorage.getAccounts();
    accounts.add(account);
    await _localStorage.saveAccounts(accounts);
    return account;
  }

  @override
  Future<Account> updateAccount(Account account) async {
    final accounts = await _localStorage.getAccounts();
    final index = accounts.indexWhere((a) => a.id == account.id);
    if (index != -1) {
      accounts[index] = account;
      await _localStorage.saveAccounts(accounts);
    }
    return account;
  }

  @override
  Future<void> deleteAccount(String id) async {
    await _localStorage.deleteAccount(id);
  }

  @override
  Future<Account> addBalance(String accountId, double amount, String description) async {
    final accounts = await _localStorage.getAccounts();
    final account = accounts.firstWhere((a) => a.id == accountId);
    final updatedAccount = account.copyWith(
      balance: account.balance + amount,
      updatedAt: DateTime.now(),
    );
    
    // Update account
    final index = accounts.indexWhere((a) => a.id == accountId);
    accounts[index] = updatedAccount;
    await _localStorage.saveAccounts(accounts);
    
    // Add transaction
    final transaction = Transaction(
      id: const Uuid().v4(),
      amount: amount,
      description: description.isNotEmpty ? description : 'Money added',
      type: TransactionType.credit,
      date: DateTime.now(),
    );
    await _localStorage.addTransaction(accountId, transaction);
    
    return updatedAccount;
  }

  @override
  Future<Account> subtractBalance(String accountId, double amount, String description) async {
    final accounts = await _localStorage.getAccounts();
    final account = accounts.firstWhere((a) => a.id == accountId);
    
    if (account.balance < amount) {
      throw Exception('Insufficient balance');
    }
    
    final updatedAccount = account.copyWith(
      balance: account.balance - amount,
      updatedAt: DateTime.now(),
    );
    
    // Update account
    final index = accounts.indexWhere((a) => a.id == accountId);
    accounts[index] = updatedAccount;
    await _localStorage.saveAccounts(accounts);
    
    // Add transaction
    final transaction = Transaction(
      id: const Uuid().v4(),
      amount: amount,
      description: description.isNotEmpty ? description : 'Money spent',
      type: TransactionType.debit,
      date: DateTime.now(),
    );
    await _localStorage.addTransaction(accountId, transaction);
    
    return updatedAccount;
  }

  @override
  Future<double> getTotalBalance() async {
    final accounts = await _localStorage.getAccounts();
    double total = 0.0;
    for (final account in accounts) {
      total += account.balance;
    }
    return total;
  }
}
