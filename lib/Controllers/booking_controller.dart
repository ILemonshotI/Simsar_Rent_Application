
// features/booking/controllers/booking_controller.dart
import 'package:flutter/material.dart';
import '../Network/booking_repository.dart';
import '../models_temp/booking.dart';

class BookingController extends ChangeNotifier {
final BookingRepository repository;

BookingController(this.repository);

DateTime? startDate;
DateTime? endDate;

List<Booking> bookedRanges = [];
bool loading = false;

Future<void> loadBookings(String apartmentId) async {
loading = true;
notifyListeners();

bookedRanges = await repository.getBookings(apartmentId);

loading = false;
notifyListeners();
}

bool isDateBlocked(DateTime date) {
for (final booking in bookedRanges) {
if (date.isAfter(booking.startDate.subtract(const Duration(days: 1))) &&
date.isBefore(booking.endDate.add(const Duration(days: 1)))) {
return true;
}
}
return false;
}

void setRange(DateTime start, DateTime end) {
startDate = start;
endDate = end;
notifyListeners();
}

int get totalDays {
if (startDate == null || endDate == null) return 0;
return endDate!.difference(startDate!).inDays + 1;
}
}
