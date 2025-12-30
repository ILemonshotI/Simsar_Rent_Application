import 'package:flutter/material.dart';
import 'package:simsar/Theme/text_theme.dart';

class SReadOnlyField extends StatelessWidget {
  final String labelText;
  final String value;
  final Widget? prefixIcon;

  const SReadOnlyField({
    super.key,
    required this.labelText,
    required this.value,
    this.prefixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 327,
      height: 52,
      child: TextFormField(
        style: STextTheme.lightTextTheme.labelLarge,
        initialValue: value,
        enabled: false, // 🔒 no input
        decoration: InputDecoration(
          labelText: labelText,
          prefixIcon: prefixIcon,
        ),
      ),
    );
  }
}
