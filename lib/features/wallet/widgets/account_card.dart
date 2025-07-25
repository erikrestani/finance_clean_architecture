import 'package:flutter/material.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/theme/app_theme.dart';
import '../../../domain/entities/account.dart';
import 'balance_dialog.dart';
import '../screens/account_statement_screen.dart';

class AccountCard extends StatelessWidget {
  final Account account;
  final Function(double, String) onAddBalance;
  final Function(double, String) onSubtractBalance;
  final VoidCallback? onDeleteAccount;

  const AccountCard({
    super.key,
    required this.account,
    required this.onAddBalance,
    required this.onSubtractBalance,
    this.onDeleteAccount,
  });

  @override
  Widget build(BuildContext context) {
    final isNegativeBalance = account.balance < 0;
    final balanceColor = isNegativeBalance
        ? AppTheme.errorColor
        : AppTheme.textPrimaryColor;
    final accountTypeText = _getAccountTypeText(account.accountType);

    return Container(
      padding: const EdgeInsets.all(AppConstants.paddingMedium),
      decoration: BoxDecoration(
        color: AppTheme.surfaceColor,
        borderRadius: BorderRadius.circular(AppConstants.radiusMedium),
        border: Border.all(
          color: isNegativeBalance
              ? AppTheme.errorColor.withValues(alpha: 0.3)
              : AppTheme.borderColor,
          width: isNegativeBalance ? 2 : 1,
        ),
        boxShadow: [
          BoxShadow(
            color: AppTheme.borderColor.withValues(alpha: 0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      account.name,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: AppTheme.textPrimaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: AppConstants.paddingSmall),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppConstants.paddingSmall,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: _getAccountTypeColor(
                          account.accountType,
                        ).withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(
                          AppConstants.radiusSmall,
                        ),
                      ),
                      child: Text(
                        accountTypeText,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: _getAccountTypeColor(account.accountType),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  IconButton(
                    onPressed: () => _showBalanceDialog(
                      context,
                      'Add Money',
                      'Enter amount to add:',
                      Icons.add,
                      AppTheme.secondaryColor,
                      onAddBalance,
                    ),
                    icon: const Icon(
                      Icons.add_circle_outline,
                      color: AppTheme.secondaryColor,
                      size: 24,
                    ),
                    tooltip: 'Add Money',
                  ),
                  IconButton(
                    onPressed: () => _showBalanceDialog(
                      context,
                      'Subtract Money',
                      'Enter amount to subtract:',
                      Icons.remove,
                      AppTheme.errorColor,
                      onSubtractBalance,
                    ),
                    icon: const Icon(
                      Icons.remove_circle_outline,
                      color: AppTheme.errorColor,
                      size: 24,
                    ),
                    tooltip: 'Subtract Money',
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(height: AppConstants.paddingMedium),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(AppConstants.paddingSmall),
                decoration: BoxDecoration(
                  color: account.color.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(AppConstants.radiusSmall),
                ),
                child: Icon(account.iconData, color: account.color, size: 24),
              ),
              const SizedBox(width: AppConstants.paddingMedium),
              Expanded(
                child: Row(
                  children: [
                    if (isNegativeBalance) ...[
                      const Icon(Icons.warning, color: AppTheme.errorColor, size: 16),
                      const SizedBox(width: AppConstants.paddingSmall),
                    ],
                    Text(
                      'R\$ ${account.balance.toStringAsFixed(2)}',
                      style: Theme.of(context).textTheme.headlineSmall
                          ?.copyWith(
                            color: balanceColor,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: () => _navigateToStatement(context, account),
                icon: const Icon(
                  Icons.arrow_forward_ios,
                  color: AppTheme.textSecondaryColor,
                  size: 16,
                ),
                tooltip: 'View Statement',
              ),
            ],
          ),
          const SizedBox(height: AppConstants.paddingMedium),
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

  Color _getAccountTypeColor(AccountType accountType) {
    switch (accountType) {
      case AccountType.debit:
        return AppTheme.primaryColor;
      case AccountType.credit:
        return AppTheme.errorColor;
      case AccountType.savings:
        return const Color(0xFF10B981);
      case AccountType.investment:
        return const Color(0xFFF59E0B);
    }
  }

  void _showBalanceDialog(
    BuildContext context,
    String title,
    String message,
    IconData icon,
    Color color,
    Function(double, String) onConfirm,
  ) {
    showDialog(
      context: context,
      builder: (context) => BalanceDialog(
        title: title,
        message: message,
        icon: icon,
        color: color,
        onConfirm: onConfirm,
      ),
    );
  }

  void _navigateToStatement(BuildContext context, Account account) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => AccountStatementScreen(account: account),
      ),
    );
  }
}
