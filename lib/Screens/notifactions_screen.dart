import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:simsar/Theme/app_colors.dart';
import 'package:simsar/Theme/text_theme.dart';
class NotifactionsScreen extends StatefulWidget {
  const NotifactionsScreen({super.key});

  @override
  State<NotifactionsScreen> createState() => _NotifactionsScreenState();
}

class _NotifactionsScreenState extends State<NotifactionsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
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
                  const SizedBox(width: 72),
                  
                ],
              ),

              const SizedBox(height: 48),
               Center(
                child: Image.asset(
                  'assets/images/no-notifications.png',
                  width: 274,
                  height: 202,
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(height: 48),

              // 🔹 Title
              Text(
                "No notifications yet",
                style: STextTheme.lightTextTheme.titleLarge,
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 16),

              // 🔹 Description
              Text(
                "All notification we send will appear here, so you can view them easily anytime.",
                style: STextTheme.lightTextTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}