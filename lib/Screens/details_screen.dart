
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../Custom_Widgets/Buttons/primary_button.dart';
import '../Custom_Widgets/Tiles/agent_section.dart';
import '../Custom_Widgets/Tiles/description_section.dart';
import '../Custom_Widgets/Tiles/details_header.dart';
import '../Custom_Widgets/Tiles/property_details_grid.dart';
import '../Custom_Widgets/Tiles/reviews_section.dart';
import '../Custom_Widgets/Tiles/image_carousel.dart';
import '../Network/api_client.dart';
import '../Theme/app_colors.dart';
import '../models_temp/property_model.dart';

class PropertyDetailsScreen extends StatelessWidget {
  final int propertyId;

  const PropertyDetailsScreen({
    super.key,
    required this.propertyId,
  });

  Future<Property> fetchProperty(int propertyId) async {
    print('/api/apartments/$propertyId');
    print('BASE URL: ${DioClient.dio.options.baseUrl}');
    final response = await DioClient.dio.get('/api/apartments/2');
    print('REQUEST URL: ${response.requestOptions.uri}');


    // Adapt fromJson according to your Property model
    return Property.fromJson(response.data);
  }

  Future<List<Review>> fetchReviews(int propertyId) async {
    final response = await DioClient.dio.get('/api/apartments/$propertyId/reviews');

    final List data = response.data['data'] ?? [];
    return data.map((e) => Review.fromJson(e)).toList();
  }


  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Property>(
      future: fetchProperty(propertyId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (snapshot.hasError) {
          return Scaffold(
            body: Center(
              child: Text('Error loading property: ${snapshot.error}'),
            ),
          );
        }

        final property = snapshot.data!;


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
                      FutureBuilder<List<Review>>(
                        future: fetchReviews(property.id),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return const Center(child: CircularProgressIndicator());
                          }

                          if (snapshot.hasError) {
                            return Center(
                              child: Text('Error loading reviews: ${snapshot.error}'),
                            );
                          }

                          final reviews = snapshot.data ?? [];

                          return ReviewsSection(
                            reviewsCount: reviews.length,
                            reviews: reviews,
                          );
                        },
                      ),

                    ],
                  ),
                ),
              ),
              SPrimaryButton(
                text: "Rent Now",
                onPressed: () {
                  context.push(
                    '/booking-summary/$propertyId',

                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
