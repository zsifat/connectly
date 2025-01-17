import 'package:flutter_riverpod/flutter_riverpod.dart';

class PhotoUploadLoadingNotifier extends StateNotifier<bool>{
  PhotoUploadLoadingNotifier() : super(false);

  setToLoading(){
    state = true;
  }

  setLoadingComplete(){
    state = false;
  }

}

final photoUploadLoadingProvider = StateNotifierProvider<PhotoUploadLoadingNotifier, bool>((ref) => PhotoUploadLoadingNotifier(),);