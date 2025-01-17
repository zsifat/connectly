import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class TransactionScreen extends ConsumerWidget {
  const TransactionScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLightMode =
        MediaQuery.of(context).platformBrightness == Brightness.light;
    return Scaffold(
        body: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Spacer(),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              'assets/images/shipping_icon.svg',
              height: 84,
              color: isLightMode ? Colors.transparent : const Color(0xFFFFFFFF),

              colorFilter: ColorFilter.mode(isLightMode ? Colors.black : const Color(0xFFFFFFFF),BlendMode.srcIn),
            ),
          ],
        ),
        const SizedBox(height: 30),
        Text('No Shipping Transactions',
            style: GoogleFonts.inter(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: Theme.of(context)
                    .primaryTextTheme
                    .bodyLarge!
                    .color)),
        const SizedBox(height: 20),
        Text('You have not made any shipping transactions yet.',
            style: GoogleFonts.inter(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Theme.of(context)
                    .primaryTextTheme
                    .bodyLarge!
                    .color)),
        const Spacer(),
      ],
    ));
  }
}
