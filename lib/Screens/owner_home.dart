import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:simsar/Custom_Widgets/Tiles/owner_property_tile.dart';
import 'package:simsar/Models/property_model.dart';
import 'package:simsar/Theme/app_colors.dart';
import 'package:simsar/Custom_Widgets/Tiles/owner_home_header.dart';
import 'package:simsar/Network/api_client.dart';

class OwnerHomeScreen extends StatefulWidget {
  const OwnerHomeScreen({super.key});

  @override
  State<OwnerHomeScreen> createState() => _OwnerHomeScreenState();
}

class _OwnerHomeScreenState extends State<OwnerHomeScreen> {
  List<Property> properties = [];
  bool isLoading = false;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    _fetchOwnerApartments();
  }

  Future<void> _fetchOwnerApartments() async {
    try {
      setState(() {
        isLoading = true;
        errorMessage = null;
      });

      final response =
          await DioClient.dio.get('/api/owner/apartments');

      final List data = response.data;

      final fetchedProperties =
          data.map((e) => Property.fromApiJson(e)).toList();

      setState(() {
        properties = fetchedProperties;
      });
    } catch (e) {
      setState(() {
        errorMessage = 'Failed to load your properties';
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 90),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                OwnerHomeHeader(
                  title: "Your Listed Properties",
                  description:
                      "Manage your property listings and view bookings.",
                ),

                const SizedBox(height: 20),

                // 🔹 STATES
                if (isLoading)
                  const Expanded(
                    child: Center(child: CircularProgressIndicator()),
                  )
                else if (errorMessage != null)
                  Expanded(
                    child: Center(
                      child: Text(
                        errorMessage!,
                        style: const TextStyle(color: SAppColors.error),
                      ),
                    ),
                  )
                else if (properties.isEmpty)
                  const Expanded(
                    child: Center(child: Text("You have no listed properties.")),
                  )
                else
                  Expanded(
                    child: ListView.separated(
                      itemCount: properties.length,
                      separatorBuilder: (_, __) => Divider(
                        color: SAppColors.outlineGray
                            .withValues(alpha: 0.25),
                        thickness: 1,
                      ),
                      itemBuilder: (context, index) {
                        final property = properties[index];

                        return OwnerPropertyTile(
                          property: property,
                          onTap: () {
                            context.push(
                              '/owner-property-details',
                              extra: property,
                            );
                          },
                        );
                      },
                    ),
                  ),
              ],
            ),
          ),

          // 🔹 Fixed bottom button
          Positioned(
            left: 16,
            right: 16,
            bottom: 12,
            child: SizedBox(
              height: 48,
              child: ElevatedButton(
                onPressed: () => context.go('/add-a-listing'),
                child: const Text("Add a Listing"),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
