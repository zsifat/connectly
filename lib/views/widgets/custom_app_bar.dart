import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});
  @override
  Widget build(BuildContext context) {
    return AppBar(
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(CupertinoIcons.bell, color: Color(0xFF6B4EFF))),
        ],
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text('Connect',
                style: GoogleFonts.inter(
                    fontWeight: FontWeight.w700, fontSize: 24)),
            Text('ly',
                style: GoogleFonts.inter(
                    fontWeight: FontWeight.w700,
                    fontSize: 24,
                    color: const Color(0xFF6B4EFF))),
          ],
        ));
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
