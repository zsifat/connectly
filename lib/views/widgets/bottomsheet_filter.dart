import 'package:change_case/change_case.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:connectly_c2c/model/product_model/product_enums/product_category_enum.dart';
import 'package:connectly_c2c/model/product_model/product_enums/product_location_enum.dart';
import 'package:connectly_c2c/viewmodel/filter_search_viewmodel/filter_search_provider.dart';
import 'package:connectly_c2c/viewmodel/product_viewmodel/filtered_product_provider.dart';

class FilterBottomSheet extends ConsumerWidget {
  final String title;
  final List<String> items;

  const FilterBottomSheet({
    super.key,
    required this.title,
    required this.items,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final String searchedFilter = ref.watch(filterSearchTextProvider);
    final isLightMode =
        MediaQuery.of(context).platformBrightness == Brightness.light;

    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(20),
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.88,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTitle(context,isLightMode),
            _buildSearchField(ref,isLightMode),
            const SizedBox(height: 10),
            _buildItemList(ref, searchedFilter,isLightMode),
          ],
        ),
      ),
    );
  }

  Widget _buildTitle(BuildContext context,bool isLightMode) {
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: MediaQuery.of(context).size.height * 0.01),
      child: Text(
        title,
        style: GoogleFonts.inter(
          fontWeight: FontWeight.w600,
          fontSize: 16,
          color: isLightMode ? const Color(0xFF212936) : const Color(0xFFE0E0E0)
        ),
      ),
    );
  }

  Widget _buildSearchField(WidgetRef ref,bool isLightMode) {
    return TextField(
      onChanged: (value) {
        ref.read(filterSearchTextProvider.notifier).setFilterSearch(value);
      },
      decoration: InputDecoration(
        hintText: 'Search $title',
        hintStyle: GoogleFonts.inter(
          fontWeight: FontWeight.w400,
          fontSize: 14,
          color: isLightMode ? const Color(0xFF212936) : const Color(0xFFE0E0E0)
        ),
        prefixIcon: const Icon(CupertinoIcons.search),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
        filled: true,
        fillColor: isLightMode ? const Color(0xFFF8F6FF) : const Color(0xFF010912),
      ),
    );
  }

  Widget _buildItemList(WidgetRef ref, String searchedTextFilter,bool isLightMode) {
    final filteredItems = items.where((item) {
      return item.toLowerCase().startsWith(searchedTextFilter.toLowerCase());
    }).toList();

    return Expanded(
      child: ListView.builder(
        itemCount: filteredItems.length,
        itemBuilder: (context, index) {
          return _buildItemRow(ref, filteredItems[index],isLightMode);
        },
      ),
    );
  }

  Widget _buildItemRow(WidgetRef ref, String item, bool isLightMode) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: InkWell(
        onTap: () {
          ref.read(filterQueryProvider.notifier).updateFilterQuery(
                isFilterQuery: true,
                location: Location.values.map((e) => e.name).contains(item)
                    ? Location.values
                        .firstWhere((element) => element.name == item)
                    : null,
                category:
                    ProductCategory.values.map((e) => e.name).contains(item)
                        ? ProductCategory.values.firstWhere((element) =>
                            element.name.toLowerCase() == item.toLowerCase())
                        : null,
              );
          ref.invalidate(filterSearchTextProvider);
          Navigator.pop(ref.context);
        },
        child: Row(
          children: [
            Text(
              item.toTitleCase(),
              style: GoogleFonts.inter(
                fontWeight: FontWeight.w500,
                color: isLightMode ? const Color(0xFF212936) : const Color(0xFFE0E0E0),
                fontSize: 14,
              ),
            ),
            const Spacer(),
            const Icon(CupertinoIcons.chevron_right),
          ],
        ),
      ),
    );
  }
}
