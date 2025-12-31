class Property {
  final int id;
  final String title;
  final String province;
  final String city;
  final double pricePerDay;
  final List<String> images;
  final int bedrooms;
  final int bathrooms;
  final int? areaSqft;
  final int? buildYear;
  final bool parking;
  final String description;
  List <Review> reviews;
  final double rating; // backend doesn't provide → default
  final int reviewsCount; // backend doesn't provide → default
  final Agent agent;

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
    required this.description,
    required this.agent,
    required this.rating,
    required this.reviewsCount,
    this.reviews = const [],
  });

  factory Property.fromJson(Map<String, dynamic> json) {
    return Property(
      id: json['id'] as int,
      title: json['title'] as String,
      province: json['province'] as String,
      city: json['city'] as String,
      description: json['description'] as String,
      bedrooms: json['rooms'] as int,
      bathrooms: json['bathrooms'] as int,
      parking: json['parking'] as bool,

      pricePerDay: double.parse(json['price_per_day']),
      images: List<String>.from(json['images'] ?? []),

      areaSqft: json['area'],
      buildYear: json['build_year'],
      reviews: [],

      agent: Agent.fromJson(json['owner']),

      // Backend doesn't provide these (yet)
      rating: 0.0,
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
  final String? reviewerAvatar; // avatar might be null
  final int rating;
  final String text;

  Review({
    required this.reviewerName,
    this.reviewerAvatar,
    required this.rating,
    required this.text,
  });

  /// Create Review from JSON
  factory Review.fromJson(Map<String, dynamic> json) {
    final tenant = json['tenant'] ?? {};
    final firstName = tenant['first_name'] ?? ' ';
    final lastName = tenant['last_name'] ?? ' ';

    return Review(
      reviewerName: '$firstName $lastName',
      reviewerAvatar: tenant['photo'], // might be null
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
