import 'package:connectly_c2c/viewmodel/product_viewmodel/product_provider.dart';
import 'package:connectly_c2c/views/price_proposed_chat_buyer.dart';
import 'package:connectly_c2c/views/widgets/productTile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class BuyingProductScreen extends ConsumerWidget {
  const BuyingProductScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    final isLightMode =
        MediaQuery.of(context).platformBrightness == Brightness.light;
    return Scaffold(
        appBar: AppBar(
          scrolledUnderElevation: 0,
          title: Text('Purchase in Progress',
              style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: Theme.of(context).primaryTextTheme.bodyLarge!.color)),
          actions: [
            IconButton(
                onPressed: () {},
                icon: Icon(CupertinoIcons.bell,
                    color: Theme.of(context).primaryTextTheme.bodyLarge!.color))
          ],
        ),
        body: Container(
          color:
              isLightMode ? const Color(0xFFF8F6FF) : const Color(0xFF010912),
          child: StreamBuilder(
            stream: ref
                .read(productServiceProvider.notifier)
                .fetchBidOrBookedProducts(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasError) {
                return Center(
                    child: Text(
                  'No products available.',
                  style: GoogleFonts.inter(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color:
                          Theme.of(context).primaryTextTheme.bodyLarge!.color),
                ));
              }
              if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                final bidOrBookedProducts = snapshot.data!;
                return ListView.builder(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  itemCount: bidOrBookedProducts.length,
                  itemBuilder: (context, index) {
                    final product = bidOrBookedProducts[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 10.0),
                      child: InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      BuyerProposalChatScreen(product: product),
                                ));
                          },
                          child: getProductTile(product, size, isLightMode,context)),
                    );
                  },
                );
              }

              return Center(
                  child: Text(
                'No products available.',
                style: GoogleFonts.inter(
                  fontWeight: FontWeight.w600,
                    color: Theme.of(context).primaryTextTheme.bodyLarge!.color),
              ));
            },
          ),
        ));
  }
}
