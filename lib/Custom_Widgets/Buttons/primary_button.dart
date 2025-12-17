import 'package:flutter/material.dart';

class SPrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;

  const SPrimaryButton({
    super.key,
    required this.text,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 327,
      height: 52, 
      child: ElevatedButton(
        onPressed: onPressed,
        // No style override needed here; it will inherit:
        child: Text(text),
      ),
    );
  }
}