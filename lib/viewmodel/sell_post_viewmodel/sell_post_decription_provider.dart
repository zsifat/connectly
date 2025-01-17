import 'package:flutter_riverpod/flutter_riverpod.dart';

class SellPostDescriptionProvider extends StateNotifier<String> {
  SellPostDescriptionProvider() : super('');

  void setDescription(String description) {
    state = description;
  }
}

final sellPostDescriptionProvider =
    StateNotifierProvider<SellPostDescriptionProvider, String>(
        (ref) => SellPostDescriptionProvider());
