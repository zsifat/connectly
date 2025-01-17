import 'package:change_case/change_case.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:connectly_c2c/model/product_model/product_enums/product_location_enum.dart';
import 'package:connectly_c2c/viewmodel/sell_post_viewmodel/sell_product_location_provider.dart';

class SellSelectLocationBottomSheet extends ConsumerWidget {
  const SellSelectLocationBottomSheet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.04,
            vertical: MediaQuery.of(context).size.height * 0.015),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Select Location',
              style: GoogleFonts.inter(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color:Theme.of(context)
                    .primaryTextTheme
                    .bodyLarge!
                    .color,
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
            Expanded(
              child: ListView.builder(
                itemCount: Location.values.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      ref
                          .read(sellProductLocationProvider.notifier)
                          .setLocation(Location.values[index]);
                      Navigator.pop(context);
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 20.0),
                      child: Row(
                        children: [
                          Text(
                            Location.values[index].name.toTitleCase(),
                            style: GoogleFonts.inter(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Theme.of(context)
                                  .primaryTextTheme
                                  .bodyLarge!
                                  .color,
                            ),
                          ),
                          const Spacer(),
                          const Icon(
                            CupertinoIcons.chevron_right,
                            color: Color(0xFF090A0A),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
