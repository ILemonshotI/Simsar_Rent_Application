import 'package:flutter/material.dart';
import '../Controllers/booking_controller.dart';

class BookingDateScreen extends StatefulWidget {
  final String propertyId;
  final BookingController controller;

  const BookingDateScreen({
    super.key,
    required this.propertyId,
    required this.controller,
  });

  @override
  State<BookingDateScreen> createState() => _BookingDateScreenState();
}

class _BookingDateScreenState extends State<BookingDateScreen> {
  DateTime? tempStart;
  DateTime? tempEnd;

  @override
  void initState() {
    super.initState();
    widget.controller.loadBookings(widget.propertyId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Select Date')),
      body: widget.controller.loading
          ? const Center(child: CircularProgressIndicator())
          : Column(
        children: [
          Expanded(
            child: CalendarDatePicker(
              initialDate: DateTime.now(),
              firstDate: DateTime.now(),
              lastDate: DateTime.now().add(const Duration(days: 365)),
              onDateChanged: (date) {
                if (widget.controller.isDateBlocked(date)) return;

                setState(() {
                  if (tempStart == null || tempEnd != null) {
                    tempStart = date;
                    tempEnd = null;
                  } else {
                    tempEnd = date;
                  }
                });
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: ElevatedButton(
              onPressed: tempStart != null && tempEnd != null
                  ? () {
                widget.controller.setRange(tempStart!, tempEnd!);
                Navigator.pop(context); // return to summary screen
              }
                  : null,
              child: const Text('Save'),
            ),
          )
        ],
      ),
    );
  }
}
