import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:simsar/Theme/app_colors.dart';
class ProfileTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String route;
  final VoidCallback? onTap;

  const ProfileTile({
    super.key,
    required this.icon,
    required this.title,
    required this.route,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 327,
      height: 24,
      child: InkWell(
        onTap: onTap ?? () => context.push(route),
        child: Row(
          children: [
            Icon(
              icon,
              size: 24,
              color: SAppColors.secondaryDarkBlue,
            ),
            const SizedBox(width: 10),

            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: SAppColors.secondaryDarkBlue,
              ),
            ),

            const Spacer(),

            const Icon(
              Icons.chevron_right,
              size: 24,
              color: SAppColors.secondaryDarkBlue,
            ),
          ],
        ),
      ),
    );
  }
}
