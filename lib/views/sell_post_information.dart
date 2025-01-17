import 'dart:io';
import 'package:change_case/change_case.dart';
import 'package:connectly_c2c/viewmodel/sell_post_viewmodel/sell_product_category_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:connectly_c2c/model/product_model/product_enums/product_condition_enum.dart';
import 'package:connectly_c2c/viewmodel/sell_post_viewmodel/sell_post_condition_provider.dart';
import 'package:connectly_c2c/viewmodel/sell_post_viewmodel/sell_post_decription_provider.dart';
import 'package:connectly_c2c/viewmodel/sell_post_viewmodel/sell_post_image_provider.dart';
import 'package:connectly_c2c/viewmodel/sell_post_viewmodel/sell_post_price_provider.dart';
import 'package:connectly_c2c/viewmodel/sell_post_viewmodel/sell_post_title_provider.dart'; 
import 'package:connectly_c2c/viewmodel/sell_post_viewmodel/sell_product_location_provider.dart';
import 'package:connectly_c2c/views/sell_post_preview_screen.dart';
import 'package:connectly_c2c/views/widgets/button.dart';
import 'package:connectly_c2c/views/widgets/sell_select_location_bottomsheet.dart';

class SellPostDetailsAdScreen extends ConsumerWidget {
  const SellPostDetailsAdScreen({super.key});

  Future<void> _pickImage(WidgetRef ref) async {
    final ImagePicker picker = ImagePicker();
    if (ref.watch(sellPostImageProvider).length >= 6) {
      return;
    }
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      ref.read(sellPostImageProvider.notifier).addImage(image.path);
    } else {
      print('No image selected.');
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    final selectedLocation = ref.watch(sellProductLocationProvider);
    final title = ref.watch(sellPostTitleProvider);
    final condition = ref.watch(sellPostConditionProvider);
    final description = ref.watch(sellPostDescriptionProvider);
    final category = ref.watch(sellProductCategoryProvider);
    final price = ref.watch(sellPostPriceProvider);
    final images = ref.watch(sellPostImageProvider);
    final isLightMode =
        MediaQuery.of(context).platformBrightness == Brightness.light;

    return PopScope(
      onPopInvokedWithResult: (didPop, result) {
        if(didPop){
          ref.invalidate(sellProductCategoryProvider);
          ref.invalidate(sellPostImageProvider);
          ref.invalidate(sellPostDescriptionProvider);
          ref.invalidate(sellPostPriceProvider);
          ref.invalidate(sellPostConditionProvider);
          ref.invalidate(sellProductLocationProvider);
          ref.invalidate(sellPostTitleProvider);
        }
      },
      child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text('Post an Ad',
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
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Select Location',
                      style: GoogleFonts.inter(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Theme.of(context)
                              .primaryTextTheme
                              .bodyLarge!
                              .color)),
                  SizedBox(height: size.height * 0.005),
                  Text('Where are you selling this item',
                      style: GoogleFonts.inter(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Theme.of(context)
                              .primaryTextTheme
                              .bodyLarge!
                              .color)),
                  SizedBox(height: size.height * 0.01),
                  InkWell(
                    onTap: () {
                      showCupertinoModalBottomSheet(
                          isDismissible: true,
                          topRadius: const Radius.circular(10),
                          context: context,
                          builder: (context) => SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.82,
                                child: const SellSelectLocationBottomSheet(),
                              ));
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: size.width * 0.02,
                          vertical: size.height * 0.015),
                      decoration: BoxDecoration(
                          color: isLightMode ?  const Color(0xFFF8F6FF) : const Color(0xFF010912),
                          border: Border.all(color: const Color(0xFFE5E7EB)),
                          borderRadius: BorderRadius.circular(10)),
                      child: Row(
                        children: [
                          const Icon(CupertinoIcons.placemark),
                          SizedBox(width: size.width * 0.02),
                          Text(selectedLocation.name.toTitleCase(),
                              style: GoogleFonts.inter(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: Theme.of(context)
                                      .primaryTextTheme
                                      .bodyLarge!
                                      .color)),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: size.height * 0.04),
                  Text('Select Condition',
                      style: GoogleFonts.inter(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Theme.of(context)
                              .primaryTextTheme
                              .bodyLarge!
                              .color)),
                  SizedBox(height: size.height * 0.01),
                  InkWell(
                    onTap: () {
                      ref
                          .read(sellPostConditionProvider.notifier)
                          .setConditionNew();
                    },
                    child: Container(
                      height: size.height * 0.1,
                      width: size.width,
                      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: condition ==
                                      ProductCondition.New
                                  ? const Color(0xFF6B4EFF)
                                  : const Color(0xFFE5E7EB)),
                          color: isLightMode ?  const Color(0xFFF8F6FF) : const Color(0xFF010912),
                          borderRadius: BorderRadius.circular(10)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            'New',
                            style: GoogleFonts.inter(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Theme.of(context)
                                    .primaryTextTheme
                                    .bodyLarge!
                                    .color),
                          ),
                          SizedBox(height: size.height * 0.005),
                          Text('Select only if the product is brand new',
                              style: GoogleFonts.inter(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: Theme.of(context)
                                      .primaryTextTheme
                                      .bodyLarge!
                                      .color))
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: size.height * 0.01),
                  InkWell(
                    onTap: () {
                      ref
                          .read(sellPostConditionProvider.notifier)
                          .setConditionUsed();
                    },
                    child: Container(
                      height: size.height * 0.1,
                      width: size.width,
                      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: condition ==
                                      ProductCondition.Used
                                  ? const Color(0xFF6B4EFF)
                                  : const Color(0xFFE5E7EB)),
                          color:  isLightMode ?  const Color(0xFFF8F6FF) : const Color(0xFF010912),
                          borderRadius: BorderRadius.circular(10)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            'Used',
                            style: GoogleFonts.inter(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Theme.of(context)
                                    .primaryTextTheme
                                    .bodyLarge!
                                    .color),
                          ),
                          SizedBox(height: size.height * 0.005),
                          Text('Select only if the product is used',
                              style: GoogleFonts.inter(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: Theme.of(context)
                                      .primaryTextTheme
                                      .bodyLarge!
                                      .color))
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: size.height * 0.04),
                  Row(
                    children: [
                      Text('Title',
                          style: GoogleFonts.inter(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Theme.of(context)
                                  .primaryTextTheme
                                  .bodyLarge!
                                  .color)),
                      SizedBox(width: size.width * 0.02),
                      ref.watch(sellPostTitleProvider) != ''
                          ? const Icon(CupertinoIcons.checkmark,
                              size: 18, color: Color(0xFF6B4EFF))
                          : const SizedBox.shrink(),
                    ],
                  ),
                  Text('Enter the title of the product',
                      style: GoogleFonts.inter(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Theme.of(context)
                              .primaryTextTheme
                              .bodyLarge!
                              .color)),
                  SizedBox(height: size.height * 0.01),
                  TextField(
                    onChanged: (value) {
                      ref.read(sellPostTitleProvider.notifier).setTitle(value);
                    },
                    onTapOutside: (event) {
                      FocusScope.of(context).unfocus();
                    },
                    textInputAction: TextInputAction.done,
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Theme.of(context)
                          .primaryTextTheme
                          .bodyLarge!
                          .color
                    ),
                    decoration: InputDecoration(
                      hintText: 'Type here',
                      hintStyle: GoogleFonts.inter(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: Theme.of(context)
                              .primaryTextTheme
                              .bodyLarge!
                              .color),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Color(0xFFE5E7EB)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Color(0xFF6B4EFF)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Color(0xFFE5E7EB)),
                      ),
                      contentPadding: EdgeInsets.symmetric(
                          horizontal: size.width * 0.04,
                          vertical: size.height * 0.015),
                    ),
                  ),
                  SizedBox(height: size.height * 0.04),
                  Row(
                    children: [
                      Text('Description',
                          style: GoogleFonts.inter(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Theme.of(context)
                                  .primaryTextTheme
                                  .bodyLarge!
                                  .color)),
                      SizedBox(width: size.width * 0.02),
                      ref.watch(sellPostDescriptionProvider) != ''
                          ? const Icon(CupertinoIcons.checkmark,
                              size: 18, color: Color(0xFF6B4EFF))
                          : const SizedBox.shrink(),
                    ],
                  ),
                  Text('Describe the product in detail',
                      style: GoogleFonts.inter(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Theme.of(context)
                              .primaryTextTheme
                              .bodyLarge!
                              .color)),
                  SizedBox(height: size.height * 0.01),
                  TextField(
                    minLines: 10,
                    maxLines: null,
                    onTapOutside: (event) {
                      FocusScope.of(context).unfocus();
                    },
                    onChanged: (value) {
                      ref
                          .read(sellPostDescriptionProvider.notifier)
                          .setDescription(value);
                    },
                    textInputAction: TextInputAction.done,
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Theme.of(context)
                          .primaryTextTheme
                          .bodyLarge!
                          .color
                    ),
                    decoration: InputDecoration(
                      hintText: 'Enter the title of the product',
                      hintStyle: GoogleFonts.inter(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: Theme.of(context)
                              .primaryTextTheme
                              .bodyLarge!
                              .color),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Color(0xFFE5E7EB)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Color(0xFF6B4EFF)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Color(0xFFE5E7EB)),
                      ),
                      contentPadding: EdgeInsets.symmetric(
                          horizontal: size.width * 0.04,
                          vertical: size.height * 0.015),
                    ),
                  ),
                  SizedBox(height: size.height * 0.04),
                  Row(
                    children: [
                      Text('Asking Price',
                          style: GoogleFonts.inter(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF090A0A))),
                      SizedBox(width: size.width * 0.02),
                      ref.watch(sellPostPriceProvider) != 0.0
                          ? const Icon(CupertinoIcons.checkmark,
                              size: 18, color: Color(0xFF6B4EFF))
                          : const SizedBox.shrink(),
                    ],
                  ),
                  Text('Enter the asking price',
                      style: GoogleFonts.inter(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color:Theme.of(context)
                              .primaryTextTheme
                              .bodyLarge!
                              .color)),
                  SizedBox(height: size.height * 0.01),
                  TextField(
                    style: GoogleFonts.inter(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Theme.of(context)
                            .primaryTextTheme
                            .bodyLarge!
                            .color
                    ),
                    onChanged: (value) {
                      ref.read(sellPostPriceProvider.notifier).setPrice(value);
                    },
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                          horizontal: size.width * 0.191,
                          vertical: size.height * 0.02),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Color(0xFFE5E7EB)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Color(0xFF6B4EFF)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Color(0xFFE5E7EB)),
                      ),
                      prefixIcon: const Icon(CupertinoIcons.money_dollar,
                          color: Color(0xFF9EA3AE)),
                      hintText: '0.00',
                      hintStyle: GoogleFonts.inter(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: Theme.of(context)
                              .primaryTextTheme
                              .bodyLarge!
                              .color),
                    ),
                  ),
                  SizedBox(height: size.height * 0.04),
                  Text('Add Images',
                      style: GoogleFonts.inter(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Theme.of(context)
                              .primaryTextTheme
                              .bodyLarge!
                              .color)),
                  SizedBox(height: size.height * 0.01),
                  Text('Add images of the product',
                      style: GoogleFonts.inter(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Theme.of(context)
                              .primaryTextTheme
                              .bodyLarge!
                              .color)),
                  SizedBox(height: size.height * 0.02),
                  SizedBox(
                    height: size.height * 0.3,
                    child: GridView.builder(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                      ),
                      itemCount:
                          images.length < 6 ? images.length + 1 : images.length,
                      itemBuilder: (context, index) {
                        if (index < images.length) {
                          return Stack(
                            alignment: Alignment.center,
                            fit: StackFit.expand,
                            children: [
                              Image.file(
                                File(images[index]),
                                fit: BoxFit.cover,
                              ),
                              Positioned(
                                top: 0,
                                right: 0,
                                child: InkWell(
                                  onTap: () {
                                    ref
                                        .read(sellPostImageProvider.notifier)
                                        .removeImage(images[index]);
                                  },
                                  child: const Icon(CupertinoIcons.clear_circled_solid,
                                      size: 20, color: Color(0xFF9EA3AE)),
                                ),
                              ),
                            ],
                          );
                        } else {
                          return InkWell(
                            onTap: () => _pickImage(ref),
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  border: Border.all(color: const Color(0xFFE5E7EB)),
                                  color: isLightMode ?  const Color(0xFFF8F6FF) : const Color(0xFF010912),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(
                                    'assets/images/product_image_placehooolder.svg',
                                    colorFilter: const ColorFilter.mode(
                                        Color(0xFF6B4EFF), BlendMode.srcIn),
                                  ),
                                  SizedBox(height: size.height * 0.01),
                                  Text('Add Image',
                                      style: GoogleFonts.inter(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          color: Theme.of(context)
                                              .primaryTextTheme
                                              .bodyLarge!
                                              .color)),
                                ],
                              ),
                            ),
                          );
                        }
                      },
                    ),
                  ),
                  SizedBox(height: size.height * 0.04),
                  SizedBox(
                    width: size.width,
                    height: size.height * 0.05,
                    child: CustomButton(
                      text: 'Next',
                      onPressed: () {
                        if(category!=null && title != '' && description !='' && price != 0 && images.isNotEmpty){
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const SellPostPreviewScreen()));
                        }

                      },
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
