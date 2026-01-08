import 'package:flutter/material.dart';
import 'package:simsar/Theme/app_colors.dart';
import 'package:simsar/Theme/text_theme.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SAppColors.background,
      appBar: AppBar(
        title: const Text("About Us"),
        backgroundColor: SAppColors.background,
        elevation: 0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
        child: Center(
          child: Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: SAppColors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            constraints: const BoxConstraints(maxWidth: 600),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title
                Text(
                  "Welcome to Simsar!",
                  style: STextTheme.lightTextTheme.titleLarge!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),

                // Description
                Text(
                  "Simsar is your go-to platform for renting properties across Syria. "
                  "Whether you're looking for a cozy apartment in Damascus, "
                  "a luxury villa in Rif Dimashq, or a seaside penthouse in Latakia, "
                  "we make it easy to find your perfect rental. "
                  "Our goal is to provide a seamless, secure, and transparent renting experience, "
                  "connecting tenants and property owners with ease.",
                  style: STextTheme.lightTextTheme.bodyMedium!.copyWith(height: 1.5),
                ),
                const SizedBox(height: 24),

                // Features
                Text(
                  "Our Features:",
                  style: STextTheme.lightTextTheme.titleMedium!
                      .copyWith(fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text("• Browse apartments, villas, and penthouses"),
                    Text("• Detailed property listings with images and reviews"),
                    Text("• Contact property owners directly"),
                    Text("• Secure booking and easy payment options"),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
