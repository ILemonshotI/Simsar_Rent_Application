import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:simsar/Custom_Widgets/Tiles/property_tile.dart';
import 'package:simsar/Custom_Widgets/Tiles/home_header.dart';
import 'package:simsar/Custom_Widgets/Text_Fields/search_field.dart';
import 'package:simsar/Models/property_model.dart';
import 'package:simsar/Theme/app_colors.dart';
import 'package:simsar/Models/filter_model.dart';
import 'package:simsar/Custom_Widgets/Tiles/filter_sheet.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  late List<Property> filteredProperties;
  PropertyFilter activeFilter = PropertyFilter();

  @override
  void initState() {
    super.initState();
    // Initially show all properties
    filteredProperties = List.from(properties);
  }

void _applyFilters(PropertyFilter newFilter) {
    setState(() {
      activeFilter = newFilter;
      filteredProperties = properties.where((p) {
        // 1. Filter by Location
        final matchesLocation = activeFilter.location == null || p.province == activeFilter.location;
        // 2. Filter by Price
        final matchesPrice = p.pricePerDay >= activeFilter.minPrice && p.pricePerDay <= activeFilter.maxPrice;
        // 3. Filter by Type (Assuming your Property model has a 'type' field)
        // final matchesType = activeFilter.propertyTypes.isEmpty || activeFilter.propertyTypes.contains(p.type);

        return matchesLocation && matchesPrice;
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // 🔹 Header
            HomeHeader(
              title: "Apartment Listings",
              onNotificationTap: () {
                debugPrint("Open notifications");
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

            // Property List
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: filteredProperties.length,
              separatorBuilder: (context, index) => Divider(
                color: SAppColors.outlineGray.withValues(alpha: 0.25),
                thickness: 1,
                indent: 8,
                endIndent: 8,
              ),
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: PropertyTile(
                    property: filteredProperties[index],
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


final dummyProperty = Property(
  title: "Yafour Villa",
  province: "Damascus",
  city: "Yafour Street No.47, RW.001",
  pricePerDay: 120.0,
  images: ["assets/images/yafour_villa.jpg"],
  bedrooms: 2,
  bathrooms: 1,
  areaSqft: 450,
  buildYear: 2021,
  parking: true,
  status: "Active",
  description: "A cozy place to stay.",
  agent: Agent(
    name: "John",
    avatarUrl: "",
    role: "Owner",
  ),
  reviewsCount: 10,
  featuredReview: Review(
    reviewerName: "Sam",
    reviewerAvatar: "",
    rating: 4,
    text: "Loved it!",
  ),
);

final List<Property> properties = [
  dummyProperty,
  dummyProperty,
  dummyProperty,
  dummyProperty,
  dummyProperty,
  dummyProperty,
  dummyProperty,
  dummyProperty,
  dummyProperty,
  dummyProperty,
];

