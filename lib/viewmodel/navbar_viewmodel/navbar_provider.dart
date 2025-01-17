import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:connectly_c2c/model/navbar_model/navbar_icon_models/home_icon_model.dart';
import 'package:connectly_c2c/model/navbar_model/navbar_icon_models/inbox_icon_model.dart';
import 'package:connectly_c2c/model/navbar_model/navbar_model.dart';
import 'package:connectly_c2c/model/navbar_model/navbar_icon_models/profile_icon_model.dart';
import 'package:connectly_c2c/model/navbar_model/navbar_icon_models/sell_icon_model.dart';

class IconStateNotifier extends StateNotifier<NavbarModel> {
  IconStateNotifier()
      : super(NavbarModel(
            selectedIndex: 0,
            homeIcon: HomeIcon.homeOutlinedIcon,
            inboxIcon: BuyingIcon.buyingOutlinedIcon,
            sellIcon: SellIcon.sellOutlinedIcon,
            profileIcon: ProfileIcon.profileOutlinedIcon));

  void updateNavbar(int selectedIndex) {
    state = state.copyWith(
      selectedIndex: selectedIndex,
      homeIcon:
          selectedIndex == 0 ? HomeIcon.homeIcon : HomeIcon.homeOutlinedIcon,
      inboxIcon: selectedIndex == 1
          ? BuyingIcon.buyingIcon
          : BuyingIcon.buyingOutlinedIcon,
      sellIcon:
          selectedIndex == 2 ? SellIcon.sellIcon : SellIcon.sellOutlinedIcon,
      profileIcon: selectedIndex == 3
          ? ProfileIcon.profileIcon
          : ProfileIcon.profileOutlinedIcon,
    );
  }
  void invalidateNavbarIndex(){
    state =state.copyWith(
      selectedIndex: 0
    );
  }

}

final navBarProvider = StateNotifierProvider<IconStateNotifier, NavbarModel>(
  (ref) {
    return IconStateNotifier();
  },
);
