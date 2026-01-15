import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:go_router/go_router.dart';
import 'package:simsar/Models/property_enums.dart';
import 'package:simsar/Network/api_client.dart';

import '../Custom_Widgets/Buttons/primary_button.dart';
import '../Models/booking_model.dart';
import '../Models/property_models.dart';
import '../Theme/app_colors.dart';

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
      final List<dynamic> data = response.data; // Use this for real API

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
          final inactiveStatuses = ['cancelled', 'rejected'];
          return b.endDate.isAfter(now) && 
                !inactiveStatuses.contains(b.status.toLowerCase());
        }).toList();

      case 1: // Completed
        return _allBookings.where((b) {
          final inactiveStatuses = ['cancelled', 'rejected'];
          return b.endDate.isBefore(now) && 
                !inactiveStatuses.contains(b.status.toLowerCase());
        }).toList();
      case 2: // Cancelled/Rejected
        return _allBookings.where((b) => 
        b.status.toLowerCase() == 'cancelled' || 
        b.status.toLowerCase() == 'rejected'
      ).toList();
      default:
        return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Bookings"),
        centerTitle: true,
      ),

      body: Column(
        children: [
          // Custom Tab Bar
          Padding(
            padding: const EdgeInsets.all(16),
            child: SegmentedButton<int>(
              segments: const [
                ButtonSegment(value: 0, label: Text("Upcoming")),
                ButtonSegment(value: 1, label: Text("Completed")),
                ButtonSegment(value: 2, label: Text("Cancelled")),
              ],
              selected: {_selectedTabIndex},
              onSelectionChanged: (value) {
                setState(() => _selectedTabIndex = value.first);
              },
            ),
          ),

          // Content
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : _filteredBookings.isEmpty
                ? _buildEmptyState(context)
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
                        status:"",
                        propertyType: PropertyType.villa,
                        id: 2,
                        title: "Yafour Villa",
                        province: Province.damascus,
                        city: City.dummar,
                        reviewsAvgRating:4,
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
                        isCompleted: _selectedTabIndex == 1,
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

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.luggage,
            size: 80,
            color: SAppColors.lightBlue,
          ),
          const SizedBox(height: 24),
          Text(
            "You have no upcoming bookings",
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          Text(
            "Go to the Home page to make a new booking",
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: SAppColors.descriptionTextGray,
            ),
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
      final property = Property.fromApiJson(response.data);
      _propertyCache[propertyId] = property; // Cache it
      return property;
    } catch (e) {
      print('Error fetching property $propertyId: $e');
      return Property(
        status: "",
        propertyType: PropertyType.villa,
        id: 2,
        title: "Yafour Villa",
        province: Province.damascus,
        city: City.dummar,
        reviewsAvgRating:4,
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
  final bool isCompleted;

  const BookingCard({
    super.key,
    required this.booking,
    required this.property,
    required this.isUpcoming,
    required this.isCompleted,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),

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
                      style: Theme.of(context).textTheme.titleLarge,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(Icons.location_on_outlined, size: 16, color: SAppColors.textGray),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            "${property.city.displayName}, ${property.province.displayName}",
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: SAppColors.descriptionTextGray,
                            ),
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
                  child:SizedBox(
                    height: 52,
                  child: OutlinedButton(

                    onPressed: () async {
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
                        final state = context.findAncestorStateOfType<_MyBookingScreenState>();
                        await state?._cancelBooking(booking);
                      }
                    },
                    child: const Text("Cancel"),

                  ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: SPrimaryButton(
                    onPressed: () {
                      context.go('/booking-edit/${property.id}', extra: booking.id);
                    },
                    text: "Edit",
                  ),
                ),
              ],
            ),

          ],
          if (isCompleted) ...[
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 12.0),
              child: Divider(height: 1),
            ),
            Row(
              children: [

                Expanded(
                  child: SPrimaryButton(
                    onPressed: () {
                      context.go('/add-review/${booking.id}');
                    },
                    text: "Add Review",
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
      case 'rejected':
        bgColor = const Color(0xFFFFE5E5); // Light Red
        textColor = const Color(0xFFFF3B30); // Red
        text = "Rejected";
        break;  
      default:
        bgColor = SAppColors.background;
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