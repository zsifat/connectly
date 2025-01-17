import 'package:connectly_c2c/services/auth_service.dart';
import 'package:connectly_c2c/viewmodel/auth_viewmodel/auth_provider.dart';
import 'package:connectly_c2c/viewmodel/ui_viewmodel/is_first_time_user_provider.dart';
import 'package:connectly_c2c/viewmodel/user_viewmodel/user_profile_provider.dart';
import 'package:connectly_c2c/views/login_screen.dart';
import 'package:connectly_c2c/views/main_screen.dart';
import 'package:connectly_c2c/views/wellcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends ConsumerWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isFirstTime = ref.watch(isFirsTimeProvider);
    final user= ref.read(authStateProvider.notifier).currentUser(ref);

    return isFirstTime.when(
      loading: () => Scaffold(
        body: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Connect',
                  style: GoogleFonts.inter(
                      fontWeight: FontWeight.w700, fontSize: 24)),
              Text('ly',
                  style: GoogleFonts.inter(
                      fontWeight: FontWeight.w700,
                      fontSize: 24,
                      color: const Color(0xFF6B4EFF))),
            ],
          ),
        ),
      ),
      error: (error, stackTrace) => Scaffold(
        body: Center(
          child: Text('Something went wrong: $error'),
        ),
      ),
      data: (isFirstTime) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if(user!=null){
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const MainScreen()),
            );
          } else if (isFirstTime) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const WelcomeScreen()),
            );
          } else {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => LoginScreen()),
            );
          }
        });

        // Return an empty scaffold while navigation is happening
        return const Scaffold();
      },
    );
  }
}
