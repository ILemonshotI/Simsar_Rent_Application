import 'package:flutter/material.dart'; 


class ApartmentSearchDelegate extends SearchDelegate<String> {
  final List<String> apartments;

  ApartmentSearchDelegate(this.apartments);

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
      onPressed: () => close(context, ''),
    );
  }

  @override
  Widget buildResults(BuildContext context) => _buildFilteredList();

  @override
  Widget buildSuggestions(BuildContext context) => _buildFilteredList();

  // Logic: Filters the list based on the user's 'query'
  Widget _buildFilteredList() {
    final results = apartments
        .where((name) => name.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(results[index]),
          onTap: () => close(context, results[index]),
        );
      },
    );
  }
}