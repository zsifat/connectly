import 'package:flutter_riverpod/flutter_riverpod.dart';

class FilterSearchTextNotifier extends StateNotifier<String> {
  FilterSearchTextNotifier() : super('');

  void setFilterSearch(String filter) {
    state = filter;
  }

  void clearFilterSearch() {
    state = '';
  }
}

final filterSearchTextProvider =
    StateNotifierProvider<FilterSearchTextNotifier, String>((ref) {
  return FilterSearchTextNotifier();
});
