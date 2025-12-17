import 'package:flutter/material.dart';
class LoginHeader extends StatelessWidget {
  final String title;
  final String description;
  
  
  const LoginHeader({
    required this.title, 
    required this.description, 
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return SizedBox(
      width: 327, // Keep your Figma width
      child: Column(
        mainAxisSize: MainAxisSize.min, 
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            textAlign: TextAlign.left,
            style: textTheme.headlineMedium, // Adjusted for better hierarchy
          ),
          const SizedBox(height: 8), 
          Text(
            description,
            textAlign: TextAlign.left,
            style: textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}