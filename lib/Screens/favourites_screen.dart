import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:simsar/Custom_Widgets/Tiles/property_tile.dart';
import 'package:simsar/Models/property_model.dart';
import 'package:simsar/Theme/app_colors.dart';
import 'package:simsar/Models/property_enums.dart';
class FavouritesScreen extends StatefulWidget {
  const FavouritesScreen({super.key});

  @override
  State<FavouritesScreen> createState() => _FavouritesScreenState();
}

class _FavouritesScreenState extends State<FavouritesScreen> {

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
