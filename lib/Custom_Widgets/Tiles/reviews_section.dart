import 'package:flutter/material.dart';
import 'package:simsar/Theme/text_theme.dart';
import '../../Theme/app_colors.dart';
import '../../Models/property_models.dart';

class ReviewsSection extends StatelessWidget {
  final int reviewsCount;
  final List<Review> reviews;

  const ReviewsSection({
    super.key,
    required this.reviewsCount,
    required this.reviews,
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
              Text(
                "Reviews $reviewsCount",
                style: STextTheme.lightTextTheme.titleMedium,
              ),
              const Spacer(),
              Text(
                "See all",
                style: STextTheme.lightTextTheme.bodyMedium,
              ),
            ],
          ),
          const SizedBox(height: 8),

          // Horizontal scrollable list
          SizedBox(
            height: 100, // Adjust based on card height
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: reviews.length,
              itemBuilder: (context, index) {
                final review = reviews[index];

                return Container(
                  width: 250, // Adjust width per card
                  margin: const EdgeInsets.only(right: 12),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: SAppColors.primaryBlue,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundImage: NetworkImage(review.reviewerAvatar?? " "),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              review.reviewerName,
                              style: STextTheme.lightTextTheme.bodyMedium,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 4),
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
                              (_) => const Icon(
                            Icons.star,
                            size: 16,
                            color: Colors.amber,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
