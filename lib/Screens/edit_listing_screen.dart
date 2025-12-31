import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:simsar/models_temp/property_model.dart';
import '../Custom_Widgets/Tiles/bedrooms_counter.dart';
import '../Custom_Widgets/Tiles/photos_section.dart';

class EditListingScreen extends StatefulWidget {
  final int id;

  const EditListingScreen({
    super.key,
    required this.id,
  });

  @override
  State<EditListingScreen> createState() => _EditListingScreenState();
}

class _EditListingScreenState extends State<EditListingScreen> {
  final Dio _dio = Dio();

  late Future<Property> _propertyFuture;

  // Controllers
  late TextEditingController nameController;
  late TextEditingController areaController;
  late TextEditingController descriptionController;
  late TextEditingController priceController;

  int bedrooms = 0;
  bool hasParking = false;

  @override
  void initState() {
    super.initState();
    _propertyFuture = _fetchProperty();
  }

  Future<Property> _fetchProperty() async {
    final response = await _dio.get(
      '/api/properties/${widget.id}',
    );

    final property = Property.fromJson(response.data);

    // Initialize controllers ONCE data exists
    nameController = TextEditingController(text: property.title);
    areaController =
        TextEditingController(text: property.areaSqft.toString());
    descriptionController =
        TextEditingController(text: property.description);
    priceController =
        TextEditingController(text: property.pricePerDay.toString());

    bedrooms = property.bedrooms;
    // hasParking = property.parking;

    return property;
  }

  @override
  void dispose() {
    nameController.dispose();
    areaController.dispose();
    descriptionController.dispose();
    priceController.dispose();
    super.dispose();
  }

  void _confirm() {
    // Validate + submit updated data
    // PUT /api/properties/:id
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Listing'),
        leading: const BackButton(),
      ),
      body: FutureBuilder<Property>(
        future: _propertyFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
              child: Text(
                'Failed to load listing',
                style: theme.textTheme.bodyLarge,
              ),
            );
          }

          final property = snapshot.data!;
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                PhotosSection(
                  initialImageUrls: property.images,
                  onPhotosChanged: (photos) {
                    // update photos list
                  },
                ),

                const SizedBox(height: 24),

                Text('Name', style: theme.textTheme.labelLarge),
                const SizedBox(height: 6),
                TextField(
                  controller: nameController,
                  textInputAction: TextInputAction.next,
                ),

                const SizedBox(height: 16),

                Text('Number of Bedrooms', style: theme.textTheme.labelLarge),
                const SizedBox(height: 6),
                BedroomsCounter(
                  value: bedrooms,
                  onChanged: (val) => setState(() => bedrooms = val),
                ),

                const SizedBox(height: 16),

                Text('Total Area (m²)', style: theme.textTheme.labelLarge),
                const SizedBox(height: 6),
                TextField(
                  controller: areaController,
                  keyboardType: TextInputType.number,
                ),

                const SizedBox(height: 16),

                Text('Price', style: theme.textTheme.labelLarge),
                const SizedBox(height: 6),
                TextField(
                  controller: priceController,
                  keyboardType: TextInputType.number,
                ),

                const SizedBox(height: 16),

                Text('Description', style: theme.textTheme.labelLarge),
                const SizedBox(height: 6),
                TextField(
                  controller: descriptionController,
                  maxLines: 4,
                ),

                const SizedBox(height: 16),

                SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(
                    'Parking Available',
                    style: theme.textTheme.bodyLarge,
                  ),
                  value: hasParking,
                  onChanged: (v) => setState(() => hasParking = v),
                ),

                const SizedBox(height: 24),

                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    onPressed: _confirm,
                    child: const Text('Confirm Listing'),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
