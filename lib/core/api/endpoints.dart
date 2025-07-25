class ApiEndpoints {
  static const String baseUrl = 'http://localhost:3000/api';
  
  static const String auth = '/auth';
  static const String accounts = '/accounts';
  static const String transactions = '/transactions';
  static const String dashboard = '/dashboard';
  
  static String login() => '$auth/login';
  static String register() => '$auth/register';
  static String me() => '$auth/me';
  
  static String userAccounts() => accounts;
  static String account(String id) => '$accounts/$id';
  static String accountTransactions(String accountId) => '$accounts/$accountId/transactions';
  
  static String dashboardSummary() => '$dashboard/summary';
} 