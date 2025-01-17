import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget accountSettingsItem(
    {required String title,
    required IconData icon,
    Widget? screen,
    required BuildContext context}) {
  return InkWell(
    onTap: () {
      if(screen!=null) {
        Navigator.push(
          context, MaterialPageRoute(builder: (context) => screen));
      }
    },
    child: Row(
      children: [
        Icon(icon, color: Theme.of(context)
            .primaryTextTheme
            .bodyLarge!
            .color),
        const SizedBox(width: 15),
        Text(title,
            style: GoogleFonts.inter(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Theme.of(context)
                    .primaryTextTheme
                    .bodyLarge!
                    .color)),
        const Spacer(),
        Icon(
          Icons.arrow_forward_ios_outlined,
          color: Theme.of(context)
              .primaryTextTheme
              .bodyLarge!
              .color,
          size: 18,
        )
      ],
    ),
  );
}
