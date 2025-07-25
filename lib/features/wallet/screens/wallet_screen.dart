import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/theme/app_theme.dart';
import '../controllers/wallet_controller.dart';
import '../widgets/total_balance_card.dart';
import '../widgets/account_card.dart';
import '../widgets/add_account_dialog.dart';
import '../widgets/empty_wallet_state.dart';

class WalletScreen extends ConsumerWidget {
  const WalletScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final accountsState = ref.watch(walletControllerProvider);
    final totalBalanceState = ref.watch(totalBalanceProvider);

    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: accountsState.when(
        data: (accounts) =>
            _buildContent(context, ref, accounts, totalBalanceState),
        loading: () => const Center(
          child: CircularProgressIndicator(color: AppTheme.primaryColor),
        ),
        error: (error, stackTrace) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.error_outline, size: 64, color: AppTheme.errorColor),
              SizedBox(height: AppConstants.paddingLarge),
              Text(
                'Error loading wallet',
                style: Theme.of(
                  context,
                ).textTheme.headlineSmall?.copyWith(color: AppTheme.errorColor),
              ),
              SizedBox(height: AppConstants.paddingMedium),
              ElevatedButton(
                onPressed: () => ref.invalidate(walletControllerProvider),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.primaryColor,
                  foregroundColor: Colors.white,
                ),
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddAccountDialog(context, ref),
        backgroundColor: AppTheme.primaryColor,
        foregroundColor: Colors.white,
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildContent(
    BuildContext context,
    WidgetRef ref,
    List<dynamic> accounts,
    AsyncValue<double> totalBalanceState,
  ) {
    return RefreshIndicator(
      onRefresh: () async {
        ref.invalidate(walletControllerProvider);
        ref.invalidate(totalBalanceProvider);
      },
      color: AppTheme.primaryColor,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(AppConstants.paddingMedium),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TotalBalanceCard(totalBalanceState: totalBalanceState),
            SizedBox(height: AppConstants.paddingLarge),
            Text(
              'Your Accounts',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: AppTheme.textPrimaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: AppConstants.paddingMedium),
            if (accounts.isEmpty)
              const EmptyWalletState()
            else
              ...accounts.map(
                (account) => Padding(
                  padding: const EdgeInsets.only(
                    bottom: AppConstants.paddingMedium,
                  ),
                  child: AccountCard(
                    account: account,
                    onAddBalance: (amount, description) => _addBalance(
                      context,
                      ref,
                      account.id,
                      amount,
                      description,
                    ),
                    onSubtractBalance: (amount, description) =>
                        _subtractBalance(
                          context,
                          ref,
                          account.id,
                          amount,
                          description,
                        ),
                    onDeleteAccount: () =>
                        _deleteAccount(context, ref, account.id),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  void _showAddAccountDialog(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (context) => const AddAccountDialog(),
    );
  }

  void _addBalance(
    BuildContext context,
    WidgetRef ref,
    String accountId,
    double amount,
    String description,
  ) {
    ref.read(walletControllerProvider.notifier).addBalance(accountId, amount, description);
  }

  void _subtractBalance(
    BuildContext context,
    WidgetRef ref,
    String accountId,
    double amount,
    String description,
  ) {
    ref
        .read(walletControllerProvider.notifier)
        .subtractBalance(accountId, amount, description);
  }

  void _deleteAccount(BuildContext context, WidgetRef ref, String accountId) {
    ref.read(walletControllerProvider.notifier).deleteAccount(accountId);
  }
}
