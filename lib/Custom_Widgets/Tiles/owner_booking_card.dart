import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Add this to your pubspec.yaml for date formatting
import 'package:simsar/Custom_Widgets/Buttons/primary_button.dart';
import 'package:simsar/Models/booking_model.dart';
import 'package:simsar/Models/property_models.dart';
import 'package:simsar/Theme/app_colors.dart';
import 'package:simsar/Models/user_model.dart';


class OwnerBookingCard extends StatelessWidget {
  final Property property;
  final User user; 
  final Booking booking;
  final bool isUpcoming;
  final bool isCompleted;
  final VoidCallback onCancel;
  final VoidCallback onApproved;

  const OwnerBookingCard({
    super.key,
    required this.user,
    required this.property,
    required this.isUpcoming,
    required this.isCompleted,
    required this.booking,
    required this.onCancel,
    required this.onApproved,
  });

  @override
  Widget build(BuildContext context) {
    final String startDateStr = DateFormat('MMM dd, yyyy').format(booking.startDate);
    final String endDateStr = DateFormat('MMM dd, yyyy').format(booking.endDate);

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
        color: SAppColors.white,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Stack(
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 26,
                    backgroundColor: SAppColors.white,
                    backgroundImage: (user.photo.isNotEmpty)
                        ? NetworkImage(user.photo) as ImageProvider
                        : const AssetImage('assets/images/profile_placeholder.png'),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          user.fullName,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold, 
                            fontSize: 16, 
                            color: SAppColors.textGray
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        Text.rich(
                          TextSpan(
                            style: const TextStyle(color: SAppColors.textGray, fontSize: 13),
                            children: [
                              const TextSpan(text: "Property: ", style: TextStyle(fontWeight: FontWeight.bold)),
                              TextSpan(text: property.title),
                            ],
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          "$startDateStr - $endDateStr",
                          style: const TextStyle(
                            fontSize: 12, 
                            fontWeight: FontWeight.w600,
                            color: SAppColors.secondaryDarkBlue
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 80),
                ],
              ),
              Positioned(
                top: 0,
                right: 0,
                child: _buildStatusBadge(booking.status),
              ),
            ],
          ),
          
          // Only show buttons if the booking is Pending (isUpcoming)
          if (isUpcoming) ...[
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 12.0),
              child: Divider(height: 1),
            ),
            Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 52, // Match SPrimaryButton height
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: SAppColors.error,
                        foregroundColor: SAppColors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                      onPressed: () => _showCancelDialog(context),
                      child: const Text("Reject", style: TextStyle(fontWeight: FontWeight.w600)),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: SPrimaryButton(
                    onPressed: () => onApproved(),
                    text: "Approve",
                  ),
                ),
              ],
            ),
          ],
          
          // isCompleted refers to "Approved" tab. We removed the button here as requested.
        ],
      ),
    );
  }

  void _showCancelDialog(BuildContext context) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Reject Booking'),
        content: const Text('Confirm rejection of booking for this tenant?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Back')),
          TextButton(onPressed: () => Navigator.pop(context, true), child: const Text('Confirm')),
        ],
      ),
    );
    if (confirm == true) onCancel();
  }

  Widget _buildStatusBadge(String status) {
    Color bgColor;
    Color textColor;
    switch (status.toLowerCase()) {
      case 'approved':
        bgColor = const Color(0xFFE3FCEC);
        textColor = const Color(0xFF19B000);
        break;
      case 'pending':
        bgColor = const Color(0xFFE6F2FF);
        textColor = const Color(0xFF007AFF);
        break;
      case 'rejected':
        bgColor = const Color(0xFFFFE5E5);
        textColor = const Color(0xFFFF3B30);
        break;
      case 'cancelled':
        bgColor = const Color(0xFFFFE5E5);
        textColor = const Color(0xFFFF3B30);
        break;
      default:
        bgColor = const Color(0xFFFFE5E5);
        textColor = const Color(0xFFFF3B30);
        break;
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(color: bgColor, borderRadius: BorderRadius.circular(8)),
      child: Text(
        status.toUpperCase(),
        style: TextStyle(color: textColor, fontSize: 10, fontWeight: FontWeight.bold),
      ),
    );
  }
}