import 'package:flutter/material.dart';
import 'package:simsar/Models/property_models.dart';
import 'package:simsar/Theme/app_colors.dart';
import 'package:simsar/Theme/text_theme.dart';
class ApartmentSearchTile extends StatelessWidget {
  final Property property;
  final VoidCallback onTap;


  const ApartmentSearchTile({
    super.key,
    required this.property,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Icon
              Icon(
                Icons.location_on_outlined,
                size: 24,
                color: SAppColors.textGray,
              ),

              const SizedBox(width: 12),

              // Texts
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Property title
                    Text(
                      property.title,
                      style: STextTheme.lightTextTheme.titleMedium!.copyWith(fontWeight: FontWeight.w800),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),

                    const SizedBox(height: 4),

                    // Location
                    Text(
                      "${property.province.displayName}, ${property.city.displayName}",
                      style: STextTheme.lightTextTheme.bodyMedium,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}