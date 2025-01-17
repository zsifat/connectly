import 'package:connectly_c2c/model/product_model/product_enums/product_location_enum.dart';

class UserProfile {
  final String uid;
  final String username;
  final String email;
  final String phoneNo;
  final Location location;
  final String profilePicURL;
  final int totalReview;
  final double reviewRating;
  final List<String> itemsSold;
  final List<String> itemsBought;
  final bool isEmailVerified;
  final bool isPhoneVerified;
  final bool isImageVerified;
  final bool isFacebookVerified;
  final double connectlyCredit;

  UserProfile(
      {
        required this.uid,
        required this.username,
        required this.email,
        required this.phoneNo,
        required this.location,
        required this.profilePicURL,
        required this.totalReview,
        required this.reviewRating,
        required this.itemsSold,
        required this.itemsBought,
        required this.isEmailVerified,
        required this.isPhoneVerified,
        required this.isImageVerified,
        required this.isFacebookVerified,
        required this.connectlyCredit,});

  factory UserProfile.fromMap(Map<String, dynamic> map) {
    return UserProfile(
      uid: map['uid'],
      username: map['username'],
      email: map['email'],
      phoneNo: map['phoneNo'],
      profilePicURL: map['profilePicURL'],
      location: Location.values[map['location']],
      totalReview: map['totalReview'],
      reviewRating: map['reviewRating'],
      itemsSold: List<String>.from(map['itemsSold']),
      itemsBought: List<String>.from(map['itemsBought']),
      isEmailVerified: map['isEmailVerified'],
      isPhoneVerified: map['isPhoneVerified'],
      isImageVerified: map['isImageVerified'],
      isFacebookVerified: map['isFacebookVerified'],
      connectlyCredit: map['connectlyCredit'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'username': username,
      'email': email,
      'phoneNo': phoneNo,
      'location': location.index,
      'profilePicURL':profilePicURL,
      'totalReview': totalReview,
      'reviewRating': reviewRating,
      'itemsSold': itemsSold,
      'itemsBought': itemsBought,
      'isEmailVerified': isEmailVerified,
      'isPhoneVerified': isPhoneVerified,
      'isImageVerified': isImageVerified,
      'isFacebookVerified': isFacebookVerified,
      'connectlyCredit': connectlyCredit,
    };
  }
}
