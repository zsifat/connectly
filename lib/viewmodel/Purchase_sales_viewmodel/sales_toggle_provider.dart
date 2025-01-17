import 'package:flutter_riverpod/flutter_riverpod.dart';

class SalesToggleNotifier extends StateNotifier<bool> {
  SalesToggleNotifier() : super(true);

  void toggle() {
    state = !state;
  }
}

final salesToggleProvider =
StateNotifierProvider<SalesToggleNotifier, bool>(
        (ref) => SalesToggleNotifier());
