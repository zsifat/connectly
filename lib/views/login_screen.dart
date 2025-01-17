import 'package:connectly_c2c/viewmodel/auth_viewmodel/auth_provider.dart';
import 'package:connectly_c2c/viewmodel/login_viewmodel/login_processing_provider.dart';
import 'package:connectly_c2c/viewmodel/login_viewmodel/password_provider.dart';
import 'package:connectly_c2c/views/forget_password_screen.dart';
import 'package:connectly_c2c/views/main_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:connectly_c2c/viewmodel/login_viewmodel/email_provider.dart';
import 'package:connectly_c2c/views/signup_screen.dart';
import 'package:connectly_c2c/views/widgets/button.dart';

class LoginScreen extends ConsumerWidget {
  LoginScreen({super.key});

  final loginFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    final bool isLoginProcessing = ref.watch(loginProcessingProvider);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Log in',
            style: GoogleFonts.inter(
                fontWeight: FontWeight.w700,
                fontSize: 18,
                color: Theme.of(context).primaryTextTheme.bodyLarge!.color)),
      ),
      body: isLoginProcessing ? const Center(child: CircularProgressIndicator()) : SingleChildScrollView(
          child: Container(
        padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
        child: Form(
            key: loginFormKey,
            child: Column(
              children: [
                SizedBox(height: size.height * 0.08),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Connect',
                        style: GoogleFonts.inter(
                          color: Theme.of(context).primaryTextTheme.bodyLarge!.color,
                            fontWeight: FontWeight.w700, fontSize: 24)),
                    Text('ly',
                        style: GoogleFonts.inter(
                            fontWeight: FontWeight.w700,
                            fontSize: 24,
                            color: const Color(0xFF6B4EFF))),
                  ],
                ),
                SizedBox(height: size.height * 0.02),
                TextFormField(
                  style: GoogleFonts.inter(
                    color: Theme.of(context).primaryTextTheme.bodyLarge!.color
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Email is required';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    ref.read(loginEmailProvider.notifier).setEmail(value);
                  },
                  decoration: InputDecoration(
                    hintText: 'Email',
                    hintStyle: GoogleFonts.inter(
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      color: const Color(0xFF9EA3AE),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: Color(0xFFE3E5E5)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: Color(0xFFE3E5E5)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: Color(0xFFE3E5E5)),
                    ),
                  ),
                ),
                SizedBox(height: size.height * 0.02),
                TextFormField(
                  style: GoogleFonts.inter(
                      color: Theme.of(context).primaryTextTheme.bodyLarge!.color
                  ),
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Password is required';
                    }
                    if (value.length < 6) {
                      return 'Password must be at least 6 characters';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    ref.read(loginPasswordProvider.notifier).setPassword(value);
                  },
                  decoration: InputDecoration(
                    hintText: 'Password',
                    hintStyle: GoogleFonts.inter(
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      color: const Color(0xFF9EA3AE),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: Color(0xFFE3E5E5)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: Color(0xFFE3E5E5)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: Color(0xFFE3E5E5)),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                      ),
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => ForgetPasswordScreen(),));
                      },
                      child: Text(
                        'Forget Password',
                        style: GoogleFonts.inter(
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          color: const Color(0xFF6B4EFF),
                        ),
                      )),
                ),
                SizedBox(height: size.height * 0.02),
                Text(
                  'By continuing, you agree to our Terms of Service and Privacy Policy.',
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.w400,
                    fontSize: 12,
                    color: Theme.of(context).primaryTextTheme.bodyLarge!.color,
                  ),
                ),
                SizedBox(height: size.height * 0.03),
                SizedBox(
                  height: size.height * 0.055,
                  width: double.infinity,
                  child: CustomButton(
                    text: 'Log in',
                    onPressed: () async{
                      ref.read(loginProcessingProvider.notifier).setLoginProcessing();
                      if(loginFormKey.currentState!.validate()) {
                        final user = await ref.read(authStateProvider.notifier).login(
                            ref.read(loginEmailProvider).trim(),
                            ref.read(loginPasswordProvider).trim(),
                            context,ref);
                        if(user!=null && context.mounted){
                          ref.read(loginProcessingProvider.notifier).setLoginComplete();
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const MainScreen(),));
                        }
                      }

                    },
                  ),
                ),
                SizedBox(height: size.height * 0.02),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Don\'t have an account?',style: GoogleFonts.inter(
                      color: Theme.of(context).primaryTextTheme.bodyLarge!.color
                    ) ,),
                    TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SignupScreen()));
                        },
                        child: Text('Sign up',
                            style: GoogleFonts.inter(
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                                color: const Color(0xFF6B4EFF))))
                  ],
                ),
              ],
            )),
      )),
    );
  }
}
