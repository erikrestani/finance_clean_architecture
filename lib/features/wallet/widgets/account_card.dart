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
    return Container(
      padding: const EdgeInsets.all(AppConstants.paddingMedium),
      decoration: BoxDecoration(
        color: AppTheme.surfaceColor,
        borderRadius: BorderRadius.circular(AppConstants.radiusMedium),
        border: Border.all(color: AppTheme.borderColor),
        boxShadow: [
          BoxShadow(
            color: AppTheme.borderColor.withValues(alpha: 0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              IconButton(
                onPressed: () => _showDeleteDialog(context, account),
                icon: Icon(
                  Icons.delete_outline,
                  color: AppTheme.errorColor,
                  size: 20,
                ),
                tooltip: 'Delete Account',
              ),
              Expanded(
                child: Text(
                  account.name,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: AppTheme.textPrimaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
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
                    icon: Icon(
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
                    icon: Icon(
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

          SizedBox(height: AppConstants.paddingMedium),
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
              SizedBox(width: AppConstants.paddingMedium),
              Expanded(
                child: Text(
                  'R\$ ${account.balance.toStringAsFixed(2)}',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: AppTheme.textPrimaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              IconButton(
                onPressed: () => _navigateToStatement(context, account),
                icon: Icon(
                  Icons.arrow_forward_ios,
                  color: AppTheme.textSecondaryColor,
                  size: 16,
                ),
                tooltip: 'View Statement',
              ),
            ],
          ),
          SizedBox(height: AppConstants.paddingMedium),
        ],
      ),
    );
  }

  void _showDeleteDialog(BuildContext context, Account account) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            Icon(
              Icons.warning_amber_rounded,
              color: AppTheme.errorColor,
              size: 24,
            ),
            SizedBox(width: AppConstants.paddingSmall),
            const Expanded(child: Text('Delete Account')),
            IconButton(
              onPressed: () => Navigator.of(context).pop(),
              icon: Icon(
                Icons.close,
                color: AppTheme.textSecondaryColor,
                size: 20,
              ),
              tooltip: 'Close',
            ),
          ],
        ),
        content: Text(
          'Are you sure you want to delete "${account.name}"? This action cannot be undone.',
          style: Theme.of(
            context,
          ).textTheme.bodyMedium?.copyWith(color: AppTheme.textSecondaryColor),
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              onDeleteAccount?.call();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.errorColor,
              foregroundColor: Colors.white,
            ),
            child: const Text('Delete'),
          ),
        ],
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
}
