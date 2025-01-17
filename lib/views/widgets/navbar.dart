import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:connectly_c2c/viewmodel/navbar_viewmodel/navbar_provider.dart';

BottomNavigationBar getNavBar(WidgetRef ref, BuildContext context) {
  var navBarModel = ref.watch(navBarProvider);
  return BottomNavigationBar(
    backgroundColor: Theme.of(context).navigationBarTheme.backgroundColor,
    type: BottomNavigationBarType.fixed,
    selectedItemColor: const Color(0xFF6B4EFF),
    items: [
      BottomNavigationBarItem(
        icon: navBarModel.homeIcon,
        label: 'Home',
      ),
      BottomNavigationBarItem(icon: navBarModel.inboxIcon, label: 'Buying'),
      BottomNavigationBarItem(icon: navBarModel.sellIcon, label: 'Selling'),
      BottomNavigationBarItem(icon: navBarModel.profileIcon, label: 'Profile'),
    ],
    currentIndex: navBarModel.selectedIndex,
    onTap: (index) {
      ref.read(navBarProvider.notifier).updateNavbar(index);
    },
  );
}
