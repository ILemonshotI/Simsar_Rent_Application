import 'package:flutter/material.dart';
import 'package:simsar/Theme/app_theme.dart';
// import 'package:simsar/Custom_Widgets/Buttons/primary_button.dart';
// import 'package:simsar/Custom_Widgets/Text_Fields/text_field.dart';
// import 'package:simsar/Custom_Widgets/Text_Fields/password_field.dart';
// import 'package:simsar/Custom_Widgets/Buttons/checkbox.dart';
import 'package:simsar/Screens/login_screen.dart';

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
        child: SignUpForm(), 
        ),
      ),
    );
  }
}// End of the code file