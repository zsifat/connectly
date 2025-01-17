
import 'package:cloudinary_flutter/cloudinary_object.dart';
import 'package:connectly_c2c/views/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:connectly_c2c/themes/app_themes.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget{
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context,WidgetRef ref)  {
    return MaterialApp(
      title: 'OfferUp',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      home: const SplashScreen(),
    );
  }
}
