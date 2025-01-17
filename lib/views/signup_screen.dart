import 'package:change_case/change_case.dart';
import 'package:connectly_c2c/model/product_model/product_enums/product_location_enum.dart';
import 'package:connectly_c2c/model/user_model/user_profile_model.dart';
import 'package:connectly_c2c/viewmodel/auth_viewmodel/auth_provider.dart';
import 'package:connectly_c2c/viewmodel/signup_viewmodel/email_provider.dart';
import 'package:connectly_c2c/viewmodel/signup_viewmodel/location_provider.dart';
import 'package:connectly_c2c/viewmodel/signup_viewmodel/signup_processing_provider.dart';
import 'package:connectly_c2c/viewmodel/user_viewmodel/user_profile_provider.dart';
import 'package:connectly_c2c/views/succesfull_login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:connectly_c2c/viewmodel/signup_viewmodel/confirm_pass_provider.dart';
import 'package:connectly_c2c/viewmodel/signup_viewmodel/name_provider.dart';
import 'package:connectly_c2c/viewmodel/signup_viewmodel/password_provider.dart';
import 'package:connectly_c2c/viewmodel/signup_viewmodel/phone_no_provider.dart';
import 'package:connectly_c2c/views/widgets/button.dart';

class SignupScreen extends ConsumerWidget {
  SignupScreen({super.key});

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    final username=ref.watch(signupNameProvider);
    final email=ref.watch(signUpEmailProvider);
    final password=ref.watch(signupPasswordProvider);
    final confirmPass=ref.watch(signUpconfirmPassProvider);
    final phoneNo=ref.watch(signupPhoneNoProvider);
    final location= ref.watch(signUpLocationProvider);
    final bool isSignUpLoading = ref.watch(signUpProcessingProvider);
    final isLightMode =
        MediaQuery.of(context).platformBrightness == Brightness.light;
    return Scaffold(
        extendBodyBehindAppBar: false,
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          title: Text(
            'Sign up',
            style: GoogleFonts.inter(
              fontWeight: FontWeight.w700,
              fontSize: 24,
              color: const Color(0xFF090A0A),
            ),
          ),
        ),
        body: isSignUpLoading ? const Center(child: CircularProgressIndicator()) : SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Form(
                key: formKey,
                child: Column(
                  children: [
                    TextFormField(
                      style: GoogleFonts.inter(
                        color: Theme.of(context).primaryTextTheme.bodyLarge!.color
                      ),
                      validator: (value) {
                        if(value==null || value == '') {
                          return 'Name is required';
                        }
                        return null;
                      },
                      autofocus: true,
                      onChanged: (value) {
                        ref.read(signupNameProvider.notifier).setName(value);
                      },
                      decoration: InputDecoration(
                        hintText: 'Name',
                        hintStyle: GoogleFonts.inter(
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                          color: const Color(0xFF9EA3AE),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                              const BorderSide(color: Color(0xFFE3E5E5)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                              const BorderSide(color: Color(0xFFE3E5E5)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                              const BorderSide(color: Color(0xFFE3E5E5)),
                        ),
                      ),
                    ),
                    SizedBox(height: size.height * 0.015),
                    TextFormField(
                      style: GoogleFonts.inter(
                          color: Theme.of(context).primaryTextTheme.bodyLarge!.color
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Email is required';
                        }
                        final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
                        if (!emailRegex.hasMatch(value)) {
                          return 'Enter a valid email';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        ref.read(signUpEmailProvider.notifier).setEmail(value);
                      },
                      decoration: InputDecoration(
                        hintText: 'Email',
                        hintStyle: GoogleFonts.inter(
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                          color: const Color(0xFF9EA3AE),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                              const BorderSide(color: Color(0xFFE3E5E5)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                              const BorderSide(color: Color(0xFFE3E5E5)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                              const BorderSide(color: Color(0xFFE3E5E5)),
                        ),
                      ),
                    ),
                    SizedBox(height: size.height * 0.015),
                    TextFormField(
                      style: GoogleFonts.inter(
                          color: Theme.of(context).primaryTextTheme.bodyLarge!.color
                      ),
                      validator: (value) {
                        if(value == '' || value == null){
                          return 'Phone No is required';
                        }
                        if(value.length>15){
                          return 'Entar a valid Phone number';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        ref.read(signupPhoneNoProvider.notifier).setPhoneNo(value);
                      },
                      autofocus: true,
                      decoration: InputDecoration(
                        hintText: 'Phone Number',
                        hintStyle: GoogleFonts.inter(
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                          color: const Color(0xFF9EA3AE),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                              const BorderSide(color: Color(0xFFE3E5E5)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                              const BorderSide(color: Color(0xFFE3E5E5)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                              const BorderSide(color: Color(0xFFE3E5E5)),
                        ),
                      ),
                    ),
                    SizedBox(height: size.height * 0.015),
                    DropdownMenu(
                      onSelected: (value) => ref.read(signUpLocationProvider.notifier).selectLocation(value),
                        width: double.infinity,
                        menuHeight: size.height *0.7,
                        enableSearch: true,
                        hintText: location.name.toTitleCase(),
                        textStyle: GoogleFonts.inter(
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                          color: Theme.of(context)
                              .primaryTextTheme
                              .bodyLarge!
                              .color,
                        ),
                        menuStyle: MenuStyle(
                          elevation: WidgetStateProperty.all(0),
                          backgroundColor: WidgetStateProperty.all(isLightMode ?  const Color(0xFFF8F6FF) : const Color(0xFF010912)),
                          padding: WidgetStateProperty.all(
                            const EdgeInsets.symmetric(horizontal: 10)
                          ),
                          shape: WidgetStateProperty.all(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),

                              ))
                        ),
                        inputDecorationTheme: InputDecorationTheme(
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(color: Color(0xFFE3E5E5)),
                          ),
                          labelStyle: GoogleFonts.inter(
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                            color: const Color(0xFF9EA3AE),
                          ),
                          hintStyle: GoogleFonts.inter(
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                            color: const Color(0xFF9EA3AE),
                            ),

                        ),
                        dropdownMenuEntries: [
                          ...Location.values.map((e) => DropdownMenuEntry(value: e.index, label: e.name.toTitleCase()),)

                    ] ),
                    SizedBox(height: size.height * 0.015),
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
                        ref.read(signupPasswordProvider.notifier).setPassword(value);
                      },
                      autofocus: true,
                      decoration: InputDecoration(
                        hintText: 'Password',
                        hintStyle: GoogleFonts.inter(
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                          color: const Color(0xFF9EA3AE),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                              const BorderSide(color: Color(0xFFE3E5E5)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                              const BorderSide(color: Color(0xFFE3E5E5)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                              const BorderSide(color: Color(0xFFE3E5E5)),
                        ),
                      ),
                    ),
                    SizedBox(height: size.height * 0.015),
                    TextFormField(
                      style: GoogleFonts.inter(
                          color: Theme.of(context).primaryTextTheme.bodyLarge!.color
                      ),
                      obscureText: true,
                      validator: (value) {
                        if(value == null || value == ''){
                          return "Confirm password required";
                        }if(password != confirmPass){
                          return 'Confirm Password does not match';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        ref
                            .read(signUpconfirmPassProvider.notifier)
                            .setConfirmPass(value);
                      },
                      autofocus: true,
                      decoration: InputDecoration(
                        hintText: 'Confirm Password',
                        hintStyle: GoogleFonts.inter(
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                          color: const Color(0xFF9EA3AE),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                              const BorderSide(color: Color(0xFFE3E5E5)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                              const BorderSide(color: Color(0xFFE3E5E5)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                              const BorderSide(color: Color(0xFFE3E5E5)),
                        ),
                      ),
                    ),
                    SizedBox(height: size.height * 0.05),
                    Text(
                        'By continuing, you agree to our Terms of Service and Privacy Policy',
                        style: GoogleFonts.inter(
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                          color: Theme.of(context).primaryTextTheme.bodyLarge!.color,
                        )),
                    SizedBox(height: size.height * 0.05),
                    SizedBox(
                      width: double.infinity,
                      height: size.height * 0.05,
                      child: CustomButton(
                        text: 'Sign up',
                        onPressed: () async{
                          ref.read(signUpProcessingProvider.notifier).setSignUpProcessing();
                          if(formKey.currentState!.validate()){
                            final UserCredential? userCred= await ref.read(authStateProvider.notifier).signUp(email, password, confirmPass);
                            if(userCred!=null){
                              ref.read(authStateProvider.notifier).sendEmailVerification(userCred.user!);
                              ref.read(userProfilerProvider.notifier).saveUserProfile(
                                  UserProfile(
                                      uid: userCred.user!.uid,
                                      username: username,
                                      email: userCred.user!.email!,
                                      phoneNo: phoneNo,
                                      location: location,
                                      profilePicURL: 'https://www.strasys.uk/wp-content/uploads/2022/02/Depositphotos_484354208_S.jpg',
                                      totalReview: 0,
                                      reviewRating: 3,
                                      itemsSold: [],
                                      itemsBought: [],
                                      isEmailVerified: false,
                                      isPhoneVerified: false,
                                      isImageVerified: false,
                                      isFacebookVerified: false,
                                      connectlyCredit: 50)
                              );
                              ref.invalidate(signupNameProvider);
                              ref.invalidate(signUpEmailProvider);
                              ref.invalidate(signupPhoneNoProvider);
                              ref.invalidate(signUpconfirmPassProvider);
                              ref.invalidate(signupPasswordProvider);
                              ref.read(signUpProcessingProvider.notifier).setSignUpComplete();
                              if(context.mounted) {
                                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const SuccesfullSignupScreen(),));
                              }
                            }
                          }



                          }
                      ),
                    ),
                  ],
                )),
          ),
        ));
  }
}
