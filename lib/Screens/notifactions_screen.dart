import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:simsar/Custom_Widgets/Tiles/notification_tile.dart';
import 'package:simsar/Theme/app_colors.dart';
import 'package:simsar/Theme/text_theme.dart';

class NotifactionsScreen extends StatefulWidget {
  const NotifactionsScreen({super.key});

  @override
  State<NotifactionsScreen> createState() => _NotifactionsScreenState();
}

class _NotifactionsScreenState extends State<NotifactionsScreen> {

  // 🔹 Static notifications (mock data)
  final List<Map<String, String>> notifications = [
    {
      'title': 'New Message',
      'description': 'You have received a new message',
    },
    {
      'title': 'Booking Update',
      'description': 'Your booking has been confirmed',
    },
    {
      'title': 'Reminder',
      'description': 'Dont forget your appointment tomorrow',
    },
  ];

  final List<Map<String, String>> emptyNotifications = [
   
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [

              /// 🔹 Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    icon: const Icon(
                      Icons.arrow_back,
                      color: SAppColors.secondaryDarkBlue,
                    ),
                    onPressed: () => context.pop(),
                  ),
                  const Text(
                    "Notifications",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: SAppColors.secondaryDarkBlue,
                    ),
                  ),
                  const SizedBox(width: 40),
                ],
              ),

              const SizedBox(height: 32),

              /// 🔹 Content
              Expanded(
                child: notifications.isEmpty
                    ? _buildEmptyState()
                    : _buildNotificationsList(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// 🔹 Empty State UI
  Widget _buildEmptyState() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          'assets/images/no-notifications.png',
          width: 274,
          height: 202,
          fit: BoxFit.contain,
        ),
        const SizedBox(height: 48),
        Text(
          "No notifications yet",
          style: STextTheme.lightTextTheme.titleLarge,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        Text(
          "All notifications we send will appear here, so you can view them easily anytime.",
          style: STextTheme.lightTextTheme.bodyMedium,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  /// 🔹 Notifications List
  Widget _buildNotificationsList() {
    return ListView.separated(
      itemCount: notifications.length,
      separatorBuilder: (_, __) => const SizedBox(height: 16),
      itemBuilder: (context, index) {
        final notification = notifications[index];
        return NotificationsTile(
          title: notification['title']!,
          description: notification['description']!,
        );
      },
    );
  }
}
