import 'package:go_router/go_router.dart';
import 'package:simsar/Screens/about_screen.dart';
import 'package:simsar/Screens/edit_profile_screen.dart';
import 'package:simsar/Screens/add_listing_screen.dart';
import 'package:simsar/Screens/add_review_screen.dart';
import 'package:simsar/Screens/admin_approval.dart';
import 'package:simsar/Screens/booking_success_screen.dart';
import 'package:simsar/Screens/details_screen.dart';
import 'package:simsar/Screens/my_bookings_screen.dart';
import 'package:simsar/Screens/edit_listing_screen.dart';
import 'package:simsar/Screens/home_screen.dart';
import 'package:simsar/Screens/login_screen.dart';
import 'package:simsar/Screens/notifactions_screen.dart';
import 'package:simsar/Screens/owner_home.dart';
import 'package:simsar/Screens/pending_approval_screen.dart';
import 'package:simsar/Screens/register_screen.dart';
import 'package:simsar/Screens/add_review_screen.dart';
import 'package:simsar/Layouts/main_layout.dart';
import 'package:simsar/Screens/favourites_screen.dart';
import 'package:simsar/Screens/profile_screen.dart';
import 'package:simsar/Layouts/owner_layout.dart';
import 'package:simsar/Screens/wallet_screen.dart';
import '../Screens/booking_edit_screen.dart';
import '../Screens/booking_request_details.dart';
import '../Screens/booking_summary_screen.dart';
class AppRouter {
  static const String home = '/home';
  static const String login = '/login';
  static const String register = '/register';
  static const String pendingApproval = '/pending-approval';
  static const String favorites = '/favorites';
  static const String bookings = '/bookings';
  static const String profile = '/profile';
  static const String editProfile = '/edit-profile';
  static const String ownerLayout = '/owner-layout';
  static const String ownerHome = '/owner-home';
  static const String ownerBookingRequests = '/owner-booking-requests';
  static const String ownerProfile = '/owner-profile';
  static const String about = '/about';
  static const String wallet = '/wallet';
  static const String notifications = '/notifications';
  static const String bookingSummary = '/booking-summary';
  static const String editListing = '/edit-listing';
  static const String detailsScreen = '/details';
  static const String bookingDate = '/booking-date';
  static const String bookingSuccess = '/booking-success';
  static const String addListing = '/add-listing';
  static const String adminApproval = '/admin-approval';
  static const String addReview = '/add-review';
  static const String editBooking = '/edit-booking';
  static final GoRouter router = GoRouter(
    initialLocation: login,
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
      GoRoute(
        path: editProfile,
        builder: (context, state) => const ProfileDetailsViewScreen(),
      ),
      GoRoute(
        path: about,
        builder: (context, state) => const AboutPage(),
      ),
      GoRoute(
        path: wallet,
        builder: (context, state) {
          final amount = state.extra as double? ?? 0.0;
          return WalletScreen(amount: amount);
        },
      ),
      GoRoute(
      path: notifications,
      builder: (context, state) => const NotifactionsScreen(),
      ),
      ShellRoute(
        builder: (context, state, child) {
          return MainLayout(child: child);
        },
        routes: [

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
          GoRoute(
            path: home,
            builder: (context, state) => const HomeScreen(),
          ),
          GoRoute(
            path: favorites,
            builder: (context, state) => const FavouritesScreen(),
          ),
          GoRoute(
            path: bookings,
            builder: (context, state) => const MyBookingScreen(),
          ),
          GoRoute(
            path: profile,
            builder: (context, state) => const ProfileScreen(),
          ),
          GoRoute(
            path: '$addReview/:bookingId',
            builder: (context, state) {
              final id = int.parse(state.pathParameters['bookingId']?? '0');
              return AddReviewScreen(bookingId: id);
            },
          ),

          GoRoute(
              path: adminApproval,
              builder: (context, state) => const AdminApprovalScreen()
          ),
          GoRoute(
            path: '/booking/:id',
            builder: (context, state) {
              final bookingId = int.parse(state.pathParameters['id']!);
              return BookingDetailsScreen(bookingId: bookingId);
            },
          ),

        ],
      ),

      ShellRoute(
        builder: (context, state, child) {
          return OwnerLayout(child: child);
        },
        routes: [
          GoRoute(
            path: '$editListing/:propertyId',
            builder: (context, state) {
              final id = int.parse(state.pathParameters['propertyId']?? '0');
              return EditListingScreen( id: id);
            },
          ),
          GoRoute(
            path: ownerHome,
            builder: (context, state) => const OwnerHomeScreen(),
          ),
          GoRoute(
            path: ownerBookingRequests,
            builder: (context, state) => const OwnerHomeScreen(),
          ),
          GoRoute(
            path: ownerProfile,
            builder: (context, state) => const ProfileScreen(),
          ),
          GoRoute(
              path: addListing,
              builder: (context, state) => const AddListingScreen()
          ),
        ],
      ),
    ],
  );
}