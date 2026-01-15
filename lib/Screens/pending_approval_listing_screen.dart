import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:simsar/Theme/app_colors.dart';

class PendingApprovalListingScreen extends StatelessWidget {
  const PendingApprovalListingScreen({super.key});

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
                Icons.location_city_outlined,
                size: 80,
                color: SAppColors.primaryBlue,
              ),
              const SizedBox(height: 32),

              // titleLarge: Inter / Semibold / 20
              Text(
                "Property Listing Pending",
                style: textTheme.titleLarge,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),

              // bodyMedium: Inter / Regular / 14
              Text(
                "Your property listing is currently being reviewed. Please wait for admin approval before your property is listed.",
                style: textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 48),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => context.push('/owner-home'),
                  child: const Text("Back to Home"),
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