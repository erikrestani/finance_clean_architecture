// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wallet_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$accountRepositoryHash() => r'506c38270d5d0d745cdb06d38c6dc99f403010b0';

/// See also [accountRepository].
@ProviderFor(accountRepository)
final accountRepositoryProvider =
    AutoDisposeProvider<AccountRepository>.internal(
  accountRepository,
  name: r'accountRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$accountRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef AccountRepositoryRef = AutoDisposeProviderRef<AccountRepository>;
String _$totalBalanceHash() => r'720669ce8c4c56ec1194bc70c98e4a771e686cd8';

/// See also [totalBalance].
@ProviderFor(totalBalance)
final totalBalanceProvider = AutoDisposeFutureProvider<double>.internal(
  totalBalance,
  name: r'totalBalanceProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$totalBalanceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef TotalBalanceRef = AutoDisposeFutureProviderRef<double>;
String _$walletNotifierHash() => r'b5ee40591a73ceaf0282b9550f6e99ebf6b721aa';

/// See also [WalletNotifier].
@ProviderFor(WalletNotifier)
final walletNotifierProvider =
    AutoDisposeAsyncNotifierProvider<WalletNotifier, List<Account>>.internal(
  WalletNotifier.new,
  name: r'walletNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$walletNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$WalletNotifier = AutoDisposeAsyncNotifier<List<Account>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
