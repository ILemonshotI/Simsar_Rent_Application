import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:simsar/Network/api_client.dart';
import '../Custom_Widgets/Tiles/bedrooms_counter.dart';
import '../Custom_Widgets/Tiles/photos_section.dart';
import '../Models/property_enums.dart';
import '../utils/image_path_grabber.dart';
import '../Models/property_models.dart';

class AddListingScreen extends StatefulWidget {
  const AddListingScreen({super.key});

  @override
  State<AddListingScreen> createState() => _AddListingScreenState();
}

class _AddListingScreenState extends State<AddListingScreen> {
  // Controllers
  late final TextEditingController nameController;
  late final TextEditingController areaController;
  late final TextEditingController descriptionController;
  late final TextEditingController priceController;

  // State
  int bedrooms = 0;
  int bathrooms = 0;
  bool hasParking = false;

  Province? _selectedProvince;
  City? _selectedCity;
  PropertyType? _selectedPropertyType;

  List<Uint8List> _newPhotos = [];
  bool _submitting = false;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    areaController = TextEditingController();
    descriptionController = TextEditingController();
    priceController = TextEditingController();
  }

  @override
  void dispose() {
    nameController.dispose();
    areaController.dispose();
    descriptionController.dispose();
    priceController.dispose();
    super.dispose();
  }

  Future<void> _confirm() async {
    if (_submitting) return;

    // 🔒 Hard validation (do not weaken this)
    if (_selectedProvince == null ||
        _selectedCity == null ||
        _selectedPropertyType == null ||
        _newPhotos.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please complete all required fields')),
      );
      return;
    }

    setState(() => _submitting = true);

    try {
      // 1️⃣ Upload images
      final imagePaths = await ImagePathGrabber.uploadImages(
        images: _newPhotos,
      );

      // 2️⃣ Create listing
      await DioClient.dio.post(
        '/api/apartments',
        data: {
          'title': nameController.text.trim(),
          'area': int.parse(areaController.text),
          'description': descriptionController.text.trim(),
          'price_per_day': double.parse(priceController.text),
          'rooms': bedrooms,
          'bathrooms': bathrooms,
          'parking': hasParking,
          'images': imagePaths,
          'type': _selectedPropertyType!.displayName,
          'province': _selectedProvince!.displayName,
          'city': _selectedCity!.displayName,
          'build_year': 1970,
        },
      );

      if (!mounted) return;
     // context.go('/admin-approval');

    } catch (e) {
      debugPrint('Add listing failed: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to create listing')),
      );
    } finally {
      if (mounted) setState(() => _submitting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Listing'),
        leading: const BackButton(),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PhotosSection(
              initialImageUrls: const [],
              onPhotosChanged: (photos) => _newPhotos = photos,
            ),

            const SizedBox(height: 24),

            Text('Name', style: theme.textTheme.labelLarge),
            const SizedBox(height: 6),
            TextField(controller: nameController),

            const SizedBox(height: 16),

            Text('Number of Bedrooms', style: theme.textTheme.labelLarge),
            const SizedBox(height: 6),
            BedroomsCounter(
              value: bedrooms,
              onChanged: (val) => setState(() => bedrooms = val),
            ),

            const SizedBox(height: 16),

            Text('Number of Bathrooms', style: theme.textTheme.labelLarge),
            const SizedBox(height: 6),
            BedroomsCounter(
              value: bathrooms,
              onChanged: (val) => setState(() => bathrooms = val),
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
              title: Text('Parking Available', style: theme.textTheme.bodyLarge),
              value: hasParking,
              onChanged: (v) => setState(() => hasParking = v),
            ),

            const SizedBox(height: 6),
            Text('Province', style: theme.textTheme.labelLarge),
            const SizedBox(height: 6),

            DropdownButtonFormField<Province>(
              initialValue: _selectedProvince,
              items: Province.values
                  .map((p) => DropdownMenuItem(
                value: p,
                child: Text(p.name.toUpperCase()),
              ))
                  .toList(),
              onChanged: (p) {
                setState(() {
                  _selectedProvince = p;
                  _selectedCity = null;
                });
              },
            ),

            const SizedBox(height: 12),
            Text('City', style: theme.textTheme.labelLarge),
            const SizedBox(height: 6),

            DropdownButtonFormField<City>(
              initialValue: _selectedCity,
              items: _selectedProvince == null
                  ? []
                  : City.getByProvince(_selectedProvince!)
                  .map((c) => DropdownMenuItem(
                value: c,
                child: Text(c.name.toUpperCase()),
              ))
                  .toList(),
              onChanged: _selectedProvince == null
                  ? null
                  : (c) => setState(() => _selectedCity = c),
            ),

            const SizedBox(height: 12),
            Text('Property Type', style: theme.textTheme.labelLarge),
            const SizedBox(height: 6),

            DropdownButtonFormField<PropertyType>(
              initialValue: _selectedPropertyType,
              items: PropertyType.values
                  .map((t) => DropdownMenuItem(
                value: t,
                child: Text(t.name.toUpperCase()),
              ))
                  .toList(),
              onChanged: (t) => setState(() => _selectedPropertyType = t),
            ),

            const SizedBox(height: 24),

            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: _submitting ? null : _confirm,
                child: _submitting
                    ? const CircularProgressIndicator()
                    : const Text('Create Listing'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
