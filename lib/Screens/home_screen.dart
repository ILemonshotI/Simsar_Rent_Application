import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:simsar/Custom_Widgets/Tiles/property_tile.dart';
import 'package:simsar/Custom_Widgets/Tiles/home_header.dart';
import 'package:simsar/Custom_Widgets/Text_Fields/search_field.dart';
import 'package:simsar/Models/property_model.dart';
import 'package:simsar/Theme/app_colors.dart';
import 'package:simsar/Models/filter_model.dart';
import 'package:simsar/Custom_Widgets/Tiles/filter_sheet.dart';
import 'package:simsar/Network/api_client.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  List<Property> properties = [];
  List<Property> filteredProperties = [];
  bool isLoading = false;
  String? errorMessage;

  PropertyFilter activeFilter = PropertyFilter();

  @override
  void initState() {
    super.initState();
    // Initially show all properties
    _fetchApartments();
  }

  Future<void> _fetchApartments({PropertyFilter? filter}) async {
      try {
        setState(() {
          isLoading = true;
          errorMessage = null;
        });

        final response = await DioClient.dio.get(
          '/api/apartments',
          queryParameters: {
            // Province
        if (filter?.province != null)
          'province': filter!.province!.displayName,

        // City
        if (filter?.city != null)
          'city': filter!.city!.displayName,

        // Property Types 
        if (filter?.propertyTypes.isNotEmpty == true)
          'type': filter!.propertyTypes
              .map((e) => e.displayName)
              .toList(),

        // Price range
        if (filter != null) 'min_price': filter.minPrice,
        if (filter != null) 'max_price': filter.maxPrice,
          },
        );

        final List data = response.data['data'];

        final fetchedProperties =
            data.map((e) => Property.fromApiJson(e)).toList();

        // Fetching favourites
        final favResponse = await DioClient.dio.get('/api/favorites');
        final List favData = favResponse.data['data'];

        final favIds = favData.map((item) => item['apartment_id'] as int).toSet();

        for (var property in fetchedProperties) {
          if (favIds.contains(property.id)) {
            property.isFavorite = true;
          }
        }

        setState(() {
          properties = fetchedProperties;
          filteredProperties = fetchedProperties;
        });
      } catch (e) {
        setState(() {
          errorMessage = 'Failed to load apartments';
        });
      } finally {
        setState(() {
          isLoading = false;
        });
      }
    }

  void _applyFilters(PropertyFilter newFilter) {
    setState(() {
      activeFilter = newFilter;
    });

    _fetchApartments(filter: newFilter);
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // Header
            HomeHeader(
              title: "Apartment Listings",
              onNotificationTap: () {
                debugPrint("Open notifications");
                context.push('/notifications');
              },
            ),

            const SizedBox(height: 16),

            // Search Bar
            Center(
              child: SPropertySearchBar(
                propertiesList: properties,
                onSelected: (selectedProperty) {
                  // Just print the returned property for now
                  print("Selected property: ${selectedProperty.title}");
            },
                onFilterTap: () => showFilterSheet(context, activeFilter, _applyFilters),
            ),
            ),

            const SizedBox(height: 20),

            // CONTENT STATES
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
            else if (filteredProperties.isEmpty)
              const Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 40),
                  child: Text("No apartments found"),
                ),
              )
            else
              // PROPERTY LIST
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: filteredProperties.length,
                separatorBuilder: (_, __) => Divider(
                  color: SAppColors.outlineGray.withValues(alpha: 0.25),
                  thickness: 1,
                  indent: 8,
                  endIndent: 8,
                ),
                itemBuilder: (context, index) {
                  final property = filteredProperties[index];

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

            const SizedBox(height: 30),

            // Return Button (for testing)
            Center(
              child: SizedBox(
                width: 200,
                child: ElevatedButton(
                  onPressed: () => context.go('/login'),
                  child: const Text("Return to Login"),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


