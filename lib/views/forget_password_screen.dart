import 'package:connectly_c2c/viewmodel/auth_viewmodel/auth_provider.dart';
import 'package:connectly_c2c/views/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class ForgetPasswordScreen extends ConsumerWidget{
  ForgetPasswordScreen({super.key});

  final _textController = TextEditingController();
  final _formKey=GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Forget Password',
        style: GoogleFonts.inter(
          fontSize: 18,
          fontWeight: FontWeight.w700,
          color: const Color(0xFF121826)
        ),),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Form(
              key: _formKey,
              child: TextFormField(
                style: GoogleFonts.inter(
                    color: Theme.of(context).primaryTextTheme.bodyLarge!.color
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Email is required';
                  }
                  return null;
                },
                controller: _textController,
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
            ),
            const SizedBox(height: 20,),
            SizedBox(
              width:double.infinity,
              height: 45,
              child: CustomButton(text: 'Send', onPressed: () {
                if(_formKey.currentState!.validate()){
                  ref.read(authStateProvider.notifier).passwordReset(_textController.text.trim());
                }

              },),
            )
          ],
        ),
      ),
    ) ;
  }
}
