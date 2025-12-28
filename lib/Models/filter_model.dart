import 'package:simsar/Models/property_enums.dart';
class PropertyFilter {
  Province? province;
  City? city;
  List<PropertyType> propertyTypes;
  double minPrice;
  double maxPrice; 

  PropertyFilter({
    this.province,
    this.city,
    this.propertyTypes = const [],
    this.minPrice = 10,
    this.maxPrice = 1000,
  });

  // Create a copy to avoid modifying state before "Apply" is pressed
  PropertyFilter copy() {
    return PropertyFilter(
      province: province,
      city: city,
      propertyTypes: List.from(propertyTypes),
      minPrice: minPrice,
      maxPrice: maxPrice,
    );
  }
}