import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:simsar/Custom_Widgets/Tiles/property_tile.dart';
import 'package:simsar/Models/property_models.dart';
import 'package:simsar/Theme/app_colors.dart';
import 'package:simsar/Models/property_enums.dart';
import 'package:simsar/Network/api_client.dart';
class FavouritesScreen extends StatefulWidget {
  const FavouritesScreen({super.key});

  @override
  State<FavouritesScreen> createState() => _FavouritesScreenState();
}

class _FavouritesScreenState extends State<FavouritesScreen> {

  List<Property> favorites = [];
  bool isLoading = true;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    _fetchFavorites();
  }

  Future<void> _fetchFavorites() async {
    try {
      setState(() {
        isLoading = true;
        errorMessage = null;
      });

      // The Interceptor automatically adds the Authorization header
      final response = await DioClient.dio.get('/api/favorites');

      // Based on your JSON, the actual properties are inside 'data' -> 'apartment'
      final List rawData = response.data['data'];

      final List<Property> fetchedFavorites = rawData.map((item) {
        // Map the nested 'apartment' object
        final property = Property.fromApiJson(item['apartment']);
        // Since it's from the favorites endpoint, we know isFavorite is true
        property.isFavorite = true; 
        return property;
      }).toList();

      setState(() {
        favorites = fetchedFavorites;
      });
    } catch (e) {
      setState(() {
        errorMessage = "Failed to load favorites";
      });
      debugPrint("Fav Fetch Error: $e");
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }
 @override
Widget build(BuildContext context) {
  return SafeArea(
    child: SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 🔹 Custom App Bar (Since you already have a parent Scaffold)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
                icon: const Icon(
                  Icons.arrow_back,
                  color: SAppColors.secondaryDarkBlue,
                ),
                onPressed: () => context.pop(),
              ),
              const Text(
                "Favorites",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: SAppColors.secondaryDarkBlue,
                ),
              ),
              const SizedBox(width: 48), 
            ],
          ),

          const SizedBox(height: 24),

          // Property List
          // CONTENT STATES (Your requested logic pattern)
            if (isLoading)
              const Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 40),
                  child: CircularProgressIndicator(),
                ),
              )
            else if (errorMessage != null)
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 40),
                  child: Text(
                    errorMessage!,
                    style: const TextStyle(color: SAppColors.error),
                  ),
                ),
              )
            else if (favorites.isEmpty)
              const Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 40),
                  child: Text("No favorites found"),
                ),
              )
            else
              // PROPERTY LIST
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: favorites.length,
                separatorBuilder: (_, __) => Divider(
                  color: SAppColors.outlineGray.withValues(alpha: 0.25),
                  thickness: 1,
                  indent: 8,
                  endIndent: 8,
                ),
                itemBuilder: (context, index) {
                  final property = favorites[index];

                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: PropertyTile(
                      property: property,
                      onTap: () {
                        context.push('/detailsscreen', extra: property);
                      },
                    ),
                  );
                },
              ),
          ],
        ),
      ),
    );
}
}


