import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:connectly_c2c/model/product_model/product_enums/product_category_enum.dart';

class ProductCategoryViewModel extends StateNotifier<List<ProductCategory>> {
  ProductCategoryViewModel() : super(ProductCategory.values.toList());
}

final productCategoryProvider =
    StateNotifierProvider<ProductCategoryViewModel, List<ProductCategory>>(
  (ref) => ProductCategoryViewModel(),
);
