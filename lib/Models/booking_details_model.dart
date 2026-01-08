// booking_details.dart
import 'package:flutter/foundation.dart';

class BookingDetails {
  final int id;
  final String startDate;
  final String endDate;
  final String status;
  final String totalPrice;
  final String apartmentTitle;
  final String city;

  // Tenant info
  final int? tenantId;
  final String? tenantFirstName;
  final String? tenantLastName;
  final String? tenantEmail;

  BookingDetails({
    required this.id,
    required this.startDate,
    required this.endDate,
    required this.status,
    required this.totalPrice,
    required this.apartmentTitle,
    required this.city,
    this.tenantId,
    this.tenantFirstName,
    this.tenantLastName,
    this.tenantEmail,
  });

  factory BookingDetails.fromJson(Map<String, dynamic> json) {
    final apartment = json['apartment'] as Map<String, dynamic>?;

    final tenant = json['tenant'] as Map<String, dynamic>?;

    return BookingDetails(
      id: json['id'],
      startDate: json['start_date'] ?? '',
      endDate: json['end_date'] ?? '',
      status: json['status'] ?? '',
      totalPrice: json['total_price']?.toString() ?? '0',
      apartmentTitle: apartment != null ? (apartment['title'] ?? '') : '',
      city: apartment != null ? (apartment['city'] ?? '') : '',
      tenantId: tenant != null ? (tenant['id'] as int?) : null,
      tenantFirstName: tenant != null ? (tenant['first_name'] as String?) : null,
      tenantLastName: tenant != null ? (tenant['last_name'] as String?) : null,
      tenantEmail: tenant != null ? (tenant['email'] as String?) : null,
    );
  }

  String get tenantFullName {
    final first = tenantFirstName ?? '';
    final last = tenantLastName ?? '';
    final combined = [first, last].where((s) => s.isNotEmpty).join(' ');
    return combined.isEmpty ? 'Unknown tenant' : combined;
  }
}
