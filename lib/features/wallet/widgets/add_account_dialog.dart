import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/utils/predefined_accounts.dart';
import '../../../domain/entities/account.dart';
import '../../../shared/widgets/custom_text_field.dart';
import '../../../presentation/providers/wallet_provider.dart';

class AddAccountDialog extends ConsumerStatefulWidget {
  const AddAccountDialog({super.key});

  @override
  ConsumerState<AddAccountDialog> createState() => _AddAccountDialogState();
}

class _AddAccountDialogState extends ConsumerState<AddAccountDialog>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _balanceController = TextEditingController();
  final _customNameController = TextEditingController();

  late TabController _tabController;
  PredefinedAccount? _selectedAccount;
  bool _isLoading = false;
  bool _isCustomAccount = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _balanceController.text = '0.00';
  }

  @override
  void dispose() {
    _tabController.dispose();
    _balanceController.dispose();
    _customNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Row(
        children: [
          const Expanded(child: Text('New Account')),
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
      content: SizedBox(
        width: double.maxFinite,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TabBar(
              controller: _tabController,
              labelColor: AppTheme.primaryColor,
              unselectedLabelColor: AppTheme.textSecondaryColor,
              indicatorColor: AppTheme.primaryColor,
              tabs: const [
                Tab(text: 'Debit'),
                Tab(text: 'Credit'),
                Tab(text: 'Savings'),
              ],
            ),
            const SizedBox(height: AppConstants.paddingMedium),
            Flexible(
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildAccountTypeTab(PredefinedAccounts.debitAccounts),
                  _buildAccountTypeTab(PredefinedAccounts.creditAccounts),
                  _buildAccountTypeTab(PredefinedAccounts.savingsAccounts),
                ],
              ),
            ),
            const SizedBox(height: AppConstants.paddingMedium),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  if (_isCustomAccount) ...[
                    CustomTextField(
                      controller: _customNameController,
                      label: 'Account Name',
                      hint: 'Enter custom account name',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter account name';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: AppConstants.paddingMedium),
                  ],
                  CustomTextField(
                    controller: _balanceController,
                    label: 'Initial Balance',
                    hint: '0.00',
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'^-?\d*\.?\d{0,2}')),
                    ],
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter initial balance';
                      }
                      final balance = double.tryParse(value);
                      if (balance == null) {
                        return 'Please enter a valid balance';
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      actions: [
        ElevatedButton(
          onPressed: _isLoading || _selectedAccount == null ? null : _handleCreateAccount,
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

  Widget _buildAccountTypeTab(List<PredefinedAccount> accounts) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1.2,
        crossAxisSpacing: AppConstants.paddingSmall,
        mainAxisSpacing: AppConstants.paddingSmall,
      ),
      itemCount: accounts.length + 1,
      itemBuilder: (context, index) {
        if (index == accounts.length) {
          return _buildCustomAccountCard();
        }
        return _buildPredefinedAccountCard(accounts[index]);
      },
    );
  }

  Widget _buildPredefinedAccountCard(PredefinedAccount account) {
    final isSelected = _selectedAccount == account;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedAccount = account;
          _isCustomAccount = false;
        });
      },
      child: Container(
        decoration: BoxDecoration(
          color: isSelected ? account.color.withValues(alpha: 0.1) : AppTheme.surfaceColor,
          borderRadius: BorderRadius.circular(AppConstants.radiusMedium),
          border: Border.all(
            color: isSelected ? account.color : AppTheme.borderColor,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              account.icon,
              color: account.color,
              size: 32,
            ),
            const SizedBox(height: AppConstants.paddingSmall),
            Text(
              account.name,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppTheme.textPrimaryColor,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
            if (account.bankName != null) ...[
              const SizedBox(height: 4),
              Text(
                account.bankName!,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppTheme.textSecondaryColor,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildCustomAccountCard() {
    final isSelected = _isCustomAccount;
    return GestureDetector(
      onTap: () {
        setState(() {
          _isCustomAccount = true;
          _selectedAccount = null;
        });
      },
      child: Container(
        decoration: BoxDecoration(
          color: isSelected ? AppTheme.primaryColor.withValues(alpha: 0.1) : AppTheme.surfaceColor,
          borderRadius: BorderRadius.circular(AppConstants.radiusMedium),
          border: Border.all(
            color: isSelected ? AppTheme.primaryColor : AppTheme.borderColor,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.add_circle_outline,
              color: isSelected ? AppTheme.primaryColor : AppTheme.textSecondaryColor,
              size: 32,
            ),
            const SizedBox(height: AppConstants.paddingSmall),
            Text(
              'Custom',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppTheme.textPrimaryColor,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _handleCreateAccount() async {
    if (!_formKey.currentState!.validate()) return;
    if (_selectedAccount == null && !_isCustomAccount) return;

    setState(() => _isLoading = true);

    try {
      final balance = double.parse(_balanceController.text);
      String accountName;
      Color accountColor;
      IconData accountIcon;
      AccountType accountType;

      if (_isCustomAccount) {
        accountName = _customNameController.text.trim();
        accountColor = AppTheme.primaryColor;
        accountIcon = Icons.account_balance_wallet;
        accountType = AccountType.debit;
      } else {
        accountName = _selectedAccount!.name;
        accountColor = _selectedAccount!.color;
        accountIcon = _selectedAccount!.icon;
        accountType = _selectedAccount!.accountType;
      }

      await ref
          .read(walletNotifierProvider.notifier)
          .addAccount(
            name: accountName,
            initialBalance: balance,
            color: accountColor,
            iconData: accountIcon,
            accountType: accountType,
          );

      if (!mounted) return;
      Navigator.of(context).pop();
      _showSuccessMessage(accountName);
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
