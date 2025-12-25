class Property {
  final String title;
  final String location;
  final double pricePerMonth;
  final List<String> images;
  final int bedrooms;
  final int bathrooms;
  final int areaSqft;
  final int buildYear;
  final String parking;
  final String status;
  final String description;

  final Agent agent;
  final int reviewsCount;
  final Review featuredReview;

  Property({
    required this.title,
    required this.location,
    required this.pricePerMonth,
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
  });
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
