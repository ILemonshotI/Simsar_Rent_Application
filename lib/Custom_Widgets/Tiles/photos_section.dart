import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../Theme/app_colors.dart';
import '../../utils/image_picker.dart' as picker;

class PhotosSection extends StatefulWidget {
  final List<String> initialImageUrls; // existing photos (URLs)
  final ValueChanged<List<Uint8List>> onPhotosChanged; // new photos only

  const PhotosSection({
    super.key,
    required this.initialImageUrls,
    required this.onPhotosChanged,
  });

  @override
  State<PhotosSection> createState() => _PhotosSectionState();
}


class _PhotosSectionState extends State<PhotosSection> {
  late List<String> existingPhotos;
  final List<Uint8List> newPhotos = [];

  @override
  void initState() {
    super.initState();
    existingPhotos = List.of(widget.initialImageUrls);
  }

  Future<void> _addPhoto() async {
    final Uint8List? image =
    await picker.pickImage(ImageSource.gallery);

    if (image == null) return;

    setState(() {
      newPhotos.add(image);
    });

    widget.onPhotosChanged(newPhotos);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Photos', style: theme.textTheme.labelLarge),
        const SizedBox(height: 8),
        SizedBox(
          height: 90,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: newPhotos.length +existingPhotos.length + 1,
            separatorBuilder: (_, __) => const SizedBox(width: 8),
            itemBuilder: (context, index) {
// Add photo button
if (index == existingPhotos.length + newPhotos.length) {
return GestureDetector(
onTap: _addPhoto,
child: Container(
width: 90,
decoration: BoxDecoration(
border: Border.all(color: theme.colorScheme.outline),
borderRadius: BorderRadius.circular(8),
),
child: const Icon(Icons.add),
),
);
}

    // Existing network photos
    if (index < existingPhotos.length) {
    return ClipRRect(
    borderRadius: BorderRadius.circular(8),
    child: Image.network(

    existingPhotos[index],
    width: 90,
    fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) =>
          Container(color: SAppColors.textGray, width: 90),

    ),
    );
    }

    // Newly added photos
    final newIndex = index - existingPhotos.length;
    return ClipRRect(
    borderRadius: BorderRadius.circular(8),
    child: Image.memory(
    newPhotos[newIndex],
    width: 90,
    fit: BoxFit.cover,
    ),
    );
    }


    // Photo preview



          ),
        ),
      ],
    );
  }
}
