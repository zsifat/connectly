import 'package:flutter_riverpod/flutter_riverpod.dart';

class SignupEmailNotifier extends StateNotifier<String> {
  SignupEmailNotifier() : super('');

  void setEmail(String email) {
    state = email;
  }
}

final signUpEmailProvider =
    StateNotifierProvider<SignupEmailNotifier, String>((ref) => SignupEmailNotifier());
