import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:simsar/Theme/app_theme.dart';
import 'package:simsar/utils/error_snackbar.dart';
import 'package:simsar/utils/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

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
      routerConfig: AppRouter.router,
      scaffoldMessengerKey: scaffoldMessengerKey,
    );
  }
}

@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print("Background notification: ${message.messageId}");
}



// End of the code