import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectly_c2c/model/offer_price_model/offer_price_model.dart';
import 'package:connectly_c2c/model/product_model/product_model.dart';

class ProductService {
  final _fireStore = FirebaseFirestore.instance;
  final _collection = 'products';
  final _bidCollection = 'bidPrice';

  void addProduct(Product product) async {
    try {
      final docRef = _fireStore.collection('products').doc();
      final productWithId = product.copyWith(productId: docRef.id);
      await docRef.set(productWithId.toMap());
    } catch (e) {
      throw Exception(e);
    }
  }

  void deleteProduct(String productId) async {
    await _fireStore.collection(_collection).doc(productId).delete();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getAllProducts() {
    final snap = _fireStore.collection(_collection).where('status',isEqualTo: 1).snapshots();
    return snap;
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getBidOrBookedProducts() {
    final snap = _fireStore.collection(_collection).where('status',isNotEqualTo: 0).snapshots();
    return snap;
  }


  Stream<QuerySnapshot<Map<String, dynamic>>> getBookedProducts(String uid) {
    return _fireStore.collection(_collection).where('status',isEqualTo: 2).where('sellerId',isEqualTo: uid).snapshots();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getSoldProducts(String uid) {
    return _fireStore.collection(_collection).where('status',isEqualTo: 0).where('sellerId',isEqualTo: uid).snapshots();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getPurchasedProducts(String uid){
    return _fireStore.collection(_collection).where('status',isEqualTo: 0).where('buyerId',isEqualTo: uid).snapshots();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getSellPosts(String sellerId) {
    final snapshot = _fireStore
        .collection(_collection).where('status',isEqualTo: 1)
        .where('sellerId', isEqualTo: sellerId)
        .snapshots();
    return snapshot;
  }

  void addBid(MakeOfferModel bid, String productId) async {
    try {
      final snap = await _fireStore
          .collection(_collection)
          .doc(productId)
          .collection(_bidCollection)
          .where('buyerId', isEqualTo: bid.buyerId)
          .get();

      if (snap.docs.isNotEmpty) {
        final docId = snap.docs.first.id;
        await _fireStore
            .collection(_collection)
            .doc(productId)
            .collection(_bidCollection)
            .doc(docId)
            .update(bid.toMap());
        print("Bid updated successfully!");
      } else {
        await _fireStore
            .collection(_collection)
            .doc(productId)
            .collection(_bidCollection)
            .doc()
            .set(bid.toMap());
        print("New bid added successfully!");
      }
    } catch (e) {
      print("Error while adding/updating bid: $e");
    }
  }

  void cancelBid(String productId, String userId) async {
   final snap = await _fireStore.collection(_collection).doc(productId).collection(_bidCollection).where('buyerId',isEqualTo: userId).get();
   await _fireStore.collection(_collection).doc(productId).collection(_bidCollection).doc(snap.docs[0].id).delete();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getBid(String productId, String userId) {
    final snap = _fireStore
        .collection(_collection)
        .doc(productId)
        .collection(_bidCollection)
        .where('buyerId', isEqualTo: userId)
        .snapshots();
    return snap;
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getAcceptedBid(String productId){
    return _fireStore.collection(_collection).doc(productId).collection(_bidCollection).get();
  }


  Stream<QuerySnapshot<Map<String, dynamic>>> getProposalsHighToLow(String productId) {
    final snap = _fireStore
        .collection(_collection)
        .doc(productId)
        .collection(_bidCollection)
        .orderBy('bidPrice', descending: true)
        .snapshots();
    return snap;
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> getBuyerSellerProfile(String uid){
    return _fireStore.collection('users').doc(uid).get();
  }

  void markAsBooked(String productId, String buyerId) async{
    final doc=await _fireStore.collection(_collection).doc(productId).collection(_bidCollection).where('buyerId',isEqualTo: buyerId).get();
    await _fireStore.collection(_collection).doc(productId).collection(_bidCollection).doc(doc.docs.first.id).update({'isAccepted':true});
    await _fireStore.collection(_collection).doc(productId).update({'status':2});
  }
  void markAsSold(String productId, String buyerId, String buyerName, double sellingPrice) async{
    await _fireStore.collection(_collection).doc(productId).update({'status':0,'selldate': DateTime.now().toIso8601String(),'buyerId':buyerId,'buyerName': buyerName,'sellingPrice':sellingPrice});
    final snap = await _fireStore.collection(_collection).doc(productId).collection(_bidCollection).where('buyerId',isNotEqualTo: buyerId).get();
    snap.docs.forEach((element) async{
      await _fireStore.collection(_collection).doc(productId).collection(_bidCollection).doc(element.id).delete();
    },);


  }

  Future<http.StreamedResponse> productPhotoUpload(String imagePath) async {
      File imageFile = File(imagePath);
      String cloudinaryUrl = "https://api.cloudinary.com/v1_1/dwnqjq3k2/image/upload";
      String unsignedPreset = "connectly";
      var request = http.MultipartRequest('POST', Uri.parse(cloudinaryUrl));
      request.fields['upload_preset'] = unsignedPreset;
      request.files.add(await http.MultipartFile.fromPath('file', imageFile.path));
      var response = await request.send();
      return response;
  }

}
