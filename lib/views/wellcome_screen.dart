import 'package:connectly_c2c/views/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:connectly_c2c/views/login_screen.dart';
import 'package:connectly_c2c/views/widgets/custom_button.dart';

class WelcomeScreen extends ConsumerWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
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
          )),
      body: Center(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      width: size.width * 0.45,
                      height: size.width * 0.45,
                      decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 241, 239, 251),
                        shape: BoxShape.circle,
                      ),
                    ),
                    SvgPicture.asset(
                      'assets/images/first_screen_logo.svg',
                      width: size.width * 0.3,
                      height: size.width * 0.3,
                    ),
                  ],
                ),
              ),
              Text(
                'Start earning by selling\n your products',
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                    fontWeight: FontWeight.w700,
                    fontSize: 18,
                  color: Theme.of(context).primaryTextTheme.bodyLarge!.color
                    ),
              ),
              SizedBox(height: size.height * 0.02),
              Text(
                'If you want to make money from your C2C marketplace, '
                'then you have to charge commission on every transaction '
                'that takes place in your platform.',
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                    fontWeight: FontWeight.w400,
                    fontSize: 12,
                    color: Theme.of(context).primaryTextTheme.bodyLarge!.color),
              ),
              SizedBox(height: size.height * 0.1),
              SizedBox(
                  width: size.width * 0.44,
                  height: size.height * 0.05,
                  child: CustomButton(
                    text: 'Log In',
                    onPressed: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoginScreen()));
                    },
                  )),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Don\'t have an account?',
                      style: GoogleFonts.inter(
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          color: Theme.of(context).primaryTextTheme.bodyLarge!.color)),
                  TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SignupScreen()));
                      },
                      child: Text(
                        'Sign Up',
                        style: GoogleFonts.inter(
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                          color: const Color(0xFF6B4EFF),
                        ),
                      ))
                ],
              ),
              SizedBox(height: size.height * 0.03),
            ],
          ),
        ),
      ),
    );
  }
}
