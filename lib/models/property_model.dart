class PropertyModel {
  final String title;
  final String location;
  final double pricePerMonth;
  final String heroImage;
  final List<String> gallery;
  final int bedrooms;
  final int bathrooms;
  final int buildYear;
  final String parking;
  final String status;
  final String area;
  final String description;

  const PropertyModel({
    required this.title,
    required this.location,
    required this.pricePerMonth,
    required this.heroImage,
    required this.gallery,
    required this.bedrooms,
    required this.bathrooms,
    required this.buildYear,
    required this.parking,
    required this.status,
    required this.area,
    required this.description,
  });
}
