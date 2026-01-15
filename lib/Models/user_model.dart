class User {
  final int id;
  final String firstName;
  final String lastName;
  final String phone;
  final String email;
  final String role;
  final String photo;
  final String idPhotoFront;
  final String idPhotoBack;
  final DateTime? birthDate;
  final bool isApproved;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? fcmToken;
  final double wallet;

  User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.email,
    required this.role,
    required this.photo,
    required this.idPhotoFront,
    required this.idPhotoBack,
    this.birthDate,
    required this.isApproved,
    this.createdAt,
    this.updatedAt,
    this.fcmToken,
    required this.wallet,
  });

  /// Helper to get full name similar to how your Agent model works
  String get fullName => '$firstName $lastName';

  factory User.fromApiJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] ?? 0,
      firstName: json['first_name'] ?? '',
      lastName: json['last_name'] ?? '',
      phone: json['phone'] ?? '',
      email: json['email'] ?? '',
      role: json['role'] ?? 'tenant',
      photo: json['photo'] ?? '',
      idPhotoFront: json['id_photo_front'] ?? '',
      idPhotoBack: json['id_photo_back'] ?? '',
      isApproved: json['is_approved'] ?? false,
      fcmToken: json['fcm_token'],
      // Handle the numeric wallet value safely as a double
      wallet: double.tryParse(json['wallet'].toString()) ?? 0.0,
      // Parse dates safely
      birthDate: json['birth_date'] != null 
          ? DateTime.tryParse(json['birth_date']) 
          : null,
      createdAt: json['created_at'] != null 
          ? DateTime.tryParse(json['created_at']) 
          : null,
      updatedAt: json['updated_at'] != null 
          ? DateTime.tryParse(json['updated_at']) 
          : null,
    );
  }

  static  User dummy() {
  return User(
    id: 0,
    firstName: "Test",
    lastName: "User",
    phone: "000000000",
    email: "test@example.com",
    role: "tenant",
    photo: "",
    idPhotoFront: "",
    idPhotoBack: "",
    isApproved: true,
    wallet: 0.0,
  );
}

}