import 'package:simsar/Models/property_enums.dart';
class Property {
  final String title;
  final Province province; 
  final City city;
  final PropertyType propertyType;
  final double pricePerDay;
  final List<String> images;
  final int bedrooms;
  final int bathrooms;
  final int areaSqft;
  final int buildYear;
  final bool parking;
  final String status;
  final String description;


  final Agent agent;
  final int reviewsCount;
  final Review featuredReview;

  Property({
    required this.title,
    required this.province,
    required this.city,
    required this.pricePerDay,
    required this.images,
    required this.bedrooms,
    required this.bathrooms,
    required this.areaSqft,
    required this.buildYear,
    required this.parking,
    required this.status,
    required this.description,
    required this.agent,
    required this.reviewsCount,
    required this.featuredReview,
    required this.propertyType,
  });

  factory Property.fromApiJson(Map<String, dynamic> json) {
  return Property(
    title: json['title'] ?? '',
    description: json['description'] ?? '',
    pricePerDay: double.tryParse(json['price_per_day'].toString()) ?? 0.0,
    images: List<String>.from(json['images'] ?? []),

    bedrooms: json['rooms'] ?? 0,
    bathrooms: json['bathrooms'] ?? 0,
    areaSqft: json['area'] ?? 0,
    buildYear: json['build_year'] ?? 0,
    parking: json['parking'] ?? false,

    status: json['is_approved'] == true ? 'Available' : 'Pending',

    province: ProvinceApiMapper.fromApi(json['province']),
    city: CityApiMapper.fromApi(json['city']),
    propertyType: PropertyTypeApiMapper.fromApi(json['type']),

    // Backend doesn’t return agent/reviews yet → safe defaults
    agent: Agent(
      name: 'Owner',
      avatarUrl: '',
      role: 'Owner',
    ),
    reviewsCount: 0,
    featuredReview: Review(
      reviewerName: '',
      reviewerAvatar: '',
      rating: 0,
      text: '',
    ),
  );
}

}

class Agent {
  final String name;
  final String avatarUrl;
  final String role;

  Agent({
    required this.name,
    required this.avatarUrl,
    required this.role,
  });
}

class Review {
  final String reviewerName;
  final String reviewerAvatar;
  final int rating;
  final String text;

  Review({
    required this.reviewerName,
    required this.reviewerAvatar,
    required this.rating,
    required this.text,
  });
}