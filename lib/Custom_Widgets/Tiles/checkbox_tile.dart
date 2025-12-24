import 'package:flutter/material.dart';
import 'package:simsar/Custom_Widgets/Buttons/checkbox.dart';
class SCheckboxTile extends StatelessWidget {
  final bool value;
  final ValueChanged<bool?> onChanged;
  final String text;
  final VoidCallback? onTap;

  const SCheckboxTile({
    super.key,
    required this.value,
    required this.onChanged,
    required this.text,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme.bodyMedium;

    return GestureDetector(
      onTap: onTap ??
          () {
            onChanged(!value);
          },
      behavior: HitTestBehavior.translucent,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SCheckbox(
            value: value,
            onChanged: onChanged,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: textStyle,
            ),
          ),
        ],
      ),
    );
  }
}
