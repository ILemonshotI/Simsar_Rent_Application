import 'package:flutter/material.dart';
import 'package:simsar/Theme/app_colors.dart'; // Import your custom colors
import 'package:simsar/Models/property_models.dart';
import 'package:simsar/Network/api_client.dart';
class FavoriteButton extends StatefulWidget {
  final Property property;

  const FavoriteButton({super.key, required this.property});

  @override
  _FavoriteButtonState createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavoriteButton> {
  bool isProcessing = false;

  Future<void> _toggleFavorite() async {
    if (isProcessing) return;

    setState(() => isProcessing = true);

    final originalState = widget.property.isFavorite;
    final apartmentId = widget.property.id;

    try {
      // Optimistic Update: Change UI immediately for better UX
      setState(() => widget.property.isFavorite = !originalState);

      if (originalState) {
        // Was favorite, now delete it
        await DioClient.dio.delete('/api/apartments/$apartmentId/favorite');
      } else {
        // Wasn't favorite, now add it
        await DioClient.dio.post('/api/apartments/$apartmentId/favorite');
      }
    } catch (e) {
      // Revert if API fails
      setState(() => widget.property.isFavorite = originalState);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Action failed. Please try again.")),
      );
    } finally {
      setState(() => isProcessing = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        widget.property.isFavorite ? Icons.favorite : Icons.favorite_border,
        color: SAppColors.heartRed,
      ),
      onPressed: _toggleFavorite,
    );
  }
}