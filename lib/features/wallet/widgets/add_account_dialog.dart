import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/theme/app_theme.dart';
import '../../../shared/widgets/custom_text_field.dart';
import '../controllers/wallet_controller.dart';

class AddAccountDialog extends ConsumerStatefulWidget {
  const AddAccountDialog({super.key});

  @override
  ConsumerState<AddAccountDialog> createState() => _AddAccountDialogState();
}

class _AddAccountDialogState extends ConsumerState<AddAccountDialog> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _balanceController = TextEditingController();

  Color _selectedColor = AppTheme.primaryColor;
  IconData _selectedIcon = Icons.account_balance_wallet;
  bool _isLoading = false;

  final List<Color> _colorOptions = [
    AppTheme.primaryColor,
    AppTheme.secondaryColor,
    const Color(0xFF8B5CF6), // Purple
    const Color(0xFFF59E0B), // Amber
    const Color(0xFFEF4444), // Red
    const Color(0xFF10B981), // Green
    const Color(0xFF3B82F6), // Blue
    const Color(0xFFEC4899), // Pink
  ];

  final List<IconData> _iconOptions = [
    Icons.account_balance_wallet,
    Icons.credit_card,
    Icons.account_balance,
    Icons.savings,
    Icons.payment,
    Icons.account_circle,
    Icons.business,
    Icons.home,
  ];

  @override
  void dispose() {
    _nameController.dispose();
    _balanceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Row(
        children: [
          const Expanded(child: Text('Add New Account')),
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
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomTextField(
                controller: _nameController,
                label: 'Account Name',
                hint: 'e.g., Nubank, Money, Savings',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter account name';
                  }
                  return null;
                },
              ),
              SizedBox(height: AppConstants.paddingMedium),
              CustomTextField(
                controller: _balanceController,
                label: 'Initial Balance',
                hint: '0.00',
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),
                ],
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter initial balance';
                  }
                  final balance = double.tryParse(value);
                  if (balance == null || balance < 0) {
                    return 'Please enter a valid balance';
                  }
                  return null;
                },
              ),
              SizedBox(height: AppConstants.paddingMedium),

              // Color Selection
              Text(
                'Choose Color',
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  color: AppTheme.textPrimaryColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: AppConstants.paddingSmall),
              Wrap(
                spacing: AppConstants.paddingSmall,
                children: _colorOptions
                    .map(
                      (color) => GestureDetector(
                        onTap: () => setState(() => _selectedColor = color),
                        child: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: color,
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: _selectedColor == color
                                  ? AppTheme.textPrimaryColor
                                  : Colors.transparent,
                              width: 3,
                            ),
                          ),
                          child: _selectedColor == color
                              ? const Icon(
                                  Icons.check,
                                  color: Colors.white,
                                  size: 20,
                                )
                              : null,
                        ),
                      ),
                    )
                    .toList(),
              ),
              SizedBox(height: AppConstants.paddingMedium),

              // Icon Selection
              Text(
                'Choose Icon',
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  color: AppTheme.textPrimaryColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: AppConstants.paddingSmall),
              Wrap(
                spacing: AppConstants.paddingSmall,
                children: _iconOptions
                    .map(
                      (icon) => GestureDetector(
                        onTap: () => setState(() => _selectedIcon = icon),
                        child: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: _selectedIcon == icon
                                ? _selectedColor.withValues(alpha: 0.1)
                                : AppTheme.inputBackgroundColor,
                            borderRadius: BorderRadius.circular(
                              AppConstants.radiusSmall,
                            ),
                            border: Border.all(
                              color: _selectedIcon == icon
                                  ? _selectedColor
                                  : AppTheme.borderColor,
                              width: 2,
                            ),
                          ),
                          child: Icon(
                            icon,
                            color: _selectedIcon == icon
                                ? _selectedColor
                                : AppTheme.textSecondaryColor,
                            size: 20,
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ],
          ),
        ),
      ),
      actions: [
        ElevatedButton(
          onPressed: _isLoading ? null : _handleCreateAccount,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppTheme.primaryColor,
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
              : const Text('Create'),
        ),
      ],
    );
  }

  void _handleCreateAccount() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      final name = _nameController.text.trim();
      final balance = double.parse(_balanceController.text);

      await ref
          .read(walletControllerProvider.notifier)
          .addAccount(
            name: name,
            initialBalance: balance,
            color: _selectedColor,
            iconData: _selectedIcon,
          );

      if (!mounted) return;
      Navigator.of(context).pop();
      _showSuccessMessage(name);
    } catch (e) {
      if (!mounted) return;

      _showErrorMessage(e.toString());
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  void _showSuccessMessage(String accountName) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Account "$accountName" created successfully!'),
        backgroundColor: AppTheme.secondaryColor,
      ),
    );
  }

  void _showErrorMessage(String error) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Error creating account: $error'),
        backgroundColor: AppTheme.errorColor,
      ),
    );
  }
}
