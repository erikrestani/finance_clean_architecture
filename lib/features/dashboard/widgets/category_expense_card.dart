import 'package:flutter/material.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../domain/entities/financial_summary.dart';
import '../../../../domain/entities/expense.dart';
import '../../../../domain/entities/transaction_category.dart';

class CategoryExpenseCard extends StatelessWidget {
  final FinancialSummary summary;

  const CategoryExpenseCard({super.key, required this.summary});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppConstants.paddingLarge),
      decoration: BoxDecoration(
        color: AppTheme.surfaceColor,
        borderRadius: BorderRadius.circular(AppConstants.radiusLarge),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Expenses by Category',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: AppTheme.textPrimaryColor,
            ),
          ),
          const SizedBox(height: AppConstants.paddingMedium),
          ...summary.expensesByCategory.entries.map((entry) {
            return _buildCategoryItem(context, entry.key, entry.value);
          }),
        ],
      ),
    );
  }

  Widget _buildCategoryItem(
    BuildContext context,
    ExpenseCategory category,
    double amount,
  ) {
    final percentage = summary.totalExpenses > 0
        ? (amount / summary.totalExpenses) * 100
        : 0.0;

    return Padding(
      padding: const EdgeInsets.only(bottom: AppConstants.paddingMedium),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: _getCategoryColor(category).withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(AppConstants.radiusMedium),
            ),
            child: Icon(
              _getCategoryIcon(category),
              color: _getCategoryColor(category),
              size: 20,
            ),
          ),
          const SizedBox(width: AppConstants.paddingMedium),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _getCategoryName(category),
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w500,
                    color: AppTheme.textPrimaryColor,
                  ),
                ),
                const SizedBox(height: AppConstants.paddingSmall / 2),
                LinearProgressIndicator(
                  value: percentage / 100,
                  backgroundColor: AppTheme.borderColor,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    _getCategoryColor(category),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: AppConstants.paddingMedium),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '\$${amount.toStringAsFixed(2)}',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppTheme.textPrimaryColor,
                ),
              ),
              Text(
                '${percentage.toStringAsFixed(1)}%',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppTheme.textSecondaryColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Color _getCategoryColor(ExpenseCategory category) {
    switch (category) {
      case ExpenseCategory.food:
        return Colors.orange;
      case ExpenseCategory.transport:
        return Colors.blue;
      case ExpenseCategory.leisure:
        return Colors.purple;
      case ExpenseCategory.bills:
        return Colors.red;
      case ExpenseCategory.emergency:
        return Colors.red.shade800;
      case ExpenseCategory.savings:
        return Colors.green;
      case ExpenseCategory.health:
        return Colors.pink;
      case ExpenseCategory.education:
        return Colors.indigo;
      case ExpenseCategory.other:
        return Colors.grey;
    }
  }

  IconData _getCategoryIcon(ExpenseCategory category) {
    switch (category) {
      case ExpenseCategory.food:
        return TransactionCategory.food.icon;
      case ExpenseCategory.transport:
        return TransactionCategory.transport.icon;
      case ExpenseCategory.leisure:
        return TransactionCategory.entertainment.icon;
      case ExpenseCategory.bills:
        return TransactionCategory.bills.icon;
      case ExpenseCategory.emergency:
        return Icons.emergency;
      case ExpenseCategory.savings:
        return Icons.savings;
      case ExpenseCategory.health:
        return TransactionCategory.health.icon;
      case ExpenseCategory.education:
        return TransactionCategory.education.icon;
      case ExpenseCategory.other:
        return TransactionCategory.other.icon;
    }
  }

  String _getCategoryName(ExpenseCategory category) {
    switch (category) {
      case ExpenseCategory.food:
        return TransactionCategory.food.label;
      case ExpenseCategory.transport:
        return TransactionCategory.transport.label;
      case ExpenseCategory.leisure:
        return TransactionCategory.entertainment.label;
      case ExpenseCategory.bills:
        return TransactionCategory.bills.label;
      case ExpenseCategory.emergency:
        return 'Emergency';
      case ExpenseCategory.savings:
        return 'Savings';
      case ExpenseCategory.health:
        return TransactionCategory.health.label;
      case ExpenseCategory.education:
        return TransactionCategory.education.label;
      case ExpenseCategory.other:
        return TransactionCategory.other.label;
    }
  }
}
