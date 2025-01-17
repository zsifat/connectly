

import 'package:connectly_c2c/model/product_model/product_enums/product_category_enum.dart';
import 'package:connectly_c2c/model/product_model/product_enums/product_location_enum.dart';

class FilterQuery {
  final bool isFilterQuery;
  final Location? location;
  final ProductCategory? category;

  FilterQuery({this.isFilterQuery = false, this.location, this.category});

  FilterQuery copyWith(
      {bool? isFilterQuery, Location? location, ProductCategory? category}) {
    return FilterQuery(
      isFilterQuery: isFilterQuery ?? this.isFilterQuery,
      location: location ?? this.location,
      category: category ?? this.category,
    );
  }
}
