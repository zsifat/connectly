import 'package:change_case/change_case.dart';
import 'package:connectly_c2c/model/product_model/product_model.dart';
import 'package:connectly_c2c/model/user_model/user_profile_model.dart';
import 'package:connectly_c2c/viewmodel/product_viewmodel/product_provider.dart';
import 'package:connectly_c2c/viewmodel/user_viewmodel/user_profile_provider.dart';
import 'package:connectly_c2c/views/main_screen.dart';
import 'package:connectly_c2c/views/widgets/button.dart';
import 'package:connectly_c2c/views/widgets/productTile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import '../model/offer_price_model/offer_price_model.dart';

class PaymentVerificationScreen extends ConsumerWidget {
  final Product product;
  final UserProfile buyerProfile;
  final MakeOfferModel bid;
  const PaymentVerificationScreen(
      {super.key,
        required this.product,
        required this.buyerProfile,
        required this.bid});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    final isLightMode =
        MediaQuery.of(context).platformBrightness == Brightness.light;
    return PopScope(
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) {
          // Ensure the pop action completes before navigating to the new screen.
          Future.microtask(() {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => MainScreen()),
            );
          });
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                getProductTile(product,size,isLightMode,context),
                SizedBox(
                  height: size.height * 0.002,
                ),
                SizedBox(
                  height: size.height * 0.30,
                  width: size.width,
                  child: Stack(
                    children: [
                      SizedBox(
                        height: size.height * 0.30,
                        width: size.width,
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          padding: EdgeInsets.only(top: size.height * 0.08),
                          height: size.height * 0.25,
                          width: size.width,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: const Color(0xFFF4F4F6),
                          ),
                          child: Column(
                            children: [
                              Text(
                                'Sent you a offer',
                                style: GoogleFonts.inter(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: const Color(0xFF212936)),
                              ),
                              SizedBox(
                                height: size.height * 0.002,
                              ),
                              Text(
                                '\$${bid.bidPrice}',
                                style: GoogleFonts.inter(
                                    fontSize: 24,
                                    fontWeight: FontWeight.w700,
                                    color: const Color(0xFF212936)),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0, vertical: 10),
                                child: Text('Booked',
                                  style: GoogleFonts.inter(
                                    fontSize: 28,
                                    fontWeight: FontWeight.w700,
                                    color: const Color(0xFF6B4EFF)),),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Column(
                        children: [
                          Align(
                            alignment: Alignment.topCenter,
                            child: CircleAvatar(
                              backgroundColor: Colors.white,
                              maxRadius: 40,
                              minRadius: 40,
                              backgroundImage: NetworkImage(buyerProfile.profilePicURL),
                            ),
                          ),
                          Text(
                            buyerProfile.username.toTitleCase(),
                            style: GoogleFonts.inter(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: const Color(0xFF212936)),
                          )
                        ],
                      ),

                    ],
                  ),
                ),
                const Spacer(),
                CustomButton(text: 'Mark As Payment Received', onPressed: () {
                  ref.read(productServiceProvider.notifier).markAsSold(product, buyerProfile,ref.watch(userProfilerProvider)!,bid.bidPrice);
                  Navigator.popUntil(context, (route) {
                    return route is MaterialPageRoute && route.builder(context) is MainScreen;
                  },);
                },),
                const Spacer()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
