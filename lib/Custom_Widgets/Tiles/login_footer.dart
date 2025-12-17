import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class LoginFooter extends StatelessWidget {
  const LoginFooter({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        style: textTheme.bodyMedium, // base style from theme
        children: [
          const TextSpan(
            text: "Don't have an account? ",
          ),
          TextSpan(
            text: "Sign Up",
            style: textTheme.titleSmall,
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                print('Sign Up tapped');
              },
          ),
        ],
      ),
    );
  }
}