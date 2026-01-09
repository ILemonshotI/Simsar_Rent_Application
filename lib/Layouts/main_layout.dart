import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:simsar/Theme/app_colors.dart';
import 'package:simsar/Theme/text_theme.dart';
class MainLayout extends StatelessWidget {
  final Widget child;
  const MainLayout({super.key, required this.child});

  static const tabs = [
    '/home',
    '/favorites',
    '/bookings',
    '/profile',
  ];

  int _locationToIndex(String location) {
    final index = tabs.indexWhere((path) => location.startsWith(path));
    return index < 0 ? 0 : index;
  }

  @override
  Widget build(BuildContext context) {
    final location = GoRouterState.of(context).uri.toString();
    final currentIndex = _locationToIndex(location);

    return Scaffold(
      body: child,
      bottomNavigationBar: SizedBox(
        height: 85, // matches your design (375x85)
        child: BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: (index) {
            context.go(tabs[index]);
          },
          type: BottomNavigationBarType.fixed,
          selectedItemColor: SAppColors.secondaryDarkBlue,
          unselectedItemColor: SAppColors.descriptionTextGray,
          selectedLabelStyle: STextTheme.lightTextTheme.headlineSmall!.copyWith(color: SAppColors.secondaryDarkBlue),
          unselectedLabelStyle: STextTheme.lightTextTheme.headlineSmall,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          iconSize: 24,
          backgroundColor: Theme.of(context).brightness == Brightness.dark
            ? SAppColors.darkBackground
            : SAppColors.background,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite_border),
              label: 'Favorite',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.receipt_long),
              label: 'My Booking',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}
