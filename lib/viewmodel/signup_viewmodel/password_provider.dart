import 'package:flutter_riverpod/flutter_riverpod.dart';

class SignupPasswordNotifier extends StateNotifier<String> {
  SignupPasswordNotifier() : super('');

  void setPassword(String password) {
    state = password;
  }
}

final signupPasswordProvider = StateNotifierProvider<SignupPasswordNotifier, String>(
    (ref) => SignupPasswordNotifier());
