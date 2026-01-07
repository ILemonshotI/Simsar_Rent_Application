import 'package:flutter/material.dart'; 
import 'package:simsar/Models/property_model.dart';
import 'package:simsar/Custom_Widgets/Tiles/apartment_search_tile.dart';
import 'package:simsar/Theme/text_theme.dart';
class ApartmentSearchDelegate extends SearchDelegate<Property?> {
  final List<Property> properties;
  
  ApartmentSearchDelegate(this.properties);

  // Theme override to ensure the search page matches your app style
  @override
  ThemeData appBarTheme(BuildContext context) {
    return Theme.of(context);
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () => query = '',
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () => close(context, null),
    );
  }

  @override
  Widget buildResults(BuildContext context) => _buildFilteredList();

  @override
  Widget buildSuggestions(BuildContext context) => _buildFilteredList();

  // Logic: Filters the list based on the user's 'query'
  Widget _buildFilteredList() {
    final results = properties.where((property) {
      return property.title
          .toLowerCase()
          .contains(query.toLowerCase());
    }).toList();

    if (results.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                'assets/images/search-null.png',
                width: 220,
                fit: BoxFit.contain,
              ),
              const SizedBox(height: 32),
              Text(
                'Search not found',
                style: STextTheme.lightTextTheme.titleLarge,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Text(
                'No place with such name found, try searching with a different name.',
                style: STextTheme.lightTextTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      );
    }

    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        final property = results[index];

        return ApartmentSearchTile(
          property: property,
          onTap: () => close(context, property),
        );
      },
    );
  }
}
