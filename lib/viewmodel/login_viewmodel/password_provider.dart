import 'package:flutter_riverpod/flutter_riverpod.dart';

class PasswordNotifer extends StateNotifier<String>{
  PasswordNotifer():super('');

  void setPassword(String password){
    state = password;
  }

}
final loginPasswordProvider = StateNotifierProvider<PasswordNotifer,String>((ref) => PasswordNotifer(),);