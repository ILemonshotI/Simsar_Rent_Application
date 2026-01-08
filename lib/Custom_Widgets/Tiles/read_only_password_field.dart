import 'package:flutter/material.dart';
import 'package:simsar/Theme/app_colors.dart';

class SReadOnlyPasswordField extends StatefulWidget {
  final String value;
  final String? labelText;

  const SReadOnlyPasswordField({
    super.key,
    required this.value,
    this.labelText,
  });

  @override
  State<SReadOnlyPasswordField> createState() => _SReadOnlyPasswordFieldState();
}

class _SReadOnlyPasswordFieldState extends State<SReadOnlyPasswordField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 327,
      child: TextFormField(
        initialValue: widget.value,
        readOnly: true, // ✅ changed from enabled:false
        obscureText: _obscureText,
        decoration: InputDecoration(
          labelText: widget.labelText ?? "Password",
          prefixIcon: const Icon(Icons.lock_outline, color: SAppColors.secondaryDarkBlue),
          suffixIcon: IconButton(
            splashRadius: 20,
            onPressed: () {
              setState(() {
                _obscureText = !_obscureText;
              });
            },
            icon: Icon(
              _obscureText
                  ? Icons.visibility_off_outlined
                  : Icons.visibility_outlined,
            ),
          ),
        ),
      ),
    );
  }
}
