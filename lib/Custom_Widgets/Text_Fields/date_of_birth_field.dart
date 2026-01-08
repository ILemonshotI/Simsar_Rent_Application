import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:simsar/Theme/app_colors.dart';
class SDatePickerField extends StatefulWidget {
  final String labelText;
  final Function(DateTime) onDateSelected;
  final double width;
  const SDatePickerField({
    super.key,
    required this.labelText,
    required this.onDateSelected,
    this.width=160,
  });

  @override
  State<SDatePickerField> createState() => _SDatePickerFieldState();
}

class _SDatePickerFieldState extends State<SDatePickerField> {
  final TextEditingController _controller = TextEditingController();
  DateTime _selectedDate = DateTime(2000, 1, 1); // Sensible default for birthdays

  void _showPicker(BuildContext context) {
    showCupertinoModalPopup(
      context: context,
      builder: (_) => Container(
        height: 250,
        color: Theme.of(context).brightness == Brightness.dark
            ? SAppColors.darkBackground
            : SAppColors.background,
        child: Column(
          children: [
            // Toolbar with a "Done" button
            Container(
              color: SAppColors.primaryBlue,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CupertinoButton(
                    child: const Text(
                      'Done',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: SAppColors.background,
                      ),
                    ),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
            ),
            // The actual Picker
            Expanded(
              child: CupertinoDatePicker(
                mode: CupertinoDatePickerMode.date,
                initialDateTime: _selectedDate,
                maximumYear: DateTime.now().year,
                onDateTimeChanged: (DateTime newDate) {
                  setState(() {
                    _selectedDate = newDate;
                    // Format: DD/MM/YYYY
                    _controller.text = "${newDate.day}/${newDate.month}/${newDate.year}";
                  });
                  widget.onDateSelected(newDate);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      child: TextFormField(
      controller: _controller,
      readOnly: true, // Prevents keyboard from opening
      onTap: () => _showPicker(context),
      decoration: InputDecoration(
        labelText: widget.labelText,
        hintText: "Select your birthday",
        prefixIcon: const Icon(Icons.calendar_today_outlined),
      ),
    ),
    );
  }
}