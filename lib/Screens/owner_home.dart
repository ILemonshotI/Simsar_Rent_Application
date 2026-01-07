import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:simsar/Custom_Widgets/Tiles/owner_property_tile.dart';
import 'package:simsar/Custom_Widgets/Tiles/home_header.dart';
import 'package:simsar/Models/property_model.dart';
import 'package:simsar/Theme/app_colors.dart';
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

      final response = await DioClient.dio.get(
        '/api/owner/apartments',
      );

      final List data = response.data;

      final fetchedProperties =
          data.map((e) => Property.fromApiJson(e)).toList();

      setState(() {
        properties = fetchedProperties;
      });
    } catch (e) {
      setState(() {
        errorMessage = 'Failed to load your apartments';
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
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            HomeHeader(
              title: "My Properties",
              onNotificationTap: () {
                debugPrint("Owner notifications");
              },
            ),

            const SizedBox(height: 20),

            // CONTENT STATES
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
            else if (properties.isEmpty)
              const Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 40),
                  child: Text("You have no properties yet"),
                ),
              )
            else
              // OWNER PROPERTY LIST
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: properties.length,
                separatorBuilder: (_, __) => Divider(
                  color: SAppColors.outlineGray.withValues(alpha: 0.25),
                  thickness: 1,
                  indent: 8,
                  endIndent: 8,
                ),
                itemBuilder: (context, index) {
                  final property = properties[index];

                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: OwnerPropertyTile(
                      property: property,
                      onTap: () {
                        context.push(
                          '/ownerPropertyDetails',
                          extra: property,
                        );
                      },
                    ),
                  );
                },
              ),
          ],
        ),
      ),
    );
  }
}
