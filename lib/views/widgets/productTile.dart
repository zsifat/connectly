import 'package:change_case/change_case.dart';
import 'package:connectly_c2c/model/product_model/product_model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget getProductTile(Product product, Size size, bool isLightMode, BuildContext context){
  return Container(
      height: 100,
      width: double.infinity,
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
                'Posted on ${product.sellPostDate.day}-${product.sellPostDate.month}-${product.sellPostDate.year} at ${product.sellPostDate.hour}:${product.sellPostDate.minute}',
                style: GoogleFonts.inter(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: Theme.of(context).primaryTextTheme.bodyLarge!.color),
              ),
              Text(
                product.productCondition.name.toTitleCase(),
                style: GoogleFonts.inter(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color:Theme.of(context).primaryTextTheme.bodyLarge!.color),
              ),
              Text(
                '\$${product.askingPrice}',
                style: GoogleFonts.inter(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Theme.of(context).primaryTextTheme.bodyLarge!.color),
              )
            ],
          )
        ],
      ));
}