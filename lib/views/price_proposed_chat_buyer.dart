import 'package:change_case/change_case.dart';
import 'package:connectly_c2c/model/product_model/product_model.dart';
import 'package:connectly_c2c/model/user_model/user_profile_model.dart';
import 'package:connectly_c2c/viewmodel/product_viewmodel/product_provider.dart';
import 'package:connectly_c2c/viewmodel/user_viewmodel/user_profile_provider.dart';
import 'package:connectly_c2c/views/main_screen.dart';
import 'package:connectly_c2c/views/make_offer_screen.dart';
import 'package:connectly_c2c/views/widgets/button.dart';
import 'package:connectly_c2c/views/widgets/productTile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import '../model/offer_price_model/offer_price_model.dart';

class BuyerProposalChatScreen extends ConsumerWidget {
  final Product product;
  const BuyerProposalChatScreen({super.key, required this.product});

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
              MaterialPageRoute(builder: (context) => const MainScreen()),
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
                SizedBox(
                    width: size.width,
                    child: getProductTile(product,size,isLightMode,context)),
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
                            color: const Color(0xFFF2F4F5),
                          ),
                          child: Column(
                            children: [
                              Text(
                                'You sent a offer',
                                style: GoogleFonts.inter(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: Theme.of(context).primaryTextTheme.bodyLarge!.color),
                              ),
                              SizedBox(
                                height: size.height * 0.002,
                              ),
                              StreamBuilder(
                                stream: ref
                                    .read(productServiceProvider.notifier)
                                    .getBid(product),
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    if (snapshot.data!.docs.isNotEmpty) {
                                      final bid = MakeOfferModel.fromJson(
                                          snapshot.data!.docs[0].data());
                                      return Column(
                                        children: [
                                          Text(
                                            '\$${bid.bidPrice}',
                                            style: GoogleFonts.inter(
                                                fontSize: 24,
                                                fontWeight: FontWeight.w700,
                                                color: Theme.of(context).primaryTextTheme.bodyLarge!.color),
                                          ),
                                          SizedBox(
                                            height: size.height * 0.02,
                                          ),
                                          bid.isAccepted
                                              ? Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    const Icon(
                                                      CupertinoIcons
                                                          .check_mark_circled_solid,
                                                      color: Color(0xFF6B4EFF),
                                                    ),
                                                    SizedBox(
                                                      width: size.width * 0.01,
                                                    ),
                                                    Text(
                                                      'Accepted By Seller.',
                                                      style: GoogleFonts.inter(
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.w700,
                                                          color: const Color(
                                                              0xFF6B4EFF)),
                                                    ),
                                                  ],
                                                )
                                              : Padding(
                                                  padding:
                                                      const EdgeInsets.symmetric(
                                                          horizontal: 10.0),
                                                  child: Row(
                                                    children: [
                                                      Expanded(
                                                          child: SizedBox(
                                                              height:
                                                                  size.height *
                                                                      0.05,
                                                              child: CustomButton(
                                                                  isCancel: true,
                                                                  text:
                                                                      'Cancel Offer',
                                                                  onPressed: () {
                                                                    ref.read(productServiceProvider.notifier).cancelBid(
                                                                        product
                                                                            .productId,
                                                                        ref
                                                                            .watch(
                                                                                userProfilerProvider)!
                                                                            .uid);
                                                                    Navigator
                                                                        .pushAndRemoveUntil(
                                                                      context,
                                                                      MaterialPageRoute(
                                                                        builder:
                                                                            (context) =>
                                                                                const MainScreen(),
                                                                      ),
                                                                      (route) =>
                                                                          false,
                                                                    );
                                                                  }))),
                                                      const SizedBox(width: 10),
                                                      Expanded(
                                                          child: SizedBox(
                                                        height:
                                                            size.height * 0.05,
                                                        child: CustomButton(
                                                            text: 'Update Offer',
                                                            onPressed: () {
                                                              Navigator.pushReplacement(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                      builder: (context) =>
                                                                          MakeOfferScreen(
                                                                              product:
                                                                                  product)));
                                                            }),
                                                      )),
                                                    ],
                                                  ),
                                                ),
                                        ],
                                      );
                                    } else {
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                                        child: Text('This Product is not Available',style: GoogleFonts.inter(
                                          color: Theme.of(context).primaryTextTheme.bodyLarge!.color
                                        ),),
                                      );
                                    }
                                  } else {
                                    return const SizedBox.shrink();
                                  }
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                      FutureBuilder(
                        future: ref
                            .read(productServiceProvider.notifier)
                            .getBuyerSellerProfile(product.sellerId),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            final sellerProfile =
                                UserProfile.fromMap(snapshot.data!.data()!);
                            return Column(
                              children: [
                                Align(
                                  alignment: Alignment.topCenter,
                                  child: CircleAvatar(
                                    maxRadius: 40,
                                    minRadius: 40,
                                    backgroundImage:
                                        NetworkImage(sellerProfile.profilePicURL),
                                  ),
                                ),
                                Text(
                                  sellerProfile.username.toTitleCase(),
                                  style: GoogleFonts.inter(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: Theme.of(context).primaryTextTheme.bodyLarge!.color),
                                )
                              ],
                            );
                          }
                          return const SizedBox.shrink();
                        },
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                StreamBuilder(
                    stream:
                        ref.read(productServiceProvider.notifier).getBid(product),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        if (snapshot.data!.docs.isNotEmpty) {
                          final bid = MakeOfferModel.fromJson(snapshot.data!.docs[0].data());
                          return bid.isAccepted ? TextButton.icon(
                              onPressed:() {

                              } ,
                            label: Text('Proceed to Pay',
                                style: GoogleFonts.inter(
                                fontSize: 22,
                                fontWeight: FontWeight.w600,
                                color: const Color(0xFF6B4EFF))) ,
                            icon: const Icon(Icons.payment_outlined,color: Color(0xFF6B4EFF),size: 30,),)
                              :
                          const SizedBox.shrink();
                        }else {return const SizedBox.shrink();}
                      } else {return const SizedBox.shrink();}
                    }),
                const Spacer()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
