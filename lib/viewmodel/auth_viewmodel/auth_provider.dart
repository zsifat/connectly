import 'package:connectly_c2c/services/auth_service.dart';
import 'package:connectly_c2c/viewmodel/login_viewmodel/email_provider.dart';
import 'package:connectly_c2c/viewmodel/login_viewmodel/password_provider.dart';
import 'package:connectly_c2c/viewmodel/user_viewmodel/user_profile_provider.dart';
import 'package:connectly_c2c/views/login_screen.dart';
import 'package:connectly_c2c/views/main_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../login_viewmodel/login_processing_provider.dart';

class AuthNotifier extends StateNotifier<UserCredential?> {
  final AuthService _authService = AuthService();

  AuthNotifier() : super(null);

  Future<User?> login(String email, String password, BuildContext context, WidgetRef ref) async {
    try {
      final userCredential = await _authService.login(email, password);
      state = userCredential;
      ref
          .read(userProfilerProvider.notifier)
          .loadUserProfile(userCredential.user!.uid);

      ref.invalidate(loginEmailProvider);
      ref.invalidate(loginPasswordProvider);
      return userCredential.user!;
    } catch (e) {
      print(e.toString());
      String message;
      if (e.toString() == 'Exception: invalid-email') {
        message = 'No user found with this email.';
      } else if (e.toString() == 'Exception: invalid-credential') {
        message = 'Incorrect password.';
      } else {
        message = 'Something went wrong. Please try again.';
      }
      ref.read(loginProcessingProvider.notifier).setLoginComplete();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(
                message)),
      );
    }
    return null;
  }

  Future<void> logout(BuildContext context) async {
    await _authService.signOut();
    state = null;
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => LoginScreen()));
  }

  Future<UserCredential?> signUp(
      String email, String password, String confirmPassword) async {
    try {
      if (password != confirmPassword) {
        throw Exception('Passwords do not match');
      }
      final UserCredential? userCredential = await _authService.signUp(email, password);
      state = userCredential;
      return userCredential;
    } on Exception catch (e) {
      throw Exception(e);
    }
    return null;
  }

  User? currentUser(WidgetRef ref) {
    final user = _authService.getCurrentUser();
    if (user != null) {
      ref.read(userProfilerProvider.notifier).loadUserProfile(user.uid);
    }
    return user;
  }

  void passwordReset(String email){
    _authService.passwordReset(email);
  }

  void sendEmailVerification(User user){
    _authService.sendEmailVerification(user);
  }
}

final authStateProvider = StateNotifierProvider<AuthNotifier, UserCredential?>(
    (ref) => AuthNotifier());
