import 'package:flutter/material.dart';
import 'package:simsar/utils/search_delegate.dart';
import 'package:simsar/Theme/app_colors.dart';
import 'package:simsar/Theme/text_theme.dart';
class SPropertySearchBar extends StatelessWidget {
  final List<String> sourceList;
  final Function(String) onSelected;

  const SPropertySearchBar({
    super.key, 
    required this.sourceList, 
    required this.onSelected
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        // This triggers the full-screen search logic
        final String? selected = await showSearch<String>(
          context: context,
          delegate: ApartmentSearchDelegate(sourceList),
        );
        
        if (selected != null && selected.isNotEmpty) {
          onSelected(selected);
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
            const Icon(Icons.tune_rounded, color: SAppColors.secondaryDarkBlue),
          ],
        ),
      ),
    );
  }
}
