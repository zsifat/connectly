import 'package:flutter_riverpod/flutter_riverpod.dart';

class IsBookedNotifier extends StateNotifier<bool>{
  IsBookedNotifier():super(false);

  setBooked(){
    state = true;
  }

  undoBooked(){
    state = false;
  }

}

final isBookedProvider = StateNotifierProvider<IsBookedNotifier,bool>((ref) => IsBookedNotifier(),);