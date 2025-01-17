
import 'package:connectly_c2c/model/offer_price_model/offer_price_model.dart';
import 'package:connectly_c2c/viewmodel/product_viewmodel/product_provider.dart';
import 'package:connectly_c2c/views/price_proposed_chat_buyer.dart';
import 'package:connectly_c2c/views/widgets/productTile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:connectly_c2c/model/product_model/product_model.dart';
import 'package:connectly_c2c/viewmodel/offer_price_viewmodel/offered_price_provider.dart';
import 'package:connectly_c2c/views/widgets/button.dart';

class MakeOfferScreen extends ConsumerWidget {
  const MakeOfferScreen({super.key, required this.product});
  final Product product;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    final isLightMode =
        MediaQuery.of(context).platformBrightness == Brightness.light;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Make Offer',
          style: GoogleFonts.inter(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Theme.of(context).primaryTextTheme.bodyLarge!.color),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              'Cancel',
              style: GoogleFonts.inter(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Theme.of(context).primaryTextTheme.bodyLarge!.color,
              ),
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            getProductTile(product,size,isLightMode,context),
            const SizedBox(height: 10),
            const Divider(
              color: Color(0xFFF2F4F5),
              thickness: 1,
            ),
            StreamBuilder(
                stream: ref.read(productServiceProvider.notifier).getBid(product),
                builder: (context, snapshot) {
                  if(snapshot.hasData) {
                    if(snapshot.data!.docs.isNotEmpty) {
                      final bid = MakeOfferModel.fromJson(snapshot.data!.docs[0].data());
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('Your current Offer: '),
                          Text('${bid.bidPrice}\$',
                              style: GoogleFonts.inter(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  color: Theme.of(context)
                                      .primaryTextTheme
                                      .bodyLarge!
                                      .color))
                        ],
                      );
                    }else{
                      return const SizedBox.shrink();
                    }

                  }else{
                    return const SizedBox.shrink();
                  }
                },),
            SizedBox(height: size.height * 0.05),
            Text(
              'Enter Your Offer',
              style: GoogleFonts.inter(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Theme.of(context)
                      .primaryTextTheme
                      .bodyLarge!
                      .color),
            ),
            SizedBox(height: size.height * 0.03),
            SizedBox(
              width: size.width * 0.5,
              child: TextField(
                style: GoogleFonts.inter(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Theme.of(context)
                        .primaryTextTheme
                        .bodyLarge!
                        .color),
                textAlign: TextAlign.center,
                onChanged: (value) {
                  ref
                      .read(offeredPriceProvider.notifier)
                      .setOfferedPrice(value);
                },
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Color(0xFFE3E5E5)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Color(0xFFE3E5E5)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Color(0xFFE3E5E5)),
                  ),
                  hintText: '\$0.00',
                  hintStyle: GoogleFonts.inter(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Theme.of(context)
                          .primaryTextTheme
                          .bodyLarge!
                          .color),
                ),
              ),
            ),
            SizedBox(height: size.height * 0.02),
            SizedBox(
              width: size.width * 0.5,
              height: size.height * 0.05,
              child: CustomButton(
                onPressed: () {
                  if (ref.read(offeredPriceProvider) <= product.askingPrice && ref.read(offeredPriceProvider) > 0 ) {
                    ref.read(productServiceProvider.notifier).addBid(product, ref.watch(offeredPriceProvider));
                    ref.invalidate(offeredPriceProvider);
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => BuyerProposalChatScreen(product: product,),));
                  }},
                text: 'Send Offer',
              ),
            ),
          ],
        ),
      )
    );
  }
}
