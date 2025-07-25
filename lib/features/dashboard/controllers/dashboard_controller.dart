import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../domain/entities/financial_summary.dart';
import '../../../domain/entities/expense.dart';
import '../../../domain/repositories/finance_repository_impl.dart';
import '../../../domain/repositories/finance_repository.dart';

part 'dashboard_controller.g.dart';

@riverpod
FinanceRepository financeRepository(Ref ref) {
  return FinanceRepositoryImpl();
}

@riverpod
class DashboardController extends _$DashboardController {
  @override
  Future<FinancialSummary> build() async {
    final repository = ref.read(financeRepositoryProvider);
    return await repository.getFinancialSummary();
  }

  Future<void> refreshData() async {
    state = const AsyncValue.loading();
    try {
      final repository = ref.read(financeRepositoryProvider);
      final summary = await repository.getFinancialSummary();
      state = AsyncValue.data(summary);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  Future<void> addExpense(Expense expense) async {
    try {
      final repository = ref.read(financeRepositoryProvider);
      await repository.addExpense(expense);
      await refreshData();
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  Future<void> deleteExpense(String id) async {
    try {
      final repository = ref.read(financeRepositoryProvider);
      await repository.deleteExpense(id);
      await refreshData();
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }
} 