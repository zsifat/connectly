import 'package:change_case/change_case.dart';
import 'package:flutter/material.dart';
import 'package:connectly_c2c/model/product_model/product_model.dart';

class ProductContainer extends StatelessWidget {
  final Product product;
  const ProductContainer({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isLightMode =
        MediaQuery.of(context).platformBrightness == Brightness.light;
    return Container(
      height: 233,
      width: size.width * 0.4,
      decoration: BoxDecoration(
        color: isLightMode ? const Color(0xFFFFFFFF) : Color(0xFF222223),
        borderRadius: BorderRadius.circular(12),
        border: const Border(
          top: BorderSide.none,
          bottom: BorderSide.none,
          left: BorderSide.none,
          right: BorderSide.none,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(12)),
              child: Image.network(
                product.productImages.first,
                width: double.infinity,
                height: 150,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                Text(
                  overflow: TextOverflow.ellipsis,
                  product.productName,
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: isLightMode
                          ? const Color(0xFF212936)
                          : const Color(0xFFE0E0E0)),
                ),
                const SizedBox(height: 5),
                Text(
                  product.productLocation.name.toTitleCase(),
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: isLightMode ? const Color(0xFF212936) : const Color(0xFFE0E0E0)),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Text(
                      '\$${product.askingPrice}',
                      style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF6B4EFF)),
                    ),
                    const Spacer(),
                    Text(
                      '${product.sellPostDate.hour.toString()}h ago',
                      style: const TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF6C727F)),
                    )
                  ],
                ),
                const SizedBox(height: 10),
              ],
            ),
          )
        ],
      ),
    );
  }
}
