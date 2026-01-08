import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:go_router/go_router.dart';
import 'package:simsar/Network/api_client.dart';

import '../Models/booking_model.dart';
import '../Models/property_model.dart';

// --- MODELS (Paste your Property, Agent, Review models here) ---
// I am assuming the Property models you provided are in a file named models.dart
// For this single-file example, I will assume they are available.



class MyBookingScreen extends StatefulWidget {
  const MyBookingScreen({super.key});

  @override
  State<MyBookingScreen> createState() => _MyBookingScreenState();
}

class _MyBookingScreenState extends State<MyBookingScreen> {
  final Dio _dio = Dio();
  bool _isLoading = true;
  List<Booking> _allBookings = [];
  int _selectedTabIndex = 0; // 0: Upcoming, 1: Completed, 2: Cancelled

  // Since the API only returns apartment_id, we need a way to show property data.
  // In a real app, you would fetch this by ID or include it in the backend response.
  // Here, I am mocking the property lookup based on apartment_id.
  final Map<int, Property> _propertyCache = {};

  @override
  void initState() {
    super.initState();
    _fetchBookings();
  }
  Future<void> _cancelBooking(Booking booking) async {
    final bookingId = booking.id;

    try {
      // Optional: show loading indicator or disable button
      final response = await DioClient.dio.post('/api/bookings/$bookingId/cancel');

      if (response.statusCode == 200 || response.statusCode == 201) {
        // Update local booking status so UI updates immediately


        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Booking cancelled successfully')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to cancel booking')),
        );
      }
    } catch (e) {
      print('Error cancelling booking: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error cancelling booking')),
      );
    }
  }

  Future<void> _fetchBookings() async {
    try {
      final response = await DioClient.dio.get('/api/bookings');
      final List<dynamic> data = response.data['data']; // Use this for real API

      setState(() {
        _allBookings = data.map((json) => Booking.fromJson(json)).toList();
        _isLoading = false;
      });
    } catch (e) {
      print('Error fetching bookings: $e');
      setState(() => _isLoading = false);
    }
  }

  // Logic to filter bookings based on the tab
  List<Booking> get _filteredBookings {
    final now = DateTime.now();

    switch (_selectedTabIndex) {
      case 0: // Upcoming
        return _allBookings.where((b) {
          // Logic: End date is in the future AND not cancelled
          return b.endDate.isAfter(now) && b.status != 'cancelled';
        }).toList();
      case 1: // Completed
        return _allBookings.where((b) {
          // Logic: End date is in the past AND not cancelled
          return b.endDate.isBefore(now) && b.status != 'cancelled';
        }).toList();
      case 2: // Cancelled
        return _allBookings.where((b) => b.status == 'cancelled').toList();
      default:
        return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {},
        ),
        title: const Text(
          "My Booking",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),      // Bottom Navigation Bar placeholder to match screenshot
      body: Column(
        children: [
          // Custom Tab Bar
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              height: 45,
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  _buildTabItem("Upcoming", 0),
                  _buildTabItem("Completed", 1),
                  _buildTabItem("Cancelled", 2),
                ],
              ),
            ),
          ),

          // Content
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : _filteredBookings.isEmpty
                ? _buildEmptyState()
                : ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: _filteredBookings.length,
              separatorBuilder: (c, i) => const SizedBox(height: 16),
                itemBuilder: (context, index) {
                  final booking = _filteredBookings[index];
                  return FutureBuilder<Property>(
                    future: fetchProperty(booking.apartmentId),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const SizedBox(
                          height: 120,
                          child: Center(child: CircularProgressIndicator()),
                        );
                      }

                      final property = snapshot.data ?? Property(
                        id: 2,
                        title: "Yafour Villa",
                        province: "Yafour Street No.47, RW.001",
                        city: "Damascus",
                        rating:4,
                        pricePerDay: 120.0,
                        images: ["assets/images/yafour_villa.jpg"],
                        bedrooms: 2,
                        bathrooms: 1,
                        areaSqft: 450,
                        buildYear: 2021,
                        parking: true,
                        description: "A cozy place to stay.",
                        agent: Agent(
                          id: 1,
                          name: "John",
                          avatarUrl: "",
                          role: "Owner",
                        ),
                        reviewsCount: 10,

                      );

                      return BookingCard(
                        booking: booking,
                        property: property,
                        isUpcoming: _selectedTabIndex == 0,
                      );
                    },
                  );
                }

            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabItem(String title, int index) {
    final isSelected = _selectedTabIndex == index;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _selectedTabIndex = index),
        child: Container(
          decoration: BoxDecoration(
            color: isSelected ? const Color(0xFF0F2C59) : Colors.transparent,
            // Dark Blue
            borderRadius: BorderRadius.circular(6),
          ),
          alignment: Alignment.center,
          margin: const EdgeInsets.all(4),
          child: Text(
            title,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.grey,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Placeholder for the illustration in the screenshot
          Container(
            height: 180,
            width: 180,
            decoration: BoxDecoration(
              color: Colors.blue[50],
              shape: BoxShape.circle,
            ),
            child: const Icon(
                Icons.luggage, size: 80, color: Color(0xFF0F2C59)),
          ),
          const SizedBox(height: 24),
          const Text(
            "You have no upcoming bookings",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const Text(
            "Go to the Home page to make a new booking",
            style: TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }


  Future<Property> fetchProperty(int propertyId) async {
    // Check cache first
    if (_propertyCache.containsKey(propertyId)) {
      return _propertyCache[propertyId]!;
    }

    try {
      final response = await DioClient.dio.get('/api/apartments/$propertyId');
      final property = Property.fromJson(response.data);
      _propertyCache[propertyId] = property; // Cache it
      return property;
    } catch (e) {
      print('Error fetching property $propertyId: $e');
      return Property(
        id: 2,
        title: "Yafour Villa",
        province: "Yafour Street No.47, RW.001",
        city: "Damascus",
        rating:4,
        pricePerDay: 120.0,
        images: ["assets/images/yafour_villa.jpg"],
        bedrooms: 2,
        bathrooms: 1,
        areaSqft: 450,
        buildYear: 2021,
        parking: true,
        description: "A cozy place to stay.",
        agent: Agent(
          id: 1,
          name: "John",
          avatarUrl: "",
          role: "Owner",
        ),
        reviewsCount: 10,

      );

    }
  }

}


class BookingCard extends StatelessWidget {
  final Booking booking;
  final Property property;
  final bool isUpcoming;

  const BookingCard({
    super.key,
    required this.booking,
    required this.property,
    required this.isUpcoming,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.05),
            spreadRadius: 2,
            blurRadius: 10,
          )
        ],
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Container(
                  width: 80,
                  height: 80,
                  color: Colors.grey[300],
                  child: Image.network(
                    property.images.isNotEmpty ? property.images.first : '',
                    fit: BoxFit.cover,
                    errorBuilder: (c, o, s) => const Icon(Icons.image, color: Colors.grey),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              // Details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      property.title,
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(Icons.location_on_outlined, size: 14, color: Colors.grey),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            "${property.city}, ${property.province}",
                            style: const TextStyle(color: Colors.grey, fontSize: 12),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          booking.dateRange,
                          style: TextStyle(color: Colors.grey[600], fontSize: 13),
                        ),
                        _buildStatusBadge(booking.status),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),

          // Edit/Cancel Buttons (Only for Upcoming)
          if (isUpcoming) ...[
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 12.0),
              child: Divider(height: 1),
            ),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: isUpcoming
                        ? () async {
                      // Optionally confirm cancellation
                      final confirm = await showDialog<bool>(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text('Cancel Booking'),
                          content: const Text('Are you sure you want to cancel this booking?'),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context, false),
                              child: const Text('No'),
                            ),
                            TextButton(
                              onPressed: () => Navigator.pop(context, true),
                              child: const Text('Yes'),
                            ),
                          ],
                        ),
                      );

                      if (confirm == true) {
                        // Call cancel function from parent state
                        final state = context.findAncestorStateOfType<_MyBookingScreenState>();
                        await state?._cancelBooking(booking);
                      }
                    }
                        : null,
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: Colors.grey.shade300),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                    child: const Text("Cancel Booking", style: TextStyle(color: Colors.grey)),
                  ),

                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {context.go('/booking-summary/${property.id}',extra:booking.id,);}, // Non-functional
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF0F2C59),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      elevation: 0,
                    ),
                    child: const Text("Edit Booking", style: TextStyle(color: Colors.white)),
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildStatusBadge(String status) {
    Color bgColor;
    Color textColor;
    String text;

    switch (status.toLowerCase()) {
      case 'approved':
        bgColor = const Color(0xFFE3FCEC); // Light Green
        textColor = const Color(0xFF19B000); // Green
        text = "Verified";
        break;
      case 'pending':
        bgColor = const Color(0xFFE6F2FF); // Light Blue
        textColor = const Color(0xFF007AFF); // Blue
        text = "Waiting";
        break;
      case 'cancelled':
        bgColor = const Color(0xFFFFE5E5); // Light Red
        textColor = const Color(0xFFFF3B30); // Red
        text = "Cancelled";
        break;
      default:
        bgColor = Colors.grey[200]!;
        textColor = Colors.black;
        text = status;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        text,
        style: TextStyle(color: textColor, fontSize: 12, fontWeight: FontWeight.w600),
      ),
    );
  }
}