import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:simsar/Theme/app_colors.dart';
import 'package:simsar/Custom_Widgets/Tiles/read_only_field.dart';
import 'dart:typed_data';
import 'package:simsar/Custom_Widgets/Tiles/read_only_password_field.dart';
class ProfileDetailsViewScreen extends StatelessWidget {
  const ProfileDetailsViewScreen({super.key});

  final Uint8List? profilePhoto = null; // Replace with actual photo data if available
  final String firstName = 'Ahmad';
  final String lastName = 'Al-Hassan';
  final String phone = '0991234567';
  final String birthday = '12 / 04 / 1999';
  final String password = '123456';
  String get fullName => '$firstName $lastName';


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              // 🔹 Header
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
                    "Profile Details",
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

              // 🔹 Profile image (display only)
              CircleAvatar(
              radius: 70,
              backgroundColor: SAppColors.white,
              backgroundImage: profilePhoto != null
                  ? MemoryImage(profilePhoto!) as ImageProvider
                : const AssetImage('assets/images/profile_placeholder.png'),
            // Optional: Add a foreground image or child if you want to overlay something
            onBackgroundImageError: (exception, stackTrace) {
            debugPrint("Error loading profile image: $exception");
          },
            ),

              const SizedBox(height: 64),


              // 🔹 Read-only fields
              SReadOnlyField(
                labelText: "Full Name",
                value: fullName,
                prefixIcon: const Icon(Icons.person, color: SAppColors.secondaryDarkBlue),
              ),
              const SizedBox(height: 32),

              
              SReadOnlyField(
                labelText: "Phone Number",
                value: phone,
                prefixIcon: const Icon(Icons.phone, color: SAppColors.secondaryDarkBlue),
              ),
              const SizedBox(height: 32),

              SReadOnlyPasswordField(
                labelText: "Password",
                value: password,
              ),
              const SizedBox(height: 32),

              SReadOnlyField(
                labelText: "Birthday",
                value: birthday,
                prefixIcon: const Icon(Icons.cake, color: SAppColors.secondaryDarkBlue),
              ),
              const SizedBox(height: 64),

              Center(
              child: SizedBox(
                width: 200,
                child: ElevatedButton(
                  onPressed: () {},
                  child: const Text("Log Out"),
                ),
              ),
            ),
            ],
          ),
        ),
      ),
    );
  }
}
