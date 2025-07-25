import '../entities/account.dart';

abstract class AccountRepository {
  Future<List<Account>> getAccounts();
  Future<Account> getAccountById(String id);
  Future<Account> createAccount(Account account);
  Future<Account> updateAccount(Account account);
  Future<void> deleteAccount(String id);
  Future<Account> addBalance(
    String accountId,
    double amount,
    String description,
  );
  Future<Account> subtractBalance(
    String accountId,
    double amount,
    String description,
  );
  Future<double> getTotalBalance();
}
