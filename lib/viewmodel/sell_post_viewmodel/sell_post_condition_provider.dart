import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:connectly_c2c/model/product_model/product_enums/product_condition_enum.dart';

class SellPostConditionNotifier extends StateNotifier<ProductCondition> {
  SellPostConditionNotifier() : super(ProductCondition.Used);

  void setConditionNew() {
    state = ProductCondition.New;
  }

  void setConditionUsed() {
    state = ProductCondition.Used;
  }

  ProductCondition getCondition() {
    return state;
  }
}

final sellPostConditionProvider =
    StateNotifierProvider<SellPostConditionNotifier, ProductCondition>(
        (ref) => SellPostConditionNotifier());
