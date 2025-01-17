import 'package:flutter_riverpod/flutter_riverpod.dart';

class SellPostTitleProvider extends StateNotifier<String> {
  SellPostTitleProvider() : super('');

  void setTitle(String title) {
    state = title;
  }
}

final sellPostTitleProvider =
    StateNotifierProvider<SellPostTitleProvider, String>(
        (ref) => SellPostTitleProvider());
