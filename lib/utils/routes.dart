import 'package:go_router/go_router.dart';
import 'package:simsar/Screens/about_screen.dart';
import 'package:simsar/Screens/edit_profile_screen.dart';
import 'package:simsar/Screens/home_screen.dart';
import 'package:simsar/Screens/login_screen.dart';
import 'package:simsar/Screens/notifactions_screen.dart';
import 'package:simsar/Screens/owner_home.dart';
import 'package:simsar/Screens/pending_approval_screen.dart';
import 'package:simsar/Screens/register_screen.dart';
import 'package:simsar/Layouts/main_layout.dart';
import 'package:simsar/Screens/favourites_screen.dart';
import 'package:simsar/Screens/profile_screen.dart';
import 'package:simsar/Layouts/owner_layout.dart';
import 'package:simsar/Screens/wallet_screen.dart';
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

  static final GoRouter router = GoRouter(
    initialLocation: home,
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
            path: home,
            builder: (context, state) => const HomeScreen(),
          ),
          GoRoute(
            path: favorites,
            builder: (context, state) => const FavouritesScreen(),
          ),
          GoRoute(
            path: bookings,
            builder: (context, state) => const HomeScreen(),
          ),
          GoRoute(
            path: profile,
            builder: (context, state) => const ProfileScreen(),
          ),
        ],
      ),

      ShellRoute(
        builder: (context, state, child) {
          return OwnerLayout(child: child);
        },
        routes: [
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
        ],
      ),
    ],
  );
}