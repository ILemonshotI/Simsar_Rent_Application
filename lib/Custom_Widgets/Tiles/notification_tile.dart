import 'package:flutter/material.dart';
import 'package:simsar/Theme/app_colors.dart';
import 'package:simsar/Theme/text_theme.dart';

class NotificationsTile extends StatelessWidget {
  final String title;
  final String description;

  const NotificationsTile({
    super.key,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Icon with subtle emphasis
          Icon(
            Icons.notifications,
            color: SAppColors.secondaryDarkBlue,
            size: 32,
          ),

          const SizedBox(width: 14),

          // Text content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: STextTheme.lightTextTheme.labelLarge,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: STextTheme.lightTextTheme.displayMedium,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),

          // Optional subtle divider indicator
          Container(
            width: 2,
            height: 32,
            decoration: BoxDecoration(
              color: SAppColors.secondaryDarkBlue.withValues(alpha:0.4),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
        ],
      ),
    );
  }
}
