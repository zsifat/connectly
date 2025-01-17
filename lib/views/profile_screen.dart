import 'dart:convert';
import 'dart:io';
import 'package:connectly_c2c/views/purchase_tracking_screen.dart';
import 'package:http/http.dart' as http;
import 'package:change_case/change_case.dart';
import 'package:connectly_c2c/viewmodel/auth_viewmodel/auth_provider.dart';
import 'package:connectly_c2c/viewmodel/navbar_viewmodel/navbar_provider.dart';
import 'package:connectly_c2c/viewmodel/user_viewmodel/user_profile_provider.dart';
import 'package:connectly_c2c/views/sales_tracking_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:connectly_c2c/viewmodel/settings_viewmodel.dart/search_alert_provider.dart';
import 'package:connectly_c2c/views/account_settings_screen.dart';
import 'package:connectly_c2c/views/payment_deposit_screen.dart';
import 'package:connectly_c2c/views/promote_plus_screen.dart';
import 'package:connectly_c2c/views/widgets/account_verification_dashboard.dart';
import 'package:connectly_c2c/views/widgets/rating.dart';
import 'package:image_picker/image_picker.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    final userProfile = ref.watch(userProfilerProvider);
    final searchAlert = ref.watch(searchAlertProvider);

    uploadImage() async {
      XFile? pickedImage =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      if (pickedImage != null) {
        File imageFile = File(pickedImage.path);
        String cloudinaryUrl =
            "https://api.cloudinary.com/v1_1/dwnqjq3k2/image/upload";
        String unsignedPreset = "connectly";
        var request = http.MultipartRequest('POST', Uri.parse(cloudinaryUrl));
        request.fields['upload_preset'] = unsignedPreset;
        request.files
            .add(await http.MultipartFile.fromPath('file', imageFile.path));
        var response = await request.send();

        if (response.statusCode == 200) {
          var responseData = await http.Response.fromStream(response);
          var data = json.decode(responseData.body);
          ref
              .read(userProfilerProvider.notifier)
              .profileInfoUpdate(userProfile!.uid, 'photo', data['secure_url']);
          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Profile Photo Uploaded Successfully')));
          }
        } else {
          print('Image upload failed: ${response.statusCode}');
        }
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Profile',
          style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: Theme.of(context).primaryTextTheme.bodyLarge!.color),
        ),
        centerTitle: true,
        actions: [
          TextButton(
              onPressed: () {
                showCupertinoDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return CupertinoAlertDialog(
                      title: Text(
                        'Confirm Logout',
                        style: GoogleFonts.inter(
                          fontSize: 16,
                          color: Theme.of(context).primaryTextTheme.bodyLarge!.color
                        ),
                      ),
                      content: Text('Are you sure you want to log out?',
                          style: GoogleFonts.inter(
                            fontSize: 16,
                          )),
                      actions: [
                        CupertinoDialogAction(
                          isDefaultAction: true,
                          onPressed: () {
                            Navigator.pop(context); // Dismiss the dialog
                          },
                          child: const Text('No'),
                        ),
                        CupertinoDialogAction(
                          isDestructiveAction: true,
                          onPressed: () {
                            Navigator.pop(context);
                            ref
                                .read(authStateProvider.notifier)
                                .logout(context);
                            ref.invalidate(userProfilerProvider);
                            ref
                                .read(navBarProvider.notifier)
                                .invalidateNavbarIndex();
                          },
                          child: const Text('Yes'),
                        ),
                      ],
                    );
                  },
                );
              },
              child: Text(
                'Logout',
                style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).primaryTextTheme.bodyLarge!.color),
              ))
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(
              horizontal: size.width * 0.05, vertical: size.height * 0.01),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                children: [
                  InkWell(
                    onTap: () {
                      showCupertinoDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return CupertinoAlertDialog(
                            title: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text(
                                'Change profile Picture?',
                                style: GoogleFonts.inter(
                                    fontSize: 16,
                                    color: Theme.of(context)
                                        .primaryTextTheme
                                        .bodyLarge!
                                        .color),
                              ),
                            ),
                            content: Text(
                                'Are you sure you want to change profile picture?',
                                style: GoogleFonts.inter(
                                    fontSize: 14,
                                    color: Theme.of(context)
                                        .primaryTextTheme
                                        .bodyLarge!
                                        .color)),
                            actions: [
                              CupertinoDialogAction(
                                isDefaultAction: true,
                                onPressed: () {
                                  Navigator.pop(context); // Dismiss the dialog
                                },
                                child: const Text('No'),
                              ),
                              CupertinoDialogAction(
                                isDestructiveAction: true,
                                onPressed: () {
                                  ref
                                      .read(userProfilerProvider.notifier)
                                      .profilePhotoUpload();
                                  Navigator.pop(context);
                                },
                                child: const Text('Yes'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      maxRadius: size.width * 0.13,
                      minRadius: size.width * 0.13,
                      foregroundImage: NetworkImage(userProfile
                              ?.profilePicURL ??
                          "https://www.strasys.uk/wp-content/uploads/2022/02/Depositphotos_484354208_S.jpg"),
                    ),
                  ),
                  SizedBox(width: size.width * 0.02),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(userProfile?.username.toTitleCase() ?? '',
                          style: GoogleFonts.inter(
                              fontSize: 16,
                              color: Theme.of(context)
                                  .primaryTextTheme
                                  .bodyLarge!
                                  .color,
                              fontWeight: FontWeight.w800)),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: size.height * 0.005),
                        child: getRatingWidget(ref),
                      ),
                      Row(
                        children: [
                          Text('${userProfile!.itemsBought.length}',
                              style: GoogleFonts.inter(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Theme.of(context)
                                      .primaryTextTheme
                                      .bodyLarge!
                                      .color)),
                          Text(' Bought ',
                              style: GoogleFonts.inter(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: Theme.of(context)
                                      .primaryTextTheme
                                      .bodyLarge!
                                      .color)),
                          const SizedBox(width: 10),
                          Text(
                            '${userProfile.itemsSold.length}',
                            style: GoogleFonts.inter(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Theme.of(context)
                                    .primaryTextTheme
                                    .bodyLarge!
                                    .color),
                          ),
                          Text(' Sold',
                              style: GoogleFonts.inter(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: Theme.of(context)
                                      .primaryTextTheme
                                      .bodyLarge!
                                      .color)),
                        ],
                      ),
                      SizedBox(height: size.height * 0.01),
                    ],
                  )
                ],
              ),
              SizedBox(height: size.height * 0.04),
              Text('Verify your account to build reputation',
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Theme.of(context).primaryTextTheme.bodyLarge!.color,
                  )),
              SizedBox(height: size.height * 0.03),
              accountVerificationDashboard(size, ref, context),
              SizedBox(height: size.height * 0.04),
              Text('Transactions',
                  style: GoogleFonts.inter(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Theme.of(context).primaryTextTheme.bodyLarge!.color,
                  )),
              Column(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const SalesTrackingScreen()));
                    },
                    child: getSettingTiles(size, context, 'Sales', CupertinoIcons.money_dollar)
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const PurchaseTrackingScreen()));
                    },
                    child: getSettingTiles(size, context, 'Purchases', CupertinoIcons.purchased_circle)

                  ),
                  InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const PaymentDepositScreen()));
                      },
                      child: getSettingTiles(size, context, 'Payment & Deposits Methods', CupertinoIcons.creditcard))
                ],
              ),
              SizedBox(height: size.height * 0.04),
              Text('Saved Items',
                  style: GoogleFonts.inter(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color:
                          Theme.of(context).primaryTextTheme.bodyLarge!.color)),
              SizedBox(height: size.height * 0.01),
              Column(
                children: [
                  getSettingTiles(size, context, 'Saved Items', CupertinoIcons.star),
                  SizedBox(height: size.height * 0.01),
                  Row(
                    children: [
                      Icon(CupertinoIcons.bell,
                          color: Theme.of(context)
                              .primaryTextTheme
                              .bodyLarge!
                              .color,
                          size: 26),
                      SizedBox(width: size.width * 0.03),
                      Text('Search Alerts',
                          style: GoogleFonts.inter(
                              fontSize: 16,
                              color: Theme.of(context)
                                  .primaryTextTheme
                                  .bodyLarge!
                                  .color,
                              fontWeight: FontWeight.w400)),
                      const Spacer(),
                      Transform.scale(
                        scale: 0.8,
                        child: Switch(
                          activeTrackColor: const Color(0xFF6B4EFF),
                          inactiveTrackColor: const Color(0xFFE5E6EB),
                          activeColor: Colors.white,
                          value: searchAlert,
                          onChanged: (value) {
                            ref
                                .read(searchAlertProvider.notifier)
                                .toggleSearchAlert();
                          },
                        ),
                      )
                    ],
                  )
                ],
              ),
              SizedBox(height: size.height * 0.03),
              Text('Account',
                  style: GoogleFonts.inter(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Theme.of(context).primaryTextTheme.bodyLarge!.color,
                  )),
              Column(
                children: [
                  InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const AccountSettingsScreen()));
                      },
                      child: getSettingTiles(size, context, 'Account Settings',
                          CupertinoIcons.settings)),
                  InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const PromotePlusScreen()));
                      },
                      child: getSettingTiles(
                          size, context, 'Promote Plus', CupertinoIcons.shift)),
                  getSettingTiles(
                      size, context, 'Custom Profile Link', CupertinoIcons.link)
                ],
              ),
              SizedBox(height: size.height * 0.03),
              Text('Help & Support',
                  style: GoogleFonts.inter(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Theme.of(context).primaryTextTheme.bodyLarge!.color,
                  )),
              SizedBox(height: size.height * 0.01),
              getSettingTiles(
                  size, context, 'Help Center', CupertinoIcons.question_circle)
            ],
          ),
        ),
      ),
    );
  }

  getSettingTiles(
      Size size, BuildContext context, String title, IconData iconData) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: size.height * 0.015),
      child: Row(
        children: [
          Icon(iconData,
              color: Theme.of(context).primaryTextTheme.bodyLarge!.color,
              size: 26),
          SizedBox(width: size.width * 0.03),
          Text(title,
              style: GoogleFonts.inter(
                  fontSize: 16,
                  color: Theme.of(context).primaryTextTheme.bodyLarge!.color,
                  fontWeight: FontWeight.w400)),
          const Spacer(),
          Icon(Icons.arrow_forward_ios,
              size: 18,
              color: Theme.of(context).primaryTextTheme.bodyLarge!.color)
        ],
      ),
    );
  }
}
