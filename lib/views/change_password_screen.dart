import 'package:connectly_c2c/viewmodel/auth_viewmodel/auth_provider.dart';
import 'package:connectly_c2c/viewmodel/user_viewmodel/user_profile_provider.dart';
import 'package:connectly_c2c/views/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class ChangePasswordScreen extends ConsumerStatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  ConsumerState<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends ConsumerState<ChangePasswordScreen> {
  bool isTapped=false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Change Password",style: GoogleFonts.inter(
          fontSize: 14,
        ),),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomButton(text: 'Reset Password', onPressed: () {
              setState(() {

              });
              isTapped =true;
              ref.read(authStateProvider.notifier).passwordReset(ref.read(userProfilerProvider)!.email);
            },),
            const SizedBox(height: 50,),
            isTapped ? const Text(
              "Password Reset Email has been Sent to your email.",textAlign: TextAlign.center,) : SizedBox.shrink()
          ],
        ),

      ),
    );

  }
}





