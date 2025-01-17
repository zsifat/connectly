import 'package:flutter_riverpod/flutter_riverpod.dart';

class SignUpPhoneNoProvider extends StateNotifier<String> {
  SignUpPhoneNoProvider() : super('');

  void setPhoneNo(String phoneNo) {
    state = phoneNo;
  }
}

final signupPhoneNoProvider =
    StateNotifierProvider<SignUpPhoneNoProvider, String>((ref) => SignUpPhoneNoProvider());
