import 'package:flutter/material.dart';

class HeroImage extends StatelessWidget {
  final String imageUrl;
  const HeroImage({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Image.network(
        imageUrl,
        height: 220,
        width: double.infinity,
        fit: BoxFit.cover,
      ),
    );
  }
}
