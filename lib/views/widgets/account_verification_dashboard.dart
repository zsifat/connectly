import 'package:connectly_c2c/viewmodel/user_viewmodel/user_profile_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

Widget accountVerificationDashboard(
    Size size, WidgetRef ref, BuildContext context) {
  final user = ref.watch(userProfilerProvider);
  final isEmailVerified = user!.isEmailVerified;
  final isImageVerified = user.isImageVerified;
  final isPhoneVerified = user.isPhoneVerified;
  final isFacebookVerified = user.isFacebookVerified;

  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      InkWell(
        onTap: () {
          ref.read(userProfilerProvider.notifier).verificationUpdate(user.uid,isEmail: true);
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  height: 50,
                  width: 50,
                  decoration: isEmailVerified
                      ? const BoxDecoration(
                          color: Color(0xFF6B4EFF),
                          shape: BoxShape.circle,
                        )
                      : BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: const Color(0xFF9EA3AE),
                            width: 2,
                          ),
                        ),
                ),
                Icon(
                  Icons.email_outlined,
                  size: 36,
                  color:
                      isEmailVerified ? Colors.white : const Color(0xFF9EA3AE),
                ),
              ],
            ),
            SizedBox(height: size.height * 0.01),
            Text('Email\nVerified',
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: Theme.of(context)
                      .primaryTextTheme
                      .bodyLarge!
                      .color
                ))
          ],
        ),
      ),
      InkWell(
        onTap: () {
          ref.read(userProfilerProvider.notifier).verificationUpdate(user.uid,isImage: true);

        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  height: 50,
                  width: 50,
                  decoration: isImageVerified
                      ? const BoxDecoration(
                          color: Color(0xFF6B4EFF),
                          shape: BoxShape.circle,
                        )
                      : BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: const Color(0xFF9EA3AE),
                            width: 2,
                          ),
                        ),
                ),
                Icon(
                  Icons.camera_alt_outlined,
                  size: 36,
                  color:
                      isImageVerified ? Colors.white : const Color(0xFF9EA3AE),
                ),
              ],
            ),
            SizedBox(height: size.height * 0.01),
            Text('Image\nVerified',
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: Theme.of(context)
                      .primaryTextTheme
                      .bodyLarge!
                      .color
                ))
          ],
        ),
      ),
      InkWell(
        onTap: () {
          ref.read(userProfilerProvider.notifier).verificationUpdate(user.uid,isPhone: true);
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  height: 50,
                  width: 50,
                  decoration: isPhoneVerified
                      ? const BoxDecoration(
                          color: Color(0xFF6B4EFF),
                          shape: BoxShape.circle,
                        )
                      : BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: const Color(0xFF9EA3AE),
                            width: 2,
                          ),
                        ),
                ),
                Icon(
                  Icons.call_outlined,
                  size: 36,
                  color:
                      isPhoneVerified ? Colors.white : const Color(0xFF9EA3AE),
                ),
              ],
            ),
            SizedBox(height: size.height * 0.01),
            Text('Phone\nVerified',
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: Theme.of(context)
                      .primaryTextTheme
                      .bodyLarge!
                      .color
                ))
          ],
        ),
      ),
      InkWell(
        onTap: () {
          ref.read(userProfilerProvider.notifier).verificationUpdate(user.uid,isFacebook: true);

        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  height: 50,
                  width: 50,
                  decoration: isFacebookVerified
                      ? const BoxDecoration(
                          color: Color(0xFF6B4EFF),
                          shape: BoxShape.circle,
                        )
                      : BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: const Color(0xFF9EA3AE),
                            width: 2,
                          ),
                        ),
                ),
                Icon(
                  Icons.facebook,
                  size: 36,
                  color: isFacebookVerified
                      ? Colors.white
                      : const Color(0xFF9EA3AE),
                ),
              ],
            ),
            SizedBox(height: size.height * 0.01),
            Text('Connect\nFacebook',
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: Theme.of(context)
                      .primaryTextTheme
                      .bodyLarge!
                      .color
                ))
          ],
        ),
      )
    ],
  );
}
