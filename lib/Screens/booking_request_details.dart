// booking_details_screen.dart
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:go_router/go_router.dart';

import 'package:simsar/Theme/app_colors.dart';
import 'package:simsar/Theme/app_theme.dart';
import 'package:simsar/Theme/text_theme.dart';

import '../Network/api_client.dart';
import '../Models/booking_details_model.dart';

class BookingDetailsScreen extends StatefulWidget {
  final int bookingId;

  const BookingDetailsScreen({super.key, required this.bookingId});

  @override
  State<BookingDetailsScreen> createState() => _BookingDetailsScreenState();
}

class _BookingDetailsScreenState extends State<BookingDetailsScreen> {
  BookingDetails? booking;
  bool isLoading = true;
  bool isSubmitting = false;

  @override
  void initState() {
    super.initState();
    fetchBooking();
  }

  Future<void> fetchBooking() async {
    try {
      final response =
      await DioClient.dio.get('/api/bookings/${widget.bookingId}');
      booking = BookingDetails.fromJson(response.data);
    } catch (e) {
      _showError("Failed to load booking");
    } finally {
      setState(() => isLoading = false);
    }
  }

  Future<void> approveBooking() async {
    await _submitAction(
      '/api/bookings/${widget.bookingId}/approve',
      successMessage: 'Booking approved',
    );
  }

  Future<void> rejectBooking() async {
    await _submitAction(
      '/api/bookings/${widget.bookingId}/reject',
      successMessage: 'Booking rejected',
    );
  }

  Future<void> _submitAction(String path,
      {required String successMessage}) async {
    setState(() => isSubmitting = true);

    try {
      await DioClient.dio.post(path);
      if (!mounted) return;

      // Go back to home screen
      context.go('/home'); // <-- change this to your actual home route

      Navigator.pop(context, true);
    } catch (e) {
      _showError("Operation failed");
    } finally {
      if (mounted) setState(() => isSubmitting = false);
    }
  }

  void _showError(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Request Details"),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : booking == null
          ? Center(
        child: Text(
          "Booking not found",
          style: textTheme.bodyLarge,
        ),
      )
          : Padding(
        padding:
        const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Apartment title
            Text(
              booking!.apartmentTitle,
              style: textTheme.headlineSmall!
                  .copyWith(fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 4),

            /// City
            Text(
              booking!.city,
              style: textTheme.bodyMedium!.copyWith(
                color: SAppColors.descriptionTextGray,
              ),
            ),

            const SizedBox(height: 20),

            /// Booking info
            _infoCard(textTheme),

            const SizedBox(height: 18),

            /// Tenant info
            _tenantCard(textTheme),

            const Spacer(),

            /// Actions
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed:
                    isSubmitting ? null : approveBooking,
                    child: isSubmitting
                        ? const SizedBox(
                      height: 18,
                      width: 18,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    )
                        : const Text("Accept Request"),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: OutlinedButton(
                    onPressed:
                    isSubmitting ? null : rejectBooking,
                    child: const Text("Reject Request"),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _infoCard(TextTheme textTheme) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: SAppColors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: SAppColors.outlineGray),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Booking Details",
              style: textTheme.titleMedium!
                  .copyWith(fontWeight: FontWeight.w700)),
          const SizedBox(height: 12),
          _detailRow("Check-in", booking!.startDate, textTheme),
          const SizedBox(height: 8),
          _detailRow("Check-out", booking!.endDate, textTheme),
          const SizedBox(height: 8),
          _detailRow("Total Price", "\$${booking!.totalPrice}", textTheme),
          const SizedBox(height: 8),
          _detailRow("Status", booking!.status.toUpperCase(), textTheme),
        ],
      ),
    );
  }

  Widget _tenantCard(TextTheme textTheme) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: SAppColors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: SAppColors.outlineGray),
      ),
      child: Row(
        children: [
          /// Avatar
          Container(
            height: 56,
            width: 56,
            decoration: BoxDecoration(
              color: SAppColors.lightBlue.withOpacity(0.15),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                _initials(),
                style: textTheme.titleMedium!.copyWith(
                  color: SAppColors.primaryBlue,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),

          const SizedBox(width: 12),

          /// Tenant info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  booking!.tenantFullName,
                  style: textTheme.titleSmall!
                      .copyWith(fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 4),
                Text(
                  booking!.tenantEmail ?? "-",
                  style: textTheme.bodyMedium!.copyWith(
                    color: SAppColors.descriptionTextGray,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  "Tenant ID: ${booking!.tenantId ?? '-'}",
                  style: textTheme.bodySmall,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _detailRow(String label, String value, TextTheme textTheme) {
    return Row(
      children: [
        Expanded(
          child: Text(
            label,
            style:
            textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.w600),
          ),
        ),
        Text(value, style: textTheme.bodyMedium),
      ],
    );
  }

  String _initials() {
    final first = booking!.tenantFirstName ?? '';
    final last = booking!.tenantLastName ?? '';
    if (first.isEmpty && last.isEmpty) return '?';
    return '${first[0].toUpperCase()}${last.isNotEmpty ? last[0].toUpperCase() : ''}';
  }
}
