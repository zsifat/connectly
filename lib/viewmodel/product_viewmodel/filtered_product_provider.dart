import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:connectly_c2c/model/product_model/filter_query_model.dart';
import 'package:connectly_c2c/model/product_model/product_enums/product_category_enum.dart';
import 'package:connectly_c2c/model/product_model/product_enums/product_location_enum.dart';

class FilterQueryNotifier extends StateNotifier<FilterQuery> {
  FilterQueryNotifier()
      : super(FilterQuery(
          isFilterQuery: false,
          location: null,
          category: null,
        ));

  void updateFilterQuery(
      {bool? isFilterQuery, Location? location, ProductCategory? category}) {
    state = state.copyWith(
        isFilterQuery: isFilterQuery, location: location, category: category);
  }
}

final filterQueryProvider =
    StateNotifierProvider<FilterQueryNotifier, FilterQuery>((ref) {
  return FilterQueryNotifier();
});
