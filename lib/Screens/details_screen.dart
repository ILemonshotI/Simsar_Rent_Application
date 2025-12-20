import 'package:flutter/material.dart';
import '../Custom_Widgets/Tiles/hero_image.dart';
import '../Custom_Widgets/Tiles/image_thumbnails.dart';
import '../Custom_Widgets/Tiles/property_details_grid.dart';
import '../models/property_model.dart';

class DetailsScreen extends StatelessWidget {
  final PropertyModel property;
  const DetailsScreen({super.key, required this.property});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 100),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                HeroImage(imageUrl: property.heroImage),
                const SizedBox(height: 12),
                ImageThumbnails(images: property.gallery),
                const SizedBox(height: 16),
                _titleAndPrice(),
                const SizedBox(height: 24),
                PropertyDetailsGrid(property: property),
                const SizedBox(height: 24),
                _description(),
              ],
            ),
          ),
          _rentButton(),
        ],
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.black),
        onPressed: () {},
      ),
      title:  Text(
        property.title,
        style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
      ),
      centerTitle: true,
      actions: [
        IconButton(
          icon: const Icon(Icons.favorite_border, color: Colors.black),
          onPressed: () {},
        ),
      ],
    );
  }

  Widget _titleAndPrice() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                'House of Mormon',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 6),
              Row(
                children: [
                  Icon(Icons.location_on, size: 14, color: Colors.grey),
                  SizedBox(width: 4),
                  Text(
                    'Denpasar, Bali',
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ],
          ),
        ),
        const Text(
          '\$310 / month',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.blue,
          ),
        ),
      ],
    );
  }

  Widget _description() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text(
          'Description',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        SizedBox(height: 8),
        Text(
          'Lorem ipsum is simply dummy text of the printing and typesetting industry. '
              'Lorem ipsum has been the industry’s standard dummy text ever since the 1500s.',
          style: TextStyle(color: Colors.grey),
        ),
      ],
    );
  }

  Widget _rentButton() {
    return Positioned(
      left: 0,
      right: 0,
      bottom: 0,
      child: Container(
        padding: const EdgeInsets.all(16),
        color: Colors.white,
        child: SizedBox(
          height: 50,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            onPressed: () {},
            child: const Text(
              'Rent now',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ),
        ),
      ),
    );
  }
}
