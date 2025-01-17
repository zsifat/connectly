import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectly_c2c/model/product_model/product_enums/product_category_enum.dart';
import 'package:connectly_c2c/model/product_model/product_enums/product_condition_enum.dart';
import 'package:connectly_c2c/model/product_model/product_enums/product_location_enum.dart';
import 'package:connectly_c2c/model/product_model/product_model.dart';
import 'package:connectly_c2c/services/products_db_service.dart';
import 'package:connectly_c2c/viewmodel/product_viewmodel/product_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:connectly_c2c/views/item_dashboard.dart';
import 'package:connectly_c2c/views/sell_post_select_category.dart';
import 'package:connectly_c2c/views/widgets/button.dart';
import 'package:connectly_c2c/views/widgets/myselling_product_card.dart';

class SellScreen extends ConsumerWidget {
  const SellScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    final isLightMode =
        MediaQuery.of(context).platformBrightness == Brightness.light;
    return Scaffold(
      backgroundColor: const Color(0xFFF8F6FF),
      appBar: AppBar(
        scrolledUnderElevation: 0,
        title: Text('My Products for Sale',
            style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: Theme.of(context).primaryTextTheme.bodyLarge!.color)),
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(CupertinoIcons.bell, color: Theme.of(context).primaryTextTheme.bodyLarge!.color))
        ],
      ),
      body: Container(
        color: isLightMode ? const Color(0xFFF8F6FF) : const Color(0xFF010912),
        padding: const EdgeInsets.symmetric(horizontal: 10),
        height: size.height,
        child: Column(
          children: [
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                  stream: ref.read(productServiceProvider.notifier).fetchSellPost(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    }
                    final products = snapshot.data!.docs;
                    return products.isEmpty ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                            'assets/images/noitemforsell.svg',width: 128,height: 128,),
                        SizedBox(height: size.height * 0.02),
                        Center(
                          child: Text('No items listed for sale',style: GoogleFonts.inter(
                            color: Theme.of(context).primaryTextTheme.bodyLarge!.color,
                            fontSize: 16
                          ),),
                        ),
                      ],
                    )
                      : ListView.builder(
                      itemCount: products.length,

                      itemBuilder: (context, index) {
                        final productJson = products[index].data() as Map<String, dynamic>;
                        final product = Product.fromJson(productJson);
                        return Padding(
                          padding: EdgeInsets.only(top: size.height *0.01),
                          child: InkWell(
                              onTap: () => Navigator.push(context,MaterialPageRoute(builder: (context) => ItemDashboard(product: product,),)),
                              child: MySellingProductCard(size: size, product: product)),
                        );
                      },

                    );}),
            ),
            Container(
              width: size.width,
              height: size.height * 0.06,
              padding: EdgeInsets.only(bottom: size.height *0.008),
              child: CustomButton(
                text: 'Post an ad',
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                          const PostSellSelectCategoryScreen()));
                },
              ),
            ),
          ],
        ),
      ),

    );
  }
}
