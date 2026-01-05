import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:simsar/Theme/app_colors.dart';
import 'package:simsar/Custom_Widgets/Tiles/read_only_field.dart';
import 'package:simsar/Custom_Widgets/Tiles/read_only_password_field.dart';
import 'package:simsar/Network/api_client.dart'; // Import your DioClient

class ProfileDetailsViewScreen extends StatefulWidget {
  const ProfileDetailsViewScreen({super.key});

  @override
  State<ProfileDetailsViewScreen> createState() => _ProfileDetailsViewScreenState();
}

class _ProfileDetailsViewScreenState extends State<ProfileDetailsViewScreen> {
  Map<String, dynamic>? userData;
  bool isLoading = false;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    _fetchProfileDetails();
  }

  Future<void> _fetchProfileDetails() async {
    try {
      setState(() {
        isLoading = true;
        errorMessage = null;
      });

      final response = await DioClient.dio.get('/api/me');
      
      setState(() {
        userData = response.data;
      });
    } catch (e) {
      setState(() {
        errorMessage = "Failed to load details";
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Data Mapping from API
    final String firstName = userData?['first_name'] ?? '';
    final String lastName = userData?['last_name'] ?? '';
    final String fullName = '$firstName $lastName'.trim();
    final String phone = userData?['phone'] ?? '';
    final String birthday = userData?['birth_date'] ?? '';
    final String? photoUrl = userData?['photo'];
    const String password = '123456'; // Static as requested

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // 🔹 Header (Original Theme Maintained)
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

              // 🔹 Content States
              if (isLoading)
                const Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 40),
                    child: CircularProgressIndicator(),
                  ),
                )
              else if (errorMessage != null)
                Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 40),
                    child: Text(
                      errorMessage!,
                      style: const TextStyle(color: Colors.red),
                    ),
                  ),
                )
              else ...[
                // 🔹 Profile image (Logic for Placeholder)
                CircleAvatar(
                  radius: 70,
                  backgroundColor: SAppColors.white,
                  backgroundImage: (photoUrl != null && photoUrl.isNotEmpty)
                      ? NetworkImage(photoUrl) as ImageProvider
                      : const AssetImage('assets/images/profile_placeholder.png'),
                  onBackgroundImageError: (exception, stackTrace) {
                    debugPrint("Error loading profile image: $exception");
                  },
                ),

                const SizedBox(height: 64),

                // 🔹 Read-only fields (Mapping dynamic values)
                SReadOnlyField(
                  labelText: "Full Name",
                  value: fullName.isEmpty ? "No Name" : fullName,
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

                // 🔹 Log Out Button (Original Theme Maintained)
                Center(
                  child: SizedBox(
                    width: 200,
                    child: ElevatedButton(
                      onPressed: () {
                        // Log out logic will go here
                      },
                      child: const Text("Log Out"),
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}