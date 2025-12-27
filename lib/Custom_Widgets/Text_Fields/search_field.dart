import 'package:flutter/material.dart';
import 'package:simsar/utils/search_delegate.dart';
import 'package:simsar/Theme/app_colors.dart';
import 'package:simsar/Theme/text_theme.dart';
import 'package:simsar/Models/property_model.dart';
import 'package:simsar/Models/filter_model.dart';

class SPropertySearchBar extends StatelessWidget {
  final List<Property> propertiesList;
  final Function(Property) onSelected;
  final VoidCallback onFilterTap;

  const SPropertySearchBar({
    super.key, 
    required this.propertiesList, 
    required this.onSelected,
    required this.onFilterTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        // This triggers the full-screen search logic
        final Property? selectedProperty = await showSearch<Property?>(
          context: context,
          delegate: ApartmentSearchDelegate(propertiesList),
        );

        if (selectedProperty != null) {
           onSelected(selectedProperty);
           print(selectedProperty.title);
        }
      },
      child: Container(
        width: 364,
        height: 52,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(width: 1, color: SAppColors.outlineGray), // Replace with SAppColors.outlineGray
        ),
        child: Row(
          children: [
            const Icon(Icons.search_rounded, color: SAppColors.secondaryDarkBlue),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                "Search Property",
                style: STextTheme.lightTextTheme.bodyMedium, // Replace with STextTheme hint style
              ),
            ),
            IconButton(
            onPressed: onFilterTap,
            icon: const Icon(Icons.tune_rounded, color: SAppColors.secondaryDarkBlue),
          ),
          ],
        ),
      ),
    );
  }
}
