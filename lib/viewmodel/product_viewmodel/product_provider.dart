import 'dart:convert';

import 'package:async/async.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectly_c2c/model/offer_price_model/offer_price_model.dart';
import 'package:connectly_c2c/model/product_model/product_enums/product_category_enum.dart';
import 'package:connectly_c2c/model/product_model/product_enums/product_condition_enum.dart';
import 'package:connectly_c2c/model/product_model/product_enums/product_location_enum.dart';
import 'package:connectly_c2c/model/product_model/product_model.dart';
import 'package:connectly_c2c/model/user_model/user_profile_model.dart';
import 'package:connectly_c2c/services/products_db_service.dart';
import 'package:connectly_c2c/viewmodel/ui_viewmodel/is_booked_provider.dart';
import 'package:connectly_c2c/viewmodel/user_viewmodel/user_profile_provider.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductsServiceNotifier extends StateNotifier<List<Product>> {
  final Ref ref;

  ProductsServiceNotifier(this.ref) : super([]);

  final productService = ProductService();

  void publishPost(
      String sellerUid,
      String sellerName,
      String productName,
      String productDescription,
      double productPrice,
      ProductCategory productCategory,
      Location productLocation,
      List<String> productImages,
      ProductCondition productCondition) {
    productService.addProduct(Product(
      productId: '',
      sellerId: sellerUid,
      sellerName: sellerName,
      productName: productName,
      productDescription: productDescription,
      askingPrice: productPrice,
      productCategory: productCategory,
      productLocation: productLocation,
      sellPostDate: DateTime.now(),
      productCondition: productCondition,
      productImages: productImages,
    ));
  }

  void unpublishPost(String productId) {
    productService.deleteProduct(productId);
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> fetchAllProduct() {
    final allProductSnaps = productService.getAllProducts();
    allProductSnaps.listen((products) {
      for (var productJson in products.docs) {
        Product product = Product.fromJson(productJson.data());
        state = [...state, product];
      }
    });
    return allProductSnaps;
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> fetchBookedProduct() {
    final bookedProductSnaps =
        productService.getBookedProducts(ref.watch(userProfilerProvider)!.uid);
    return bookedProductSnaps;
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> fetchSoldProduct() {
    final soldProductSnaps =
        productService.getSoldProducts(ref.watch(userProfilerProvider)!.uid);
    return soldProductSnaps;
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> fetchPurchasedProducts() {
    final purchasedProductSnaps =
    productService.getPurchasedProducts(ref.watch(userProfilerProvider)!.uid);
    ref.read(userProfilerProvider.notifier).loadUserProfile(ref.read(userProfilerProvider)!.uid);
    return purchasedProductSnaps;
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> fetchSellPost() {
    final sellerId = ref.watch(userProfilerProvider)!.uid;
    return productService.getSellPosts(sellerId);
  }

  void addBid(Product product, double bidPrice) {
    productService.addBid(
        MakeOfferModel(
          bidPrice: bidPrice,
          sellerId: product.sellerId,
          buyerId: ref.watch(userProfilerProvider)!.uid,
          buyerName: ref.watch(userProfilerProvider)!.username,
          productId: product.productId,
          bidTime: DateTime.now().toIso8601String(),
          isAccepted: false,
        ),
        product.productId);
  }

  void cancelBid(String productId, String userId) {
    productService.cancelBid(productId, userId);
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getBid(Product product) {
    return productService.getBid(
        product.productId, ref.watch(userProfilerProvider)!.uid);
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getAcceptedBid(String productId) {
    return productService.getAcceptedBid(productId);
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getProposalsHighToLow(
      String productId) {
    return productService.getProposalsHighToLow(productId);
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> getBuyerSellerProfile(
      String uid) {
    return productService.getBuyerSellerProfile(uid);
  }

  void markAsBooked(String productId, String buyerId) async {
    // ref.read(isBookedProvider.notifier).setBooked();
    productService.markAsBooked(productId, buyerId);
  }

  void markAsSold(Product product, UserProfile buyerProfile,
      UserProfile sellerProfile,double sellingPrice) async {
    // ref.read(isBookedProvider.notifier).setBooked();
    productService.markAsSold(product.productId, buyerProfile.uid,buyerProfile.username,sellingPrice);
    ref
        .read(userProfilerProvider.notifier)
        .updateItemsSoldBought(sellerProfile,buyerProfile, product);


  }

  List<Product> _bidProducts = [];

  List<Product> get bidProducts => _bidProducts;

  Stream<List<Product>> fetchBidOrBookedProducts() {
    return productService.getBidOrBookedProducts().asyncMap((snapshot) async {
      final allProductsJson = snapshot.docs;
      final allProducts = allProductsJson.map((e) {
        return Product.fromJson(e.data());
      }).toList();

      final List<Product> bidProducts = [];
      final List<Stream<QuerySnapshot<Map<String, dynamic>>>> bidStreams =
          allProducts.map((product) {
        return getBid(product);
      }).toList();

      final combinedStream = StreamZip(bidStreams);
      final bidSnapshots = await combinedStream.first;

      for (int i = 0; i < bidSnapshots.length; i++) {
        if (bidSnapshots[i].docs.isNotEmpty) {
          bidProducts.add(allProducts[i]);
        }
      }

      _bidProducts = bidProducts;
      return bidProducts;
    });
  }



  Future<String?> productPhotoUploadCloud(String imagePath) async{
    http.StreamedResponse response = await productService.productPhotoUpload(imagePath);
    if (response.statusCode == 200) {
      var responseData = await http.Response.fromStream(response);
      var data = json.decode(responseData.body);
      return data['secure_url'];
    } else {
      print('Image upload failed: ${response.statusCode}');
      return null;
    }
    }



}

final productServiceProvider =
    StateNotifierProvider<ProductsServiceNotifier, List<Product>>(
  (ref) => ProductsServiceNotifier(ref),
);
