// booking_model.dart
import 'package:intl/intl.dart';

class Booking {
  final int id;
  final int apartmentId;
  final int tenantId;
  final DateTime startDate;
  final DateTime endDate;
  final String status;
  final double totalPrice;
  final bool hasReview;

  Booking({
    required this.id,
    required this.apartmentId,
    required this.tenantId,
    required this.startDate,
    required this.endDate,
    required this.status,
    required this.totalPrice,
    required this.hasReview,
  });

  factory Booking.fromJson(Map<String, dynamic> json) {
    return Booking(
      id: json['id'],
      apartmentId: json['apartment_id'],
      tenantId: json['tenant_id'],
      startDate: DateTime.parse(json['start_date']),
      endDate: DateTime.parse(json['end_date']),
      status: json['status'],
      totalPrice: double.tryParse(json['total_price'].toString()) ?? 0.0,
      hasReview: false,

    );
  }

  factory Booking.fromApiJson(Map<String, dynamic> json) {
    return Booking(
      id: json['id'],
      apartmentId: json['apartment_id'],
      tenantId: json['tenant_id'],
      startDate: DateTime.parse(json['start_date']),
      endDate: DateTime.parse(json['end_date']),
      status: json['status'],
      totalPrice: double.tryParse(json['total_price'].toString()) ?? 0.0,
      hasReview: json['has_review'],

    );
  }

  // Helper to format dates like "12 Aug - 12 Sep"
  String get dateRange {
    final startFormat = DateFormat('d MMM');
    final endFormat = DateFormat('d MMM');
    return '${startFormat.format(startDate)} - ${endFormat.format(endDate)}';
  }
}