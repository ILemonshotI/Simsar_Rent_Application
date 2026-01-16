import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:simsar/Theme/app_colors.dart';
import 'package:simsar/Theme/text_theme.dart';
import 'package:simsar/Custom_Widgets/Tiles/profile_tile.dart';
import 'package:simsar/Network/api_client.dart';
class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Map<String, dynamic>? userData;
  bool isLoading = false;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    _fetchProfile();
  }

  Future<void> _fetchProfile() async {
    try {
      setState(() {
        isLoading = true;
        errorMessage = null;
      });

      // AuthInterceptor handles the token automatically
      final response = await DioClient.dio.get('/api/me');

      setState(() {
        userData = response.data;
      });
    } catch (e) {
      setState(() {
        errorMessage = "Failed to load profile info";
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

 @override
Widget build(BuildContext context) {
  final String firstName = userData?['first_name'] ?? "";
  final String lastName = userData?['last_name'] ?? "";
  final String fullName = (firstName.isEmpty && lastName.isEmpty) 
      ? "Guest User" 
      : "$firstName $lastName";

  final String? photoUrl = userData?['photo'];  
  debugPrint(photoUrl);

  return SafeArea(
    child: SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 🔹 Custom App Bar (Since you already have a parent Scaffold)
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
                "Profile",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: SAppColors.secondaryDarkBlue,
                ),
              ),
              const SizedBox(width: 48), 
            ],
          ),

          const SizedBox(height: 48),
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
                  child: Text(errorMessage!, style: const TextStyle(color: SAppColors.error)),
                ),
              )
            else
              Center(
                child: Column(
                  children: [
                    // PROFILE IMAGE
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

                    const SizedBox(height: 16),

                    // FULL NAME
                    Text(
                      fullName,
                      style: STextTheme.lightTextTheme.titleMedium!.copyWith(
                        fontWeight: FontWeight.w600,
                        color: SAppColors.secondaryDarkBlue,
                      ),
                    ),

                    const SizedBox(height: 48),

                    // MENU TILES
                    ProfileTile(
                      icon: Icons.person,
                      title: 'Profile Details',
                      route: '/edit-profile',
                    ),
                    const SizedBox(height: 20),
                    ProfileTile(
                      icon: Icons.info_outline,
                      title: 'About',
                      route: '/about',
                    ),
                    const SizedBox(height: 20),
                    ProfileTile(
                      icon: Icons.account_balance_wallet_outlined,
                      title: 'Wallet',
                      route: '/wallet',
                      onTap: () {
                        // Calculate the amount from the API data we fetched earlier
                        final walletValue = userData?['wallet'];
                        final double amount = double.tryParse(walletValue.toString()) ?? 0.0;

                        context.push('/wallet', extra: amount);
                      },
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}