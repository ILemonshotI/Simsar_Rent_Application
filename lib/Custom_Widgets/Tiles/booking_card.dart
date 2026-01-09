// features/booking/widgets/booking_card.dart
import 'package:flutter/material.dart';
import '../../Models/property_model.dart';
import '../../Theme/app_colors.dart';
import '../../Theme/text_theme.dart';


class BookingCard extends StatelessWidget {
  final Property property;

  const BookingCard({
    super.key,
    required this.property,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.all(12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              property.images.first,
              width: 80,
              height: 80,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  property.title,
                  style: STextTheme.lightTextTheme.titleMedium,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),

                Text(
                  property.province.displayName,
                  style:  STextTheme.lightTextTheme.bodySmall,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),

                Row(
                  children: [
                    Text(
                      '\$${property.pricePerDay}/day',
                      style:  STextTheme.lightTextTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const Spacer(),
                    Icon(
                      Icons.star,
                      size: 16,
                      color:SAppColors.secondaryDarkBlue,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      property.reviewsAvgRating.toStringAsFixed(1),
                      style: STextTheme.lightTextTheme.bodySmall,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
