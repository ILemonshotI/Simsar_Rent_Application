import 'package:flutter/material.dart';
import 'package:simsar/Theme/app_theme.dart';
import 'package:simsar/utils/routes.dart';

void main() {
  runApp(const MyApp());
}

 @override
 
class MyApp extends StatelessWidget {

  const MyApp({super.key});

  @override

  Widget build(BuildContext context) {

    return MaterialApp.router(
      title: 'Simsar App',
      debugShowCheckedModeBanner: false,
      theme: SAppTheme.lightTheme,
      darkTheme: SAppTheme.darkTheme,
      themeMode: ThemeMode.system,
      // Just call LoginScreen here. Don't add Scaffold/Center here.
      routerConfig: AppRouter.router,
    );
  }
}


// End of the code file