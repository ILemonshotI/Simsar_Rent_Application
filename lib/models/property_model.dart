import 'package:simsar/Models/property_enums.dart';
class Property {
  final int id;
  final String title;
  final Province province;
  final City city;
  final PropertyType propertyType;
  final double pricePerDay;
  final List<String> images;
  final int bedrooms;
  final int bathrooms;
  List <Review> reviews;
  final int areaSqft;
  final int buildYear;
  final bool parking;
  final String status;
  final String description;
  final double reviewsAvgRating;
  bool isFavorite;


  final Agent agent;
  final int reviewsCount;


  Property({
    required this.id,
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
    required this.propertyType,
    required this.reviewsAvgRating,
    this.isFavorite = false,
    this.reviews = const [],
  });

  factory Property.fromApiJson(Map<String, dynamic> json) {
    return Property(
      id: json['id'] ?? 0,
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
      reviewsAvgRating: double.tryParse(json['reviews_avg_rating']?.toString() ?? '') ?? 0.0,
      isFavorite: json['is_favorite'] ?? false,

      // Backend doesn’t return agent/reviews yet → safe defaults
      agent: Agent(
        id: 0,
        name: ' ',
        avatarUrl: '',
        role: 'agent',
      ),
      reviewsCount: 0,
    );

  }

  factory Property.fromJson(Map<String, dynamic> json) {
    return Property(
      status: "",
      id: json['id'] as int,
      title: json['title'] as String,
      province: ProvinceApiMapper.fromApi(json['province']),
      city: CityApiMapper.fromApi(json['city']),
      description: json['description'] as String,
      bedrooms: json['rooms'] as int,
      bathrooms: json['bathrooms'] as int,
      parking: json['parking'] as bool,
      propertyType: PropertyTypeApiMapper.fromApi(json['type']),
      pricePerDay: double.parse(json['price_per_day']),
      images: List<String>.from(json['images'] ?? []),

      areaSqft: json['area'],
      buildYear: json['build_year'],
      reviews: [],

      agent: Agent.fromJson(json['owner']),

      // Backend doesn't provide these (yet)
      reviewsAvgRating: 0.0,
      reviewsCount: 0,

    );
  }

}

class Agent {
    final int id;
    final String name;
  final String avatarUrl;
  final String role;

  Agent({
    required this.id,
    required this.name,
    required this.avatarUrl,
    required this.role,
  });
  factory Agent.fromJson(Map<String, dynamic> json) {
    return Agent(
      id: json['id'],
      name: '${json['first_name']} ${json['last_name']}'?? ' ',
      avatarUrl: json['photo'],
      role: json['role'],
    );
  }
}

class Review {
  final String reviewerName;
  final String? reviewerAvatar;
  final int rating;
  final String text;

  Review({
    required this.reviewerName,
     this.reviewerAvatar,
    required this.rating,
    required this.text,
  });
  factory Review.fromJson(Map<String, dynamic> json) {
    final tenant = json['tenant'] ?? {};
    final firstName = tenant['first_name'] ?? ' ';
    final lastName = tenant['last_name'] ?? ' ';

    return Review(
      reviewerName: '$firstName $lastName',
      reviewerAvatar: tenant['photo'] ?? "https://picsum.photos/200", // might be null
      rating: json['rating'] ?? 0,
      text: json['comment'] ?? '',
    );
  }

  /// Convert Review to JSON
  Map<String, dynamic> toJson() {
    return {
      'rating': rating,
      'comment': text,
      'tenant': {
        'name': reviewerName,
        'photo': reviewerAvatar,
      },
    };
  }
}
