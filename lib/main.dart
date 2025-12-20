import 'package:flutter/material.dart';
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

final demoProperty = PropertyModel(
  title: 'House of Mormon',
  location: 'Denpasar, Bali',
  pricePerMonth: 310,
  heroImage: 'https://images.unsplash.com/photo-1600585154340-be6161a56a0c',
  gallery: [
    'https://images.unsplash.com/photo-1568605114967-8130f3a36994',
    'https://images.unsplash.com/photo-1572120360610-d971b9d7767c',
    'https://images.unsplash.com/photo-1580587771525-78b9dba3b914',
  ],
  bedrooms: 3,
  bathrooms: 2,
  buildYear: 2020,
  parking: 'Indoor',
  status: 'For Rent',
  area: '1,880 sqft',
  description:
  'Lorem ipsum is simply dummy text of the printing and typesetting industry.',
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
      home: DetailsScreen(property: demoProperty),
    );
  }
}

// End of the code file