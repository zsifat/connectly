import 'package:connectly_c2c/model/offer_price_model/offer_price_model.dart';
import 'package:connectly_c2c/model/product_model/product_model.dart';
import 'package:connectly_c2c/model/user_model/user_profile_model.dart';
import 'package:connectly_c2c/viewmodel/Purchase_sales_viewmodel/sales_toggle_provider.dart';
import 'package:connectly_c2c/viewmodel/product_viewmodel/product_provider.dart';
import 'package:connectly_c2c/views/payment_verification_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class SalesTrackingScreen extends ConsumerWidget {
  const SalesTrackingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isBookedSelected = ref.watch(salesToggleProvider);
    final size = MediaQuery.of(context).size;
    final isLightMode =
        MediaQuery.of(context).platformBrightness == Brightness.light;
    return Scaffold(
      appBar: AppBar(
        title: Text('Sales',
            style: GoogleFonts.inter(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: Theme.of(context)
                    .primaryTextTheme
                    .bodyLarge!
                    .color)),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal:10,vertical: 10),
        color: isLightMode ? const Color(0xFFF8F6FF) : const Color(0xFF010912),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {
                      ref.read(salesToggleProvider.notifier).toggle();
                    },
                    child: Container(
                      height: 40,
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                                  color: isBookedSelected
                                      ? const Color(0xFF6B4EFF)
                                      : Colors.transparent,
                                  width: 3))),
                      child: Center(
                        child: Text('Booked',
                            style: GoogleFonts.inter(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Theme.of(context)
                                    .primaryTextTheme
                                    .bodyLarge!
                                    .color)),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: InkWell(
                    onTap: () {
                      ref.read(salesToggleProvider.notifier).toggle();
                    },
                    child: Container(
                      height: 40,
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                                  color: !isBookedSelected
                                      ? const Color(0xFF6B4EFF)
                                      : Colors.transparent,
                                  width: 3))),
                      child: Center(
                        child: Text('Sold',
                            style: GoogleFonts.inter(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Theme.of(context)
                                    .primaryTextTheme
                                    .bodyLarge!
                                    .color)),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            isBookedSelected ? Expanded(
              child: StreamBuilder(
                stream: ref
                    .read(productServiceProvider.notifier)
                    .fetchBookedProduct(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError) {
                    return const Text('Something Error');
                  }
                  if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
                    final bookedProductsJson = snapshot.data!.docs;
                    final bookedProduct = bookedProductsJson.map(
                          (e) {
                        return Product.fromJson(e.data());
                      },
                    ).toList();
                    return ListView.builder(
                      itemCount: bookedProduct.length,
                      itemBuilder: (context, index) {
                        final product = bookedProduct[index];
                        return StreamBuilder(
                          stream: ref
                              .read(productServiceProvider.notifier)
                              .getProposalsHighToLow(product.productId),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                  child: CircularProgressIndicator());
                            }
                            if (snapshot.hasError) {
                              return const Text('Something Error');
                            }
                            if (snapshot.hasData &&
                                snapshot.data!.docs.isNotEmpty) {
                              final bid = snapshot.data!.docs.map((e) {
                                return MakeOfferModel.fromJson(e.data());
                              },).toList().firstWhere((element) =>
                              element.isAccepted == true,);

                              return FutureBuilder(
                                future: ref.read(
                                    productServiceProvider.notifier)
                                    .getBuyerSellerProfile(bid.buyerId),
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    final buyerProfile = UserProfile.fromMap(
                                        snapshot.data!.data()!);
                                    return InkWell(
                                        onTap: () {
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    PaymentVerificationScreen(
                                                        product: product,
                                                        buyerProfile: buyerProfile,
                                                        bid: bid),));
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.only(bottom: 10),
                                          child: Container(
                                              height: 100,
                                              width: size.width,
                                              decoration: BoxDecoration(
                                                  color: isLightMode ? const Color(0xFFFFFFFF) : const Color(0xFF222223),
                                                  borderRadius: BorderRadius.circular(12)
                                              ),
                                              child: Row(
                                                children: [
                                                  ClipRRect(
                                                    borderRadius: BorderRadius.circular(12),
                                                    child: Image.network(
                                                      product.productImages.first,
                                                      width: 100,
                                                      height: 100,
                                                      fit: BoxFit.fitHeight,
                                                    ),
                                                  ),
                                                  const SizedBox(width: 10),
                                                  Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                    children: [
                                                      SizedBox(
                                                        width:size.width * 0.4,
                                                        child: Text(
                                                          overflow: TextOverflow.ellipsis,
                                                          product.productName,
                                                          style: GoogleFonts.inter(
                                                              fontSize: 16,
                                                              fontWeight: FontWeight.w700,
                                                              color: Theme.of(context)
                                                                  .primaryTextTheme
                                                                  .bodyLarge!
                                                                  .color),
                                                        ),
                                                      ),
                                                      Text(
                                                        'Posted on ${product.sellPostDate.day}-${product.sellPostDate.month}-${product.sellPostDate.year} at ${product.sellPostDate.hour}:${product.sellPostDate.minute}',
                                                        style: GoogleFonts.inter(
                                                            fontSize: 12,
                                                            fontWeight: FontWeight.w400,
                                                            color: Theme.of(context)
                                                                .primaryTextTheme
                                                                .bodyLarge!
                                                                .color),
                                                      ),
                                                      Text(
                                                        'Asking Price: \$${product.askingPrice}',
                                                        style: GoogleFonts.inter(
                                                            fontSize: 12,
                                                            fontWeight: FontWeight.w400,
                                                            color: Theme.of(context)
                                                                .primaryTextTheme
                                                                .bodyLarge!
                                                                .color),
                                                      ),
                                                      Text(
                                                        'Booked at \$${bid.bidPrice}',
                                                        style: GoogleFonts.inter(
                                                            fontSize: 14,
                                                            fontWeight: FontWeight.w600,
                                                            color: Theme.of(context)
                                                                .primaryTextTheme
                                                                .bodyLarge!
                                                                .color),
                                                      )
                                                    ],
                                                  )
                                                ],
                                              )),
                                        ));
                                  }
                                  return const SizedBox.shrink();
                                },
                              );
                            }
                            return const SizedBox.shrink();
                          },
                        );
                      },
                    );
                  }
                  return Center(child: Text('No items',style: GoogleFonts.inter(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context)
                          .primaryTextTheme
                          .bodyLarge!
                          .color)));
                },
              ),
            ) : Expanded(
              child: StreamBuilder(
                  stream: ref.read(productServiceProvider.notifier).fetchSoldProduct(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (snapshot.hasError) {
                      return const Text('Something Error');
                    }
                    if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
                      final soldProductsJson = snapshot.data!.docs;
                      final soldProducts = soldProductsJson.map(
                            (e) {
                          return Product.fromJson(e.data());
                        },
                      ).toList();
                      return ListView.builder(
                        itemCount: soldProducts.length,
                          itemBuilder:(context, index) {
                          final product = soldProducts[index];
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: Container(
                                  height: 100,
                                  width: size.width,
                                  decoration: BoxDecoration(
                                      color: isLightMode ? const Color(0xFFFFFFFF) : const Color(0xFF222223),
                                      borderRadius: BorderRadius.circular(12)
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(12),
                                        child: Image.network(
                                          product.productImages.first,
                                          width: 90,
                                          height: 100,
                                          fit: BoxFit.fitHeight,
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          SizedBox(
                                            width:size.width * 0.4,
                                            child: Text(
                                              overflow: TextOverflow.ellipsis,
                                              product.productName,
                                              style: GoogleFonts.inter(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w700,
                                                  color: Theme.of(context)
                                                      .primaryTextTheme
                                                      .bodyLarge!
                                                      .color),
                                            ),
                                          ),
                                          Text(
                                            'Sold on ${product.sellDate!.day}-${product.sellDate!.month}-${product.sellDate!.year} at ${product.sellDate!.hour}:${product.sellDate!.minute}',
                                            style: GoogleFonts.inter(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w400,
                                                color: const Color(0xFF6C727F)),
                                          ),
                                          Text(
                                            'Asking Price: \$${product.askingPrice}',
                                            style: GoogleFonts.inter(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w400,
                                                color: const Color(0xFF6C727F)),
                                          ),
                                          FutureBuilder(
                                            future: ref.read(productServiceProvider.notifier).getAcceptedBid(product.productId),
                                            builder: (context, snapshot) {
                                              if(snapshot.hasData){
                                                final bid = MakeOfferModel.fromJson(snapshot.data!.docs.first.data());
                                                return Text(
                                                  'Sell Price \$${bid.bidPrice}',
                                                  style: GoogleFonts.inter(
                                                      fontSize: 14,
                                                      fontWeight: FontWeight.w600,
                                                      color: const Color(0xFF6B4EFF)),
                                                );
                                              }else {
                                                return const SizedBox.shrink();
                                              }


                                            },

                                          )
                                        ],
                                      )
                                    ],
                                  )),
                            );
                          }, );
                    }
                    return Center(child: Text('No items',
                    style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                        color: Theme.of(context)
                            .primaryTextTheme
                            .bodyLarge!
                            .color)));
                  },),
            )
          ],
        ),
      ),
    );
  }
}