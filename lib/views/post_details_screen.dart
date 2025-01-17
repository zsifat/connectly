import 'package:change_case/change_case.dart';
import 'package:connectly_c2c/model/user_model/user_profile_model.dart';
import 'package:connectly_c2c/viewmodel/product_viewmodel/product_provider.dart';
import 'package:connectly_c2c/viewmodel/user_viewmodel/user_profile_provider.dart';
import 'package:connectly_c2c/views/price_proposed_chat_buyer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:connectly_c2c/model/product_model/product_model.dart';
import 'package:connectly_c2c/views/make_offer_screen.dart';
import 'package:connectly_c2c/views/widgets/button.dart';
import 'package:connectly_c2c/views/widgets/image_carousel.dart';

class PostDetailsScreen extends ConsumerWidget {
  final Product product;
  const PostDetailsScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    final isOwnPost= product.sellerId == ref.watch(userProfilerProvider)!.uid;
    final isLightMode =
        MediaQuery.of(context).platformBrightness == Brightness.light;


    return Scaffold(
        appBar: AppBar(
          title: Text('Product Details',
              style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: Theme.of(context).primaryTextTheme.bodyLarge!.color)),
          actions: [
            IconButton(
                onPressed: () {},
                icon: const Icon(CupertinoIcons.star,
                    size: 20, color: Colors.black))
          ],
        ),
        body: Container(
          width: size.width,
          height: size.height,
          padding: const EdgeInsets.only(bottom: 10),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                            height: size.height * 0.4,
                            width: size.width,
                            child: NetworkImageCarousel(imageUrls: product.productImages)),
                        const SizedBox(height: 10),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: size.width * 0.03),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 10),
                              Row(
                                children: [
                                  SizedBox(
                                    width: size.width * 0.8,
                                    child: Text(
                                        overflow: TextOverflow.ellipsis,
                                        product.productName,
                                        style: GoogleFonts.inter(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w700,
                                            color: Theme.of(context).primaryTextTheme.bodyLarge!.color)),
                                  ),
                                  const SizedBox(width: 10),
                                  Text(product.productCondition.name,
                                      style: GoogleFonts.inter(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          color: Theme.of(context).primaryTextTheme.bodyLarge!.color)),
                                ],
                              ),
                              const SizedBox(height: 15),
                              Row(
                                children: [
                                  Text(
                                      'Posted on ${product.sellPostDate.day}-${product.sellPostDate.month}-${product.sellPostDate.year} at ${product.sellPostDate.hour}:${product.sellPostDate.minute}',
                                      style: GoogleFonts.inter(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          color: Theme.of(context).primaryTextTheme.bodyLarge!.color)),
                                  const SizedBox(width: 20),
                                  Icon(CupertinoIcons.location_fill,
                                      size: 16, color: Theme.of(context).primaryTextTheme.bodyLarge!.color),
                                  const SizedBox(width: 5),
                                  Text(
                                      product.productLocation.name
                                          .toTitleCase(),
                                      style: GoogleFonts.inter(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          color: Theme.of(context).primaryTextTheme.bodyLarge!.color)),
                                ],
                              ),
                              const SizedBox(height: 15),
                              const Divider(
                                color: Colors.grey,
                                thickness: 1,
                              ),
                              const SizedBox(height: 10),
                              Row(
                                children: [
                                  Text('\$${product.askingPrice}',
                                      style: GoogleFonts.inter(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w800,
                                          color: const Color(0xFF6B4EFF))),
                                  const SizedBox(width: 10),
                                  Text('Negotiable  ',
                                      style: GoogleFonts.inter(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          color: Theme.of(context).primaryTextTheme.bodyLarge!.color)),
                                ],
                              ),
                              const SizedBox(height: 15),
                              Row(
                                children: [
                                  Text('For sale by',
                                      style: GoogleFonts.inter(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          color: Theme.of(context).primaryTextTheme.bodyLarge!.color)),
                                  const SizedBox(width: 10),
                                  Text(product.sellerName.toTitleCase(),
                                      style: GoogleFonts.inter(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          color: Theme.of(context).primaryTextTheme.bodyLarge!.color)),
                                ],
                              ),
                              const SizedBox(height: 15),
                              FutureBuilder(
                                  future: ref.read(productServiceProvider.notifier).getBuyerSellerProfile(product.sellerId) ,
                                  builder: (context, snapshot) {
                                    if(snapshot.hasData){
                                      final UserProfile buyer = UserProfile.fromMap(snapshot.data!.data()!);
                                      return Row(
                                        children: [
                                          Icon(CupertinoIcons.checkmark_shield_fill,
                                              size: 18,
                                              color: buyer.isEmailVerified == true
                                                  ? const Color(0xFF6B4EFF)
                                                  : const Color(0xFF6C727F)),
                                          const SizedBox(width: 5),
                                          Text(
                                              buyer.isEmailVerified == true ? 'Verified Member' : 'Not Verified Member',
                                              style: GoogleFonts.inter(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500,
                                                  color: buyer.isEmailVerified
                                                      ? const Color(0xFF6B4EFF)
                                                      : const Color(0xFF6C727F))),
                                        ],
                                      );
                                    } else {
                                      return const SizedBox.shrink();
                                    }

                                  },),

                              const SizedBox(height: 15),
                              const Divider(
                                color: Colors.grey,
                                thickness: 1,
                              ),
                              const SizedBox(height: 15),
                              Text('Description',
                                  style: GoogleFonts.inter(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: Theme.of(context).primaryTextTheme.bodyLarge!.color)),
                              const SizedBox(height: 10),
                              Text(product.productDescription,
                                  style: GoogleFonts.inter(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: Theme.of(context).primaryTextTheme.bodyLarge!.color)),
                              const SizedBox(height: 10),
                            ],
                          ),
                        ),
                      ]),
                ),
              ),
              const SizedBox(height: 10),
              isOwnPost ? const SizedBox.shrink() :
              StreamBuilder(
                  stream: ref.read(productServiceProvider.notifier).getBid(product),
                  builder: (context, snapshot) {
                    if(snapshot.hasData){
                      if(snapshot.data!.docs.isNotEmpty){
                        return Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: size.width * 0.03,
                              vertical: size.height * 0.01),
                          child: Row(
                            children: [
                              Expanded(
                                  child: SizedBox(
                                      height: size.height * 0.05,
                                      child:
                                      CustomButton(
                                          text: 'Chat',
                                          onPressed: () {
                                            Navigator.push(context, MaterialPageRoute(builder: (context) => BuyerProposalChatScreen(product: product),));
                                      }))),
                            ],
                          ),
                        );
                      }
                      else {
                        return Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: size.width * 0.03,
                              vertical: size.height * 0.01),
                          child: Row(
                            children: [
                              Expanded(
                                  child: SizedBox(
                                      height: size.height * 0.05,
                                      child:
                                      CustomButton(
                                          text: 'Chat',
                                          onPressed: () {

                                          }))),
                              const SizedBox(width: 10),
                              Expanded(
                                  child: SizedBox(
                                    height: size.height * 0.05,
                                    child: CustomButton(
                                        text: 'Make Offer',
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      MakeOfferScreen(product: product)));
                                        }),
                                  )),
                            ],
                          ),
                        );
                      }
                    }
                    return const SizedBox.shrink();

                  },)
            ],
          ),
        ));
  }
}
