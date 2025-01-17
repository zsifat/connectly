import 'package:flutter_riverpod/flutter_riverpod.dart';

class SearchAlertProvider extends StateNotifier<bool> {
  SearchAlertProvider() : super(false);

  void toggleSearchAlert() {
    state = !state;
  }
}

final searchAlertProvider = StateNotifierProvider<SearchAlertProvider, bool>(
    (ref) => SearchAlertProvider());
