import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class HowPromoteWorksScreen extends StatelessWidget {
  const HowPromoteWorksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('How Promoting Works',
            style: GoogleFonts.inter(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF090A0A))),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SvgPicture.asset(
                    'assets/images/promote_plus/get_more_views.svg',
                    width: size.width * 0.2,
                    height: 100),
                SizedBox(width: size.width * 0.05),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Get more views',
                        style: GoogleFonts.inter(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF212936))),
                    SizedBox(height: size.height * 0.01),
                    SizedBox(
                      width: size.width * 0.7,
                      child: Text(
                          'Promoted posts appear among the first spots buyers see and get an average of 14x more views.',
                          style: GoogleFonts.inter(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: const Color(0xFF4D5461))),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: size.height * 0.04),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SvgPicture.asset(
                    'assets/images/promote_plus/add_promote_slot.svg',
                    width: size.width * 0.2,
                    height: 100),
                SizedBox(width: size.width * 0.05),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Add a Promote Slot',
                        style: GoogleFonts.inter(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF212936))),
                    SizedBox(height: size.height * 0.01),
                    SizedBox(
                      width: size.width * 0.7,
                      child: Text(
                          'Your item appears as a new post in search results as well as in the promoted spot.',
                          style: GoogleFonts.inter(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: const Color(0xFF4D5461))),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: size.height * 0.04),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SvgPicture.asset(
                    'assets/images/promote_plus/shared_promote_slot.svg',
                    width: size.width * 0.2,
                    height: 100),
                SizedBox(width: size.width * 0.05),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Promoted spots are shared',
                        style: GoogleFonts.inter(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF212936))),
                    SizedBox(height: size.height * 0.01),
                    SizedBox(
                      width: size.width * 0.7,
                      child: Text(
                          'Don’t worry if you don’t see your item at the top of the feed. Spots are shared between sellers',
                          style: GoogleFonts.inter(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: const Color(0xFF4D5461))),
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
