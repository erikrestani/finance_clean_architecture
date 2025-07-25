import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/theme/app_theme.dart';
import '../../../domain/entities/transaction_category.dart';
import '../../../shared/widgets/custom_text_field.dart';

class BalanceDialog extends StatefulWidget {
  final String title;
  final String message;
  final IconData icon;
  final Color color;
  final Function(double, String) onConfirm;

  const BalanceDialog({
    super.key,
    required this.title,
    required this.message,
    required this.icon,
    required this.color,
    required this.onConfirm,
  });

  @override
  State<BalanceDialog> createState() => _BalanceDialogState();
}

class _BalanceDialogState extends State<BalanceDialog> {
  final _formKey = GlobalKey<FormState>();
  final _amountController = TextEditingController();
  final _descriptionController = TextEditingController();
  TransactionCategory? _selectedCategory;
  bool _isLoading = false;
  bool _showCustomDescription = false;

  @override
  void dispose() {
    _amountController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Row(
        children: [
          Icon(widget.icon, color: widget.color),
          const SizedBox(width: AppConstants.paddingSmall),
          Expanded(child: Text(widget.title)),
          IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(
              Icons.close,
              color: AppTheme.textSecondaryColor,
              size: 20,
            ),
            tooltip: 'Close',
          ),
        ],
      ),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              widget.message,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppTheme.textSecondaryColor,
              ),
            ),
            const SizedBox(height: AppConstants.paddingMedium),
            CustomTextField(
              controller: _amountController,
              label: 'Amount',
              hint: '0.00',
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),
              ],
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter an amount';
                }
                final amount = double.tryParse(value);
                if (amount == null || amount <= 0) {
                  return 'Please enter a valid amount';
                }
                return null;
              },
            ),
            const SizedBox(height: AppConstants.paddingMedium),
            if (widget.title.toLowerCase().contains('subtract')) ...[
              DropdownButtonFormField<TransactionCategory>(
                value: _selectedCategory,
                decoration: const InputDecoration(
                  labelText: 'Category',
                  border: OutlineInputBorder(),
                ),
                hint: const Text('Select a category'),
                items: TransactionCategory.values.map((category) {
                  return DropdownMenuItem(
                    value: category,
                    child: Row(
                      children: [
                        Icon(category.icon, size: 20),
                        const SizedBox(width: 8),
                        Text(category.label),
                      ],
                    ),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedCategory = value;
                    _showCustomDescription = value == TransactionCategory.other;
                    if (!_showCustomDescription && value != null) {
                      _descriptionController.text = value.label;
                    } else {
                      _descriptionController.clear();
                    }
                  });
                },
                validator: (value) {
                  if (value == null) {
                    return 'Please select a category';
                  }
                  return null;
                },
              ),
              const SizedBox(height: AppConstants.paddingMedium),
            ],
            if (_showCustomDescription ||
                !widget.title.toLowerCase().contains('subtract')) ...[
              CustomTextField(
                controller: _descriptionController,
                label: 'Description',
                hint: 'Enter transaction description',
                maxLines: 2,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter a description';
                  }
                  return null;
                },
              ),
            ],
          ],
        ),
      ),
      actions: [
        ElevatedButton(
          onPressed: _isLoading ? null : _handleConfirm,
          style: ElevatedButton.styleFrom(
            backgroundColor: widget.color,
            foregroundColor: Colors.white,
          ),
          child: _isLoading
              ? const SizedBox(
                  height: 16,
                  width: 16,
                  child: CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 2,
                  ),
                )
              : const Text('Confirm'),
        ),
      ],
    );
  }

  void _handleConfirm() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      final amount = double.parse(_amountController.text);
      final description = _descriptionController.text.trim();
      widget.onConfirm(amount, description);
      Navigator.of(context).pop();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: ${e.toString()}'),
          backgroundColor: AppTheme.errorColor,
        ),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }
}
