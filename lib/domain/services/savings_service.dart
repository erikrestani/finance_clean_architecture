import '../entities/transaction.dart';
import '../repositories/local_storage_repository.dart';

class SavingsService {
  final LocalStorageRepository _localStorage = LocalStorageRepositoryImpl();

  Future<double> getMonthlySpendingAverage() async {
    final accounts = await _localStorage.getAccounts();
    final allTransactions = <Transaction>[];

    for (final account in accounts) {
      final transactions = await _localStorage.getTransactions(account.id);
      allTransactions.addAll(transactions);
    }

    final debitTransactions = allTransactions
        .where((t) => t.type == TransactionType.debit)
        .toList();

    if (debitTransactions.isEmpty) return 0.0;

    final totalSpent = debitTransactions.fold(
      0.0,
      (sum, transaction) => sum + transaction.amount,
    );

    final now = DateTime.now();
    final threeMonthsAgo = DateTime(now.year, now.month - 3, now.day);

    final recentTransactions = debitTransactions
        .where((t) => t.date.isAfter(threeMonthsAgo))
        .toList();

    if (recentTransactions.isEmpty) return totalSpent / 3;

    final recentTotal = recentTransactions.fold(
      0.0,
      (sum, transaction) => sum + transaction.amount,
    );

    return recentTotal / 3; // Average over 3 months
  }

  Future<double> getPotentialSavingsFromLeisure() async {
    final accounts = await _localStorage.getAccounts();
    final allTransactions = <Transaction>[];

    for (final account in accounts) {
      final transactions = await _localStorage.getTransactions(account.id);
      allTransactions.addAll(transactions);
    }

    final leisureExpenses = allTransactions
        .where(
          (t) =>
              t.type == TransactionType.debit &&
              _isLeisureExpense(t.description),
        )
        .fold(0.0, (sum, transaction) => sum + transaction.amount);

    return leisureExpenses * 0.3; // Suggest saving 30% of leisure expenses
  }

  bool _isLeisureExpense(String description) {
    final desc = description.toLowerCase();
    return desc.contains('entertainment') ||
        desc.contains('coffee') ||
        desc.contains('shopping') ||
        desc.contains('travel') ||
        desc.contains('restaurant') ||
        desc.contains('movie') ||
        desc.contains('game') ||
        desc.contains('leisure') ||
        desc.contains('bar') ||
        desc.contains('club') ||
        desc.contains('amazon') ||
        desc.contains('netflix') ||
        desc.contains('spotify');
  }

  Future<Map<String, dynamic>> getSavingsRecommendations() async {
    final monthlyAverage = await getMonthlySpendingAverage();
    final potentialLeisureSavings = await getPotentialSavingsFromLeisure();

    final recommendations = <String>[];

    if (monthlyAverage > 2000) {
      recommendations.add(
        'Your monthly spending is high. Consider setting a budget.',
      );
    }

    if (potentialLeisureSavings > 100) {
      recommendations.add(
        'You could save \$${potentialLeisureSavings.toStringAsFixed(2)} monthly by reducing leisure expenses.',
      );
    }

    return {
      'monthlyAverage': monthlyAverage,
      'potentialLeisureSavings': potentialLeisureSavings,
      'recommendations': recommendations,
      'savingsGoal': monthlyAverage * 0.2, // 20% of monthly spending
    };
  }

  bool shouldShowSavingsWarning(String description, double amount) {
    if (!_isLeisureExpense(description)) return false;

    return amount > 50.0;
  }

  String getSavingsWarningMessage(String description, double amount) {
    final potentialSavings = amount * 0.3;

    return 'Are you sure you want to spend \$${amount.toStringAsFixed(2)} on "$description"?\n\n'
        '💡 You could save \$${potentialSavings.toStringAsFixed(2)} by choosing a cheaper option or skipping this expense.\n\n'
        'Would you like to reconsider?';
  }
}
