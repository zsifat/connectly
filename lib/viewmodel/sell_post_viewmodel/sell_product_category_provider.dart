import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:connectly_c2c/model/product_model/product_enums/product_category_enum.dart';

class SellProductCategoryProvider extends StateNotifier<ProductCategory?> {
  SellProductCategoryProvider() : super(null);

  void setCategory(ProductCategory category) {
    state = category;
  }
}

final sellProductCategoryProvider =
    StateNotifierProvider<SellProductCategoryProvider, ProductCategory?>(
        (ref) => SellProductCategoryProvider());
