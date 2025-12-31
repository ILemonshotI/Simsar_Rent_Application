import 'package:go_router/go_router.dart';
import 'package:simsar/Controllers/booking_controller.dart';
import 'package:simsar/Screens/booking_success_screen.dart';
import 'package:simsar/Screens/details_screen.dart';
import 'package:simsar/Screens/my_bookings_screen.dart';
import 'package:simsar/models_temp/property_model.dart';
import 'package:simsar/Screens/edit_listing_screen.dart';
import 'package:simsar/Screens/home_screen.dart';
import 'package:simsar/Screens/login_screen.dart';
import 'package:simsar/Screens/pending_approval_screen.dart';
import 'package:simsar/Screens/register_screen.dart';
import 'package:simsar/Layouts/main_layout.dart';

import '../Screens/booking_date_screen.dart';
import '../Screens/booking_edit_screen.dart';
import '../Screens/booking_summary_screen.dart';
class AppRouter {
  static const String home = '/home';
  static const String login = '/login';
  static const String register = '/register';
  static const String pendingApproval = '/pending-approval';
  static const String favorites = '/favorites';
  static const String bookings = '/bookings';
  static const String profile = '/profile';
  static const String bookingSummary = '/booking-summary';
  static const String editListing = '/edit-listing';
  static const String detailsScreen = '/details';
  static const String bookingDate = '/booking-date';
  static const String bookingSuccess = '/booking-success';

  static final GoRouter router = GoRouter(
    initialLocation: '/booking-summary/2',
    routes: [

      GoRoute(
        path: login,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: register,
        builder: (context, state) => const RegisterScreen(),
      ),
      GoRoute(
        path: pendingApproval,
        builder: (context, state) => const PendingApprovalScreen(),
      ),
      ShellRoute(
        builder: (context, state, child) {
          return MainLayout(child: child);
        },
        routes: [
          // GoRoute(
          //   path: '$editListing/:propertyId',
          //   builder: (context, state) {
          //     final id = int.parse(state.pathParameters['propertyId']?? '0');
          //
          //
          //
          //     return EditListingScreen( id: id);
          //   },
          // ),
          GoRoute(
            path: '$detailsScreen/:propertyId',
            builder: (context, state) {
              final id = int.parse(state.pathParameters['propertyId']?? '0');



              return PropertyDetailsScreen(propertyId: id);
            },
          ),
          GoRoute(
            path: '/booking-summary/:id',
            builder: (context, state) {
              final id = state.pathParameters['id'];
              return BookingSummaryScreen(propertyId: int.parse(id!));
            },
          ),
          GoRoute(
            path: '/booking-success',
            builder: (context, state) => const BookingSuccessScreen(),
          ),
          GoRoute(
            path: '/booking-edit/:propertyId',
            builder: (context, state) {
              return BookingEditScreen(
                  propertyId: int.parse(state.pathParameters['propertyId']!),
                  bookingId: state.extra as int);
            }
          ),



          // GoRoute(
          //   path: '/booking-date',
          //   builder: (context, state) {
          //     final args = state.extra as Map<String, dynamic>;
          //     return BookingDateScreen(
          //       propertyId: args['propertyId'],
          //       controller: args['controller'],
          //     );
          //   },
          // ),
          GoRoute(
            path: home,
            builder: (context, state) => const HomeScreen(),
          ),
          GoRoute(
            path: favorites,
            builder: (context, state) => const HomeScreen(),
          ),
          GoRoute(
            path: bookings,
            builder: (context, state) => const MyBookingScreen(),
          ),
          GoRoute(
            path: profile,
            builder: (context, state) => const HomeScreen(),
          ),

        ],
      ),
    ],
  );
}