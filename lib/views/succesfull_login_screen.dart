import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:connectly_c2c/views/main_screen.dart';
import 'package:connectly_c2c/views/widgets/button.dart';

class SuccesfullSignupScreen extends StatelessWidget {
  const SuccesfullSignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.check_circle_outline_outlined,
                  size: 100, color: Color(0xFF6B4EFF)),
            ],
          ),
          SizedBox(height: size.height * 0.03),
          Text(
            'Congratulations!',
            style: GoogleFonts.inter(
              fontWeight: FontWeight.w700,
              fontSize: 24,
            ),
          ),
          SizedBox(height: size.height * 0.01),
          Text(
            'Your account has been created successfully',
            style: GoogleFonts.inter(
              fontWeight: FontWeight.w500,
              fontSize: 12,
            ),
          ),
          SizedBox(height: size.height * 0.04),
          SizedBox(
              width: size.width * 0.44,
              height: size.height * 0.05,
              child: CustomButton(
                  text: 'Continue',
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const MainScreen()));
                  })),
        ],
      ),
    );
  }
}
