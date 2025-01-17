import 'package:flutter_riverpod/flutter_riverpod.dart';

class AccountsTransactionToggleNotifier extends StateNotifier<bool> {
  AccountsTransactionToggleNotifier() : super(true);

  void toggle() {
    state = !state;
  }
}

final accountSelectedProvider =
    StateNotifierProvider<AccountsTransactionToggleNotifier, bool>(
        (ref) => AccountsTransactionToggleNotifier());
