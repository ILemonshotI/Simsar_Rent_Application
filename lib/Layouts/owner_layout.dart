import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:simsar/Theme/app_colors.dart';
import 'package:simsar/Theme/text_theme.dart';
class OwnerLayout extends StatelessWidget {
  final Widget child;
  const OwnerLayout({super.key, required this.child});

  static const tabs = [
    '/owner-home',
    '/owner-booking-requests',
    '/owner-profile',
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
            context.push(tabs[index]);
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
              icon: Icon(Icons.receipt_long),
              label: 'Booking Requests',
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
