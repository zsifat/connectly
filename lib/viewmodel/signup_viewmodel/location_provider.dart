import 'package:connectly_c2c/model/product_model/product_enums/product_location_enum.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class _LocationNotifier extends StateNotifier<Location>{
  _LocationNotifier(): super(Location.dhaka);

  selectLocation(int? index){
    if(index!=null){
      state = Location.values[index];
    }

  }
}

final signUpLocationProvider = StateNotifierProvider<_LocationNotifier, Location>((ref) => _LocationNotifier(),);