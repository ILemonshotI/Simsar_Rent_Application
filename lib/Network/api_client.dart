import 'package:dio/dio.dart';
import 'package:simsar/Network/api_interceptor.dart'; // Import your interceptor

class DioClient {
  static final Dio dio = _initDio();

  static Dio _initDio() {
    final dioInstance = Dio(
      BaseOptions(
        baseUrl: 'https://airbnb-production-d781.up.railway.app',
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
      ),
    );

    // Register your custom interceptor
    dioInstance.interceptors.add(AuthInterceptor());

    return dioInstance;
  }
}