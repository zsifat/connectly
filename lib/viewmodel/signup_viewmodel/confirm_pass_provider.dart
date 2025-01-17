import 'package:flutter_riverpod/flutter_riverpod.dart';

class SignupConfirmPassProvider extends StateNotifier<String> {
  SignupConfirmPassProvider() : super('');

  void setConfirmPass(String confirmPass) {
    state = confirmPass;
  }
}

final signUpconfirmPassProvider = StateNotifierProvider<SignupConfirmPassProvider, String>(
    (ref) => SignupConfirmPassProvider());
