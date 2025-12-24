import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:simsar/Theme/app_colors.dart';

class PendingApprovalScreen extends StatelessWidget {
  const PendingApprovalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.pending_actions_rounded,
                size: 80,
                color: SAppColors.primaryBlue,
              ),
              const SizedBox(height: 32),

              // titleLarge: Inter / Semibold / 20
              Text(
                "Registration Pending",
                style: textTheme.titleLarge,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),

              // bodyMedium: Inter / Regular / 14
              Text(
                "Your account is currently being reviewed. Please wait for admin approval before you can access all features.",
                style: textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 48),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => context.go('/login'),
                  child: const Text("Back to Login"),
                ),
              ),
              const SizedBox(height: 24),
              
              // bodySmall: Inter / Regular / 10
              Text(
                "If you think this is a mistake, please contact support.",
                style: textTheme.bodySmall,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}