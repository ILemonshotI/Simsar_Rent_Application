import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:simsar/Network/api_client.dart';
import 'package:simsar/Models/property_model.dart';
import '../Custom_Widgets/Tiles/bedrooms_counter.dart';
import '../Custom_Widgets/Tiles/photos_section.dart';
import '../Models/property_enums.dart';
import '../utils/image_path_grabber.dart'; // <-- uploadPhoto util

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
  late Future<Property> _propertyFuture;
  Province? _selectedProvince;
  City? _selectedCity;
  PropertyType? _selectedPropertyType;
  // Controllers
  late TextEditingController nameController;
  late TextEditingController areaController;
  late TextEditingController descriptionController;
  late TextEditingController priceController;

  int bedrooms = 0;
  int bathrooms = 0;
  bool hasParking = false;

  // 🔹 Photo state
  List<Uint8List> _newPhotos = [];
  bool _uploadingPhotos = false;

  @override
  void initState() {
    super.initState();
    _propertyFuture = _fetchProperty();
  }

  Future<Property> _fetchProperty() async {
    final response = await DioClient.dio.get(
      '/api/apartments/${widget.id}',
    );

    final property = Property.fromApiJson(response.data);

    nameController = TextEditingController(text: property.title);
    areaController =
        TextEditingController(text: property.areaSqft.toString());
    descriptionController =
        TextEditingController(text: property.description);
    priceController =
        TextEditingController(text: property.pricePerDay.toString());

    bedrooms = property.bedrooms;
    hasParking = property.parking;

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

  Future<void> _confirm() async {
    if (_uploadingPhotos) return;

    setState(() => _uploadingPhotos = true);

    try {
      final property = await _propertyFuture;

      // 1️⃣ Upload new photos if any
      List<String> uploadedPaths = [];
      if (_newPhotos.isNotEmpty) {
        uploadedPaths = await ImagePathGrabber.uploadImages(images: _newPhotos);
      }

      // 2️⃣ Merge existing + newly uploaded
      final List<String> finalImages = [
        ...property.images,
        ...uploadedPaths,
      ];

      // 3️⃣ Submit update
      await DioClient.dio.put(
        '/api/apartments/${widget.id}',
        data: {
          'title': nameController.text.trim(),
          'area': int.parse(areaController.text),
          'description': descriptionController.text.trim(),
          'price_per_day': double.parse(priceController.text),
          'rooms': bedrooms,
          'parking': hasParking,
          'images': finalImages,
          'type': _selectedPropertyType!.displayName,
          'province': _selectedProvince!.displayName,
          'city': _selectedCity!.displayName,
          'bathrooms': bathrooms,
          'build_year':1970,


        },
      );

      if (!mounted) return;

      context.push('/admin-approval');

    } catch (e) {
      debugPrint('Edit listing failed: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to update listing')),
      );
    } finally {
      if (mounted) {
        setState(() => _uploadingPhotos = false);
      }
    }
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
                    _newPhotos = photos;
                  },
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

                const SizedBox(height: 6),
                Text('Province', style: theme.textTheme.labelLarge),
                const SizedBox(height: 6),

                DropdownButtonFormField<Province>(
                  initialValue: _selectedProvince,
                  items: Province.values.map((province) {
                    return DropdownMenuItem(
                      value: province,
                      child: Text(province.name.toUpperCase()),
                    );
                  }).toList(),
                  onChanged: (province) {
                    setState(() {
                      _selectedProvince = province;
                      _selectedCity = null; // reset city
                    });
                  },
                ),

                Text('City', style: theme.textTheme.labelLarge),
                const SizedBox(height: 6),

                DropdownButtonFormField<City>(
                  initialValue: _selectedCity,
                  items: _selectedProvince == null
                      ? []
                      : City.getByProvince(_selectedProvince)
                      .map((city) => DropdownMenuItem(
                    value: city,
                    child: Text(city.name.toUpperCase()),
                  ))
                      .toList(),
                  onChanged: _selectedProvince == null
                      ? null
                      : (city) {
                    setState(() => _selectedCity = city);
                  },
                ),

                const SizedBox(height: 6),
                Text('Property Type', style: theme.textTheme.labelLarge),
                const SizedBox(height: 6),

                DropdownButtonFormField<PropertyType>(
                  initialValue: _selectedPropertyType,
                  items: PropertyType.values.map((propertyType) {
                    return DropdownMenuItem(
                      value: propertyType,
                      child: Text(propertyType.name.toUpperCase()),
                    );
                  }).toList(),
                  onChanged: (propertyType) {
                    setState(() {
                      _selectedPropertyType = propertyType;
                    });
                  },
                ),

                const SizedBox(height: 24),

                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    onPressed: _uploadingPhotos ? null : _confirm,
                    child: _uploadingPhotos
                        ? const CircularProgressIndicator()
                        : const Text('Confirm Listing'),
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
