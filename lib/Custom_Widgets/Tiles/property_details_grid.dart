import 'package:flutter/material.dart';
import '../../models/property_model.dart';
import 'detail_item.dart';

class PropertyDetailsGrid extends StatelessWidget {
  final PropertyModel property;

  const PropertyDetailsGrid({super.key, required this.property});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 3,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        DetailItem(icon: Icons.bed, label: 'Bedrooms', value: '${property.bedrooms}'),
        DetailItem(icon: Icons.bathtub, label: 'Bathub', value: '${property.bathrooms}'),
        DetailItem(icon: Icons.square_foot, label: 'Area', value: property.area),
        DetailItem(icon: Icons.calendar_today, label: 'Build', value: '${property.buildYear}'),
        DetailItem(icon: Icons.local_parking, label: 'Parking', value: property.parking),
        DetailItem(icon: Icons.home, label: 'Status', value: property.status),
      ],
    );
  }
}
