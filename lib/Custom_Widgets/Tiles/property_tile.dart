import 'package:flutter/material.dart';
import 'package:simsar/Theme/app_colors.dart'; 
import 'package:simsar/Custom_Widgets/Buttons/favourite_button.dart';
import 'package:simsar/Custom_Widgets/Tiles/rating_tile.dart';
import 'package:simsar/Models/property_models.dart';
import 'package:simsar/Theme/text_theme.dart';
class PropertyTile extends StatelessWidget {
  final Property property;
  final VoidCallback onTap;

  const PropertyTile({
    super.key, 
    required this.property,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
    color: Colors.transparent, 
    child: InkWell(
      borderRadius: BorderRadius.circular(16), // Match your container radius
      onTap: onTap,
    child: Container(
      width: 327,
      height: 84,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: SAppColors.transparent,
        borderRadius: BorderRadius.circular(16),

      ),
      child: Stack(
        children: [
          Row(
            children: [
              // 1. Image from the images list
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: property.images.isNotEmpty && property.images.first.startsWith('http')
                  ? Image.network(
                      property.images.first,
                      width: 80,
                      height: 62,
                      fit: BoxFit.cover,
                      // Shows while the image is downloading
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Container(color: SAppColors.textGray, width: 80, height: 62);
                      },
                      // Fallback for broken links
                      errorBuilder: (context, error, stackTrace) => 
                          Container(color: SAppColors.textGray, width: 80, height: 62),
                    )
                  : Container(color: SAppColors.textGray, width: 80, height: 62),
              ),
              const SizedBox(width: 12),
              
              // 2. Property Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      property.title,
                      style: STextTheme.lightTextTheme.labelLarge,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 2),
                    Row(
                      children: [
                        Icon(Icons.location_on_outlined, 
                             size: 12, color: SAppColors.descriptionTextGray),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            "${property.province.displayName}, ${property.city.displayName}",
                            style: STextTheme.lightTextTheme.bodySmall,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '\$${property.pricePerDay.toInt()}/night',
                      style: STextTheme.lightTextTheme.displaySmall,
                    ),
                  ],
                ),
              ),
            ],
          ),

          // 3. Heart Button (Top Right)
           Positioned(
            top: -8, // Adjusting for IconButton padding
            right: -8,
            child: FavoriteButton(property: property), 
          ),

          // 4. Rating (Bottom Right)
          Positioned(
            bottom: 0,
            right: 0,
            child: RatingTile(rating: property.reviewsAvgRating,),
          ),
        ],
      ),
    )
    ),
    );
  }
}
