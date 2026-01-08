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

    return SizedBox(
      width: 327, 
      
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
                Icons.location_city,
                size: 26,
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