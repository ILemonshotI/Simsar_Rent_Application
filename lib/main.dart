import 'package:flutter/material.dart';
import 'package:simsar/Screens/edit_listing_screen.dart';
import 'package:simsar/Screens/login_screen.dart';
import 'package:simsar/Screens/register_screen.dart';
import 'package:simsar/Theme/app_theme.dart';
import 'package:simsar/Custom_Widgets/Buttons/primary_button.dart';
import 'package:simsar/Custom_Widgets/Text_Fields/text_field.dart';
import 'package:simsar/Custom_Widgets/Text_Fields/password_field.dart';
import 'package:simsar/Custom_Widgets/Buttons/checkbox.dart';
import 'package:simsar/Custom_Widgets/Tiles/login_header.dart';
import 'package:simsar/Custom_Widgets/Text_Fields/date_of_birth_field.dart';
import 'models/property_model.dart';
import 'screens/details_screen.dart';
final demoAgent = Agent(
  name: "laith",
  avatarUrl: "",
  role: "",
);
final demoReview = Review(
    reviewerName: "Laith al3llak",
    reviewerAvatar: "",
    rating:5,
    text: "");

final demoProperty = Property(
  title: 'House of Mormon',
  location: 'Denpasar, Bali',
  pricePerMonth: 310,
// add images attribute
  bedrooms: 3,
  bathrooms: 2,
  buildYear: 2020,
  parking: 'Indoor',
  status: 'For Rent',
  description: 'Lorem ipsum is simply dummy text of the printing and typesetting industry.', images: [], areaSqft: 400, agent:demoAgent , reviewsCount: 32, featuredReview:demoReview ,
);



void main() {
  runApp(const MyApp());
}

  @override

class MyApp extends StatelessWidget {

  const MyApp({super.key});

  @override

  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: SAppTheme.lightTheme,
      darkTheme: SAppTheme.darkTheme,
      themeMode: ThemeMode.system,
      // Just call LoginScreen here. Don't add Scaffold/Center here.
      home: EditListingScreen(apartment: demoProperty),
    );
  }
}

// End of the code