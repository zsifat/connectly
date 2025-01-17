import 'dart:convert';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectly_c2c/model/product_model/product_model.dart';
import 'package:connectly_c2c/model/user_model/user_profile_model.dart';
import 'package:image_picker/image_picker.dart';

class ProfileDbService{
  final _fireStore = FirebaseFirestore.instance;
  final _collection='users';
  

  Future<void> addUserProfile(UserProfile profile) async{
    await _fireStore.collection(_collection).doc(profile.uid).set(profile.toMap());
  }

  Future<UserProfile?> getUserProfile(String uid) async{
    final doc = await _fireStore.collection(_collection).doc(uid).get();
    if(doc.exists){
      return UserProfile.fromMap(doc.data()!);
    }else{
      return null;
    }
  }
  
  void verificationUpdate(String uid,{bool isEmail=false,bool isImage=false,bool isPhone=false, bool isFacebook=false}) async {
    if (isEmail) {
      await _fireStore.collection(_collection).doc(uid).update(
          {'isEmailVerified': true});
    } else if (isImage) {
      await _fireStore.collection(_collection).doc(uid).update(
          {'isImageVerified': true});
    } else if (isPhone) {
      await _fireStore.collection(_collection).doc(uid).update(
          {'isPhoneVerified': true});
    } else if (isFacebook) {
      await _fireStore.collection(_collection).doc(uid).update(
          {'isFacebookVerified': true});
    }
  }

  void userInfoUpdate(
      {required String uid, required String field, String? value, int? locationIndex}) async{
    if(locationIndex!=null){
      await _fireStore.collection(_collection).doc(uid).update({field:locationIndex});
    }else if(value!=null){
      await _fireStore.collection(_collection).doc(uid).update({field:value});
    }

  }

  Future<bool> updateItemsSoldBought(UserProfile sellerProfile,UserProfile buyerProfile, Product product) async{
    try{
      final UserProfile? latestSellerProfile =  await getUserProfile(sellerProfile.uid);
      final UserProfile? latestBuyerProfile =  await getUserProfile(buyerProfile.uid);
      bool check1=false;
      bool check2=false;
      if(latestSellerProfile!=null){
        _fireStore.collection(_collection).doc(sellerProfile.uid).update({'itemsSold':[...sellerProfile.itemsSold,product.productId]});
        check1 =true;
      }
      if(latestBuyerProfile!=null){
        _fireStore.collection(_collection).doc(buyerProfile.uid).update({'itemsBought':[...buyerProfile.itemsBought,product.productId]});
        check2 = true;
      }
      if(check1&&check2){
        return true;
      } else {
        return false;
      }
    }catch(e){
      throw Exception(e);
    }

  }


Future<http.StreamedResponse?>? cloudPhotoUpload() async {
    XFile? pickedImage=await ImagePicker().pickImage(source: ImageSource.gallery);
    if(pickedImage!=null){
      File imageFile = File(pickedImage.path);
      String cloudinaryUrl = "https://api.cloudinary.com/v1_1/dwnqjq3k2/image/upload";
      String unsignedPreset = "connectly";
      var request = http.MultipartRequest('POST', Uri.parse(cloudinaryUrl));
      request.fields['upload_preset'] = unsignedPreset;
      request.files.add(await http.MultipartFile.fromPath('file', imageFile.path));
      var response = await request.send();
      return response;
    }
    return null;

  }


}