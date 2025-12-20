import 'package:flutter/material.dart';

class ImageThumbnails extends StatelessWidget {
  final List<String> images;

  const ImageThumbnails({super.key, required this.images});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: images.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              images[index],
              width: 70,
              height: 70,
              fit: BoxFit.cover,
            ),
          );
        },
      ),
    );
  }
}
