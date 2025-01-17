import 'package:connectly_c2c/model/product_model/product_enums/product_category_enum.dart';
import 'package:connectly_c2c/model/product_model/product_enums/product_condition_enum.dart';
import 'package:connectly_c2c/model/product_model/product_enums/product_location_enum.dart';
import 'package:connectly_c2c/model/product_model/product_enums/product_sell_status_enum.dart';

class Product {
  final String productId;
  final String sellerId;
  final String sellerName;
  final String productName;
  final String productDescription;
  final double askingPrice;
  final ProductCategory productCategory;
  final Location productLocation;
  final DateTime sellPostDate;
  final ProductCondition productCondition;
  final ProductSellStatus productSellStatus;
  final List<String> productImages;
  final DateTime? sellDate;
  final String? buyerName;
  final double? sellingPrice;
  final String? buyerId;

  const Product(
      {required this.productId,
      required this.sellerId,
      required this.sellerName,
      required this.productName,
      required this.productDescription,
      required this.askingPrice,
      required this.productCategory,
      required this.productLocation,
      required this.sellPostDate,
      required this.productCondition,
      required this.productImages,
      this.productSellStatus = ProductSellStatus.unsold,
      this.sellDate,
      this.buyerName,
      this.buyerId,
      this.sellingPrice});

  Product copyWith(
      {String? productId,
      String? sellerId,
      String? sellerName,
      String? productName,
      String? productDescription,
      double? askingPrice,
      ProductCategory? productCategory,
      Location? productLocation,
      DateTime? sellPostDate,
      ProductCondition? productCondition,
      ProductSellStatus? productSellStatus,
      DateTime? sellDate,
      String? buyerName,
      String? buyerId,
      List<String>? productImages,
      double? sellingPrice}) {
    return Product(
        productId: productId ?? this.productId,
        sellerId: sellerId ?? this.sellerId,
        sellerName: sellerName ?? this.sellerName,
        productName: productName ?? this.productName,
        productDescription: productDescription ?? this.productDescription,
        askingPrice: askingPrice ?? this.askingPrice,
        productCategory: productCategory ?? this.productCategory,
        productLocation: productLocation ?? this.productLocation,
        sellPostDate: sellPostDate ?? this.sellPostDate,
        productCondition: productCondition ?? this.productCondition,
        productSellStatus: productSellStatus ?? this.productSellStatus,
        sellDate: sellDate ?? this.sellDate,
        productImages: productImages ?? this.productImages,
        buyerId: buyerId ?? this.buyerId,
        buyerName: buyerName ?? this.buyerName,
        sellingPrice: sellingPrice ?? this.sellingPrice);
  }

  factory Product.fromJson(Map<String, dynamic> map) {
    return Product(
        productId: map['productId'],
        sellerId: map['sellerId'],
        sellerName: map['sellerName'],
        productName: map['productName'],
        productDescription: map['productDescription'],
        askingPrice: map['askingPrice'],
        productCategory: ProductCategory.values[map['productCategory']],
        productLocation: Location.values[map['productLocation']],
        sellPostDate: DateTime.parse(map['sellPostDate']),
        productCondition: ProductCondition.values[map['condition']],
        productSellStatus: ProductSellStatus.values[map['status']],
        sellDate: DateTime.tryParse(map['selldate'] ?? ''),
        productImages: (map['productImages'] as List<dynamic>).cast<String>(),
        sellingPrice: map['sellingPrice'],
        buyerName: map['buyerName'],
        buyerId: map['buyerId']);
  }

  Map<String, dynamic> toMap() {
    return {
      'productId': productId,
      'sellerId': sellerId,
      'sellerName': sellerName,
      'productName': productName,
      'productDescription': productDescription,
      'askingPrice': askingPrice,
      'productCategory': productCategory.index,
      'productLocation': productLocation.index,
      'sellPostDate': sellPostDate.toIso8601String(),
      'condition': productCondition.index,
      'status': productSellStatus.index,
      'selldate': sellDate?.toIso8601String(),
      'productImages': productImages,
      'buyerName': buyerName,
      'buyerId': buyerId,
      'sellingPrice': sellingPrice
    };
  }
}
