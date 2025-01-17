import 'package:change_case/change_case.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectly_c2c/model/offer_price_model/offer_price_model.dart';
import 'package:connectly_c2c/model/product_model/product_model.dart';
import 'package:connectly_c2c/model/user_model/user_profile_model.dart';
import 'package:connectly_c2c/viewmodel/product_viewmodel/product_provider.dart';
import 'package:connectly_c2c/views/account_setting_update_screen.dart';
import 'package:connectly_c2c/views/main_screen.dart';
import 'package:connectly_c2c/views/post_details_screen.dart';
import 'package:connectly_c2c/views/price_proposed_chat_seller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:connectly_c2c/views/promote_plus_screen.dart';
import 'package:connectly_c2c/views/widgets/button.dart';

class ItemDashboard extends ConsumerWidget {
  final Product product;
  const ItemDashboard({super.key, required this.product});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    final isLightMode =
        MediaQuery.of(context).platformBrightness == Brightness.light;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Item Dashboard',
          style: GoogleFonts.inter(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Theme.of(context).primaryTextTheme.bodyLarge!.color),
        ),
      ),
      body: Container(
        width: size.width,
        height: size.height,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: size.height * 0.125,
              width: size.width,
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(product.productImages.first,
                        height: size.height * 0.12,
                        width: size.width * 0.24,
                        fit: BoxFit.cover),
                  ),
                  SizedBox(width: size.width * 0.02),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: size.width * 0.6,
                        child: Text(
                          overflow: TextOverflow.ellipsis,
                          product.productName,
                          style: GoogleFonts.inter(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Theme.of(context)
                                  .primaryTextTheme
                                  .bodyLarge!
                                  .color),
                        ),
                      ),
                      Text(
                        "\$${product.askingPrice}",
                        style: GoogleFonts.inter(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: const Color(0xFF6B4EFF)),
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.visibility_rounded,
                            color: Color(0xFF6B4EFF),
                            size: 18,
                          ),
                          SizedBox(width: size.width * 0.01),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        PostDetailsScreen(product: product),
                                  ));
                            },
                            child: Text('View Post',
                                style: GoogleFonts.inter(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: const Color(0xFF6B4EFF))),
                          ),
                          SizedBox(width: size.width * 0.02),
                          const Icon(
                            Icons.edit_rounded,
                            color: Color(0xFF6B4EFF),
                            size: 18,
                          ),
                          SizedBox(width: size.width * 0.02),
                          Text('Edit Post',
                              style: GoogleFonts.inter(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: const Color(0xFF6B4EFF))),
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
            StreamBuilder(
              stream: ref
                  .read(productServiceProvider.notifier)
                  .getProposalsHighToLow(product.productId),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data!.docs.isNotEmpty) {
                    final bid =
                        MakeOfferModel.fromJson(snapshot.data!.docs[0].data());
                    return Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Center(
                        child: Text('Highest Bid: ${bid.bidPrice}\$',
                            style: GoogleFonts.inter(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Theme.of(context)
                                    .primaryTextTheme
                                    .bodyLarge!
                                    .color)),
                      ),
                    );
                  } else {
                    return const SizedBox.shrink();
                  }
                } else {
                  return const SizedBox.shrink();
                }
              },
            ),
            Row(
              children: [
                Expanded(
                  child: CustomButton(
                    text: 'Unpublish',
                    onPressed: () {
                      ref
                          .read(productServiceProvider.notifier)
                          .unpublishPost(product.productId);
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const MainScreen(),
                        ),
                        (route) => false,
                      );
                    },
                  ),
                ),
                SizedBox(width: size.width * 0.02),
                Expanded(
                  child: CustomButton(
                    text: 'Sell Faster',
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const PromotePlusScreen()));
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: size.height * 0.02),
            Text('Messages',
                style: GoogleFonts.inter(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color:
                        Theme.of(context).primaryTextTheme.bodyLarge!.color)),
            SizedBox(height: size.height * 0.01),
            StreamBuilder(
              stream: ref
                  .read(productServiceProvider.notifier)
                  .getProposalsHighToLow(product.productId),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data!.docs.isNotEmpty) {
                    return Expanded(
                      child: ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          final bid = MakeOfferModel.fromJson(
                              snapshot.data!.docs[index].data());

                          return FutureBuilder<DocumentSnapshot>(
                            future: ref
                                .read(productServiceProvider.notifier)
                                .getBuyerSellerProfile(bid.buyerId),
                            builder: (context, userSnapshot) {
                              if (userSnapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const SizedBox(
                                    height: 3,
                                    child: LinearProgressIndicator(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                    ));
                              }

                              if (userSnapshot.hasData) {
                                final buyerProfile = UserProfile.fromMap(
                                    userSnapshot.data!.data()
                                        as Map<String, dynamic>);
                                final difference = DateTime.now()
                                    .difference(DateTime.parse(bid.bidTime));
                                return InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              SellerProposalChatScreen(
                                            product: product,
                                            buyer: buyerProfile,
                                            bid: bid,
                                          ),
                                        ));
                                  },
                                  child: ListTile(
                                    minVerticalPadding: 0,
                                    contentPadding: EdgeInsets.zero,
                                    trailing: Text(
                                      '${difference.inHours}h ${difference.inMinutes % 60}m ago',
                                      style: GoogleFonts.inter(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                        color: Theme.of(context)
                                            .primaryTextTheme
                                            .bodyLarge!
                                            .color,
                                      ),
                                    ),
                                    leading: CircleAvatar(
                                      minRadius: 30,
                                      maxRadius: 30,
                                      backgroundImage: NetworkImage(
                                          buyerProfile.profilePicURL),
                                    ),
                                    title: Text(
                                        buyerProfile.username.toTitleCase(),
                                        style: GoogleFonts.inter(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400,
                                          color: Theme.of(context)
                                              .primaryTextTheme
                                              .bodyLarge!
                                              .color,
                                        )),
                                    subtitle: Text('I offer ${bid.bidPrice}\$',
                                        style: GoogleFonts.inter(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: Theme.of(context)
                                              .primaryTextTheme
                                              .bodyLarge!
                                              .color,
                                        )),
                                  ),
                                );
                              } else {
                                return const SizedBox.shrink();
                              }
                            },
                          );
                        },
                      ),
                    );
                  } else {
                    return Center(
                      child: Text(
                        "Price not yet offered for this product.",
                        style: GoogleFonts.inter(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Theme.of(context)
                                .primaryTextTheme
                                .bodyLarge!
                                .color),
                      ),
                    );
                  }
                } else {
                  return const CircularProgressIndicator();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
