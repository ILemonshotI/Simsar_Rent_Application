import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class LoginFooter extends StatelessWidget {
  final String preText;
  final String sufText;
  final VoidCallback onTap;

  const LoginFooter({
    required this.preText,
    required this.sufText,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        style: textTheme.bodyMedium, // base style from theme
        children: [
           TextSpan(
            text: preText,
          ),
          TextSpan(
            text: sufText,
            style: textTheme.titleSmall,
            recognizer: TapGestureRecognizer()..onTap = onTap,
          ),
        ],
      ),
    );
  }
}