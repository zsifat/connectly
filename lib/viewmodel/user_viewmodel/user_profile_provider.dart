import 'dart:convert';

import 'package:connectly_c2c/model/product_model/product_model.dart';
import 'package:connectly_c2c/model/user_model/user_profile_model.dart';
import 'package:connectly_c2c/services/profile_db_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

class UserProfileNotifier extends StateNotifier<UserProfile?>{
  final ProfileDbService userProfileService;
  UserProfileNotifier(this.userProfileService):super(null);

  void loadUserProfile(String uid) async{
    state = await userProfileService.getUserProfile(uid);
  }

  void saveUserProfile(UserProfile profile) async{
    await userProfileService.addUserProfile(profile);
    loadUserProfile(profile.uid);
  }

  void verificationUpdate(String uid, {bool isEmail=false,bool isImage=false,bool isPhone=false, bool isFacebook=false}) async{
    userProfileService.verificationUpdate(uid,isEmail: isEmail,isImage: isImage,isPhone: isPhone,isFacebook: isFacebook);
    loadUserProfile(uid);
  }

  void profileInfoUpdate(String uid,String field,String value){
    if(field=='name'){
      userProfileService.userInfoUpdate(uid: uid,field: 'username',value: value);
      loadUserProfile(uid);
    }else if(field=='phone'){
      userProfileService.userInfoUpdate(uid: uid,field:  'phoneNo',value: value);
      loadUserProfile(uid);
    }else if(field == 'location'){
      userProfileService.userInfoUpdate(uid: uid, field: 'location',locationIndex: int.tryParse(value));
      loadUserProfile(uid);
    }else if(field=='photo'){
      userProfileService.userInfoUpdate(uid: uid,field:  'profilePicURL',value: value);
      loadUserProfile(uid);
    }

  }

  void updateItemsSoldBought(UserProfile sellerProfile,UserProfile buyerProfile, Product product) async{
    bool check = await userProfileService.updateItemsSoldBought(sellerProfile,buyerProfile, product);
    if(check){
      loadUserProfile(sellerProfile.uid);
    }
  }

  profilePhotoUpload() async{
    http.StreamedResponse? response = await userProfileService.cloudPhotoUpload();
    if(response!=null) {
      if (response.statusCode == 200) {
        var responseData = await http.Response.fromStream(response);
        var data = json.decode(responseData.body);
        profileInfoUpdate(state!.uid, 'photo',data['secure_url']);
      } else {
        print('Image upload failed: ${response.statusCode}');
      }
    }
  }

}

final userProfilerServiceProvider = Provider((ref) => ProfileDbService(),);

final userProfilerProvider = StateNotifierProvider<UserProfileNotifier,UserProfile?>((ref) {
  final userProfileService= ref.watch(userProfilerServiceProvider);
  return UserProfileNotifier(userProfileService);
},);