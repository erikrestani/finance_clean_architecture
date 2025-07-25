import '../entities/expense.dart';
import '../entities/financial_summary.dart';
import 'finance_repository.dart';

class FinanceRepositoryImpl implements FinanceRepository {
  final List<Expense> _expenses = [
    Expense(
      id: '1',
      title: 'Netflix Subscription',
      amount: 29.90,
      category: ExpenseCategory.leisure,
      date: DateTime(2024, 1, 15),
    ),
    Expense(
      id: '2',
      title: 'Electricity Bill',
      amount: 150.00,
      category: ExpenseCategory.bills,
      date: DateTime(2024, 1, 10),
    ),
    Expense(
      id: '3',
      title: 'Car Repair',
      amount: 500.00,
      category: ExpenseCategory.emergency,
      date: DateTime(2024, 1, 8),
    ),
    Expense(
      id: '4',
      title: 'Savings Transfer',
      amount: 1000.00,
      category: ExpenseCategory.savings,
      date: DateTime(2024, 1, 5),
    ),
    Expense(
      id: '5',
      title: 'Restaurant',
      amount: 80.00,
      category: ExpenseCategory.food,
      date: DateTime(2024, 1, 12),
    ),
    Expense(
      id: '6',
      title: 'Uber Ride',
      amount: 25.00,
      category: ExpenseCategory.transport,
      date: DateTime(2024, 1, 14),
    ),
  ];

  @override
  Future<FinancialSummary> getFinancialSummary() async {
    await Future.delayed(const Duration(milliseconds: 500));

    final totalExpenses = _expenses.fold(
      0.0,
      (sum, expense) => sum + expense.amount,
    );
    final totalIncome = 5000.0;
    final savings = _expenses
        .where((e) => e.category == ExpenseCategory.savings)
        .fold(0.0, (sum, expense) => sum + expense.amount);

    final leisureExpenses = _expenses
        .where((e) => e.category == ExpenseCategory.leisure)
        .fold(0.0, (sum, expense) => sum + expense.amount);
    final potentialSavings = leisureExpenses * 0.5;

    final expensesByCategory = <ExpenseCategory, double>{};
    for (final expense in _expenses) {
      expensesByCategory[expense.category] =
          (expensesByCategory[expense.category] ?? 0) + expense.amount;
    }

    final recentExpenses = _expenses.take(5).toList();

    return FinancialSummary(
      totalExpenses: totalExpenses,
      totalIncome: totalIncome,
      savings: savings,
      potentialSavings: potentialSavings,
      expensesByCategory: expensesByCategory,
      recentExpenses: recentExpenses,
    );
  }

  @override
  Future<List<Expense>> getExpenses() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return _expenses;
  }

  @override
  Future<List<Expense>> getExpensesByCategory(ExpenseCategory category) async {
    await Future.delayed(const Duration(milliseconds: 200));
    return _expenses.where((expense) => expense.category == category).toList();
  }

  @override
  Future<void> addExpense(Expense expense) async {
    await Future.delayed(const Duration(milliseconds: 200));
    _expenses.add(expense);
  }

  @override
  Future<void> updateExpense(Expense expense) async {
    await Future.delayed(const Duration(milliseconds: 200));
    final index = _expenses.indexWhere((e) => e.id == expense.id);
    if (index != -1) {
      _expenses[index] = expense;
    }
  }

  @override
  Future<void> deleteExpense(String id) async {
    await Future.delayed(const Duration(milliseconds: 200));
    _expenses.removeWhere((expense) => expense.id == id);
  }
}
