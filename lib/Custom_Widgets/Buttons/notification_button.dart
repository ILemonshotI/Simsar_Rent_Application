import 'package:flutter/material.dart';
import 'package:simsar/Theme/app_colors.dart'; 

class NotificationButton extends StatelessWidget {
  final VoidCallback onTap;

  const NotificationButton({
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          // Using a light gray border or background as seen in standard UI kits
          color: SAppColors.transparent, 
          borderRadius: BorderRadius.circular(33),
          border: Border.all(
            color: SAppColors.outlineGray,
            width: 1,
          ),
        ),
        child: const Center(
          child: Icon(
            Icons.notifications_none_outlined, // Standard bell icon
            size: 24,
            color: SAppColors.textGray, // Adjust color to match your theme
          ),
        ),
      ),
    );
  }
}