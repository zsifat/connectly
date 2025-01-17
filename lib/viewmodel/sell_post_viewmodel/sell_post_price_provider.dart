import 'package:flutter_riverpod/flutter_riverpod.dart';

class SellPostPriceProvider extends StateNotifier<double> {
  SellPostPriceProvider() : super(0.0);

  void setPrice(String price) {
    state = double.tryParse(price) ?? 0.0;
  }
}

final sellPostPriceProvider =
    StateNotifierProvider<SellPostPriceProvider, double>(
  (ref) => SellPostPriceProvider(),
);
