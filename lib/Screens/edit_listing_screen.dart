import 'package:flutter/material.dart';
import 'package:simsar/models/property_model.dart';
import '../Custom_Widgets/Tiles/bedrooms_counter.dart';
import '../Custom_Widgets/Tiles/photos_section.dart';

class EditListingScreen extends StatefulWidget {
  final Property apartment;

  const EditListingScreen({super.key, required this.apartment});

  @override
  State<EditListingScreen> createState() => _EditListingScreenState();
}

class _EditListingScreenState extends State<EditListingScreen> {
  late final TextEditingController nameController;
  late final TextEditingController areaController;
  late final TextEditingController descriptionController;
  late final TextEditingController priceController;

  late int bedrooms;
  bool hasParking = false;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.apartment.title);
    areaController =
        TextEditingController(text: widget.apartment.areaSqft.toString());
    descriptionController =
        TextEditingController(text: widget.apartment.description);
    priceController =
        TextEditingController(text: widget.apartment.pricePerMonth.toString());

    bedrooms = widget.apartment.bedrooms;
   // hasParking = widget.apartment.parking;
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
    // Validate and submit
    // Call your bloc / provider / cubit / controller here
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Listing'),
        leading: const BackButton(),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PhotosSection(
              initialPhotos: widget.apartment.images,
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
      ),
    );
  }
}
