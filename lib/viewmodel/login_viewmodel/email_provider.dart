import 'package:flutter_riverpod/flutter_riverpod.dart';

class EmailProvider extends StateNotifier<String> {
  EmailProvider() : super('');
  setEmail(String email) {
    state = email;
  }
}

final loginEmailProvider = StateNotifierProvider<EmailProvider, String>(
  (ref) => EmailProvider(),
);
