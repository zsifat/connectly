import 'package:flutter_riverpod/flutter_riverpod.dart';

class OfferedPriceProvider extends StateNotifier<double> {
  OfferedPriceProvider() : super(0);

  void setOfferedPrice(String price) {
    if (price.isNotEmpty && price != '0') {
      final parsedPrice = double.tryParse(price);
      if (parsedPrice != null && parsedPrice.toStringAsFixed(0) == price) {
        state = parsedPrice;
      }
    }
  }
}

final offeredPriceProvider =
    StateNotifierProvider<OfferedPriceProvider, double>(
  (ref) => OfferedPriceProvider(),
);
