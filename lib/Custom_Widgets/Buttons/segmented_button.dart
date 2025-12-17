import 'package:flutter/material.dart';

class SSegmentedButton<T> extends StatelessWidget {
  final T selected;
  final List<ButtonSegment<T>> segments;
  final ValueChanged<T> onSelectionChanged;
  final double width;

  const SSegmentedButton({
    super.key,
    required this.selected,
    required this.segments,
    required this.onSelectionChanged,
    this.width = 160, // Matching your inputs & buttons
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: width,
        child: SegmentedButton<T>(
          // Applies your SSegmentedButtonTheme automatically
          segments: segments,
          selected: {selected},
          onSelectionChanged: (Set<T> newSelection) {
            onSelectionChanged(newSelection.first);
          },
          // Hides the checkmark for a cleaner "toggle" look
          showSelectedIcon: false, 
        ),
      ),
    );
  }
}