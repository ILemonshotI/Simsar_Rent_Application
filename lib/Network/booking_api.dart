// features/booking/data/booking_api.dart
import 'package:dio/dio.dart';
import 'package:simsar/Network/api_client.dart';
import '../models_temp/booking.dart';

class BookingApi {
  final Dio dio;

  BookingApi(this.dio);

  Future<List<Booking>> fetchApartmentBookings(String apartmentId) async {
    final response = await DioClient.dio.get(
      '/api/apartments/$apartmentId/bookings',
    );

    final List data = response.data;

    return data.map((e) {
      return Booking(
        startDate: DateTime.parse(e['start_date']),
        endDate: DateTime.parse(e['end_date']),
      );
    }).toList();
  }
}
