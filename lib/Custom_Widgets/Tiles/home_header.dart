import 'package:flutter/material.dart';
import 'package:simsar/Custom_Widgets/Buttons/notification_button.dart'; 
import 'package:simsar/Theme/text_theme.dart';
class HomeHeader extends StatelessWidget {
  final String title;
  final VoidCallback onNotificationTap;

  const HomeHeader({
    super.key,
    required this.title,
    required this.onNotificationTap,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 360,
        height: 44,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(top: 9, bottom: 9),
              child: Text(
                title,
                style: STextTheme.lightTextTheme.titleLarge!.copyWith(fontWeight: FontWeight.w800),
              ),
            ),
            ),

            // Middle: The 90x44 Sized Box
            const SizedBox(
              width: 30,
              height: 44,
            ),

            // Right Side: Notification Button
            NotificationButton(
              onTap: onNotificationTap,
            ),
          ],
        ),
      ),
    );
  }
}