import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:simsar/Custom_Widgets/Tiles/property_tile.dart';
import 'package:simsar/Custom_Widgets/Tiles/home_header.dart';
import 'package:simsar/Custom_Widgets/Text_Fields/search_field.dart';
import 'package:simsar/Models/property_model.dart';
import 'package:simsar/Theme/app_colors.dart';
import 'package:simsar/Models/filter_model.dart';
import 'package:simsar/Custom_Widgets/Tiles/filter_sheet.dart';
import 'package:simsar/Models/property_enums.dart';
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
        // 1. Filter by Province
        final matchesProvince = activeFilter.province == null || p.province == activeFilter.province;
        // 2. Filter by City
        final matchesCity = activeFilter.city == null || p.city == activeFilter.city;
        // 3. Filter by Type
        final matchesType = activeFilter.propertyTypes.isEmpty || 
                    activeFilter.propertyTypes.contains(p.propertyType);
        // 4. Filter by Price
        final matchesPrice = p.pricePerDay >= activeFilter.minPrice && p.pricePerDay <= activeFilter.maxPrice;

        return matchesProvince && matchesCity && matchesType && matchesPrice;
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
                    onTap: () {
                      // Navigate to details and pass the property object
                      context.push('/detailsscreen', extra: filteredProperties[index]);
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


final List<Property> properties = [
  // 1. A Luxury Villa in Rif Dimashq
  Property(
    title: "Modern Yafour Estate",
    province: Province.rifdimashq,
    city: City.yafour,
    propertyType: PropertyType.villa,
    pricePerDay: 450.0,
    images: ["assets/images/yafour_villa.jpg"],
    bedrooms: 5,
    bathrooms: 4,
    areaSqft: 1200,
    buildYear: 2022,
    parking: true,
    status: "Available",
    description: "An elegant villa with a private garden and high-end finishes.",
    agent: Agent(name: "Omar", avatarUrl: "", role: "Premier Agent"),
    reviewsCount: 15,
    featuredReview: Review(
      reviewerName: "Laila",
      reviewerAvatar: "",
      rating: 5,
      text: "Absolutely stunning location and very private.",
    ),
  ),

  // 2. A Cozy Apartment in Damascus
  Property(
    title: "Charming Mouhajrin Flat",
    province: Province.damascus,
    city: City.mouhajrin,
    propertyType: PropertyType.apartment,
    pricePerDay: 85.0,
    images: ["assets/images/yafour_villa.jpg"],
    bedrooms: 2,
    bathrooms: 1,
    areaSqft: 95,
    buildYear: 2015,
    parking: false,
    status: "Available",
    description: "Authentic Damascus living with a great view of the city.",
    agent: Agent(name: "Sami", avatarUrl: "", role: "Owner"),
    reviewsCount: 8,
    featuredReview: Review(
      reviewerName: "Hasan",
      reviewerAvatar: "",
      rating: 4,
      text: "Great location, very close to the market.",
    ),
  ),

  // 3. A Seaside Penthouse in Latakia
  Property(
    title: "Blue Wave Penthouse",
    province: Province.latakia,
    city: City.alkournish,
    propertyType: PropertyType.penthouse,
    pricePerDay: 210.0,
    images: ["assets/images/yafour_villa.jpg"],
    bedrooms: 3,
    bathrooms: 2,
    areaSqft: 250,
    buildYear: 2019,
    parking: true,
    status: "Available",
    description: "Spacious penthouse overlooking the Mediterranean Sea.",
    agent: Agent(name: "Maya", avatarUrl: "", role: "Broker"),
    reviewsCount: 22,
    featuredReview: Review(
      reviewerName: "Zaid",
      reviewerAvatar: "",
      rating: 5,
      text: "The sunset from the balcony is worth every penny.",
    ),
  ),
];
