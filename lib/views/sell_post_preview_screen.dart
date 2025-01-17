import 'package:change_case/change_case.dart';
import 'package:connectly_c2c/viewmodel/product_viewmodel/product_provider.dart';
import 'package:connectly_c2c/viewmodel/ui_viewmodel/product_photo_upload_loading_provider.dart';
import 'package:connectly_c2c/viewmodel/user_viewmodel/user_profile_provider.dart';
import 'package:connectly_c2c/views/widgets/file_image_carousal.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:connectly_c2c/viewmodel/sell_post_viewmodel/sell_post_condition_provider.dart';
import 'package:connectly_c2c/viewmodel/sell_post_viewmodel/sell_post_decription_provider.dart';
import 'package:connectly_c2c/viewmodel/sell_post_viewmodel/sell_post_image_provider.dart';
import 'package:connectly_c2c/viewmodel/sell_post_viewmodel/sell_post_price_provider.dart';
import 'package:connectly_c2c/viewmodel/sell_post_viewmodel/sell_post_title_provider.dart';
import 'package:connectly_c2c/viewmodel/sell_post_viewmodel/sell_product_category_provider.dart';
import 'package:connectly_c2c/viewmodel/sell_post_viewmodel/sell_product_location_provider.dart';
import 'package:connectly_c2c/views/main_screen.dart';
import 'package:connectly_c2c/views/widgets/button.dart';

class SellPostPreviewScreen extends ConsumerWidget {
  const SellPostPreviewScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    final title = ref.read(sellPostTitleProvider);
    final description = ref.read(sellPostDescriptionProvider);
    final price = ref.read(sellPostPriceProvider);
    final condition = ref.read(sellPostConditionProvider);
    final location = ref.read(sellProductLocationProvider);
    final List<String> imagePaths = ref.read(sellPostImageProvider);
    final isLoading = ref.watch(photoUploadLoadingProvider);
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Preview',
              style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: Theme.of(context)
                      .primaryTextTheme
                      .bodyLarge!
                      .color)),
          actions: [
            IconButton(
                onPressed: () {},
                icon: Icon(CupertinoIcons.star,
                    size: 20, color: Theme.of(context)
                        .primaryTextTheme
                        .bodyLarge!
                        .color))
          ],
        ),
        body: isLoading ? Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset('assets/images/file_uploading.svg',height: 128,width: 128,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Publishing',
                  style: GoogleFonts.inter(
                  fontSize: 20,
                  color: Theme.of(context)
                      .primaryTextTheme
                      .bodyLarge!
                      .color,
                  fontWeight: FontWeight.w600
                ),),
                const SizedBox(width: 10,),
                const CircularProgressIndicator(
                  color: Color(0xFF6B4EFF),
                ),
              ],
            ),
          ],
        ) :
        Container(
          width: size.width,
          height: size.height,
          padding: const EdgeInsets.only(bottom: 10),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                            height: size.height * 0.4,
                            width: size.width,
                            child: FileImageCarousel(imagePaths: imagePaths)),
                        const SizedBox(height: 10),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: size.width * 0.03),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 10),
                              Row(
                                children: [
                                  SizedBox(
                                    width:size.width *0.8,
                                    child: Text(title,
                                        style: GoogleFonts.inter(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w700,
                                            color: Theme.of(context)
                                                .primaryTextTheme
                                                .bodyLarge!
                                                .color),
                                    overflow: TextOverflow.ellipsis,),
                                  ),
                                  SizedBox(width: size.width *0.001),
                                  Text(condition.name,
                                      style: GoogleFonts.inter(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          color: Theme.of(context)
                                              .primaryTextTheme
                                              .bodyLarge!
                                              .color)),
                                ],
                              ),
                              const SizedBox(height: 15),
                              Row(
                                children: [
                                  Icon(CupertinoIcons.location_fill,
                                      size: 16, color: Theme.of(context)
                                          .primaryTextTheme
                                          .bodyLarge!
                                          .color),
                                  const SizedBox(width: 5),
                                  Text(location.name.toTitleCase(),
                                      style: GoogleFonts.inter(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          color: Theme.of(context)
                                              .primaryTextTheme
                                              .bodyLarge!
                                              .color)),
                                ],
                              ),
                              const SizedBox(height: 15),
                              const Divider(
                                color: Colors.grey,
                                thickness: 1,
                              ),
                              const SizedBox(height: 10),
                              Row(
                                children: [
                                  Text('\$$price',
                                      style: GoogleFonts.inter(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w800,
                                          color: Theme.of(context)
                                              .primaryTextTheme
                                              .bodyLarge!
                                              .color)),
                                  const SizedBox(width: 10),
                                  Text('Negotiable  ',
                                      style: GoogleFonts.inter(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          color: Theme.of(context)
                                              .primaryTextTheme
                                              .bodyLarge!
                                              .color)),
                                ],
                              ),
                              const SizedBox(height: 15),
                              Row(
                                children: [
                                  Text('For sale by',
                                      style: GoogleFonts.inter(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          color: Theme.of(context)
                                              .primaryTextTheme
                                              .bodyLarge!
                                              .color)),
                                  const SizedBox(width: 10),
                                  Text(ref.read(userProfilerProvider)!.username.toTitleCase(),
                                      style: GoogleFonts.inter(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          color: Theme.of(context)
                                              .primaryTextTheme
                                              .bodyLarge!
                                              .color)),
                                ],
                              ),
                              const SizedBox(height: 15),
                              Row(
                                children: [
                                  Icon(CupertinoIcons.checkmark_shield_fill,
                                      size: 18,
                                      color: ref.watch(userProfilerProvider)!.isEmailVerified
                                          ? const Color(0xFF6B4EFF)
                                          : const Color(0xFF6C727F)),
                                  const SizedBox(width: 5),
                                  Text(
                                      ref.watch(userProfilerProvider)!.isEmailVerified == true ? 'Verified Member' : 'Not Verified Member',
                                      style: GoogleFonts.inter(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          color: ref.watch(userProfilerProvider)!.isEmailVerified ==
                                                  true
                                              ? const Color(0xFF6B4EFF)
                                              : const Color(0xFF6C727F))),
                                ],
                              ),
                              const SizedBox(height: 15),
                              const Divider(
                                color: Colors.grey,
                                thickness: 1,
                              ),
                              const SizedBox(height: 15),
                              Text('Description',
                                  style: GoogleFonts.inter(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: Theme.of(context)
                                          .primaryTextTheme
                                          .bodyLarge!
                                          .color)),
                              const SizedBox(height: 10),
                              Text(description,
                                  style: GoogleFonts.inter(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: Theme.of(context)
                                          .primaryTextTheme
                                          .bodyLarge!
                                          .color)),
                              const SizedBox(height: 10),
                            ],
                          ),
                        ),
                      ]),
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: size.width * 0.03,
                    vertical: size.height * 0.01),
                child: Row(
                  children: [
                    Expanded(
                        child: SizedBox(
                            height: size.height * 0.05,
                            child: CustomButton(
                                text: 'Cancel',
                                onPressed: () {
                                  ref.invalidate(sellProductCategoryProvider);
                                  ref.invalidate(sellPostImageProvider);
                                  ref.invalidate(sellPostDescriptionProvider);
                                  ref.invalidate(sellPostPriceProvider);
                                  ref.invalidate(sellPostConditionProvider);
                                  ref.invalidate(sellProductLocationProvider);
                                  ref.invalidate(sellPostTitleProvider);

                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => const MainScreen()));
                                }))),
                    const SizedBox(width: 10),
                    Expanded(
                        child: SizedBox(
                      height: size.height * 0.05,
                      child: CustomButton(
                          text:  'Publish',
                          onPressed: () async{
                            ref.read(photoUploadLoadingProvider.notifier).setToLoading();
                            final List<String> imageUrls=[];
                            for(String imagePath in imagePaths){
                             final imageUrl = await ref.read(productServiceProvider.notifier).productPhotoUploadCloud(imagePath);
                             if(imageUrl!=null){
                               imageUrls.add(imageUrl);
                             }
                            }
                            if(imageUrls.isNotEmpty){
                              ref.read(productServiceProvider.notifier).publishPost(
                                ref.watch(userProfilerProvider)!.uid,
                                ref.watch(userProfilerProvider)!.username,
                                title,
                                description,
                                price,
                                ref.watch(sellProductCategoryProvider)!,
                                location,
                                imageUrls,
                                condition,);
                              ref.invalidate(sellProductCategoryProvider);
                              ref.invalidate(sellPostImageProvider);
                              ref.invalidate(sellPostDescriptionProvider);
                              ref.invalidate(sellPostPriceProvider);
                              ref.invalidate(sellPostConditionProvider);
                              ref.invalidate(sellProductLocationProvider);
                              ref.invalidate(sellPostTitleProvider);
                              if(context.mounted) {
                                ref.read(photoUploadLoadingProvider.notifier).setLoadingComplete();
                                Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const MainScreen()),(route) => false,);
                            }}
                          }),
                    )),
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
