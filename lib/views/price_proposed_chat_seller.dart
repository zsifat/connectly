import 'package:change_case/change_case.dart';
import 'package:connectly_c2c/model/product_model/product_model.dart';
import 'package:connectly_c2c/model/user_model/user_profile_model.dart';
import 'package:connectly_c2c/viewmodel/product_viewmodel/product_provider.dart';
import 'package:connectly_c2c/viewmodel/ui_viewmodel/is_booked_provider.dart';
import 'package:connectly_c2c/viewmodel/user_viewmodel/user_profile_provider.dart';
import 'package:connectly_c2c/views/main_screen.dart';
import 'package:connectly_c2c/views/make_offer_screen.dart';
import 'package:connectly_c2c/views/payment_verification_screen.dart';
import 'package:connectly_c2c/views/widgets/button.dart';
import 'package:connectly_c2c/views/widgets/productTile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import '../model/offer_price_model/offer_price_model.dart';

class SellerProposalChatScreen extends ConsumerWidget {
  final Product product;
  final UserProfile buyer;
  final MakeOfferModel bid;
  const SellerProposalChatScreen(
      {super.key,
      required this.product,
      required this.buyer,
      required this.bid});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    final isLightMode =
        MediaQuery.of(context).platformBrightness == Brightness.light;
    return Scaffold(
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
                                  color: Theme.of(context).primaryTextTheme.bodyLarge!.color),
                            ),
                            SizedBox(
                              height: size.height * 0.002,
                            ),
                            Text(
                              '\$${bid.bidPrice}',
                              style: GoogleFonts.inter(
                                  fontSize: 24,
                                  fontWeight: FontWeight.w700,
                                  color: Theme.of(context).primaryTextTheme.bodyLarge!.color),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10.0, vertical: 20),
                              child: Row(
                                children: [
                                  Expanded(
                                      child: SizedBox(
                                          height: size.height * 0.05,
                                          child: CustomButton(
                                              isCancel: true,
                                              text: 'Reject',
                                              onPressed: () {
                                                ref
                                                    .read(productServiceProvider
                                                        .notifier)
                                                    .cancelBid(
                                                        product.productId,
                                                        buyer.uid);
                                                Navigator.pushAndRemoveUntil(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        const MainScreen(),
                                                  ),
                                                  (route) => false,
                                                );
                                              }))),
                                  const SizedBox(width: 10),
                                  Expanded(
                                      child: SizedBox(
                                    height: size.height * 0.05,
                                    child: CustomButton(
                                        text: 'Accept',
                                        onPressed: () {
                                          ref
                                              .read(productServiceProvider
                                                  .notifier)
                                              .markAsBooked(
                                                  product.productId, buyer.uid);
                                          Navigator.push(context, MaterialPageRoute(
                                            builder: (context) =>
                                                PaymentVerificationScreen(
                                                    product: product,
                                                    buyerProfile: buyer,
                                                    bid: bid),
                                          ),);
                                        }),
                                  )),
                                ],
                              ),
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
                            maxRadius: 40,
                            minRadius: 40,
                            backgroundImage: NetworkImage(buyer.profilePicURL),
                          ),
                        ),
                        Text(
                          buyer.username.toTitleCase(),
                          style: GoogleFonts.inter(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: Theme.of(context).primaryTextTheme.bodyLarge!.color),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
