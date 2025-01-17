import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final isFirsTimeProvider = StateNotifierProvider<IsFirsTimeNotifier, AsyncValue<bool>>(
      (ref) => IsFirsTimeNotifier()..checkFirstTimeUser(), // Explicitly call the method here
);

class IsFirsTimeNotifier extends StateNotifier<AsyncValue<bool>> {
  IsFirsTimeNotifier() : super(const AsyncValue.loading());

  Future<void> checkFirstTimeUser() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final isFirstTime = prefs.getBool('isFirstTime') ?? true;
      if (isFirstTime) {
        await prefs.setBool('isFirstTime', false); // Mark as not first-time
      }

      state = AsyncValue.data(isFirstTime);
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }
}
