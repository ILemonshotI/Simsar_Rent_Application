
import 'package:flutter/material.dart';

class LoginHeader extends StatelessWidget {
  const LoginHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body:Center( 
      child:SizedBox(
      width: 327, // fixed width from Figma
      child: Column(
        mainAxisSize: MainAxisSize.min, // HUG behavior
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Welcome',
            textAlign: TextAlign.left,
            style: textTheme.titleLarge
          ),
          const SizedBox(height: 8), // use Figma gap if specified
          Text(
            'Please enter your mobile number and password to continue',
            textAlign: TextAlign.left,
            style: textTheme.bodyMedium,
          ),
        ],
      ),
    ),
    ),
    );
  }
}