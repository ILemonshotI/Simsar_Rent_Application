import 'package:flutter/cupertino.dart';
import 'package:simsar/Theme/text_theme.dart';

import '../../models_temp/property_model.dart';

class PropertyDetailsGrid extends StatelessWidget {
  final Property property;

  const PropertyDetailsGrid({super.key, required this.property});

  Widget _item(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: STextTheme.lightTextTheme.bodyMedium),
        const SizedBox(height: 4),
        Text(value, style: STextTheme.lightTextTheme.bodyMedium),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: GridView(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          childAspectRatio: 2,
        ),
        children: [
          _item("Bedrooms", property.bedrooms.toString()),
          _item("Bathroom", property.bathrooms.toString()),
          _item("Area", "${property.areaSqft} sqft"),
          _item("Build", property.buildYear.toString()),
          _item("Parking", property.parking.toString()),
        ],
      ),
    );
  }
}
