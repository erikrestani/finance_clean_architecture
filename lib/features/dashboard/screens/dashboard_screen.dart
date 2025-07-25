import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/theme/app_theme.dart';
import '../../../shared/widgets/app_bar.dart';
import '../controllers/dashboard_controller.dart';
import '../widgets/expense_summary_card.dart';
import '../widgets/category_expense_card.dart';
import '../widgets/recent_expenses_card.dart';
import '../widgets/savings_insight_card.dart';
import '../../wallet/screens/wallet_screen.dart';
import '../../reports/screens/report_screen.dart';
import '../../tips/screens/tips_screen.dart';

class DashboardScreen extends ConsumerStatefulWidget {
  const DashboardScreen({super.key});

  @override
  ConsumerState<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends ConsumerState<DashboardScreen> {
  int _currentIndex = 0;
  late PageController _pageController;

  static const List<Widget> _screens = [
    DashboardContent(),
    WalletScreen(),
    ReportScreen(),
    TipsScreen(),
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _currentIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onPageChanged(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  void _onTabTapped(int index) {
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: CustomAppBar(
        actions: [
          IconButton(
            icon: const Icon(
              Icons.person_outline_rounded,
              color: AppTheme.primaryLightColor,
            ),
            onPressed: () {
            },
          ),
        ],
      ),
      body: PageView(
        controller: _pageController,
        onPageChanged: _onPageChanged,
        children: _screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
        type: BottomNavigationBarType.fixed,
        backgroundColor: AppTheme.surfaceColor,
        selectedItemColor: AppTheme.primaryColor,
        unselectedItemColor: AppTheme.textSecondaryColor,
        selectedLabelStyle: Theme.of(context).textTheme.bodySmall?.copyWith(
          fontWeight: FontWeight.w600,
        ),
        unselectedLabelStyle: Theme.of(context).textTheme.bodySmall,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_balance_wallet),
            label: 'Wallet',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart),
            label: 'Reports',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.tips_and_updates),
            label: 'Tips',
          ),
        ],
      ),
    );
  }


}

class DashboardContent extends ConsumerWidget {
  const DashboardContent({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dashboardState = ref.watch(dashboardControllerProvider);

    return dashboardState.when(
      data: (summary) => _buildDashboardContent(context, summary),
      loading: () => const Center(
        child: CircularProgressIndicator(
          color: AppTheme.primaryColor,
        ),
      ),
      error: (error, stackTrace) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 64,
              color: AppTheme.errorColor,
            ),
            SizedBox(height: AppConstants.paddingLarge),
            Text(
              'Error loading dashboard',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: AppTheme.errorColor,
              ),
            ),
            SizedBox(height: AppConstants.paddingMedium),
            ElevatedButton(
              onPressed: () {
                ref.read(dashboardControllerProvider.notifier).refreshData();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.primaryColor,
                foregroundColor: Colors.white,
              ),
              child: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDashboardContent(BuildContext context, summary) {
    return RefreshIndicator(
      onRefresh: () async {
        // Refresh data
      },
      color: AppTheme.primaryColor,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(AppConstants.paddingMedium),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Expense Summary Cards
            ExpenseSummaryCard(summary: summary),
            SizedBox(height: AppConstants.paddingLarge),
            
            // Savings Insight
            SavingsInsightCard(summary: summary),
            SizedBox(height: AppConstants.paddingLarge),
            
            // Category Expenses
            CategoryExpenseCard(summary: summary),
            SizedBox(height: AppConstants.paddingLarge),
            
            // Recent Expenses
            RecentExpensesCard(summary: summary),
          ],
        ),
      ),
    );
  }
} 