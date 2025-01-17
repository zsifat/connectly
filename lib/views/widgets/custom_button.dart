import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  const CustomButton({super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF6B4EFF),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(48)),
          fixedSize: const Size(double.infinity, double.infinity)),
      onPressed: onPressed,
      child: Text(
        text,
        style: GoogleFonts.inter(
          fontWeight: FontWeight.w400,
          color: Colors.white,
        ),
      ),
    );
  }
}
