import 'package:connectly_c2c/viewmodel/user_viewmodel/user_profile_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

getRatingWidget(WidgetRef ref) {
  final rating = ref.watch(userProfilerProvider)!.reviewRating.round();
  final reviewCount = ref.watch(userProfilerProvider)!.totalReview;
  return Row(
    children: [
      ...List.generate(
        rating,
        (index) => const Icon(Icons.star, color: Color(0xFFFEBB0E)),
      ),
      ...List.generate(
        (5 - rating),
        (index) => const Icon(Icons.star_outline, color: Color(0xFFFEBB0E)),
      ),
      const SizedBox(width: 5),
      Text('($reviewCount)',
          style: GoogleFonts.inter(
            fontWeight: FontWeight.w500,
            fontSize: 14,
          )),
    ],
  );
}
