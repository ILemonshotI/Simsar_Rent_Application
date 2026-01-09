import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

import '../Network/api_client.dart';

class AddReviewScreen extends StatefulWidget {
  final int bookingId;

  const AddReviewScreen({
    super.key,
    required this.bookingId,
  });

  @override
  State<AddReviewScreen> createState() => _AddReviewScreenState();
}

class _AddReviewScreenState extends State<AddReviewScreen> {
  final TextEditingController _commentController = TextEditingController();
  final Dio _dio = Dio();

  int _rating = 0;
  bool _isSubmitting = false;

  Future<void> _submitReview() async {
    if (_rating == 0) {
      _showError('Please select a rating.');
      return;
    }

    if (_commentController.text.trim().isEmpty) {
      _showError('Please write a review.');
      return;
    }

    setState(() => _isSubmitting = true);

    try {
      await DioClient.dio.post(
        '/api/reviews',
        data: {
          'booking_id': widget.bookingId,
          'rating': _rating,
          'comment': _commentController.text.trim(),
        },
      );

      if (!mounted) return;

      Navigator.pop(context, true); // success result
    } on DioException catch (e) {
      _showError(
        e.response?.data?['message'] ?? 'Failed to submit review.',
      );
    } finally {
      if (mounted) {
        setState(() => _isSubmitting = false);
      }
    }
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  Widget _buildStar(int index) {
    return IconButton(
      icon: Icon(
        index <= _rating ? Icons.star : Icons.star_border,
        color: Colors.amber,
        size: 36,
      ),
      onPressed: () {
        setState(() => _rating = index);
      },
    );
  }

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Review'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Your Rating',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Row(
              children: List.generate(5, (index) => _buildStar(index + 1)),
            ),
            const SizedBox(height: 24),
            const Text(
              'Your Review',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _commentController,
              maxLines: 5,
              decoration: const InputDecoration(
                hintText: 'Write your experience...',
                border: OutlineInputBorder(),
              ),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _isSubmitting ? null : _submitReview,
                child: _isSubmitting
                    ? const SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
                    : const Text('Submit Review'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
