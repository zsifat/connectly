import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectly_c2c/model/product_model/product_model.dart';
import 'package:connectly_c2c/viewmodel/product_viewmodel/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class MySellingProductCard extends ConsumerWidget {
  final Size size;
  final Product product;
  const MySellingProductCard(
      {super.key, required this.size, required this.product});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLightMode =
        MediaQuery.of(context).platformBrightness == Brightness.light;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        color: isLightMode ? const Color(0xFFFFFFFF) : const Color(0xFF222223),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
                product.productImages.first,
                width: size.width * 0.2,
                height: size.height * 0.1,
                fit: BoxFit.cover),
          ),
          SizedBox(width: size.width * 0.03),
          SizedBox(
            height: size.height * 0.1,
            width: size.width * 0.6,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                    overflow: TextOverflow.ellipsis,
                    product.productName,
                    style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).primaryTextTheme.bodyLarge!.color)),
                Text('\$${product.askingPrice}',
                    style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Theme.of(context).primaryTextTheme.bodyLarge!.color)),
                const Spacer(),
                Row(
                  children: [
                    Text('Sell faster',
                        style: GoogleFonts.inter(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF6B4EFF))),
                    const Spacer(),
                    InkWell(
                      onTap: () {
                        ref.read(productServiceProvider.notifier).unpublishPost(product.productId);
                      },
                      child: Text('Unpublish',
                          style: GoogleFonts.inter(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF6B4EFF))),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
