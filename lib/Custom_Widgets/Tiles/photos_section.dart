import 'dart:io';
import 'package:flutter/material.dart';
//import 'package:image_picker/image_picker.dart';

class PhotosSection extends StatefulWidget {
  final List<String> initialPhotos;
  final ValueChanged<List<String>> onPhotosChanged;

  const PhotosSection({
    super.key,
    required this.initialPhotos,
    required this.onPhotosChanged,
  });

  @override
  State<PhotosSection> createState() => _PhotosSectionState();
}

class _PhotosSectionState extends State<PhotosSection> {
 // final picker = ImagePicker();
  late List<String> photos;

  @override
  void initState() {
    super.initState();
    photos = List.of(widget.initialPhotos);
  }

  // Future<void> _addPhoto() async {
  //   final image = await picker.pickImage(source: ImageSource.gallery);
  //   if (image == null) return;
  //
  //   setState(() {
  //     photos.add(image.path);
  //   });
  //
  //   widget.onPhotosChanged(photos);
  // }

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
            itemCount: photos.length + 1,
            separatorBuilder: (_, __) => const SizedBox(width: 8),
            itemBuilder: (context, index) {
              if (index == photos.length) {
                return GestureDetector(
                  // onTap: _addPhoto,
                  child: Container(
                    width: 90,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: theme.colorScheme.outline,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(Icons.add),
                  ),
                );
              }

              return ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.file(
                  File(photos[index]),
                  width: 90,
                  fit: BoxFit.cover,
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
