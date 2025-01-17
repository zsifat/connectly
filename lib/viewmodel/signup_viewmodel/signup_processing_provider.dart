import 'package:flutter_riverpod/flutter_riverpod.dart';

class SignUpProcessingNotifier extends StateNotifier<bool>{
  SignUpProcessingNotifier():super(false);

  setSignUpProcessing(){
    state = true;
  }

  setSignUpComplete(){
    state = false;
  }
}

final signUpProcessingProvider = StateNotifierProvider<SignUpProcessingNotifier,bool>((ref) => SignUpProcessingNotifier(),);