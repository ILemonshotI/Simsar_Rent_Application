import 'package:flutter/material.dart';

import 'package:simsar/Screens/login_screen.dart';

import 'package:simsar/Theme/app_theme.dart';

// import 'package:simsar/Custom_Widgets/Buttons/primary_button.dart';

// import 'package:simsar/Custom_Widgets/Text_Fields/text_field.dart';

// import 'package:simsar/Custom_Widgets/Text_Fields/password_field.dart';

// import 'package:simsar/Custom_Widgets/Buttons/checkbox.dart';

void main() {

  runApp(const MyApp());

}



  @override

class MyApp extends StatelessWidget {

  const MyApp({super.key});



  @override

  Widget build(BuildContext context) {

    return MaterialApp(

      debugShowCheckedModeBanner: false,

      theme: SAppTheme.lightTheme,

      darkTheme: SAppTheme.darkTheme,

      themeMode: ThemeMode.system,

      // Just call LoginScreen here. Don't add Scaffold/Center here.

      home: Scaffold(

        body: Center(

          child: LoginScreen(),

        ),

      ),

    );

  }

}

// End of the code file