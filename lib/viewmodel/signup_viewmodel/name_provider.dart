import 'package:flutter_riverpod/flutter_riverpod.dart';

class SignupNameNotifier extends StateNotifier<String> {
  SignupNameNotifier() : super('');

  void setName(String name) {
    state = name;
  }
}

final signupNameProvider =
    StateNotifierProvider<SignupNameNotifier, String>((ref) => SignupNameNotifier());
