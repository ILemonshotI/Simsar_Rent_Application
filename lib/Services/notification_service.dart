import 'package:dio/dio.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import '../Network/api_client.dart';
import '../utils/error_snackbar.dart';

class NotificationService {
  static final FirebaseMessaging _messaging = FirebaseMessaging.instance;

  /// Call once after login or app startup
  static Future<void> initialize() async {
    // Request permission (Android 13+ & iOS)
    await _messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    // Get FCM token
    final token = await _messaging.getToken();
    print("FCM Token: $token");
    try {
      final response = await DioClient.dio.post('/api/store-token',
        data: {
          "token": token,
        },
      );
    }on DioException catch (e){
      if (e.response != null) {
        final statusCode = e.response!.statusCode;
        final data = e.response!.data;

        switch (statusCode) {
          case 401:
            showError("Session expired. Please login again.");
            break;

          case 422:
            showError("Validation Error");
            break;

          default:
            final message = data["message"] ?? "Something went wrong";
            showError("Error $statusCode: $message");
        }
      } else {
        if (e.type == DioExceptionType.connectionTimeout) {
          showError("Connection timeout. Try again.");
        } else if (e.type == DioExceptionType.receiveTimeout) {
          showError("Server is not responding.");
        } else {
          showError("No internet connection.");
        }
      }
    }


    // Foreground notifications
    FirebaseMessaging.onMessage.listen(_onMessage);

    // Notification clicked
    FirebaseMessaging.onMessageOpenedApp.listen(_onMessageOpenedApp);
  }

  static void _onMessage(RemoteMessage message) {
    print("New notification received");
    print("Title: ${message.notification?.title}");
    print("Body: ${message.notification?.body}");
    print("Data: ${message.data}");
  }

  static void _onMessageOpenedApp(RemoteMessage message) {
    print("Notification clicked");
    print("Data: ${message.data}");
  }
}
