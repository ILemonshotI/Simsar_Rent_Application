import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:simsar/Custom_Widgets/Tiles/property_tile.dart';
import 'package:simsar/Models/property_model.dart';
import 'package:simsar/Theme/app_colors.dart';
import 'package:simsar/Models/filter_model.dart';
import 'package:simsar/Models/property_enums.dart';
import 'package:simsar/Custom_Widgets/Tiles/owner_home_header.dart';
class OwnerHomeScreen extends StatefulWidget {
  const OwnerHomeScreen({super.key});

  @override
  State<OwnerHomeScreen> createState() => _OwnerHomeScreenState();
}

class _OwnerHomeScreenState extends State<OwnerHomeScreen> {
  late List<Property> filteredProperties;
  PropertyFilter activeFilter = PropertyFilter();

  @override
  void initState() {
    super.initState();
    filteredProperties = List.from(properties);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [

          // 🔹 Scrollable content
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 90), // space for button
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                OwnerHomeHeader(
                  title: "Your Listed Properties",
                  description: "Manage your property listings and view bookings.",
                ),

                const SizedBox(height: 16),

                const SizedBox(height: 20),

                Expanded(
                  child: ListView.separated(
                    itemCount: filteredProperties.length,
                    separatorBuilder: (context, index) => Divider(
                      color: SAppColors.outlineGray.withValues(alpha: 0.25),
                      thickness: 1,
                    ),
                    itemBuilder: (context, index) {
                      return PropertyTile(
                        property: filteredProperties[index],
                        onTap: () {
                          context.push(
                            '/owner-property-details',
                            extra: filteredProperties[index],
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),

          // 🔹 Fixed bottom button
          Positioned(
            left: 16,
            right: 16,
            bottom: 12, // above BottomNavigationBar
            child: SizedBox(
              height: 48,
              child: ElevatedButton(
                onPressed: () => context.go('/add-a-listing'),
                child: const Text("Add a Listing"),
              ),
            ),
          ),
        ],
      ),
    );
  }
}



final List<Property> properties = [
  // 1. A Luxury Villa in Rif Dimashq
  Property(
    id: 1,
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
    reviewsAvgRating: 4.8,
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
    id: 2,
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
    reviewsAvgRating: 4.2,
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
    id: 3,
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
    reviewsAvgRating: 4.7,
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
