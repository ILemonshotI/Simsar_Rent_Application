import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:simsar/Models/date_filter_model.dart';
import 'package:simsar/Network/api_client.dart';
import 'package:simsar/Theme/app_colors.dart';

void showCalendarSheet(
    BuildContext context,
    int apartmentId,
    DateFilter currentFilter,
    Function(DateFilter) onApply,
    ) async {
  DateFilter tempFilter = currentFilter.copy();
  Set<DateTime> bookedDates = {};

  // Fetch booked dates
  try {
    final response =
    await DioClient.dio.get('/api/apartments/$apartmentId/bookings');
    final data = response.data as List;

    for (final booking in data) {
      final start = DateTime.parse(booking['start_date']);
      final end = DateTime.parse(booking['end_date']);
      if (booking['status'] == 'approved') {
        for (int i = 0; i <= end
            .difference(start)
            .inDays; i++) {
          final d = start.add(Duration(days: i));
          bookedDates.add(DateTime(d.year, d.month, d.day));
        }
      }
    }
  } catch (e) {
    debugPrint('Failed to fetch bookings: $e');
  }

  DateTime focusedDay = tempFilter.start ?? DateTime.now();

  bool isBooked(DateTime day) {
    final d = DateTime(day.year, day.month, day.day);
    return bookedDates.contains(d);
  }

  bool isInRange(DateTime day) {
    if (tempFilter.start == null || tempFilter.end == null) return false;
    return day.isAfter(tempFilter.start!.subtract(const Duration(days: 1))) &&
        day.isBefore(tempFilter.end!.add(const Duration(days: 1)));
  }

  bool rangeContainsBooked(DateTime start, DateTime end) {
    DateTime day = start;

    while (!day.isAfter(end)) {
      if (isBooked(day)) return true;
      day = day.add(const Duration(days: 1));
    }
    return false;
  }


  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
    ),
    builder: (_) {
      return StatefulBuilder(
        builder: (context, setStateModal) {
          return Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: SAppColors.background,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                const SizedBox(height: 16),

                const Text(
                  "Select Date",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: SAppColors.secondaryDarkBlue,
                  ),
                ),
                const SizedBox(height: 16),

                TableCalendar(
                  firstDay: DateTime(2000),
                  lastDay: DateTime(2100),
                  focusedDay: focusedDay,
                  rangeStartDay: tempFilter.start,
                  rangeEndDay: tempFilter.end,
                  calendarFormat: CalendarFormat.month,
                  rangeSelectionMode: RangeSelectionMode.enforced,
                  availableGestures: AvailableGestures.horizontalSwipe,

                  enabledDayPredicate: (day) => !isBooked(day),

                  onRangeSelected: (start, end, _) {
                    if (start == null || end == null) return;

                    // 🚫 Block ranges that overlap booked days
                    if (rangeContainsBooked(start, end)) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Selected range contains booked dates'),
                          behavior: SnackBarBehavior.floating,
                        ),
                      );
                      return;
                    }

                    setStateModal(() {
                      tempFilter.start = start;
                      tempFilter.end = end;
                    });
                  },


                  calendarStyle: CalendarStyle(
                    isTodayHighlighted: true,
                    rangeHighlightColor:
                    SAppColors.secondaryDarkBlue.withOpacity(0.15),
                    rangeStartDecoration: const BoxDecoration(
                      color: SAppColors.secondaryDarkBlue,
                      shape: BoxShape.circle,
                    ),
                    rangeEndDecoration: const BoxDecoration(
                      color: SAppColors.secondaryDarkBlue,
                      shape: BoxShape.circle,
                    ),
                  ),

                  calendarBuilders: CalendarBuilders(
                    defaultBuilder: (context, day, _) {
                      if (isBooked(day)) {
                        return _redDay(day);
                      }
                      if (isInRange(day)) {
                        return _rangeDay(day);
                      }
                      return null;
                    },
                    disabledBuilder: (context, day, _) {
                      return _redDay(day);
                    },
                  ),
                ),

                const SizedBox(height: 16),

                if (tempFilter.start != null)
                  Text(
                    tempFilter.end == null
                        ? "Start: ${_fmt(tempFilter.start!)}"
                        : "From ${_fmt(tempFilter.start!)} → ${_fmt(tempFilter.end!)}",
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      color: SAppColors.secondaryDarkBlue,
                    ),
                  ),

                const SizedBox(height: 24),

                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton(
                    onPressed: tempFilter.start != null &&
                        tempFilter.end != null
                        ? () {
                      onApply(tempFilter);
                      Navigator.pop(context);
                    }
                        : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: SAppColors.secondaryDarkBlue,
                      disabledBackgroundColor: Colors.grey.shade400,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      "Save",
                      style:
                      TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      );
    },
  );
}

Widget _redDay(DateTime day) {
  return Container(
    margin: const EdgeInsets.all(6),
    decoration: const BoxDecoration(
      color: Colors.red,
      shape: BoxShape.circle,
    ),
    alignment: Alignment.center,
    child: Text(
      '${day.day}',
      style: const TextStyle(color: Colors.white),
    ),
  );
}

Widget _rangeDay(DateTime day) {
  return Container(
    margin: const EdgeInsets.all(6),
    decoration: BoxDecoration(
      color: SAppColors.secondaryDarkBlue.withOpacity(0.25),
      shape: BoxShape.circle,
    ),
    alignment: Alignment.center,
    child: Text('${day.day}'),
  );
}

String _fmt(DateTime d) {
  return "${d.year}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}";
}
