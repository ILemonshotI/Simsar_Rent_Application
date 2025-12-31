import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:simsar/Custom_Widgets/Tiles/property_tile.dart';
import 'package:simsar/Custom_Widgets/Tiles/home_header.dart';
import 'package:simsar/Custom_Widgets/Text_Fields/search_field.dart';

import 'package:simsar/models_temp/property_model.dart';
import 'package:simsar/Theme/app_colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  late List<Property> filteredProperties;

  @override
  void initState() {
    super.initState();
    // Initially show all properties
    filteredProperties = List.from(properties);
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
                sourceList: dummyPropertyNames,
                onSelected: (selectedName) {
                  // Just print the returned string for now
                  print("Selected property: $selectedName");
            },
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

                      context.push('/details/${filteredProperties[index].id}');
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
final dummyProperty = Property(
  id: 2,
  title: "Yafour Villa",
  province: "Yafour Street No.47, RW.001",
  city: "Damascus",
  rating:4,
  pricePerDay: 120.0,
  images: ["assets/images/yafour_villa.jpg"],
  bedrooms: 2,
  bathrooms: 1,
  areaSqft: 450,
  buildYear: 2021,
  parking: true,
  description: "A cozy place to stay.",
  agent: Agent(
    id: 1,
    name: "John",
    avatarUrl: "",
    role: "Owner",
  ),
  reviewsCount: 10,

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
final List<String> dummyPropertyNames = [
  "Yafour Villa",
  "Damascus City Apartment",
  "Luxury Apartment in Mezzeh",
  "Modern Studio – Abu Rummaneh",
  "Family House in Kafr Sousa",
  "Sea View Apartment",
  "Downtown Flat",
  "Garden Villa",
  "Furnished Studio",
  "Penthouse Apartment",
];
