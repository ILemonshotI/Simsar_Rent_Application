class PropertyFilter {
  String? location;
  List<String> propertyTypes;
  double minPrice;
  double maxPrice;

  PropertyFilter({
    this.location,
    this.propertyTypes = const [],
    this.minPrice = 10,
    this.maxPrice = 100,
  });

  // Create a copy to avoid modifying state before "Apply" is pressed
  PropertyFilter copy() {
    return PropertyFilter(
      location: location,
      propertyTypes: List.from(propertyTypes),
      minPrice: minPrice,
      maxPrice: maxPrice,
    );
  }
}