import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:simsar/Network/api_client.dart';
import '../Models/booking_model.dart';
import '../Models/property_models.dart';
import 'package:simsar/Models/user_model.dart';
import 'package:simsar/Custom_Widgets/Tiles/owner_booking_card.dart';
import 'package:simsar/Theme/app_colors.dart';
class OwnerMyBookingScreen extends StatefulWidget {
  const OwnerMyBookingScreen({super.key});

  @override
  State<OwnerMyBookingScreen> createState() => _MyBookingScreenState();
}

class _MyBookingScreenState extends State<OwnerMyBookingScreen> {
  bool _isLoading = true;
  List<Booking> _allBookings = [];
  int _selectedTabIndex = 0; // 0: Pending, 1: Approved, 2: Cancelled
  User? tenant; // To store the result
  bool _isUserLoading = false;        // Separate loading state
  String? _userErrorMessage; 
  final Map<int, User> _userCache = {};        // Separate error state

  final Map<int, Property> _propertyCache = {};

  @override
  void initState() {
    super.initState();
    _fetchBookings();
  }

  Future<void> _fetchBookings() async {
    try {
      setState(() => _isLoading = true);
      // New Endpoint
      final response = await DioClient.dio.get('/api/owner/bookings');
      
      // Accessing the 'data' list from the paginated response body
     final List<dynamic> data = response.data;

      setState(() {
        _allBookings = data.map((json) => Booking.fromJson(json)).toList();
        _isLoading = false;
      });

      final tenantIds = _allBookings.map((b) => b.tenantId).toSet();
    
    for (var id in tenantIds) {
      _fetchUser(id); // This runs in the background as bookings appear
    }

    } catch (e) {
      debugPrint('Error fetching bookings: $e');
      setState(() => _isLoading = false);
    }
  }

  Future<void> _rejectBooking(Booking booking) async {
    try {
      final response = await DioClient.dio.post('/api/bookings/${booking.id}/reject');
      if (response.statusCode == 200 || response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Booking rejected successfully')),
        );
        _fetchBookings(); // Refresh list
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error rejecting booking')),
      );
    }
  }

  Future<void> _approveBooking(Booking booking) async {
    try {
      final response = await DioClient.dio.post('/api/bookings/${booking.id}/approve');
      if (response.statusCode == 200 || response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Booking has been approved, payment transferred succesfully')),
        );
        _fetchBookings(); // Refresh list
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error approving booking')),
      );
    }
  }

  Future<void> _fetchUser(int userId) async {

  if (_userCache.containsKey(userId)) return;

  try {
    setState(() {
      _isUserLoading = true;
      _userErrorMessage = null;
    });

    final response = await DioClient.dio.get('/api/users/$userId');

    // 200 - Success logic
    setState(() {
      _userCache[userId] = User.fromApiJson(response.data);
    });
    
  } on DioException catch (e) {
    setState(() {
      // Documentation specific error handling
      if (e.response?.statusCode == 401) {
        _userErrorMessage = "Unauthenticated: Please log in again.";
      } else if (e.response?.statusCode == 404) {
        _userErrorMessage = "User not found: The ID $userId does not exist.";
      } else {
        _userErrorMessage = "Network Error: ${e.message}";
      }
    });
  } catch (e) {
    setState(() {
      _userErrorMessage = "An unexpected error occurred: $e";
    });
  } finally {
    setState(() {
      _isUserLoading = false;
    });
  }
}

  

  // Updated filtering based on status string from API
  List<Booking> get _filteredBookings {
    switch (_selectedTabIndex) {
      case 0: // Pending
        return _allBookings.where((b) => b.status.toLowerCase() == 'pending').toList();
      case 1: // Approved
        return _allBookings.where((b) => b.status.toLowerCase() == 'approved').toList();
      case 2: // Cancelled
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
      appBar: AppBar(title: const Text("Booking Requests"), centerTitle: true),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: SegmentedButton<int>(
              segments: const [
                ButtonSegment(value: 0, label: Text("Pending")),
                ButtonSegment(value: 1, label: Text("Approved")),
                ButtonSegment(value: 2, label: Text("Cancelled")),
              ],
              selected: {_selectedTabIndex},
              onSelectionChanged: (value) {
                setState(() => _selectedTabIndex = value.first);
              },
            ),
          ),
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
                          final tenant = _userCache[booking.tenantId];
                          return FutureBuilder<Property>(
                            future: fetchProperty(booking.apartmentId),
                            builder: (context, snapshot) {
                              if (!snapshot.hasData) {
                                return const SizedBox(height: 100, child: Center(child: CircularProgressIndicator()));
                              }
                              return OwnerBookingCard(
                                booking: booking,
                                property: snapshot.data!,
                                // Logic: Pending tab shows edit/cancel, Approved shows review
                                isUpcoming: _selectedTabIndex == 0, 
                                isCompleted: _selectedTabIndex == 1,
                                user: tenant ?? User.dummy(), // Using your AppUser dummy
                                onCancel: () => _rejectBooking(booking),
                                onApproved:() => _approveBooking(booking),
                              );
                            },
                          );
                        },
                      ),
          ),
        ],
      ),
    );
  }

  // Cached Property fetcher (same as your previous logic)
  Future<Property> fetchProperty(int propertyId) async {
    if (_propertyCache.containsKey(propertyId)) return _propertyCache[propertyId]!;
    try {
      final response = await DioClient.dio.get('/api/apartments/$propertyId');
      final property = Property.fromApiJson(response.data);
      _propertyCache[propertyId] = property;
      return property;
    } catch (e) {
      return Property.dummy(); // Ensure your Property model has a dummy()
    }
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
            "You have no requested bookings",
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          Text(
            "Wait for a tenant to request a stay at one of your properties",
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: SAppColors.descriptionTextGray,
            ),
          ),
        ],
      ),
    );
  }
}