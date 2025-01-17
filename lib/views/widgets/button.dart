import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isCancel;
  const CustomButton({super.key, required this.text, required this.onPressed, this.isCancel =false});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          backgroundColor: !isCancel ? const Color(0xFF6B4EFF) : const Color(0xFFF4F4F6),
          side: isCancel ? const BorderSide(color: Color(0xFF6B4EFF) ) : BorderSide.none,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(48)),
          fixedSize: const Size(double.infinity, double.infinity)),
      onPressed: onPressed,
      child: Text(
        text,
        style: GoogleFonts.inter(
          fontWeight: FontWeight.w400,
          color: isCancel ?  const Color(0xFF6B4EFF) :Colors.white,
        ),
      ),
    );
  }
}
