import 'package:flutter/material.dart';
import 'package:simsar/Theme/app_colors.dart';
import 'package:simsar/Theme/text_theme.dart'; 


class RatingTile extends StatelessWidget {
  final double rating;

  const RatingTile({
    super.key, 
    this.rating = 4.5,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      decoration: BoxDecoration(
        // Use your theme color for the light cream background
        color: SAppColors.reviewBackground, 
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.star_rounded, // Rounded star matches your image better
            color: SAppColors.starYellow, // Or AppColors.starIcon
            size: 12,
          ),
          const SizedBox(width: 2),
          Text(
            rating.toString(),
            style: STextTheme.lightTextTheme.displaySmall,
          ),
        ],
      ),
    );
  }
}