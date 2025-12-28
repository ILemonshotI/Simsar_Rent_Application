import 'package:flutter/material.dart';
import 'package:simsar/Models/data_filter_model.dart';
import 'package:simsar/Theme/app_colors.dart';
void showCalendarSheet(
  BuildContext context,
  DateFilter currentFilter,
  Function(DateFilter) onApply,
) {
  DateFilter tempFilter = currentFilter.copy();

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
    ),
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setModalState) {
          return Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Drag handle
                Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: SAppColors.background,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),

                const SizedBox(height: 16),

                const Text(
                  "Select Date",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: SAppColors.secondaryDarkBlue,
                  ),
                ),

                const SizedBox(height: 16),

                CalendarDatePicker(
                  initialDate: tempFilter.start ?? DateTime.now(),
                  firstDate: DateTime.now(),
                  lastDate: DateTime.now().add(const Duration(days: 365)),
                  onDateChanged: (date) {
                    setModalState(() {
                      // Same logic you described
                      if (tempFilter.start == null ||
                          tempFilter.end != null) {
                        tempFilter.start = date;
                        tempFilter.end = null;
                      } else {
                        tempFilter.end = date;
                      }
                    });
                  },
                ),

                const SizedBox(height: 16),

                // Selected range preview (optional but UX 🔥)
                if (tempFilter.start != null)
                  Text(
                    tempFilter.end == null
                        ? "Start: ${_fmt(tempFilter.start!)}"
                        : "From ${_fmt(tempFilter.start!)} → ${_fmt(tempFilter.end!)}",
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      color: SAppColors.secondaryDarkBlue,
                    ),
                  ),

                const SizedBox(height: 24),

                // Save button
                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton(
                    onPressed: () {
                      onApply(tempFilter);
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: SAppColors.secondaryDarkBlue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      "Save",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      );
    },
  );
}
String _fmt(DateTime d) {
  return "${d.year}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}";
}
