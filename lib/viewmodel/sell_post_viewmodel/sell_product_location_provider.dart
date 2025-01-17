import 'package:connectly_c2c/viewmodel/user_viewmodel/user_profile_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:connectly_c2c/model/product_model/product_enums/product_location_enum.dart';

class SellProductLocationNotifier extends StateNotifier<Location> {
  final Ref ref;
  SellProductLocationNotifier(this.ref) : super(ref.watch(userProfilerProvider)!.location);

  void setLocation(Location location) {
    state = location;
  }
}

final sellProductLocationProvider =
    StateNotifierProvider<SellProductLocationNotifier, Location>(
        (ref) {
          return SellProductLocationNotifier(ref);
        });
