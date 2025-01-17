import 'package:change_case/change_case.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:connectly_c2c/viewmodel/product_viewmodel/product_category_provider.dart';
import 'package:connectly_c2c/viewmodel/sell_post_viewmodel/sell_product_category_provider.dart';
import 'package:connectly_c2c/views/sell_post_information.dart';

class PostSellSelectCategoryScreen extends ConsumerWidget {
  const PostSellSelectCategoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    final categories = ref.watch(productCategoryProvider);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Post an ad',
            style: GoogleFonts.inter(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: Theme.of(context)
                    .primaryTextTheme
                    .bodyLarge!
                    .color)),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: size.width * 0.04, vertical: size.height * 0.01),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Select Category',
                style: GoogleFonts.inter(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context)
                        .primaryTextTheme
                        .bodyLarge!
                        .color)),
            SizedBox(height: size.height * 0.01),
            Text('Choose a category below to post an ad',
                style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Theme.of(context)
                        .primaryTextTheme
                        .bodyLarge!
                        .color)),
            SizedBox(height: size.height * 0.03),
            Expanded(
              child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      mainAxisSpacing: 15,
                      crossAxisSpacing: 15,
                      childAspectRatio: 1),
                  itemCount: categories.length,
                  itemBuilder: (context, index) => InkWell(
                        onTap: () {
                          ref
                              .read(sellProductCategoryProvider.notifier)
                              .setCategory(categories[index]);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const SellPostDetailsAdScreen()));
                        },
                        child: Container(
                            decoration: BoxDecoration(
                                color: const Color(0xFFF8F6FF),
                                borderRadius: BorderRadius.circular(10)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.asset(
                                  categories[index].iconPath,
                                  width: 30,
                                  height: 30,
                                ),
                                SizedBox(height: size.height * 0.01),
                                Text(categories[index].name.toTitleCase(),
                                    style: GoogleFonts.inter(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        color: const Color(0xFF212936)))
                              ],
                            )),
                      )),
            )
          ],
        ),
      ),
    );
  }
}
