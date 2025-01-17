import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginProcessingNotifier extends StateNotifier<bool>{
  LoginProcessingNotifier():super(false);

  setLoginProcessing(){
    state = true;
  }

  setLoginComplete(){
    state = false;
  }
}

final loginProcessingProvider = StateNotifierProvider<LoginProcessingNotifier,bool>((ref) => LoginProcessingNotifier(),);