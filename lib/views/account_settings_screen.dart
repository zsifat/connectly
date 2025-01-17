import 'package:change_case/change_case.dart';
import 'package:connectly_c2c/viewmodel/user_viewmodel/user_profile_provider.dart';
import 'package:connectly_c2c/views/change_password_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:connectly_c2c/views/account_setting_update_screen.dart';
import 'package:connectly_c2c/views/widgets/account_setting_items.dart';

class AccountSettingsScreen extends ConsumerWidget {
  const AccountSettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userProfile = ref.watch(userProfilerProvider);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Account Settings',
            style: GoogleFonts.inter(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: Theme.of(context)
                    .primaryTextTheme
                    .bodyLarge!
                    .color)),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          children: [
            const SizedBox(height: 20),
            accountSettingsItem(
                title: userProfile!.username,
                icon: CupertinoIcons.person,
                screen: AccountSettingUpdateScreen(
                  fieldType: 'name',
                  initialValue: userProfile.username,
                ),
                context: context),
            const SizedBox(height: 40),
            accountSettingsItem(
                title: userProfile.phoneNo,
                icon: CupertinoIcons.phone,
                screen: AccountSettingUpdateScreen(
                  fieldType: 'phone',
                  initialValue: userProfile.phoneNo,
                ),
                context: context),
            const SizedBox(height: 40),
            accountSettingsItem(
                title: userProfile.location.name.toTitleCase(),
                icon: CupertinoIcons.location,
                screen: AccountSettingUpdateScreen(
                  fieldType: 'location',
                  initialValue: userProfile.location.name.toTitleCase(),
                ),
                context: context),
            const SizedBox(height: 40),
            accountSettingsItem(
                title: userProfile.email,
                icon: CupertinoIcons.mail,
                screen: AccountSettingUpdateScreen(
                  fieldType: 'email',
                  initialValue: userProfile.email,
                ),
                context: context),
            const SizedBox(height: 40),
            accountSettingsItem(
                context: context,
                title: 'Change Password',
                icon: CupertinoIcons.lock,
                screen: ChangePasswordScreen()),
          ],
        ),
      ),
    );
  }
}
