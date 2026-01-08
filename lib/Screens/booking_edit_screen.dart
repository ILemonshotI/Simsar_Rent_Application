import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:go_router/go_router.dart';

import '../Network/api_client.dart';
import '../Network/booking_api.dart';
import '../Network/booking_repository.dart';
import '../Controllers/booking_controller.dart';

import '../Custom_Widgets/Tiles/booking_card.dart';
import '../Custom_Widgets/Tiles/calendar_sheet.dart';

import '../Theme/app_colors.dart';
import '../Models/property_model.dart';
import 'package:simsar/Models/date_filter_model.dart';

class BookingEditScreen extends StatefulWidget {
  final int propertyId;
  final int bookingId;
  const BookingEditScreen({super.key, required this.propertyId, required this.bookingId});

  @override
  State<BookingEditScreen> createState() => _BookingEditScreenState();
}

class _BookingEditScreenState extends State<BookingEditScreen> {
  late final BookingController controller;
  late final Future<Property> _propertyFuture;
  bool _isBooking = false;


  DateFilter _dateFilter = DateFilter();
  late final int bookingId;
  @override
  void initState() {
    super.initState();
    final api = BookingApi(DioClient.dio);
    final repository = BookingRepository(api);
    controller = BookingController(repository);
    _propertyFuture = _fetchProperty(widget.propertyId);
    bookingId = widget.bookingId;
  }

  Future<Property> _fetchProperty(int id) async {
    final response = await DioClient.dio.get('/api/apartments/$id');
    return Property.fromJson(response.data);
  }
  Future<void> _bookApartment() async {
    if (controller.startDate == null || controller.endDate == null) return;

    setState(() => _isBooking = true);

    try {
      await DioClient.dio.put(
        '/api/bookings/$bookingId',
        data: {
          'start_date': _formatDate(controller.startDate!),
          'end_date': _formatDate(controller.endDate!),
        },
      );

      if (!mounted) return;

      context.push('/booking-success');
    } on DioException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            e.response?.data['message'] ??
                'Booking failed. Please try again.',
          ),
          behavior: SnackBarBehavior.floating,
        ),
      );
    } finally {
      if (mounted) {
        setState(() => _isBooking = false);
      }
    }
  }


  void _openCalendar() {
    showCalendarSheet(
      context,
      widget.propertyId, // Pass propertyId to fetch booked dates
      _dateFilter,
          (filter) {
        setState(() {
          _dateFilter = filter;
          controller.startDate = filter.start;
          controller.endDate = filter.end;
        });
      },
    );
  }

  String _formatDate(DateTime date) {
    return "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Property>(
      future: _propertyFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (snapshot.hasError) {
          return Scaffold(
            body: Center(
              child: Text('Failed to load property: ${snapshot.error}'),
            ),
          );
        }

        final property = snapshot.data!;

        return Scaffold(
          appBar: AppBar(title: const Text('Edit Booking')),
          body: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                BookingCard(property: property),
                const SizedBox(height: 24),

                // Period selection
                ListTile(
                  title: const Text('Period'),
                  subtitle: Text(
                    controller.startDate == null || controller.endDate == null
                        ? 'Select date'
                        : '${_formatDate(controller.startDate!)} → ${_formatDate(controller.endDate!)}',
                  ),
                  trailing: const Icon(
                    Icons.calendar_today,
                    color: SAppColors.secondaryDarkBlue,
                  ),
                  onTap: _openCalendar,
                ),

                const Spacer(),

                // Book button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: controller.startDate != null &&
                        controller.endDate != null &&
                        !_isBooking
                        ? _bookApartment
                        : null,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      backgroundColor: SAppColors.secondaryDarkBlue,
                      disabledBackgroundColor: Colors.grey.shade400,
                    ),
                    child: _isBooking
                        ? const SizedBox(
                      height: 22,
                      width: 22,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    )
                        : const Text(
                      'Book',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
