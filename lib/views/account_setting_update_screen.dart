import 'package:change_case/change_case.dart';
import 'package:connectly_c2c/viewmodel/user_viewmodel/user_profile_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:connectly_c2c/views/widgets/button.dart';

import '../model/product_model/product_enums/product_location_enum.dart';

class AccountSettingUpdateScreen extends ConsumerWidget {
  final String fieldType;
  final String initialValue;
  AccountSettingUpdateScreen(
      {super.key, required this.fieldType, required this.initialValue});


  final _textController= TextEditingController();


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userProfile = ref.read(userProfilerProvider);
    final size = MediaQuery.of(context).size;
    _textController.text=initialValue;
    int? selectedLocation;
    final isLightMode =
        MediaQuery.of(context).platformBrightness == Brightness.light;

    return Scaffold(
      appBar: AppBar(
        title: Text('Update ${fieldType.toTitleCase()}',
            style: GoogleFonts.inter(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: Theme.of(context)
                    .primaryTextTheme
                    .bodyLarge!
                    .color)),
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              Text(
                'Your $fieldType',
                style: GoogleFonts.inter(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Theme.of(context)
                        .primaryTextTheme
                        .bodyLarge!
                        .color),
              ),
              const SizedBox(height: 10),
              fieldType == 'location' ?
              DropdownMenu(
                initialSelection: userProfile!.location.index,
                  onSelected: (value) {
                    selectedLocation=value;
                  },
                  width: double.infinity,
                  menuHeight: size.height *0.7,
                  textStyle: GoogleFonts.inter(
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    color: Theme.of(context)
                        .primaryTextTheme
                        .bodyLarge!
                        .color,
                  ),
                  enableSearch: true,
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

                  ] ): TextFormField(
                controller: _textController,
                style: GoogleFonts.inter(
                  color: Theme.of(context)
                      .primaryTextTheme
                      .bodyLarge!
                      .color
                ),
                readOnly: fieldType == 'email' ? true : false,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Color(0xFFE3E5E5)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Color(0xFFE3E5E5)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Color(0xFFE3E5E5)),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: CustomButton(
                  text:fieldType == 'email' ? 'Email Can\'t be Changed' : 'Update ${fieldType.toTitleCase()}',

                  onPressed: () {
                    if (fieldType != 'location' &&
                        initialValue != _textController.text.trim()) {
                      ref.read(userProfilerProvider.notifier).profileInfoUpdate(
                          userProfile!.uid, fieldType,
                          _textController.text.trim());
                      Navigator.pop(context);
                    } else if (fieldType == 'location' && selectedLocation !=null && selectedLocation != userProfile!.location.index){
                      ref.read(userProfilerProvider.notifier).profileInfoUpdate(
                          userProfile.uid, fieldType,
                          selectedLocation.toString());
                      Navigator.pop(context);
                    }
                  }
                  ,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
