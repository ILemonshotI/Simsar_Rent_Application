import 'package:flutter/material.dart';
import 'package:simsar/Theme/text_theme.dart';
class OwnerHomeHeader extends StatelessWidget {
  final String title;
  final String description;
  
  
  const OwnerHomeHeader({
    required this.title, 
    required this.description, 
    super.key,
  });
    

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return SizedBox(
      width: 327, // Keep your Figma width
      
      child:Column(
        mainAxisSize: MainAxisSize.min, 
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [              
              Text(
                title,
                style: STextTheme.lightTextTheme.titleLarge!
                    .copyWith(fontWeight: FontWeight.w800),
              ),
              const SizedBox(width: 16),
              const Icon(
                Icons.home_outlined,
                size: 24,
              ),
            ],
          ),
          const SizedBox(height: 8), 
          Text(
            description,
            textAlign: TextAlign.left,
            style: STextTheme.lightTextTheme.bodyMedium!.copyWith(fontSize: 14),
          ),
        ],
      ),
    );
  }
}