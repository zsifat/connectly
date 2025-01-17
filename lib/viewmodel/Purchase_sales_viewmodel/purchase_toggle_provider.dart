import 'package:flutter_riverpod/flutter_riverpod.dart';

class PurchaseToggleNotifier extends StateNotifier<bool> {
  PurchaseToggleNotifier() : super(true);

  void toggle() {
    state = !state;
  }
}

final purchaseToggleProvider =
StateNotifierProvider<PurchaseToggleNotifier, bool>(
        (ref) => PurchaseToggleNotifier());
