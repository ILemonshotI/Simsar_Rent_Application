// features/booking/data/booking_repository.dart
import '../models_temp/booking.dart';
import 'booking_api.dart';

class BookingRepository {
  final BookingApi api;

  BookingRepository(this.api);

  Future<List<Booking>> getBookings(String apartmentId) {
    return api.fetchApartmentBookings(apartmentId);
  }
}
