import 'package:change_case/change_case.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectly_c2c/viewmodel/product_viewmodel/product_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:connectly_c2c/model/product_model/product_enums/product_category_enum.dart';
import 'package:connectly_c2c/model/product_model/product_enums/product_location_enum.dart';
import 'package:connectly_c2c/viewmodel/filter_search_viewmodel/filter_search_provider.dart';
import 'package:connectly_c2c/viewmodel/product_viewmodel/filtered_product_provider.dart';
import 'package:connectly_c2c/views/post_details_screen.dart';
import 'package:connectly_c2c/views/widgets/bottomsheet_filter.dart';
import 'package:connectly_c2c/views/widgets/custom_app_bar.dart';
import 'package:connectly_c2c/views/widgets/product_container.dart';

import '../model/product_model/product_model.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filterQuery = ref.watch(filterQueryProvider);
    final size = MediaQuery.of(context).size;
    final isLightMode =
        MediaQuery.of(context).platformBrightness == Brightness.light;

    List<Product> getFilteredProducts(
        List<QueryDocumentSnapshot<Map<String, dynamic>>> allProductsJson,
        Location? locationFilter,
        ProductCategory? categoryFilter) {
      List<Product> allProducts = allProductsJson.map((e) {
        return Product.fromJson(e.data());
      }).toList();
      final List<Product> displayProducts = allProducts.where(
        (product) {
          if (locationFilter != null) {
            return product.productLocation == locationFilter;
          }
          if (categoryFilter != null) {
            return product.productCategory == categoryFilter;
          } else {
            return true;
          }
        },
      ).toList();
      return displayProducts;
    }

    return Scaffold(
      appBar: const CustomAppBar(),
      body: StreamBuilder(
        stream: ref.watch(productServiceProvider.notifier).fetchAllProduct(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return const Text('Something Error');
          }
          final allProductsJson = snapshot.data!.docs;
          if (allProductsJson.isNotEmpty) {
            return Column(
              children: [
                Container(
                  height: size.height * 0.13,
                  padding: EdgeInsets.symmetric(
                      horizontal: size.width * 0.03, vertical: 0),
                  child: Column(
                    children: [
                      TextField(
                        decoration: InputDecoration(
                          hintText: 'Search',
                          prefixIcon: const Icon(Icons.search),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide.none,
                          ),
                          filled: true,
                          fillColor: isLightMode
                              ? const Color(0xFFF8F6FF)
                              : const Color(0xFF010912),
                        ),
                      ),
                      Expanded(
                        child: Center(
                          child: Row(
                            children: [
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    showCupertinoModalBottomSheet(
                                      backgroundColor: Colors.white,
                                      topRadius: const Radius.circular(16),
                                      isDismissible: true,
                                      context: context,
                                      builder: (context) => FilterBottomSheet(
                                        title: 'Location',
                                        items: Location.values
                                            .map((e) => e.name)
                                            .toList(),
                                      ),
                                    ).then(
                                      (value) {
                                        ref.invalidate(
                                            filterSearchTextProvider);
                                      },
                                    );
                                  },
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Icon(CupertinoIcons.placemark,
                                            size: 22,
                                            color: isLightMode
                                                ? const Color(0xFF212936)
                                                : const Color(0xFFE0E0E0)),
                                        const SizedBox(width: 5),
                                        Text(
                                            filterQuery.location != null
                                                ? filterQuery.location!.name
                                                    .toTitleCase()
                                                : 'Location',
                                            style: GoogleFonts.inter(
                                                color: isLightMode
                                                    ? const Color(0xFF212936)
                                                    : const Color(0xFFE0E0E0),
                                                fontWeight: FontWeight.w400,
                                                fontSize: 16)),
                                      ]),
                                ),
                              ),
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    showCupertinoModalBottomSheet(
                                      backgroundColor: Colors.white,
                                      topRadius: const Radius.circular(16),
                                      isDismissible: true,
                                      context: context,
                                      builder: (context) => FilterBottomSheet(
                                        title: 'Category',
                                        items: ProductCategory.values
                                            .map((e) => e.name)
                                            .toList(),
                                      ),
                                    ).then(
                                      (value) {
                                        ref.invalidate(
                                            filterSearchTextProvider);
                                      },
                                    );
                                  },
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(CupertinoIcons.list_bullet,
                                            size: 22,
                                            color: isLightMode
                                                ? const Color(0xFF212936)
                                                : const Color(0xFFE0E0E0)),
                                        const SizedBox(width: 5),
                                        Text(
                                            filterQuery.category != null
                                                ? filterQuery.category!.name
                                                    .toTitleCase()
                                                : 'Category',
                                            style: GoogleFonts.inter(
                                                color: isLightMode
                                                    ? const Color(0xFF212936)
                                                    : const Color(0xFFE0E0E0),
                                                fontWeight: FontWeight.w400,
                                                fontSize: 16)),
                                      ]),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    color: isLightMode
                        ? const Color(0xFFF8F6FF)
                        : const Color(0xFF010912),
                    padding: EdgeInsets.symmetric(
                        horizontal: size.width * 0.03, vertical: 0),
                    child: Column(
                      children: [
                        filterQuery.isFilterQuery
                            ? Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Showing ${getFilteredProducts(allProductsJson, filterQuery.location, filterQuery.category).length} results',
                                    style: GoogleFonts.inter(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                        color: isLightMode
                                            ? const Color(0xFF212936)
                                            : const Color(0xFFE0E0E0)),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      ref.invalidate(filterQueryProvider);
                                    },
                                    child: Text('Clear Filter',
                                        style: GoogleFonts.inter(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                            color: const Color(0xFF6B4EFF))),
                                  )
                                ],
                              )
                            : const SizedBox(height: 10),
                        Expanded(
                          child: GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    childAspectRatio: 0.7,
                                    mainAxisSpacing: 10,
                                    crossAxisSpacing: 10),
                            itemCount: getFilteredProducts(allProductsJson,
                                    filterQuery.location, filterQuery.category)
                                .length,
                            itemBuilder: (context, index) {
                              final allProduct = getFilteredProducts(
                                  allProductsJson,
                                  filterQuery.location,
                                  filterQuery.category);
                              final Product product = allProduct[index];
                              return InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              PostDetailsScreen(
                                                  product: product)));
                                },
                                child: ProductContainer(product: product),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          }
          return Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                'assets/images/empty_cart.svg',
                width: 128,
                height: 128,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 60.0, vertical: 10),
                child: Text(
                  'Be the first to create a sell post and start earning today!',
                  style: GoogleFonts.inter(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).primaryTextTheme.bodyLarge!.color),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ));
        },
      ),
    );
  }
}
