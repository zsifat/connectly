import 'package:connectly_c2c/viewmodel/user_viewmodel/user_profile_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:connectly_c2c/viewmodel/navbar_viewmodel/navbar_provider.dart';
import 'package:connectly_c2c/views/home_screen.dart';
import 'package:connectly_c2c/views/buying_product_screen.dart';
import 'package:connectly_c2c/views/profile_screen.dart';
import 'package:connectly_c2c/views/post_sell_ad_screen.dart';
import 'package:connectly_c2c/views/widgets/navbar.dart';
import 'package:google_fonts/google_fonts.dart';

class MainScreen extends ConsumerWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = ref.watch(navBarProvider).selectedIndex;
    final userProfile =ref.watch(userProfilerProvider);
    final isLightMode =
        MediaQuery.of(context).platformBrightness == Brightness.light;
    List<Widget> pages = [
      const HomeScreen(),
      const BuyingProductScreen(),
      const SellScreen(),
      const ProfileScreen(),
    ];
    if(userProfile!=null){
      return Scaffold(
        body: pages[currentIndex],
        bottomNavigationBar: getNavBar(ref,context),
      );
    }else{
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Connect',
                      style: GoogleFonts.inter(
                          fontWeight: FontWeight.w700, fontSize: 24,
                      color: Theme.of(context).primaryTextTheme.bodyLarge!.color
                      )),
                  Text('ly',
                      style: GoogleFonts.inter(
                          fontWeight: FontWeight.w700,
                          fontSize: 24,
                          color: const Color(0xFF6B4EFF))),
                ],
              ),
              const SizedBox(height: 10,),
              const SizedBox(
                  width: 120,
                  child: LinearProgressIndicator(
                    color: Color(0xFF6B4EFF),
                  ))
            ],
          ),
        ),

      );
    }

  }
}
