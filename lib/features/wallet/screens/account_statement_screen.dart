import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/utils/date_formatter.dart';
import '../../../domain/entities/account.dart';
import '../../../domain/entities/transaction.dart';
import '../../../domain/repositories/local_storage_repository.dart';
import '../../../shared/widgets/app_bar.dart';

class AccountStatementScreen extends ConsumerWidget {
  final Account account;

  const AccountStatementScreen({super.key, required this.account});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isNegativeBalance = account.balance < 0;
    final accountTypeText = _getAccountTypeText(account.accountType);

    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: const CustomAppBar(showBackButton: true),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.all(AppConstants.paddingMedium),
            padding: const EdgeInsets.all(AppConstants.paddingLarge),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: isNegativeBalance
                    ? [
                        AppTheme.errorColor,
                        AppTheme.errorColor.withValues(alpha: 0.8),
                      ]
                    : [account.color, account.color.withValues(alpha: 0.8)],
              ),
              borderRadius: BorderRadius.circular(AppConstants.radiusMedium),
              boxShadow: [
                BoxShadow(
                  color:
                      (isNegativeBalance ? AppTheme.errorColor : account.color)
                          .withValues(alpha: 0.3),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(AppConstants.paddingSmall),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(
                          AppConstants.radiusSmall,
                        ),
                      ),
                      child: Icon(
                        isNegativeBalance ? Icons.warning : account.iconData,
                        color: Colors.white,
                        size: 24,
                      ),
                    ),
                    const SizedBox(width: AppConstants.paddingMedium),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            account.name,
                            style: Theme.of(context).textTheme.titleMedium
                                ?.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                ),
                          ),
                          const SizedBox(height: AppConstants.paddingSmall),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: AppConstants.paddingSmall,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.2),
                              borderRadius: BorderRadius.circular(
                                AppConstants.radiusSmall,
                              ),
                            ),
                            child: Text(
                              accountTypeText,
                              style: Theme.of(context).textTheme.bodySmall
                                  ?.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                  ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppConstants.paddingMedium),
                Row(
                  children: [
                    if (isNegativeBalance) ...[
                      const Icon(Icons.warning, color: Colors.white, size: 20),
                      const SizedBox(width: AppConstants.paddingSmall),
                    ],
                    Text(
                      'R\$ ${account.balance.toStringAsFixed(2)}',
                      style: Theme.of(context).textTheme.headlineSmall
                          ?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppConstants.paddingMedium,
              vertical: AppConstants.paddingSmall,
            ),
            child: Row(
              children: [
                Text(
                  'Transaction History',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: AppTheme.textPrimaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Spacer(),
                FutureBuilder<List<Transaction>>(
                  future: LocalStorageRepositoryImpl().getTransactions(
                    account.id,
                  ),
                  builder: (context, snapshot) {
                    final count = snapshot.data?.length ?? 0;
                    return Text(
                      '$count transactions',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppTheme.textSecondaryColor,
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          Expanded(child: _buildTransactionsTable(context)),
        ],
      ),
    );
  }

  String _getAccountTypeText(AccountType accountType) {
    switch (accountType) {
      case AccountType.debit:
        return 'Debit';
      case AccountType.credit:
        return 'Credit';
      case AccountType.savings:
        return 'Savings';
      case AccountType.investment:
        return 'Investment';
    }
  }

  Widget _buildTransactionsTable(BuildContext context) {
    return FutureBuilder<List<Transaction>>(
      future: LocalStorageRepositoryImpl().getTransactions(account.id),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(color: AppTheme.primaryColor),
          );
        }

        if (snapshot.hasError) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.error_outline, size: 64, color: AppTheme.errorColor),
                const SizedBox(height: AppConstants.paddingMedium),
                Text(
                  'Error loading transactions',
                  style: Theme.of(
                    context,
                  ).textTheme.titleMedium?.copyWith(color: AppTheme.errorColor),
                ),
              ],
            ),
          );
        }

        final transactions = snapshot.data ?? [];

        if (transactions.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.receipt_long_outlined,
                  size: 64,
                  color: AppTheme.textSecondaryColor,
                ),
                const SizedBox(height: AppConstants.paddingMedium),
                Text(
                  'No transactions yet',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: AppTheme.textSecondaryColor,
                  ),
                ),
                const SizedBox(height: AppConstants.paddingSmall),
                Text(
                  'Transactions will appear here',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppTheme.textSecondaryColor,
                  ),
                ),
              ],
            ),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.symmetric(
            horizontal: AppConstants.paddingMedium,
          ),
          itemCount: transactions.length,
          itemBuilder: (context, index) {
            final transaction = transactions[index];
            return _buildTransactionRow(context, transaction);
          },
        );
      },
    );
  }

  Widget _buildTransactionRow(BuildContext context, Transaction transaction) {
    final isPositive = transaction.type == TransactionType.credit;

    return Container(
      margin: const EdgeInsets.only(bottom: AppConstants.paddingSmall),
      padding: const EdgeInsets.all(AppConstants.paddingMedium),
      decoration: BoxDecoration(
        color: AppTheme.surfaceColor,
        borderRadius: BorderRadius.circular(AppConstants.radiusSmall),
        border: Border.all(color: AppTheme.borderColor),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(AppConstants.paddingSmall),
            decoration: BoxDecoration(
              color:
                  (isPositive ? AppTheme.secondaryColor : AppTheme.errorColor)
                      .withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(AppConstants.radiusSmall),
            ),
            child: Icon(
              isPositive ? Icons.add : Icons.remove,
              color: isPositive ? AppTheme.secondaryColor : AppTheme.errorColor,
              size: 20,
            ),
          ),
          const SizedBox(width: AppConstants.paddingMedium),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  transaction.description.isNotEmpty
                      ? transaction.description
                      : (isPositive ? 'Money Added' : 'Money Spent'),
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    color: AppTheme.textPrimaryColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  DateFormatter.formatRelativeDate(transaction.date),
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppTheme.textSecondaryColor,
                  ),
                ),
              ],
            ),
          ),
          Text(
            '${isPositive ? '+' : '-'} R\$ ${transaction.amount.toStringAsFixed(2)}',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: isPositive ? AppTheme.secondaryColor : AppTheme.errorColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
