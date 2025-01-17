import 'package:flutter/material.dart';

class NavbarModel {
  final int selectedIndex;
  final Icon homeIcon;
  final Icon inboxIcon;
  final Icon sellIcon;
  final Icon profileIcon;

  NavbarModel({
    required this.selectedIndex,
    required this.homeIcon,
    required this.inboxIcon,
    required this.sellIcon,
    required this.profileIcon,
  });

  NavbarModel copyWith({
    int? selectedIndex,
    Icon? homeIcon,
    Icon? inboxIcon,
    Icon? sellIcon,
    Icon? profileIcon,
  }) {
    return NavbarModel(
      selectedIndex: selectedIndex ?? this.selectedIndex,
      homeIcon: homeIcon ?? this.homeIcon,
      inboxIcon: inboxIcon ?? this.inboxIcon,
      sellIcon: sellIcon ?? this.sellIcon,
      profileIcon: profileIcon ?? this.profileIcon,
    );
  }
}
