import 'package:flutter/material.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/theme/app_theme.dart';

class SavingsWarningDialog extends StatelessWidget {
  final String description;
  final double amount;
  final VoidCallback onConfirm;
  final VoidCallback onCancel;

  const SavingsWarningDialog({
    super.key,
    required this.description,
    required this.amount,
    required this.onConfirm,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    final potentialSavings = amount * 0.3;

    return AlertDialog(
      title: Row(
        children: [
          const Icon(Icons.savings, color: AppTheme.secondaryColor, size: 24),
          const SizedBox(width: AppConstants.paddingSmall),
          const Expanded(child: Text('Savings Opportunity')),
          IconButton(
            onPressed: onCancel,
            icon: const Icon(
              Icons.close,
              color: AppTheme.textSecondaryColor,
              size: 20,
            ),
            tooltip: 'Close',
          ),
        ],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Are you sure you want to spend \$${amount.toStringAsFixed(2)} on "$description"?',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: AppTheme.textPrimaryColor,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: AppConstants.paddingMedium),
          Container(
            padding: const EdgeInsets.all(AppConstants.paddingMedium),
            decoration: BoxDecoration(
              color: AppTheme.secondaryColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(AppConstants.radiusSmall),
              border: Border.all(
                color: AppTheme.secondaryColor.withValues(alpha: 0.3),
              ),
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.lightbulb_outline,
                  color: AppTheme.secondaryColor,
                  size: 20,
                ),
                const SizedBox(width: AppConstants.paddingSmall),
                Expanded(
                  child: Text(
                    'You could save \$${potentialSavings.toStringAsFixed(2)} by choosing a cheaper option or skipping this expense.',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppTheme.secondaryColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppConstants.paddingMedium),
          Text(
            '💡 Tip: Consider if this expense is really necessary or if you could find a more affordable alternative.',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: AppTheme.textSecondaryColor,
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
      actions: [
        TextButton(onPressed: onCancel, child: const Text('Reconsider')),
        ElevatedButton(
          onPressed: onConfirm,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppTheme.errorColor,
            foregroundColor: Colors.white,
          ),
          child: const Text('Spend Anyway'),
        ),
      ],
    );
  }
}
