import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:simsar/Custom_Widgets/Tiles/property_tile.dart';
import 'package:simsar/Models/property_model.dart';
import 'package:simsar/Theme/app_colors.dart';
import 'package:simsar/Custom_Widgets/Tiles/home_header.dart';
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
   
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Inside HomeScreen Column children:
            HomeHeader(
              title: "Apartment Listings",
              onNotificationTap: () {
                print("Open notifications");
              },
            ),
            const SizedBox(height: 20),

            // 2. IMPLEMENTATION: The scrolling list of apartments
            ListView.separated(
              shrinkWrap: true, // Allows the list to take only needed space
              physics: const NeverScrollableScrollPhysics(), // Disables nested scrolling
              itemCount: properties.length,
              separatorBuilder: (context, index) => Divider(
                color: SAppColors.outlineGray.withValues(alpha: 0.25), // Light gray color
                thickness: 1,       
                indent: 8,   
                endIndent: 8,                 
              ),
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 8.0), // Adds spacing between cards
                  child: PropertyTile(property: properties[index]),
                );
              },
            ),

            const SizedBox(height: 30),
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
  location: "Yafour Street No.47, RW.001",
  pricePerMonth: 120.0,
  images: ["assets/images/yafour_villa.jpg"],
  bedrooms: 2,
  bathrooms: 1,
  areaSqft: 450,
  buildYear: 2021,
  parking: "Yes",
  status: "Active",
  description: "A cozy place to stay.",
  agent: Agent(name: "John", avatarUrl: "", role: "Owner"),
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
      dummyProperty, // Duplicate for demonstration
      dummyProperty, 
    ];