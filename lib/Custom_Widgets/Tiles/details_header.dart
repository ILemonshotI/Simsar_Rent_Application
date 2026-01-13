import 'package:flutter/material.dart';
import 'package:simsar/Theme/text_theme.dart';

import '../../Models/property_models.dart';

class HeaderSection extends StatelessWidget {
  final Property property;

  const HeaderSection({super.key, required this.property});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  property.title,
                  style: STextTheme.lightTextTheme.titleLarge,
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(Icons.location_on, size: 16),
                    const SizedBox(width: 4),
                    Text(

                      "${property.province.displayName}, ${property.city.displayName}",
                      style: STextTheme.lightTextTheme.headlineMedium,
                    ),
                  ],
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                "\$${property.pricePerDay.toInt()}",
                style: STextTheme.lightTextTheme.titleSmall,
              ),
              Text(
                "/day",
                style: STextTheme.lightTextTheme.headlineSmall,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
