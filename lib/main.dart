import 'package:flutter/material.dart';
import 'package:simsar/Theme/app_theme.dart';
import 'package:simsar/Custom_Widgets/Buttons/primary_button.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // Apply your custom theme here
      theme: SAppTheme.lightTheme,
      home: Scaffold(
        body: Center(
          // Using your custom button component
          child: SPrimaryButton(
            text: "Sign up",
            onPressed: () {}, // Change to () {} to enable the button
          ),
        ),
      ),
    );
  }
}