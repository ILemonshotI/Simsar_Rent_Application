import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Custom_Widgets/Buttons/primary_button.dart';
import '../Custom_Widgets/Tiles/agent_section.dart';
import '../Custom_Widgets/Tiles/description_section.dart';
import '../Custom_Widgets/Tiles/details_header.dart';
import '../Custom_Widgets/Tiles/property_details_grid.dart';
import '../Custom_Widgets/Tiles/reviews_section.dart';
import '../Theme/app_colors.dart';
import '../models/property_model.dart';
import '../Custom_Widgets/Tiles/image_carousel.dart';
class PropertyDetailsScreen extends StatelessWidget {
  final Property property;


  const PropertyDetailsScreen({
    super.key,
    required this.property,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SAppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: const BackButton(),
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite_border),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.only(bottom: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ImageCarousel(images: property.images),
                  const SizedBox(height: 16),
                  HeaderSection(property: property),
                  const SizedBox(height: 16),
                  PropertyDetailsGrid(property: property),
                  const SizedBox(height: 16),
                  DescriptionSection(description: property.description),
                  const SizedBox(height: 16),
                  AgentSection(agent: property.agent),
                  const SizedBox(height: 16),
                  ReviewsSection(
                    reviewsCount: property.reviewsCount,
                    review: property.featuredReview,
                  ),
                ],
              ),
            ),
          ),
          SPrimaryButton(
          text: "Rent Now",
    ),
        ],
      ),
    );
  }
}
