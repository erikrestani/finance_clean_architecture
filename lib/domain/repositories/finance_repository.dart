import '../entities/expense.dart';
import '../entities/financial_summary.dart';

abstract class FinanceRepository {
  Future<FinancialSummary> getFinancialSummary();
  Future<List<Expense>> getExpenses();
  Future<List<Expense>> getExpensesByCategory(ExpenseCategory category);
  Future<void> addExpense(Expense expense);
  Future<void> updateExpense(Expense expense);
  Future<void> deleteExpense(String id);
}
