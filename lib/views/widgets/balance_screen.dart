import 'package:connectly_c2c/viewmodel/user_viewmodel/user_profile_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class BalanceScreen extends ConsumerWidget {
  const BalanceScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    final totalBalance = ref.watch(userProfilerProvider)!.connectlyCredit;
    final isLightMode =
        MediaQuery.of(context).platformBrightness == Brightness.light;
    return Scaffold(
      body: Column(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Total Balance',
                style: GoogleFonts.inter(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                    color: Theme.of(context)
                        .primaryTextTheme
                        .bodyLarge!
                        .color),
              ),
              Text(
                '\$$totalBalance',
                style: GoogleFonts.inter(
                    fontSize: 32,
                    fontWeight: FontWeight.w800,
                    color: Theme.of(context)
                        .primaryTextTheme
                        .bodyLarge!
                        .color),
              ),
              const SizedBox(height: 20),
              Row(children: [
                Text(
                  'Cards',
                  style: GoogleFonts.inter(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context)
                          .primaryTextTheme
                          .bodyLarge!
                          .color),
                ),
                const Spacer(),
                TextButton(
                    onPressed: () {

                    },
                    child: Text('Add New Card',
                        style: GoogleFonts.inter(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF6B4EFF)))),
              ]),
              const SizedBox(height: 10),
              SizedBox(
                height: size.height * 0.4,
                child: ListView.builder(
                  itemCount: 1,
                  itemBuilder: (context, index) {
                    return Container(
                      padding: const EdgeInsets.all(10),
                      margin: const EdgeInsets.only(bottom: 10),
                      decoration: BoxDecoration(
                        color: isLightMode ? const Color(0xFFFFFFFF) : const Color(0xFF222223),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: const Color(0xFFEAECF0)),
                      ),
                      child: Row(
                        children: [
                          SvgPicture.network(
                              'https://upload.wikimedia.org/wikipedia/commons/d/d6/Visa_2021.svg',
                              width: 15,
                              height: 15),
                          const SizedBox(width: 20),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Visa',
                                style: GoogleFonts.inter(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Theme.of(context)
                                      .primaryTextTheme
                                      .bodyLarge!
                                      .color,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                '**** **** **** **** ****',
                                style: GoogleFonts.inter(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: Theme.of(context)
                                      .primaryTextTheme
                                      .bodyLarge!
                                      .color,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                'Expiry: 06/28',
                                style: GoogleFonts.inter(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: Theme.of(context)
                                      .primaryTextTheme
                                      .bodyLarge!
                                      .color,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
