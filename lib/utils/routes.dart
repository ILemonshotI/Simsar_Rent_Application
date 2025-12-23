import 'package:go_router/go_router.dart';
import 'package:simsar/Screens/home_screen.dart';
import 'package:simsar/Screens/login_screen.dart';
import 'package:simsar/Screens/pending_approval_screen';
import 'package:simsar/Screens/register_screen.dart';

class AppRouter {
  static const String home = '/home';
  static const String login = '/login';
  static const String register = '/register';
  static const String pendingApproval = '/pending-approval';

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
        path: home,
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: pendingApproval,
        builder: (context, state) => const PendingApprovalScreen(),
      )
    ],
  );
}