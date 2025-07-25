// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dashboard_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$financeRepositoryHash() => r'137facf48c357d6debcc1747bb999d0020ba74da';

/// See also [financeRepository].
@ProviderFor(financeRepository)
final financeRepositoryProvider =
    AutoDisposeProvider<FinanceRepository>.internal(
      financeRepository,
      name: r'financeRepositoryProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$financeRepositoryHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef FinanceRepositoryRef = AutoDisposeProviderRef<FinanceRepository>;
String _$dashboardControllerHash() =>
    r'b44c44ab2de933400a1832672167266caf369968';

/// See also [DashboardController].
@ProviderFor(DashboardController)
final dashboardControllerProvider =
    AutoDisposeAsyncNotifierProvider<
      DashboardController,
      FinancialSummary
    >.internal(
      DashboardController.new,
      name: r'dashboardControllerProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$dashboardControllerHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$DashboardController = AutoDisposeAsyncNotifier<FinancialSummary>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
