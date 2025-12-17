import 'package:flutter/material.dart';

class SCheckbox extends StatelessWidget {
  final bool value;
  final ValueChanged<bool?> onChanged;

  const SCheckbox({
    super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 14,
      height: 14,
      child: Transform.scale(
        scale: 1, // fine-tune visual size to match 14x14 exactly
        child: Checkbox(
          value: value,
          onChanged: onChanged,
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
      ),
    );
  }
}
