import 'package:connectly_c2c/model/product_model/product_model.dart';
import 'package:connectly_c2c/viewmodel/product_viewmodel/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class PurchaseTrackingScreen extends ConsumerWidget {
  const PurchaseTrackingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    final isLightMode =
        MediaQuery.of(context).platformBrightness == Brightness.light;
    return Scaffold(
      appBar: AppBar(
        title: Text('Purchases',
            style: GoogleFonts.inter(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: Theme.of(context).primaryTextTheme.bodyLarge!.color)),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        color: isLightMode ? const Color(0xFFF8F6FF) : const Color(0xFF010912),
        child: Column(
          children: [
            const SizedBox(height: 10),
            Expanded(
              child: StreamBuilder(
                stream: ref
                    .read(productServiceProvider.notifier)
                    .fetchPurchasedProducts(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError) {
                    return const Text('Something Error');
                  }
                  if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
                    final purchasedProductsJson = snapshot.data!.docs;
                    final purchasedProducts = purchasedProductsJson.map(
                      (e) {
                        return Product.fromJson(e.data());
                      },
                    ).toList();
                    return ListView.builder(
                      itemCount: purchasedProducts.length,
                      itemBuilder: (context, index) {
                        final product = purchasedProducts[index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: Container(
                              height: 100,
                              width: size.width,
                              decoration: BoxDecoration(
                                  color: isLightMode ? const Color(0xFFFFFFFF) : const Color(0xFF222223),
                                  borderRadius: BorderRadius.circular(12)),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      SizedBox(
                                        width: size.width * 0.4,
                                        child: Text(
                                          overflow: TextOverflow.ellipsis,
                                          product.productName,
                                          style: GoogleFonts.inter(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w700,
                                              color: Theme.of(context).primaryTextTheme.bodyLarge!.color),
                                        ),
                                      ),
                                      Text(
                                        'Purchased on ${product.sellDate!.day}-${product.sellDate!.month}-${product.sellDate!.year} at ${product.sellDate!.hour}:${product.sellDate!.minute}',
                                        style: GoogleFonts.inter(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400,
                                            color: Theme.of(context).primaryTextTheme.bodyLarge!.color),
                                      ),
                                      Text(
                                        'Asking Price: \$${product.askingPrice}',
                                        style: GoogleFonts.inter(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400,
                                            color: Theme.of(context).primaryTextTheme.bodyLarge!.color),
                                      ),
                                      Text(
                                        'Sell Price \$${product.sellingPrice}',
                                        style: GoogleFonts.inter(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                            color: const Color(0xFF6B4EFF)),
                                      )
                                    ],
                                  )
                                ],
                              )),
                        );
                      },
                    );
                  }
                  return const Center(child: Text('No items'));
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
