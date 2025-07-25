import 'expense.dart';

class FinancialSummary {
  final double totalExpenses;
  final double totalIncome;
  final double savings;
  final double potentialSavings;
  final double totalBalance;
  final Map<ExpenseCategory, double> expensesByCategory;
  final List<Expense> recentExpenses;

  const FinancialSummary({
    required this.totalExpenses,
    required this.totalIncome,
    required this.savings,
    required this.potentialSavings,
    required this.totalBalance,
    required this.expensesByCategory,
    required this.recentExpenses,
  });

  double get balance => totalBalance;
  double get savingsRate => totalIncome > 0 ? (savings / totalIncome) * 100 : 0;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is FinancialSummary &&
        other.totalExpenses == totalExpenses &&
        other.totalIncome == totalIncome &&
        other.savings == savings;
  }

  @override
  int get hashCode =>
      totalExpenses.hashCode ^ totalIncome.hashCode ^ savings.hashCode;

  @override
  String toString() {
    return 'FinancialSummary(totalExpenses: $totalExpenses, totalIncome: $totalIncome, savings: $savings)';
  }
}
