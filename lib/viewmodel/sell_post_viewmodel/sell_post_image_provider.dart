import 'package:flutter_riverpod/flutter_riverpod.dart';

class SellPostImageProvider extends StateNotifier<List<String>> {
  SellPostImageProvider() : super([]);

  void addImage(String image) {
    if (state.length <= 6) {
      state = [...state, image];
    }
  }

  void removeImage(String image) {
    state = state.where((e) => e != image).toList();
  }
}

final sellPostImageProvider =
    StateNotifierProvider<SellPostImageProvider, List<String>>(
        (ref) => SellPostImageProvider());
