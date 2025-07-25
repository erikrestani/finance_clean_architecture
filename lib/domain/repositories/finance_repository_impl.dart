import '../entities/expense.dart';
import '../entities/financial_summary.dart';
import '../entities/transaction.dart';
import 'finance_repository.dart';
import 'local_storage_repository.dart';

class FinanceRepositoryImpl implements FinanceRepository {
  final LocalStorageRepository _localStorage = LocalStorageRepositoryImpl();

  @override
  Future<FinancialSummary> getFinancialSummary() async {
    final accounts = await _localStorage.getAccounts();

    if (accounts.isEmpty) {
      return const FinancialSummary(
        totalExpenses: 0.0,
        totalIncome: 0.0,
        savings: 0.0,
        potentialSavings: 0.0,
        expensesByCategory: <ExpenseCategory, double>{},
        recentExpenses: <Expense>[],
        totalBalance: 0.0,
      );
    }

    final totalBalance = accounts.fold(
      0.0,
      (sum, account) => sum + account.balance,
    );

    final allTransactions = <Transaction>[];
    for (final account in accounts) {
      final transactions = await _localStorage.getTransactions(account.id);
      allTransactions.addAll(transactions);
    }

    final totalIncome = allTransactions
        .where((t) => t.type == TransactionType.credit)
        .fold(0.0, (sum, transaction) => sum + transaction.amount);

    final totalExpenses = allTransactions
        .where((t) => t.type == TransactionType.debit)
        .fold(0.0, (sum, transaction) => sum + transaction.amount);

    final savings = totalIncome;

    final leisureExpenses = allTransactions
        .where(
          (t) =>
              t.type == TransactionType.debit &&
              _isLeisureExpense(t.description),
        )
        .fold(0.0, (sum, transaction) => sum + transaction.amount);
    final potentialSavings = leisureExpenses * 0.3;

    final expensesByCategory = <ExpenseCategory, double>{};

    for (final category in ExpenseCategory.values) {
      expensesByCategory[category] = 0.0;
    }

    for (final transaction in allTransactions.where(
      (t) => t.type == TransactionType.debit,
    )) {
      final category = _categorizeTransaction(transaction);
      expensesByCategory[category] =
          (expensesByCategory[category] ?? 0) + transaction.amount;
    }

    final recentTransactions =
        allTransactions.where((t) => t.type == TransactionType.debit).toList()
          ..sort((a, b) => b.date.compareTo(a.date));

    final recentExpenses = recentTransactions
        .take(5)
        .map(
          (t) => Expense(
            id: t.id,
            title: t.description.isNotEmpty ? t.description : 'Transaction',
            amount: t.amount,
            category: _categorizeTransaction(t),
            date: t.date,
          ),
        )
        .toList();

    return FinancialSummary(
      totalExpenses: totalExpenses,
      totalIncome: totalIncome,
      savings: savings,
      potentialSavings: potentialSavings,
      expensesByCategory: expensesByCategory,
      recentExpenses: recentExpenses,
      totalBalance: totalBalance,
    );
  }

  @override
  Future<List<Expense>> getExpenses() async {
    final accounts = await _localStorage.getAccounts();
    final allTransactions = <Transaction>[];

    for (final account in accounts) {
      final transactions = await _localStorage.getTransactions(account.id);
      allTransactions.addAll(
        transactions.where((t) => t.type == TransactionType.debit),
      );
    }

    return allTransactions
        .map(
          (t) => Expense(
            id: t.id,
            title: t.description.isNotEmpty ? t.description : 'Transaction',
            amount: t.amount,
            category: _categorizeTransaction(t),
            date: t.date,
          ),
        )
        .toList();
  }

  @override
  Future<List<Expense>> getExpensesByCategory(ExpenseCategory category) async {
    final expenses = await getExpenses();
    return expenses.where((expense) => expense.category == category).toList();
  }

  @override
  Future<void> addExpense(Expense expense) async {}

  @override
  Future<void> updateExpense(Expense expense) async {}

  @override
  Future<void> deleteExpense(String id) async {}

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

  ExpenseCategory _categorizeTransaction(Transaction transaction) {
    final description = transaction.description.toLowerCase();

    if (description.contains('food') || description.contains('groceries')) {
      return ExpenseCategory.food;
    }

    if (description.contains('transport') || description.contains('travel')) {
      return ExpenseCategory.transport;
    }

    if (description.contains('entertainment') ||
        description.contains('movie') ||
        description.contains('game')) {
      return ExpenseCategory.leisure;
    }

    if (description.contains('shopping')) {
      return ExpenseCategory.leisure;
    }

    if (description.contains('bills') || description.contains('receipt')) {
      return ExpenseCategory.bills;
    }

    if (description.contains('health') || description.contains('medical')) {
      return ExpenseCategory.health;
    }

    if (description.contains('education') || description.contains('school')) {
      return ExpenseCategory.education;
    }

    if (description.contains('coffee')) {
      return ExpenseCategory.leisure;
    }

    return ExpenseCategory.other;
  }
}
