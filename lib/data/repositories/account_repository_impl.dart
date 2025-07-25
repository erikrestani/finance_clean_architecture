import 'package:dio/dio.dart';
import '../../core/api/api_client.dart';
import '../../domain/entities/account.dart';
import '../../domain/repositories/account_repository.dart';

class AccountRepositoryImpl implements AccountRepository {
  final ApiClient _apiClient;

  AccountRepositoryImpl(this._apiClient);

  @override
  Future<List<Account>> getAccounts() async {
    try {
      final response = await _apiClient.get('/accounts');
      return (response.data as List)
          .map((json) => Account.fromJson(json))
          .toList();
    } on DioException catch (e) {
      throw Exception(e.error ?? 'Failed to get accounts');
    }
  }

  @override
  Future<Account> getAccountById(String id) async {
    try {
      final response = await _apiClient.get('/accounts/$id');
      return Account.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception(e.error ?? 'Failed to get account');
    }
  }

  @override
  Future<Account> createAccount(Account account) async {
    try {
      final response = await _apiClient.post('/accounts', data: account.toJson());
      return Account.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception(e.error ?? 'Failed to create account');
    }
  }

  @override
  Future<Account> updateAccount(Account account) async {
    try {
      final response = await _apiClient.put('/accounts/${account.id}', data: account.toJson());
      return Account.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception(e.error ?? 'Failed to update account');
    }
  }

  @override
  Future<void> deleteAccount(String id) async {
    try {
      await _apiClient.delete('/accounts/$id');
    } on DioException catch (e) {
      throw Exception(e.error ?? 'Failed to delete account');
    }
  }

  @override
  Future<Account> addBalance(String accountId, double amount, String description) async {
    try {
      final response = await _apiClient.post('/accounts/$accountId/transactions', data: {
        'amount': amount,
        'description': description,
        'type': 'CREDIT',
      });
      return Account.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception(e.error ?? 'Failed to add balance');
    }
  }

  @override
  Future<Account> subtractBalance(String accountId, double amount, String description) async {
    try {
      final response = await _apiClient.post('/accounts/$accountId/transactions', data: {
        'amount': amount,
        'description': description,
        'type': 'DEBIT',
      });
      return Account.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception(e.error ?? 'Failed to subtract balance');
    }
  }

  @override
  Future<double> getTotalBalance() async {
    try {
      final response = await _apiClient.get('/accounts/balance');
      return response.data['totalBalance'].toDouble();
    } on DioException catch (e) {
      throw Exception(e.error ?? 'Failed to get total balance');
    }
  }
} 