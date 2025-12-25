import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:simsar/Theme/text_theme.dart';

import '../../Theme/app_colors.dart';
import '../../models/property_model.dart';

class ReviewsSection extends StatelessWidget {
  final int reviewsCount;
  final Review review;

  const ReviewsSection({
    required this.reviewsCount,
    required this.review,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text("Reviews $reviewsCount", style: STextTheme.lightTextTheme.titleMedium),
              const Spacer(),
              Text(
                "See all",
                style: STextTheme.lightTextTheme.bodyMedium
              ),
            ],
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: SAppColors.primaryBlue,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(review.reviewerAvatar),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(review.reviewerName, style: STextTheme.lightTextTheme.bodyMedium),
                      Text(
                        review.text,
                        style: STextTheme.lightTextTheme.bodySmall,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                Row(
                  children: List.generate(
                    review.rating,
                        (_) => const Icon(Icons.star, size: 16, color: Colors.amber),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
