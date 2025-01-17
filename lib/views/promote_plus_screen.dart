import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:connectly_c2c/views/how_promote_works_screen.dart';
import 'package:connectly_c2c/views/widgets/button.dart';

class PromotePlusScreen extends StatelessWidget {
  const PromotePlusScreen({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Manage Promote Plus',
            style: GoogleFonts.inter(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: Theme.of(context)
                    .primaryTextTheme
                    .bodyLarge!
                    .color)),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                    'assets/images/promote_plus/promote_plus_logo.svg',
                    width: 100,
                    height: 100),
              ],
            ),
            const SizedBox(
              height: 50,
            ),
            Text('Sell faster with Promote Plus',
                style: GoogleFonts.inter(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Theme.of(context)
                        .primaryTextTheme
                        .bodyLarge!
                        .color)),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                const Icon(Icons.check, color: Color(0xFF6B4EFF), size: 20),
                const SizedBox(
                  width: 10,
                ),
                Text('Get an average of 14x more views each day.',
                    style: GoogleFonts.inter(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Theme.of(context)
                            .primaryTextTheme
                            .bodyLarge!
                            .color)),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              children: [
                const Icon(Icons.check, color: Color(0xFF6B4EFF), size: 20),
                const SizedBox(
                  width: 10,
                ),
                Text('Promote for multiple days.',
                    style: GoogleFonts.inter(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Theme.of(context)
                            .primaryTextTheme
                            .bodyLarge!
                            .color)),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              children: [
                const Icon(Icons.check, color: Color(0xFF6B4EFF), size: 20),
                const SizedBox(
                  width: 10,
                ),
                Text('Switch promotion to any item.',
                    style: GoogleFonts.inter(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Theme.of(context)
                            .primaryTextTheme
                            .bodyLarge!
                            .color)),
              ],
            ),
            const SizedBox(
              height: 40,
            ),
            OutlinedButton(
                style: OutlinedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  side: const BorderSide(color: Color(0xFF6B4EFF), width: 2),
                  fixedSize: const Size(double.infinity, 50),
                ),
                onPressed: () {},
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(CupertinoIcons.shift_fill,
                        color: Color(0xFF6B4EFF), size: 20),
                    const SizedBox(
                      width: 10,
                    ),
                    Text('Sell faster with Promote Plus',
                        style: GoogleFonts.inter(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Theme.of(context)
                                .primaryTextTheme
                                .bodyLarge!
                                .color)),
                  ],
                )),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: CustomButton(
                text: 'See how it works',
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const HowPromoteWorksScreen()));
                },
              ),
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
