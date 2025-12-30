import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:simsar/Models/property_model.dart';
import 'package:simsar/Theme/app_colors.dart';
import 'package:simsar/Models/property_enums.dart';
import 'dart:typed_data';
import 'package:simsar/Theme/text_theme.dart';
import 'package:simsar/Custom_Widgets/Tiles/profile_tile.dart';
class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Uint8List? profilePhoto; 
  String profileName = "Profile Name";
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
                "Profile",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: SAppColors.secondaryDarkBlue,
                ),
              ),
              const SizedBox(width: 48), 
            ],
          ),

          const SizedBox(height: 48),
          Center(
            child: Column(
              children: [
                CircleAvatar(
              radius: 70,
              backgroundColor: SAppColors.white,
              backgroundImage: profilePhoto != null
                  ? MemoryImage(profilePhoto!) as ImageProvider
                : const AssetImage('assets/images/profile_placeholder.png'),
            // Optional: Add a foreground image or child if you want to overlay something
            onBackgroundImageError: (exception, stackTrace) {
            debugPrint("Error loading profile image: $exception");
          },
            ),
                const SizedBox(height: 16),
                 Text(
                  profileName,
                  style: STextTheme.lightTextTheme.titleMedium!.copyWith(fontWeight: FontWeight.w600, color: SAppColors.secondaryDarkBlue),
                ),
                const SizedBox(height: 48),
                ProfileTile(
                icon: Icons.person,
                title: 'Profile Details',
                route: '/edit-profile',
                ),
                SizedBox(height: 20),

                ProfileTile(
                  icon: Icons.info_outline,
                  title: 'About',
                  route: '/about',
                ),
                SizedBox(height: 20),

                ProfileTile(
                  icon: Icons.account_balance_wallet_outlined,
                  title: 'Wallet',
                  route: '/wallet',
                ),
          ],
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
